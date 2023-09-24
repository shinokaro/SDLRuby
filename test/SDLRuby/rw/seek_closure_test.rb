# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class RW
    class SeekClosureTest < Minitest::Test
      include TestHelper

      def setup
        @context = nil # is dummy
      end

      def test_call
        mock = Minitest::Mock.new

        # The seek method returning 0 is based on Ruby's IO object.
        #
        mock.expect :seek, 0, [0, IO::SEEK_SET]
        mock.expect :tell, 0

        obj = RW::SeekClosure.new(mock)
        assert_equal 0, obj.call(@context, 0, IO::SEEK_SET)

        mock.verify
      end

      def test_call_with_exception_raising_object
        msg = "error message"

        mock = Minitest::Mock.new
        mock.expect :seek, nil do
          raise msg
        end

        obj = RW::SeekClosure.new(mock)
        assert_equal -1, obj.call(@context, 0, IO::SEEK_SET)
        assert_equal msg, sdl_get_error,
                     "Exception message must be communicated to SDL"
        mock.verify
      end
    end
  end
end
