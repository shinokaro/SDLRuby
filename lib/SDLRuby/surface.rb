require_relative 'palette'
require_relative 'pixel_formatter'
require_relative 'renderer'
require_relative 'surface/pixel_format'
require_relative 'surface/surface_renderer'

module SDLRuby
  class Surface
    include PixelFormatter, Renderer, SDL, SurfaceRenderer
    extend Forwardable

    class << self
      include SDL

      def load(src)
        ptr = SDL.SDL_LoadBMP_RW(SDL.SDL_RWFromFile(src, "rb"), 1)
        raise SDLError if ptr.null?

        new(ptr)
      end

      def create(width, height, format = SDL_PIXELFORMAT_ARGB8888)
        ptr = SDL.SDL_CreateRGBSurfaceWithFormat(0, width, height, 0, format)
        raise SDLError if ptr.null?

        new(ptr)
      end
    end

    def initialize(ptr, add_ref: nil)
      @st = SDL_Surface.new(ptr, SDL_FREE_SURFACE)
      @st.refcount += 1 if add_ref

      @format = PixelFormat.new(@st.format, add_ref: true)
    end

    def_delegators :@st, :h, :pitch, :refcount, :to_ptr, :w
    def_delegators :@format, :format, :palette

    def palette=(pal)
      @format.palette = pal
    end

    def ==(other) = other.to_ptr == @st.to_ptr

    def alpha_mod
      v = SDL.tmp_value("Uint8")
      err = SDL.SDL_GetSurfaceAlphaMod(self, a)
      raise SDLError if err < 0
      v.value
    end

    def alpha_mod=(n)
      err = SDL.SDL_SetSurfaceAlphaMod(self, n)
      raise SDLError if err < 0
    end

    def blend_mode
      v = SDL.tmp_value("int")
      err = SDL.SDL_GetSurfaceBlendMode(self, blend_mode)
      raise SDLError if err < 0
      v.value
    end

    def blend_mode=(blend)
      err = SDL.SDL_SetSurfaceBlendMode(self, blend)
      raise SDLError if err < 0
    end

    def blit(src, src_rect: nil, dst_rect: nil)
      src_r &&= Rect[*src_rect]
      dst_r &&= Rect[*dst_rect]

      # src, dstのrectサイズが一致している場合、内部でSDL_BlitSurfaceを呼び出している。
      # Blit, BlitScaled 呼び出しの分岐は不要。
      #
      err = SDL.SDL_UpperBlitScaled(src, src_r, self, dst_r)
      raise SDLError if err < 0
    end

    def clear(color)
      err = SDL.SDL_FillRect(self, nil, @format.to_pixel(color))
      raise SDLError if err < 0
    end

    def clip
      r = Rect[]
      SDL.SDL_GetClipRect(self, r)
      r.to_a
    end

    def clip=(rect)
      SDL.SDL_SetClipRect(self, Rect[*rect])
    end

    def color_key
      v = SDL.tmp_value("Uint32")
      err = SDL.SDL_GetColorKey(self, v)
      raise SDLError if err < 0

      @format.to_color(v.value)
    end

    def color_key=(color)
      err = if color
              SDL.SDL_SetColorKey(self, 1, @format.to_pixel(color))
            else
              SDL.SDL_SetColorKey(self, 0, 0)
            end
      raise SDLError if err < 0
    end

    def color_key? = SDL.SDL_HasColorKey(self) == 1

    def color_mod
      r, g, b = SDL.tmp_value("Uint8", "Uint8", "Uint8")
      err = SDL.SDL_GetSurfaceColorMod(self, r, g, b)
      raise SDLError if err < 0

      [r.value, g.value, b.value]
    end

    def color_mod=(color)
      r, g, b = *color
      err = SDL.SDL_SetSurfaceColorMod(self, r, g, b)
      raise SDLError if err < 0
    end

    def fill(color, *i)
      size = f.count
      count = size / 4
      raise ArgumentError if count.zero? || (size % 4).nonzero?
      ptr = i.pack("i*")

      err = SDL.SDL_FillRects(self, ptr, count, @format.to_pixel(color))
      raise SDLError if err < 0
    end

    def lock
      err = SDL.SDL_LockSurface(self)
      raise SDLError if err < 0
    end

    def rle? = SDL.SDL_HasSurfaceRLE(self) != 0

    def rle=(b)
      err = SDL.SDL_SetSurfaceRLE(self, b ? 1 : 0)
      raise SDLError if err < 0
    end

    def save(file)
      err = SDL.SDL_SaveBMP_RW(self, SDL.SDL_RWFromFile(src, "rb"), 1)
      raise SDLError if err < 0
    end

    def size = [w, h]

    def synchronize(&)
      lock
      begin
        yield
      ensure
        unlock
      end
    end

    def to_s = synchronize { @st.pixels.to_str(h * pitch) }

    def to_surface(format = nil)
      return self unless format

      ptr = SDL.SDL_ConvertSurface(self, format, 0)
      raise SDLError if ptr.null?
      Surface.new(ptr)
    end

    def unlock = SDL.SDL_UnlockSurface(self)
  end
end
