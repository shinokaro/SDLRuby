module SDLRuby
  class Texture
    require_relative 'pixel_formatter'

    include PixelFormatter, SDL

    attr_reader :format, :h, :w

    def initialize(ptr)
      ptr.free = SDL_DESTROY_TEXTURE
      @ptr = ptr

      query
    end

    def alpha_mod
      v = SDL.tmp_value("Uint8")
      err = SDL.SDL_GetTextureAlphaMod(self, v)
      raise SDLError if err < 0

      v.value
    end

    def alpha_mod=(n)
      err = SDL.SDL_SetTextureAlphaMod(self, n)
      raise SDLError if err < 0
    end

    def blend_mode
      v = SDL.tmp_value("int")
      err = SDL.SDL_GetTextureBlendMode(self, v)
      raise SDLError if err < 0

      v.value
    end

    def blend_mode=(n)
      err = SDL.SDL_SetTextureBlendMode(self, n)
      raise SDLError if err < 0
    end

    def color_mod
      r, g, b = SDL.tmp_value("Uint8", "Uint8", "Uint8")
      err = SDL.SDL_GetTextureColorMod(self, r, g, b)
      raise SDLError if err < 0

      [r.value, g.value, b.value]
    end

    def color_mod=(color)
      r, g, b = *color
      err = SDL.SDL_SetTextureColorMod(self, r, g, b)
      raise SDLError if err < 0
    end

    private def query
      format, access, w, h = SDL.tmp_value("Uint32", "int", "int", "int")
      err = SDL.SDL_QueryTexture(@ptr, format, access, w, h)
      raise SDLError if err < 0

      @format = format.value
      @access = access.value
      @w = w.value
      @h = h.value
    end

    def scale_mode
      v = SDL.tmp_value("int")
      err = SDL.SDL_GetTextureScaleMode(self, v)
      raise SDLError if err < 0

      v.value
    end

    def scale_mode=(n)
      err = SDL.SDL_SetTextureScaleMode(self, n)
      raise SDLError if err < 0
    end

    def size = [@w, @h]

    def to_ptr = @ptr

    def to_surface
      ptr = SDL.tmp_value("void*")
      err = SDL.SDL_LockTextureToSurface(self, nil, ptr)
      raise SDLError if err < 0
      SDL.SDL_UnlockTexture(self)

      Surface.new(ptr.value)
    end
  end
end
