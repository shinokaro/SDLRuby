module SDLRuby
  class Surface
    class PixelFormat
      include SDL
      extend Forwardable

      def initialize(ptr, add_ref: nil)
        @st = SDL_PixelFormat.new(ptr, SDL_FREE_FORMAT)
        @st.refcount += 1 if add_ref
      end

      def_delegators :@st, :format, :refcount, :to_ptr

      def map(color)
        if alpha?
          r, g, b, a = *color, SDL_ALPHA_OPAQUE
          SDL.SDL_MapRGBA(self, r, g, b, a)
        else
          r, g, b = *color
          SDL.SDL_MapRGB(self, r, g, b)
        end
      end

      alias to_pixel map

      def palette
        ptr = @st.palette
        return if ptr.null?

        Palette.new(ptr, add_ref: true)
      end

      def palette=(obj)
        err = SDL.SDL_SetPixelFormatPalette(self, obj)
        raise SDLError if err < 0
      end

      def to_color(pixel)
        if alpha?
          r, g, b, a = SDL.tmp_value("Uint8", "Uint8", "Uint8", "Uint8")
          SDL.SDL_GetRGBA(pixel, self, r, g, b, a)
          [r.value, g.value, b.value, a.value]
        else
          r, g, b = SDL.tmp_value("Uint8", "Uint8", "Uint8")
          SDL.SDL_GetRGB(pixel, self, r, g, b)
          [r.value, g.value, b.value]
        end
      end
    end
  end
end
