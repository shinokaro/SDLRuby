# frozen_string_literal: true

require 'test_helper'

module SDLRuby
  class SDLTest < Minitest::Test
    include ::SDLRuby, ::SDLRuby::SDL

    def sdl_init(flags)
      err = SDL.SDL_Init(flags)
      raise "SDL initialization failed" if err < 0
      if block_given?
        begin
          yield
        ensure
          sdl_quit
        end
      end
    end

    def sdl_was_init = SDL.SDL_WasInit(0)

    def sdl_quit = SDL.SDL_Quit

    def test_init
      assert_respond_to SDL, :init

      assert_nil SDL.init
      assert_equal SDL_INIT_EVERYTHING, sdl_was_init,
                   "When no arguments are provided, it must be initialized with\
 SDL_INIT_EVERYTHING."
      sdl_quit

      assert_nil SDL.init(SDL_INIT_EVENTS)
      assert_equal SDL_INIT_EVENTS, sdl_was_init,
                   "It is initializing everything except the specified subsystems"
      sdl_quit

      assert_nil SDL.init(0)
      assert_equal 0, sdl_was_init,
                   "When called with an argument of 0, the subsystems are initialized"
      sdl_quit
    end

    def test_init?
      assert_respond_to SDL, :init?

      assert_equal false, SDL.init?
      assert_equal false, SDL.init?(0)

      sdl_init(SDL_INIT_EVERYTHING) do
        assert_equal true,  SDL.init?
        assert_equal true,  SDL.init?(SDL_INIT_EVERYTHING)
        assert_equal true,  SDL.init?(SDL_INIT_EVENTS)
        assert_equal true,  SDL.init?(SDL_INIT_EVENTS | SDL_INIT_TIMER)
        assert_equal true,  SDL.init?(0)
      end

      sdl_init(SDL_INIT_EVENTS) do
        assert_equal true,  SDL.init?
        assert_equal false, SDL.init?(SDL_INIT_EVERYTHING)
        assert_equal true,  SDL.init?(SDL_INIT_EVENTS)
        assert_equal false, SDL.init?(SDL_INIT_EVENTS | SDL_INIT_TIMER)
        assert_equal true,  SDL.init?(0)
      end

      sdl_init(SDL_INIT_EVENTS | SDL_INIT_TIMER) do
        assert_equal true,  SDL.init?
        assert_equal false, SDL.init?(SDL_INIT_EVERYTHING)
        assert_equal true,  SDL.init?(SDL_INIT_EVENTS)
        assert_equal true,  SDL.init?(SDL_INIT_EVENTS | SDL_INIT_TIMER)
        assert_equal false, SDL.init?(SDL_INIT_EVENTS | SDL_INIT_AUDIO)
        assert_equal true,  SDL.init?(0)
      end
    end

    def test_quit
      assert_respond_to SDL, :quit

      assert_nil SDL.quit

      sdl_init(SDL_INIT_EVERYTHING) do
        assert_nil SDL.quit

        assert_equal 0, sdl_was_init,
                     "SDL shutdown was not performed"
      end
    end

    def test_clipboard_text
      # Note that the clipboard can be updated from the OS system.
      # The clipboard's state is also updated during the execution of tests.
      #
      assert_respond_to SDL, :clipboard_text

      sdl_init(SDL_INIT_VIDEO) do
        act = SDL.clipboard_text

        assert_equal Encoding::UTF_8, act.encoding
      end
    end

    def test_clipboard_text_setter
      # Note that the clipboard can be updated from the OS system.
      # The clipboard's state is also updated during the execution of tests.
      #
      assert_respond_to SDL, :clipboard_text=

      sdl_init(SDL_INIT_VIDEO) do
        exp = "This text was written by SDLRuby tests."

        SDL.clipboard_text = exp
      end
    end

    def test_last_error_message_setter
      assert_respond_to SDL, :last_error_message=

      exp = "test message"
      SDL.last_error_message = exp
      assert_equal exp, SDL.SDL_GetError.to_s

      exp = "printf style(%d)"
      SDL.last_error_message = exp
      assert_equal exp, SDL.SDL_GetError.to_s,
                   "When a printf-style string is provided, proper escaping is\
 not being performed"
    end
  end
end
