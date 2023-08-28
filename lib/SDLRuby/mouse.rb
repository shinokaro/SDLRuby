module SDLRuby
  module Mouse
    @global_x, @global_y = *SDL.tmp_value("int", "int")
    @relative_x, @relative_y = *SDL.tmp_value("int", "int")
    @x, @y = *SDL.tmp_value("int", "int")

    class << self
      include SDL

      def to_button_ary(num)
        [
          num & SDL_BUTTON_LMASK  != 0,
          num & SDL_BUTTON_MMASK  != 0,
          num & SDL_BUTTON_RMASK  != 0,
          num & SDL_BUTTON_X1MASK != 0,
          num & SDL_BUTTON_X2MASK != 0
        ]
      end

      def capture=(b)
        err = SDL.SDL_CaptureMouse(b ? 1 : 0)
        raise SDLError if err < 0
      end

      def global_pos=(xy)
        err = SDL.SDL_WarpMouseGlobal(*xy)
        raise SDLError if err < 0
      end

      def global_state = [
        SDL.SDL_GetGlobalMouseState(@global_x, @global_y),
        @global_x.value, @global_y.value
      ]

      def relative=(b)
        err = SDL.SDL_SetRelativeMouseMode(b ? 1 : 0)
        raise SDLError if err < 0
      end

      def relative? = SDL.SDL_GetRelativeMouseMode == 1

      def relative_state = [
        SDL.SDL_GetRelativeMouseState(@relative_x, @relative_y),
        @relative_x.value, @relative_y.value
      ]

      def state = [
        SDL.SDL_GetMouseState(@x, @y), @x.value, @y.value
      ]
    end
  end
end
