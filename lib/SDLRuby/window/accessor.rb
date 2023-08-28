module SDLRuby
  class Window
    module Accessor
      def boarder_size
        t, l, b, r = SDL.tmp_value("int", "int", "int", "int")
        err = SDL.SDL_GetWindowBordersSize(self, t, l, b, r)
        raise SDLError if err < 0

        [t.value, l.value, b.value, r.value]
      end

      def h
        v = SDL.tmp_value("int")
        SDL.SDL_GetWindowSize(self, nil, v)
        v.value
      end

      def h=(n)
        SDL.SDL_SetWindowSize(self, w, n)
      end

      def icon=(surface)
        SDL.SDL_SetWindowIcon(self, surface)
      end

      def maximum_size
        w, h = SDL.tmp_value("int", "int")
        SDL.SDL_GetWindowMaximumSize(self, w, h)

        [w.value, h.value]
      end

      def maximum_size=(wh)
        SDL.SDL_SetWindowMaximumSize(self, *wh)
      end

      def minimum_size
        w, h = SDL.tmp_value("int", "int")
        SDL.SDL_GetWindowMinimumSize(self, w, h)

        [w.value, h.value]
      end

      def minimum_size=(wh)
        SDL.SDL_SetWindowMinimumSize(self, *wh)
      end

      def opacity
        f = SDL.tmp_value("float")
        err = SDL.SDL_GetWindowOpacity(self, f)
        raise SDLError if err < 0

        f.value
      end

      def opacity=(f)
        err = SDL.SDL_SetWindowOpacity(self, f)
        raise SDLError if err < 0
      end

      def pos
        vx, vy = SDL.tmp_value("int", "int")
        SDL.SDL_GetWindowPosition(self, vx, vy)
        [vx.value, vy.value]
      end

      def pos=(xy)
        SDL.SDL_SetWindowPosition(self, *xy)
      end

      def size
        vw, vh = SDL.tmp_value("int", "int")
        SDL.SDL_GetWindowSize(self, vw, vh)
        [vw.value, vh.value]
      end

      def size=(wh)
        SDL.SDL_SetWindowSize(self, *wh)
      end

      def size_in_pixels
        vw, vh = SDL.tmp_value("int", "int")
        SDL.SDL_GetWindowSizeInPixels(self, vw, vh)

        [vw.value, vh.value]
      end

      def title = SDL.SDL_GetWindowTitle(self).to_s.force_encoding("UTF-8")

      def title=(s)
        SDL.SDL_SetWindowTitle(self, s.encode("UTF-8"))
      end

      def w
        v = SDL.tmp_value("int")
        SDL.SDL_GetWindowSize(self, v, nil)
        v.value
      end

      def w=(n)
        SDL.SDL_SetWindowSize(self, n, h)
      end

      def x
        v = SDL.tmp_value("int")
        SDL.SDL_GetWindowPosition(self, v, nil)
        v.value
      end

      def x=(n)
        SDL.SDL_SetWindowPosition(self, n, y)
      end

      def y
        v = SDL.tmp_value("int")
        SDL.SDL_GetWindowPosition(self, nil, v)
        v.value
      end

      def y=(n)
        SDL.SDL_SetWindowPosition(self, x, n)
      end
    end
  end
end
