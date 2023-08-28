module SDLRuby
  class Window
    class << self
      # 該当するウィンドウがない場合はnilを戻す。
      #
      def grabbed
        ptr = SDL.SDL_GetGrabbedWindow
        return if ptr.null?

        new(ptr)
      end

      # 該当するウィンドウがない場合はnilを戻す。
      #
      def keyboard_focused
        ptr = SDL.SDL_GetKeyboardFocus
        return if ptr.null?

        new(ptr)
      end

      # 該当するウィンドウがない場合はnilを戻す。
      #
      def mouse_focused
        ptr = SDL.SDL_GetMouseFocus
        return if ptr.null?

        new(ptr)
      end
    end

    module Input
      def grab = SDL.SDL_GetWindowGrab(self) != 0

      def grab=(b)
        SDL.SDL_SetWindowGrab(sef, b ? 1 : 0)
      end

      def keyboard_grabbed? = SDL.SDL_GetWindowKeyboardGrab(self) != 0

      def keyboard_grab=(b)
        SDL.SDL_SetWindowKeyboardGrab(self, b ? 1 : 0)
      end

      def mouse_clip
        ptr = SDL.SDL_GetWindowMouseRect(self)
        return if ptr.null?

        SDL_Rect.new(ptr).to_a
      end

      def mouse_clip=(rect)
        err = SDL.SDL_SetWindowMouseRect(self, Rect[*rect])
        raise SDLError if err < 0
      end

      def mouse_pos=(xy)
        SDL.SDL_WarpMouseInWindow(self, *xy)
      end

      def mouse_grabbed? = SDL.SDL_GetWindowMouseGrab(self) != 0

      def mouse_grab=(b)
        SDL.SDL_SetWindowMouseGrab(self, b ? 1 : 0)
      end
    end
  end
end
