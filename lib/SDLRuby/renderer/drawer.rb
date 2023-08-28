module SDLRuby
  module Renderer
    module Drawer
      include Fiddle, SDL

      def draw_copy(texture,
                    angle: nil, center: nil, dst_rect:nil, flip: nil, src_rect: nil)

        sr = src_rect && Rect[*src_rect]
        dr = dst_rect && Rect[*dst_rect]
        a = angle || 0
        pt = if center
               SDL_Point.malloc(RUBY_FREE).tap { |pt| pt.x, pt.y = *center }
             end
        fl = flip || 0 #=SDL_FLIP_NONE

        err = SDL.SDL_RenderCopyEx(renderer, texture, sr, dr, a, pt, fl)
        raise SDLError if err < 0
      end

      def draw_fill(*f)
        size = f.count
        count = size / 4
        raise ArgumentError if count.zero? || (size % 4).nonzero?
        ptr = f.pack("f*")

        err = SDL.SDL_RenderFillRectsF(renderer, ptr, count)
        raise SDLError if err < 0
      end

      def draw_line(*f)
        size = f.count
        count = size / 2
        raise ArgumentError if count.zero? || (size % 2).nonzero?
        ptr = f.pack("f*")

        err = SDL.SDL_RenderDrawLinesF(renderer, ptr, count)
        raise SDLError if err < 0
      end

      def draw_point(*f)
        size = f.count
        count = size / 2
        raise ArgumentError if count.zero? || (size % 2).nonzero?
        ptr = f.pack("f*")

        err = SDL.SDL_RenderDrawPointsF(renderer, ptr, count)
        raise SDLError if err < 0
      end

      def draw_rect(*f)
        size = f.count
        count = size / 4
        raise ArgumentError if count.zero? || (size % 4).nonzero?
        ptr = f.pack("f*")

        err = SDL.SDL_RenderDrawRectsF(renderer, ptr, count)
        raise SDLError if err < 0
      end

      def render_blend_mode
        mode = SDL.tmp_value("int")
        err = SDL.SDL_GetRenderDrawBlendMode(renderer, mode)
        raise SDLError if err < 0

        mode.value
      end

      def render_blend_mode=(mode)
        err = int SDL_SetRenderDrawBlendMode(renderer, mode)
        raise SDLError if err < 0
      end

      def render_clear
        err = SDL.SDL_RenderClear(renderer)
        raise SDLError if err < 0
      end

      def render_clip
        r = Rect[]
        SDL.SDL_RenderGetClipRect(renderer, r)
        r.to_a
      end

      def render_clip=(rect)
        err = SDL.SDL_RenderSetClipRect(renderer, Rect[*rect])
        raise SDLError if err < 0
      end

      def render_clipped? = SDL.SDL_RenderIsClipEnabled(renderer) != 0

      def render_color
        r, g, b, a = SDL.tmp_value("Uint8", "Uint8", "Uint8", "Uint8")
        err = SDL.SDL_GetRenderDrawColor(renderer, r, g, b, a)
        raise SDLError if err < 0

        [r.value, g.value, b.value, a.value]
      end

      def render_color=(obj)
        r, g, b, a = *obj, SDL_ALPHA_OPAQUE
        err = SDL.SDL_SetRenderDrawColor(renderer, r, g, b, a)
        raise SDLError if err < 0
      end
    end
  end
end
