module SDLRuby
  module Mouse
    class << self
      include SDL

      def button = button_to_ary(WindowMouse.button)

      # If called without initializing the SDL video subsystem,
      # even if a mouse is present in the system, it will return an error.
      #
      # This method must be called from the main thread.
      #
      def capture=(b)
        err = SDL.SDL_CaptureMouse(b ? 1 : 0)
        raise SDLError if err < 0
      end

      def global_button = button_to_ary(GlobalMouse.button)

      def global_pos = GlobalMouse.pos

      # If called without initializing the SDL video subsystem,
      # even if a mouse is present in the system, it will return an error.
      #
      def global_pos=(xy)
        GlobalMouse.pos=(xy)
      end

      def global_state
        a = GlobalMouse.state
        a[0] = button_to_ary(a[0])
        a
      end

      def pos = WindowMouse.pos

      def pos=(xy)
        SDL.SDL_WarpMouseInWindow(nil, *xy)
      end

      # If called without initializing the SDL video subsystem,
      # even if a mouse is present in the system, it will return an error.
      #
      def relative=(b)
        err = SDL.SDL_SetRelativeMouseMode(b ? 1 : 0)
        raise SDLError if err < 0
      end

      def relative? = SDL.SDL_GetRelativeMouseMode != 0

      def relative_pos = RelativeMouse.pos

      def relative_state
        a = RelativeMouse.state
        a[0] = button_to_ary(a[0])
        a
      end

      def state
        a = WindowMouse.state
        a[0] = button_to_ary(a[0])
        a
      end

      private

      def button_to_ary(num)
        [
          num & SDL_BUTTON_LMASK  != 0,
          num & SDL_BUTTON_MMASK  != 0,
          num & SDL_BUTTON_RMASK  != 0,
          num & SDL_BUTTON_X1MASK != 0,
          num & SDL_BUTTON_X2MASK != 0,
        ]
      end
    end

    module GlobalMouse
      @x, @y = SDL.tmp_value("int", "int")

      class << self
        def button = SDL.SDL_GetGlobalMouseState(nil, nil)

        def pos
          SDL.SDL_GetGlobalMouseState(@x, @y)
          [@x.value, @y.value]
        end

        def pos=(xy)
          err = SDL.SDL_WarpMouseGlobal(*xy)
          raise SDLError if err < 0
        end

        def state = [SDL.SDL_GetGlobalMouseState(@x, @y), @x.value, @y.value]
      end
    end

    module RelativeMouse
      @x, @y = SDL.tmp_value("int", "int")

      class << self
        def pos
          SDL.SDL_GetRelativeMouseState(@x, @y)
          [@x.value, @y.value]
        end

        def state = [SDL.SDL_GetRelativeMouseState(@x, @y), @x.value, @y.value]
      end
    end

    module WindowMouse
      @x, @y = SDL.tmp_value("int", "int")

      class << self
        def button = SDL.SDL_GetMouseState(nil, nil)

        def pos
          SDL.SDL_GetMouseState(@x, @y)
          [@x.value, @y.value]
        end

        def pos=(xy)
          SDL.SDL_WarpMouseInWindow(nil, *xy)
        end

        def state = [SDL.SDL_GetMouseState(@x, @y), @x.value, @y.value]
      end
    end
  end
end
