# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class RWOpsTest < Minitest::Test
    include Fiddle, TestHelper

    def test_close_from_sdl
      rw = RWOps["42"]

      assert_equal "42", rw.read

      SDL.SDL_RWclose(rw)

      assert rw.closed?
      assert rw.to_ptr.freed?
    end

    def test_initialize_with_string
      obj = String.new("42")
      rw = RWOps[obj]

      ptr = Pointer.malloc(2, RUBY_FREE)
      SDL.SDL_RWread(rw, ptr, 1, 2)

      assert_equal "42", ptr.to_str

      SDL.SDL_RWwrite(rw, "42", 1, 2)

      assert_equal "4242", obj
    end

    def test_initialize_with_object
      obj = Object.new
      rw = RWOps[obj]

      sdl_clear_error
      assert_equal 0,  SDL.SDL_RWread(rw, "\x00", 1, 1)
      refute_empty sdl_get_error

      sdl_clear_error
      assert_equal -1, SDL.SDL_RWseek(rw, 0, IO::SEEK_SET)
      refute_empty sdl_get_error

      sdl_clear_error
      assert_equal -1, SDL.SDL_RWsize(rw)
      refute_empty sdl_get_error

      sdl_clear_error
      assert_equal 0,  SDL.SDL_RWwrite(rw, "\x00", 1, 1)
      refute_empty sdl_get_error

      assert_raises SDLError do rw.read end
      assert_raises SDLError do rw.seek(0, IO::SEEK_SET) end
      assert_raises SDLError do rw.size end
      assert_raises SDLError do rw.write("42") end
      assert_nil rw.close
    end

    def test_initialize_with_pointer
      obj = Pointer.malloc(2, RUBY_FREE)
      rw = RWOps[obj]

      sdl_clear_error
      assert_equal 2, SDL.SDL_RWread(rw, "\x00\x00", 1, 2)
      assert_empty sdl_get_error

      sdl_clear_error
      assert_equal 0, SDL.SDL_RWseek(rw, 0, IO::SEEK_SET)
      assert_empty sdl_get_error

      sdl_clear_error
      assert_equal 2, SDL.SDL_RWsize(rw)
      assert_empty sdl_get_error

      sdl_clear_error
      assert_equal 2, SDL.SDL_RWwrite(rw, "42", 1, 2)
      assert_empty sdl_get_error

      sdl_clear_error
      assert_equal 0, SDL.SDL_RWwrite(rw, "42", 1, 2)
      assert_empty sdl_get_error,
                   "SDL2's SDL_RWMem does not set an error message"
    end
  end
end
