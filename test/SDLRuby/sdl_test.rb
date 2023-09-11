# frozen_string_literal: true

require 'test_helper'

module SDLRuby
  class SDLTest < Minitest::Test
    include ::SDLRuby, ::SDLRuby::SDL

    def test_clipboard_text
      # Note that the clipboard can be updated from the OS system.
      # The clipboard's state is also updated during the execution of tests.
      #
      assert_respond_to SDL, :clipboard_text

      SDL.init(SDL_INIT_VIDEO)

      act = SDL.clipboard_text

      assert_equal Encoding::UTF_8, act.encoding

      SDL.quit
    end

    def test_clipboard_text_setter
      # Note that the clipboard can be updated from the OS system.
      # The clipboard's state is also updated during the execution of tests.
      #
      assert_respond_to SDL, :clipboard_text=

      SDL.init(SDL_INIT_VIDEO)

      exp = "This text was written by SDLRuby tests."

      SDL.clipboard_text = exp

      SDL.quit
    end

    def test_last_error_message_setter
      assert_respond_to SDL, :last_error_message=

      exp = "test message"

      SDL.last_error_message = exp

      act = SDL.SDL_GetError.to_s

      assert_equal exp, act
    end
  end
end
