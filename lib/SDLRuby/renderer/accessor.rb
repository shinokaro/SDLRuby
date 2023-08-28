module SDLRuby
  module Renderer
    module Accessor
      def integer_scale? = SDL.SDL_RenderGetIntegerScale(renderer) != 0

      def integer_scale=(b)
        err = SDL.SDL_RenderSetIntegerScale(renderer, b ? 1 : 0)
        raise SDLError if err < 0
      end

      def logical_size
        w, h = SDL.tmp_value("int", "int")
        SDL.SDL_RenderGetLogicalSize(renderer, w, h)
        [w.value, h.value]
      end

      def logical_size=(wh)
        err = SDL.SDL_RenderSetLogicalSize(renderer, *wh)
        raise SDLError if err < 0
      end

      def output_size
        x, y = SDL.tmp_value("int", "int")
        err = SDL.SDL_GetRendererOutputSize(renderer, x, y)
        raise SDLError if err < 0

        [x.value, y.value]
      end

      def scale
        x, y = SDL.tmp_value("float", "float")
        SDL.SDL_RenderGetScale(renderer, x, y)
        [x.value, y.value]
      end

      def scale=(xy)
        err = SDL.SDL_RenderSetScale(renderer, x, y)
        raise SDLError if err < 0
      end

      # ウィンドウ座標から対応する論理座標を戻す。
      def to_logical_pos(x, y)
        xp, yp = SDL.tmp_value("float", "float")
        SDL.SDL_RenderWindowToLogical(renderer, x, y, xp, yp)

        [xp.value, yp.value]
      end

      # 論理座標から対応するウィンドウの実座標を戻す。
      #
      def to_renderer_pos(x, y)
        xp, yp = SDL.tmp_value("float", "float")
        SDL.SDL_RenderLogicalToWindow(renderer, x, y, xp, yp)

        [xp.value, yp.value]
      end

      def viewport
        r =  Rect[]
        SDL.SDL_RenderGetViewport(renderer, r)
        r.to_a
      end

      def viewport=(rect)
        err = SDL.SDL_RenderSetViewport(renderer, Rect[*rect])
        raise SDLError if err < 0
      end
    end
  end
end
