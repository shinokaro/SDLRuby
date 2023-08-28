module SDLRuby
  class Window
    module Surfacer
      include SDL

      def destroy_surface
        err = SDL.SDL_DestroyWindowSurface(self)
        raise SDLError if err < 0
      end

      def surface
        ptr = SDL.SDL_GetWindowSurface(self)
        raise SDLError if ptr.null?

        # ウィンドウからのサーフェスにはSDL_DONTFREEフラグが設定されている。
        # このためにSDL_FreeSurfaceではリファレンスカウンターを減じる事ができない。
        # これはRubyのGC管理では問題になる（メモリーリークする）。
        # そのためSDL_DONTFREEフラグを解除する！
        #
        st = SDL_Surface.new(ptr)
        st.flags &= ~SDL_DONTFREE

        Surface.new(ptr, add_ref: true)
      end

      # ウィンドウのサーフェスがvalidかどうか確認していない。
      # リサイズなどで壊れていてもtrueを戻す。
      #
      def surface? = SDL.SDL_HasWindowSurface(self) == 1

      def update_surface
        err = SDL.SDL_UpdateWindowSurface(self)
        raise SDLError if err < 0
      end
    end
  end
end
