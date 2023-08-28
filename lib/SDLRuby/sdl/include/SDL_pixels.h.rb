module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_endian.h.rb'

  typealias "SDL_PixelType", "int"
  typealias "SDL_BitmapOrder", "int"
  typealias "SDL_PackedOrder", "int"
  typealias "SDL_ArrayOrder", "int"
  typealias "SDL_PackedLayout", "int"
  typealias "SDL_PixelFormatEnum", "int"
  extern "const char* SDL_GetPixelFormatName(Uint32 format)"
  extern "SDL_bool SDL_PixelFormatEnumToMasks(Uint32 format, int *bpp, Uint32 *Rmask, Uint32 *Gmask, Uint32 *Bmask, Uint32 *Amask)"
  extern "Uint32 SDL_MasksToPixelFormatEnum(int bpp, Uint32 Rmask, Uint32 Gmask, Uint32 Bmask, Uint32 Amask)"
  extern "SDL_PixelFormat * SDL_AllocFormat(Uint32 pixel_format)"
  extern "void SDL_FreeFormat(SDL_PixelFormat *format)"
  extern "SDL_Palette * SDL_AllocPalette(int ncolors)"
  extern "int SDL_SetPixelFormatPalette(SDL_PixelFormat *format, SDL_Palette *palette)"
  extern "int SDL_SetPaletteColors(SDL_Palette *palette, const SDL_Color *colors, int firstcolor, int ncolors)"
  extern "void SDL_FreePalette(SDL_Palette *palette)"
  extern "Uint32 SDL_MapRGB(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b)"
  extern "Uint32 SDL_MapRGBA(const SDL_PixelFormat *format, Uint8 r, Uint8 g, Uint8 b, Uint8 a)"
  extern "void SDL_GetRGB(Uint32 pixel, const SDL_PixelFormat *format, Uint8 *r, Uint8 *g, Uint8 *b)"
  extern "void SDL_GetRGBA(Uint32 pixel, const SDL_PixelFormat *format, Uint8 *r, Uint8 *g, Uint8 *b, Uint8 *a)"
  extern "void SDL_CalculateGammaRamp(float gamma, Uint16 *ramp)"
end
