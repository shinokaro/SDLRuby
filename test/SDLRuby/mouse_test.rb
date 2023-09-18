# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class MouseTest < Minitest::Test
    include Fiddle, ::SDLRuby, ::SDLRuby::SDL, TestHelper

    def setup
      # Some of SDL's mouse functions require the initialization of the SDL
      # video subsystem.
      # If this is not done, SDL functions will return an error.
      # It is sufficient for the video subsystem to be initialized once,
      # and the error notification will not occur even
      # if it is shut down after initialization.
      #
      # Do not test for the error of SDL initialization not being performed.
      #
      # However, considering the scenario where SDL in the test environment
      # does not support the mouse, errors from SDL mouse function calls within
      # the test are checked.
      #
      sdl_init(SDL_INIT_VIDEO)
      sdl_quit
    end

    def test_button
      assert_respond_to Mouse, :button

      SDL.stub(:SDL_GetMouseState, 0) do
        assert_equal [false, false, false, false, false], Mouse.button
      end
    end

    def test_capture_setter
      assert_respond_to Mouse, :capture=

      arg = nil
      SDL.stub(:SDL_CaptureMouse, -> (b) { arg = b; 0 }) do
        Mouse.capture = true
        assert 1 == arg
      end

      arg = nil
      SDL.stub(:SDL_CaptureMouse, -> (b) { arg = b; 0 }) do
        Mouse.capture = false
        assert 0 == arg
      end

      arg = nil
      SDL.stub(:SDL_CaptureMouse, -> (b) { arg = b; 0 }) do
        Mouse.capture = Object.new
        assert 1 == arg
      end

      arg = nil
      SDL.stub(:SDL_CaptureMouse, -> (b) { arg = b; 0 }) do
        Mouse.capture = nil
        assert 0 == arg
      end

      SDL.stub(:SDL_CaptureMouse, -1) do
        assert_raises SDLError do
          Mouse.capture = true
        end
      end

      e = assert_raises SDLError,
                        "The SDL specification has been modified" do
        Mouse.capture = true
      end
      assert_equal "SDL_CaptureMouse() must be called on the main thread",
                   e.message,
                   "The SDL specification has been modified"
    end

    def test_global_button
      assert_respond_to Mouse, :global_button

      SDL.stub(:SDL_GetGlobalMouseState, 0) do
        assert_equal [false, false, false, false, false], Mouse.global_button
      end
    end

    def test_global_pos
      assert_respond_to Mouse, :global_pos

      SDL.stub(:SDL_GetGlobalMouseState, -> (x, y) {
        x.value = 0
        y.value = 0
        0
      }) do
        assert_equal [0, 0], Mouse.global_pos
      end
    end

    def test_global_pos_setter
      assert_respond_to Mouse, :global_pos=

      SDL.stub(:SDL_WarpMouseGlobal, -1) do
        assert_raises SDLError do
          Mouse.global_pos = [0, 0]
        end
      end
    end

    def test_global_state
      assert_respond_to Mouse, :global_state

      SDL.stub(:SDL_GetGlobalMouseState, -> (x, y) {
        x.value = 0
        y.value = 0
        0
      }) do
        assert_equal [[false, false, false, false, false], 0, 0],
                     Mouse.global_state
      end
    end

    def test_pos
      assert_respond_to Mouse, :pos

      SDL.stub(:SDL_GetMouseState, -> (x, y) {
        x.value = 0
        y.value = 0
        0
      }) do
        assert_equal [0, 0], Mouse.pos
      end
    end

    def test_pos_setter
      assert_respond_to Mouse, :pos=

      SDL.stub(:SDL_WarpMouseInWindow, nil) do
        Mouse.pos = [0, 0]
      end
    end

    def test_relative_setter
      assert_respond_to Mouse, :relative=

      Mouse.relative = true
      assert 0 != SDL.SDL_GetRelativeMouseMode

      Mouse.relative = false
      assert 0 == SDL.SDL_GetRelativeMouseMode

      Mouse.relative = Object.new
      assert 0 != SDL.SDL_GetRelativeMouseMode

      Mouse.relative = nil
      assert 0 == SDL.SDL_GetRelativeMouseMode

      SDL.stub(:SDL_SetRelativeMouseMode, -1) do
        assert_raises SDLError do
          Mouse.relative = true
        end
      end
    end

    def test_relative?
      assert_respond_to Mouse, :relative?

      SDL.stub(:SDL_GetRelativeMouseMode, 1) do
        assert_equal true, Mouse.relative?
      end

      SDL.stub(:SDL_GetRelativeMouseMode, 0) do
        assert_equal false, Mouse.relative?
      end
    end

    def test_relative_pos
      assert_respond_to Mouse, :relative_pos

      SDL.stub(:SDL_GetRelativeMouseState, -> (x, y) {
        x.value = 0
        y.value = 0
        0
      }) do
        assert_equal [0, 0], Mouse.relative_pos
      end
    end

    def test_relative_state
      assert_respond_to Mouse, :relative_state

      SDL.stub(:SDL_GetRelativeMouseState, -> (x, y) {
        x.value = 0
        y.value = 0
        0
      }) do
        assert_equal [[false, false, false, false, false], 0, 0],
                     Mouse.relative_state
      end
    end

    def test_state
      assert_respond_to Mouse, :state

      SDL.stub(:SDL_GetMouseState, -> (x, y) {
        x.value = 0
        y.value = 0
        0
      }) do
        assert_equal [[false, false, false, false, false], 0, 0], Mouse.state
      end
    end
  end
end
