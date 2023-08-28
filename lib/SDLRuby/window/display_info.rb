module SDLRuby
  class Window
    module DisplayInfo
      include SDL

      def display_brightness = SDL.SDL_GetWindowBrightness(self)

      def display_icc_profile
        size = SDL.tmp_value("size_t")
        ptr = SDL.SDL_GetWindowICCProfile(self, size)
        raise SDLError if ptr.null?

        ptr.free = SDL_FREE
        ptr.to_str(size.value)
      end

      def display_index
        num = SDL.SDL_GetWindowDisplayIndex(self)
        raise SDLError if num < 0

        num
      end

      def display_gamma_ramp
        rgb = Array.new(3) { Fiddle::Pointer.malloc(2 * 256, Fiddle::RUBY_FREE) }
        err = SDL.SDL_GetWindowGammaRamp(self, *rgb)
        raise SDLError if err < 0

        rgb.map { |ptr| ptr.to_str.unpack("S*") }
      end

      def display_orientation = Display.orientation(display_index)

      def fullscreen_display_mode
        mode = DisplayMode.new
        err = SDL.SDL_GetWindowDisplayMode(self, mode)
        raise SDLError if err < 0

        mode
      end

      def fullscreen_display_mode=(mode)
        err = SDL.SDL_SetWindowDisplayMode(self, mode)
        raise SDLError if err < 0
      end
    end
  end
end
