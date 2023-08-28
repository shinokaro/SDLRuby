module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_pixels.h.rb'
  require_relative 'SDL_rect.h.rb'
  require_relative 'SDL_blendmode.h.rb'
  require_relative 'SDL_rwops.h.rb'

  typealias "SDL_BlitMap", "struct SDL_BlitMap"
  typealias "SDL_YUV_CONVERSION_MODE", "int"
  extern "SDL_Surface * SDL_CreateRGBSurfaceFrom(void *pixels, int width, int height, int depth, int pitch, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)"
  extern "void SDL_FreeSurface(SDL_Surface *surface)"
  extern "int SDL_SetSurfacePalette(SDL_Surface *surface, SDL_Palette *palette)"
  extern "int SDL_LockSurface(SDL_Surface *surface)"
  extern "void SDL_UnlockSurface(SDL_Surface *surface)"
  extern "SDL_Surface * SDL_LoadBMP_RW(SDL_RWops *src, int freesrc)"
  extern "int SDL_SetSurfaceRLE(SDL_Surface *surface, int flag)"
  extern "SDL_bool SDL_HasSurfaceRLE(SDL_Surface *surface)"
  extern "int SDL_SetColorKey(SDL_Surface *surface, int flag, Uint32 key)"
  extern "SDL_bool SDL_HasColorKey(SDL_Surface *surface)"
  extern "int SDL_GetColorKey(SDL_Surface *surface, Uint32 *key)"
  extern "int SDL_SetSurfaceColorMod(SDL_Surface *surface, Uint8 r, Uint8 g, Uint8 b)"
  extern "int SDL_GetSurfaceColorMod(SDL_Surface *surface, Uint8 *r, Uint8 *g, Uint8 *b)"
  extern "int SDL_SetSurfaceAlphaMod(SDL_Surface *surface, Uint8 alpha)"
  extern "int SDL_GetSurfaceAlphaMod(SDL_Surface *surface, Uint8 *alpha)"
  extern "int SDL_SetSurfaceBlendMode(SDL_Surface *surface, SDL_BlendMode blendMode)"
  extern "int SDL_GetSurfaceBlendMode(SDL_Surface *surface, SDL_BlendMode *blendMode)"
  extern "SDL_bool SDL_SetClipRect(SDL_Surface *surface, const SDL_Rect *rect)"
  extern "void SDL_GetClipRect(SDL_Surface *surface, SDL_Rect *rect)"
  extern "SDL_Surface * SDL_DuplicateSurface(SDL_Surface *surface)"
  extern "int SDL_ConvertPixels(int width, int height, Uint32 src_format, const void *src, int src_pitch, Uint32 dst_format, void *dst, int dst_pitch)"
  extern "int SDL_PremultiplyAlpha(int width, int height, Uint32 src_format, const void *src, int src_pitch, Uint32 dst_format, void *dst, int dst_pitch)"
  extern "int SDL_SoftStretch(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect)"
  extern "int SDL_SoftStretchLinear(SDL_Surface *src, const SDL_Rect *srcrect, SDL_Surface *dst, const SDL_Rect *dstrect)"
  extern "void SDL_SetYUVConversionMode(SDL_YUV_CONVERSION_MODE mode)"
  extern "SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionMode(void)"
  extern "SDL_YUV_CONVERSION_MODE SDL_GetYUVConversionModeForResolution(int width, int height)"
end
