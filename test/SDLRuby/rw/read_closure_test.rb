# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class RW
    class ReadClosureTest < Minitest::Test
      include Fiddle, TestHelper

      def setup
        @context = nil # is dummy
      end

      def test_call
        exp = "42"
        exp_size = exp.size
        ptr = Pointer.malloc(exp_size, RUBY_FREE)

        mock = Minitest::Mock.new
        mock.expect :read, exp, [exp_size]

        obj = RW::ReadClosure.new(mock)
        assert_equal exp_size, obj.call(@context, ptr, 1, exp_size)
        assert_equal exp, ptr.to_str

        mock.verify
      end

      def test_call_when_stream_was_eof
        exp_size = 2
        ptr = Pointer.malloc(exp_size, RUBY_FREE)

        mock = Minitest::Mock.new
        mock.expect :read, nil, [exp_size]

        obj = RW::ReadClosure.new(mock)
        assert_equal 0, obj.call(@context, ptr, 1, exp_size)

        mock.verify
      end

      def test_call_with_exception_raising_object
        msg = "error message"
        exp_size = 2
        ptr = Pointer.malloc(exp_size, RUBY_FREE)

        mock = Minitest::Mock.new
        mock.expect :read, nil do
          raise msg
        end

        obj = RW::ReadClosure.new(mock)
        assert_equal 0, obj.call(@context, ptr, 1, exp_size)
        assert_equal msg, sdl_get_error,
                     "Exception message must be communicated to SDL"
        mock.verify
      end
    end
  end
end
