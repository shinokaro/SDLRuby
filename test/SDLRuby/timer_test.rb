# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class TimerTest < Minitest::Test
    include TestHelper

    def setup
      # The internal timer of SDL starts running as soon as SDL_GetTicks is
      # called, irrespective of SDL's initialization state (SDL_INIT_TIMER).
      # When SDL_Quit is called,
      # it stops the internal timer and resets the ticks value to 0.
      #
    end

    def test_inspect
      SDL.stub(:SDL_GetTicks64, 0) do
        assert_equal "0 00:00:00.0000000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 1) do
        assert_equal "0 00:00:00.0010000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 1_001) do
        assert_equal "0 00:00:01.0010000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 61_001) do
        assert_equal "0 00:01:01.0010000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 3_661_001) do
        assert_equal "0 01:01:01.0010000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 90_061_001) do
        assert_equal "1 01:01:01.0010000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 954_061_001) do
        assert_equal "11 01:01:01.0010000", Timer.inspect
      end
      SDL.stub(:SDL_GetTicks64, 0xFFFF_FFFF_FFFF_FFFF) do
        assert_equal "213503982334 14:25:51.6150000", Timer.inspect
      end
    end

    def test_ticks
      assert_respond_to Timer, :ticks

      sdl_quit
      assert 0 == Timer.ticks

      sleep 0.01
      assert 0 <  Timer.ticks

      sdl_quit
      assert 0 == Timer.ticks
    end
  end
end
