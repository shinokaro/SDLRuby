module SDLRuby
  class Window
    module Controller
      def always_on_top = SDL.SDL_SetWindowAlwaysOnTop(self)

      def always_on_top? = flags & SDL_WINDOW_ALWAYS_ON_TOP != 0

      def border=(obj)
        SDL.SDL_SetWindowBordered(self, obj ? 1 : 0)
      end

      def borderless? = flags & SDL_WINDOW_BORDERLESS != 0

      def fullscreen=(obj)
        err = SDL.SDL_SetWindowFullscreen(self, obj ? SDL_WINDOW_FULLSCREEN : 0)
        raise SDLError if err < 0
      end

      def fullscreen? = flags & SDL_WINDOW_FULLSCREEN != 0

      def fullscreen_desktop=(obj)
        err = SDL.SDL_SetWindowFullscreen(self, obj ? SDL_WINDOW_FULLSCREEN_DESKTOP : 0)
        raise SDLError if err < 0
      end

      def fullscreen_desktop? = flags & SDL_WINDOW_FULLSCREEN_DESKTOP != 0

      def hide = SDL.SDL_HideWindow(self)

      def hidden? = flags & SDL_WINDOW_HIDDEN != 0

      def maximize = SDL.SDL_MaximizeWindow(self)

      def maximized? = flags & SDL_WINDOW_MAXIMIZED != 0

      def minimize = SDL.SDL_MinimizeWindow(self)

      def minimized? = flags & SDL_WINDOW_MINIMIZED != 0

      def resizable=(obj)
        SDL.SDL_SetWindowResizable(self, obj ? 1 : 0)
      end

      def resizable? = flags & SDL_WINDOW_RESIZABLE != 0

      def restore = SDL.SDL_RestoreWindow(self)

      def show = SDL.SDL_ShowWindow(self)

      def shown? = flags & SDL_WINDOW_SHOWN != 0
    end
  end
end
