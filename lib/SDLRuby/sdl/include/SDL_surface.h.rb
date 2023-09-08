module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_pixels.h"
  require_relative "SDL_rect.h"
  require_relative "SDL_blendmode.h"
  require_relative "SDL_rwops.h"

  SDL_SWSURFACE = 0
  SDL_PREALLOC = 0x00000001
  SDL_RLEACCEL = 0x00000002
  SDL_DONTFREE = 0x00000004
  SDL_SIMD_ALIGNED = 0x00000008

  def self.SDL_MUSTLOCK(s)
    (((s).flags & SDL_RLEACCEL) != 0)
  end

  SDL_Surface = struct(
    [
      "Uint32 flags",
      "SDL_PixelFormat *format",
      "int w",
      "int h",
      "int pitch",
      "void *pixels",
      "void *userdata",
      "int locked",
      "void *list_blitmap",
      { clip_rect: SDL_Rect },
      "SDL_BlitMap *map",
      "int refcount",
    ]
  )

  typealias "SDL_blit", "void*"

  SDL_YUV_CONVERSION_JPEG = 0
  SDL_YUV_CONVERSION_BT601 = 1
  SDL_YUV_CONVERSION_BT709 = 2
  SDL_YUV_CONVERSION_AUTOMATIC = 3
  typealias "SDL_YUV_CONVERSION_MODE", "int"

  extern "SDL_Surface * SDL_CreateRGBSurface (Uint32 flags, int width, int height, int depth, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)"
  extern "SDL_Surface * SDL_CreateRGBSurfaceWithFormat (Uint32 flags, int width, int height, int depth, Uint32 format)"
  extern "SDL_Surface * SDL_CreateRGBSurfaceFrom(void *pixels, int width, int height, int depth, int pitch, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)"
  extern "SDL_Surface * SDL_CreateRGBSurfaceWithFormatFrom (void *pixels, int width, int height, int depth, int pitch, Uint32 format)"
  extern "void SDL_FreeSurface(SDL_Surface * surface)"
  extern "int SDL_SetSurfacePalette(SDL_Surface * surface, SDL_Palette * palette)"
  extern "int SDL_LockSurface(SDL_Surface * surface)"
  extern "void SDL_UnlockSurface(SDL_Surface * surface)"
  extern "SDL_Surface * SDL_LoadBMP_RW(SDL_RWops * src, int freesrc)"

  def self.SDL_LoadBMP(file)
    SDL_LoadBMP_RW(SDL_RWFromFile(file, "rb"), 1)
  end

  extern "int SDL_SaveBMP_RW (SDL_Surface * surface, SDL_RWops * dst, int freedst)"

  def self.SDL_SaveBMP(surface, file)
    SDL_SaveBMP_RW(surface, SDL_RWFromFile(file, "wb"), 1)
  end

  extern "int SDL_SetSurfaceRLE(SDL_Surface * surface, int flag)"
  extern "SDL_bool SDL_HasSurfaceRLE(SDL_Surface * surface)"
  extern "int SDL_SetColorKey(SDL_Surface * surface, int flag, Uint32 key)"
  extern "SDL_bool SDL_HasColorKey(SDL_Surface * surface)"
  extern "int SDL_GetColorKey(SDL_Surface * surface, Uint32 * key)"
  extern "int SDL_SetSurfaceColorMod(SDL_Surface * surface, Uint8 r, Uint8 g, Uint8 b)"
  extern "int SDL_GetSurfaceColorMod(SDL_Surface * surface, Uint8 * r, Uint8 * g, Uint8 * b)"
  extern "int SDL_SetSurfaceAlphaMod(SDL_Surface * surface, Uint8 alpha)"
  extern "int SDL_GetSurfaceAlphaMod(SDL_Surface * surface, Uint8 * alpha)"
  extern "int SDL_SetSurfaceBlendMode(SDL_Surface * surface, SDL_BlendMode blendMode)"
  extern "int SDL_GetSurfaceBlendMode(SDL_Surface * surface, SDL_BlendMode *blendMode)"
  extern "SDL_bool SDL_SetClipRect(SDL_Surface * surface, const SDL_Rect * rect)"
  extern "void SDL_GetClipRect(SDL_Surface * surface, SDL_Rect * rect)"
  extern "SDL_Surface * SDL_DuplicateSurface(SDL_Surface * surface)"
  extern "SDL_Surface * SDL_ConvertSurface (SDL_Surface * src, const SDL_PixelFormat * fmt, Uint32 flags)"
  extern "SDL_Surface * SDL_ConvertSurfaceFormat (SDL_Surface * src, Uint32 pixel_format, Uint32 flags)"
  extern "int SDL_ConvertPixels(int width, int height, Uint32 src_format, const void * src, int src_pitch, Uint32 dst_format, void * dst, int dst_pitch)"
  extern "int SDL_PremultiplyAlpha(int width, int height, Uint32 src_format, const void * src, int src_pitch, Uint32 dst_format, void * dst, int dst_pitch)"
  extern "int SDL_FillRect (SDL_Surface * dst, const SDL_Rect * rect, Uint32 color)"
  extern "int SDL_FillRects (SDL_Surface * dst, const SDL_Rect * rects, int count, Uint32 color)"
  extern "int SDL_UpperBlit (SDL_Surface * src, const SDL_Rect * srcrect, SDL_Surface * dst, SDL_Rect * dstrect)"
  class << self
    alias SDL_BlitSurface SDL_UpperBlit
  end
  alias SDL_BlitSurface SDL_UpperBlit
  extern "int SDL_LowerBlit (SDL_Surface * src, SDL_Rect * srcrect, SDL_Surface * dst, SDL_Rect * dstrect)"
  extern "int SDL_SoftStretch(SDL_Surface * src, const SDL_Rect * srcrect, SDL_Surface * dst, const SDL_Rect * dstrect)"
  extern "int SDL_SoftStretchLinear(SDL_Surface * src, const SDL_Rect * srcrect, SDL_Surface * dst, const SDL_Rect * dstrect)"
  extern "int SDL_UpperBlitScaled (SDL_Surface * src, const SDL_Rect * srcrect, SDL_Surface * dst, SDL_Rect * dstrect)"
  class << self
    alias SDL_BlitScaled SDL_UpperBlitScaled
  end
  alias SDL_BlitScaled SDL_UpperBlitScaled
  extern "int SDL_LowerBlitScaled (SDL_Surface * src, SDL_Rect * srcrect, SDL_Surface * dst, SDL_Rect * dstrect)"
  extern "void SDL_SetYUVConversionMode(SDL_YUV_CONVERSION_MODE mode)"
  extern "SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionMode(void)"
  extern "SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionModeForResolution(int width, int height)"
end
