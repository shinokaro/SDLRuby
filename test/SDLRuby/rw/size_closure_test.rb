# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class RW
    class SizeClosureTest < Minitest::Test
      include TestHelper

      def setup
        @context = nil # is dummy
      end

      def test_call
        mock = Minitest::Mock.new
        mock.expect :size, 42

        obj = RW::SizeClosure.new(mock)
        assert_equal 42, obj.call(@context)

        mock.verify
      end

      def test_call_with_exception_raising_object
        msg = "error message"

        mock = Minitest::Mock.new
        mock.expect :size, nil do
          raise msg
        end

        obj = RW::SizeClosure.new(mock)
        assert_equal -1, obj.call(@context)
        assert_equal msg, sdl_get_error,
                     "Exception message must be communicated to SDL"
        mock.verify
      end
    end
  end
end
