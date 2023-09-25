# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class RW
    class OperationalTest < Minitest::Test
      include Fiddle, SDL, TestHelper

      def make_sdl_rw_ops(do_not_free: nil)
        str = String.new("123456789")
        ptr = SDL.SDL_RWFromMem(str, str.bytesize)
        raise sdl_get_error if ptr.null?

        st = SDL_RWops.new(ptr, do_not_free ? nil : SDL_FREE_RW)
        st.singleton_class.instance_eval { attr_accessor :buffer }
        st.buffer = str
        st.extend(RW::Operational)
      end

      def test_close
        rw = make_sdl_rw_ops(do_not_free: true)

        assert_respond_to rw, :close

        rw.stub(:closed?, true) do
          assert_nil rw.close
        end

        SDL.stub :SDL_RWclose, proc { -1 } do
          assert_raises SDLError do
            rw.close
          end
        end

        assert_nil rw.close
      end

      def test_closed?
        rw = make_sdl_rw_ops

        assert_respond_to rw, :closed?

        assert_equal false, rw.to_ptr.freed?
        assert_equal false, rw.closed?

        rw.to_ptr.call_free

        assert_equal true, rw.to_ptr.freed?
        assert_equal true, rw.closed?
      end

      def test_eof?
        rw = make_sdl_rw_ops

        assert_respond_to rw, :eof?

        rw.stub(:closed?, true) do
          assert_raises SDLError do
            rw.eof?
          end
        end

        assert_equal false, rw.eof?

        SDL.SDL_RWseek(rw, 0, IO::SEEK_END)

        assert_equal true, rw.eof?
      end

      def test_pos
        rw = make_sdl_rw_ops

        assert_respond_to rw, :pos
      end

      def test_pos_setter
        rw = make_sdl_rw_ops

        assert_respond_to rw, :pos=
      end

      def test_read
        rw = make_sdl_rw_ops

        assert_respond_to rw, :read

        rw.stub(:closed?, true) do
          assert_raises SDLError do
            rw.read
          end
        end

        assert_equal "123456789", rw.read,
                     "If no arguments are provided, it will read everything"

        SDL.SDL_RWseek(rw, 0, IO::SEEK_SET)
        assert_equal "123", rw.read(3)
        assert_equal "456", rw.read(3)
        rw.pos = 0

        assert_raises ArgumentError,
                      "Providing a negative 'length' argument will cause an error" do
          rw.read(-1)
        end

        assert_raises TypeError do
          rw.read("1")
        end

        assert_raises TypeError do
          rw.read(nil, 123456789)
        end

        SDL.stub :SDL_RWread, 0 do
          assert_raises SDLError do
            rw.read
          end
        end
      end

      def test_read_at_eof
        rw = make_sdl_rw_ops

        SDL.SDL_RWseek(rw, 0, IO::SEEK_END)

        assert_nil rw.read(1),
                   "When the 'length' argument has a value, it returns nil"
        assert_equal "", rw.read(0),
                     "When the 'length' argument is zero, it returns an empty string"
        assert_equal "", rw.read,
                     "When the 'length' argument is nil, it returns an empty string"
      end

      def test_read_with_buffer
        rw = make_sdl_rw_ops

        buf = "\x00" * 9
        res = rw.read(9, buf)
        assert_equal "123456789", buf
        assert_same buf, res
      end

      def test_read_with_buffer_larger_than_length
        rw = make_sdl_rw_ops

        buf = "\x00" * 10
        res = rw.read(9, buf)
        assert_equal "123456789", buf
        assert_same buf, res
      end

      def test_read_with_buffer_smaller_than_lenght
        rw = make_sdl_rw_ops

        buf = "\x00" * 1
        res = rw.read(9, buf)
        assert_equal "123456789", buf
        assert_same buf, res
      end

      def test_read_with_buffer_at_eof
        rw = make_sdl_rw_ops
        SDL.SDL_RWseek(rw, 0, IO::SEEK_END)

        buf = "\x00" * 9
        res = rw.read(9, buf)
        assert_nil res
        assert_empty buf

        buf = "\x00" * 9
        res = rw.read(0, buf)
        assert_equal buf, res
        assert_empty buf

        buf = "\x00" * 9
        res = rw.read(nil, buf)
        assert_equal buf, res
        assert_empty buf
      end

      def test_seek
        rw = make_sdl_rw_ops

        assert_respond_to rw, :seek

        rw.stub(:closed?, true) do
          assert_raises SDLError do
            rw.seek(2)
          end
        end

        assert_equal 0, rw.seek(2)
        assert_equal 2, SDL.SDL_RWtell(rw)

        assert_equal 0, rw.seek(2)
        assert_equal 2, SDL.SDL_RWtell(rw),
                     "The 'whence' argument does not default to SEEK_SET"

        SDL.stub :SDL_RWseek, proc { -1 } do
          assert_raises SDLError do
            rw.seek(2)
          end
        end
      end

      def test_size
        rw = make_sdl_rw_ops

        assert_respond_to rw, :size

        rw.stub(:closed?, true) do
          assert_raises SDLError do
            rw.size
          end
        end

        assert_equal rw.buffer.bytesize, rw.size

        SDL.stub :SDL_RWsize, proc { -1 } do
          assert_raises SDLError do
            rw.size
          end
        end
      end

      def test_tell
        rw = make_sdl_rw_ops

        assert_respond_to rw, :tell

        rw.stub(:closed?, true) do
          assert_raises SDLError do
            rw.tell
          end
        end

        assert_equal 0, rw.tell

        SDL.stub :SDL_RWtell, proc { -1 } do
          assert_raises SDLError do
            rw.tell
          end
        end
      end

      def test_write
        rw = make_sdl_rw_ops

        assert_respond_to rw, :write

        rw.stub(:closed?, true) do
          assert_raises SDLError do
            rw.write("42")
          end
        end

        assert_equal 0, rw.write(nil)
        assert_equal "123456789", rw.buffer

        assert_equal 2, rw.write("42")
        assert_equal "423456789", rw.buffer

        mock = Minitest::Mock.new
        mock.expect :to_s, "42"

        assert_equal 2, rw.write(mock)
        assert_equal "424256789", rw.buffer
        mock.verify

        assert_raises SDLError do
          rw.write("424242")
        end
        assert_equal "424242424", rw.buffer
      end
    end
  end
end
