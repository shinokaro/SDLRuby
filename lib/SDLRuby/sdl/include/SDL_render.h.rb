module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_rect.h"
  require_relative "SDL_video.h"

  SDL_RENDERER_SOFTWARE = 0x00000001,
    SDL_RENDERER_ACCELERATED = 0x00000002,
    SDL_RENDERER_PRESENTVSYNC = 0x00000004,
    SDL_RENDERER_TARGETTEXTURE = 0x00000008
  typealias "SDL_RendererFlags", "int"

  SDL_RendererInfo = struct(
    [
      "const char *name",
      "Uint32 flags",
      "Uint32 num_texture_formats",
      "Uint32 texture_formats[16]",
      "int max_texture_width",
      "int max_texture_height",
    ]
  )
  SDL_Vertex = struct(
    [
      position: SDL_FPoint,
      color: SDL_Color,
      tex_coord: SDL_FPoint,
    ]
  )

  SDL_ScaleModeNearest = 0
  SDL_ScaleModeLinear = 1
  SDL_ScaleModeBest = 2
  typealias "SDL_ScaleMode", "int"

  SDL_TEXTUREACCESS_STATIC = 0
  SDL_TEXTUREACCESS_STREAMING = 1
  SDL_TEXTUREACCESS_TARGET = 2
  typealias "SDL_TextureAccess", "int"

  SDL_TEXTUREMODULATE_NONE = 0x00000000
  SDL_TEXTUREMODULATE_COLOR = 0x00000001
  SDL_TEXTUREMODULATE_ALPHA = 0x00000002
  typealias "SDL_TextureModulate", "int"

  SDL_FLIP_NONE = 0x00000000
  SDL_FLIP_HORIZONTAL = 0x00000001
  SDL_FLIP_VERTICAL = 0x00000002
  typealias "SDL_RendererFlip", "int"

  extern "int SDL_GetNumRenderDrivers(void)"
  extern "int SDL_GetRenderDriverInfo(int index, SDL_RendererInfo * info)"
  extern "int SDL_CreateWindowAndRenderer( int width, int height, Uint32 window_flags, SDL_Window **window, SDL_Renderer **renderer)"
  extern "SDL_Renderer * SDL_CreateRenderer(SDL_Window * window, int index, Uint32 flags)"
  extern "SDL_Renderer * SDL_CreateSoftwareRenderer(SDL_Surface * surface)"
  extern "SDL_Renderer * SDL_GetRenderer(SDL_Window * window)"
  extern "SDL_Window * SDL_RenderGetWindow(SDL_Renderer *renderer)"
  extern "int SDL_GetRendererInfo(SDL_Renderer * renderer, SDL_RendererInfo * info)"
  extern "int SDL_GetRendererOutputSize(SDL_Renderer * renderer, int *w, int *h)"
  extern "SDL_Texture * SDL_CreateTexture(SDL_Renderer * renderer, Uint32 format, int access, int w, int h)"
  extern "SDL_Texture * SDL_CreateTextureFromSurface(SDL_Renderer * renderer, SDL_Surface * surface)"
  extern "int SDL_QueryTexture(SDL_Texture * texture, Uint32 * format, int *access, int *w, int *h)"
  extern "int SDL_SetTextureColorMod(SDL_Texture * texture, Uint8 r, Uint8 g, Uint8 b)"
  extern "int SDL_GetTextureColorMod(SDL_Texture * texture, Uint8 * r, Uint8 * g, Uint8 * b)"
  extern "int SDL_SetTextureAlphaMod(SDL_Texture * texture, Uint8 alpha)"
  extern "int SDL_GetTextureAlphaMod(SDL_Texture * texture, Uint8 * alpha)"
  extern "int SDL_SetTextureBlendMode(SDL_Texture * texture, SDL_BlendMode blendMode)"
  extern "int SDL_GetTextureBlendMode(SDL_Texture * texture, SDL_BlendMode *blendMode)"
  extern "int SDL_SetTextureScaleMode(SDL_Texture * texture, SDL_ScaleMode scaleMode)"
  extern "int SDL_GetTextureScaleMode(SDL_Texture * texture, SDL_ScaleMode *scaleMode)"
  extern "int SDL_SetTextureUserData(SDL_Texture * texture, void *userdata)"
  extern "void * SDL_GetTextureUserData(SDL_Texture * texture)"
  extern "int SDL_UpdateTexture(SDL_Texture * texture, const SDL_Rect * rect, const void *pixels, int pitch)"
  extern "int SDL_UpdateYUVTexture(SDL_Texture * texture, const SDL_Rect * rect, const Uint8 *Yplane, int Ypitch, const Uint8 *Uplane, int Upitch, const Uint8 *Vplane, int Vpitch)"
  extern "int SDL_UpdateNVTexture(SDL_Texture * texture, const SDL_Rect * rect, const Uint8 *Yplane, int Ypitch, const Uint8 *UVplane, int UVpitch)"
  extern "int SDL_LockTexture(SDL_Texture * texture, const SDL_Rect * rect, void **pixels, int *pitch)"
  extern "int SDL_LockTextureToSurface(SDL_Texture *texture, const SDL_Rect *rect, SDL_Surface **surface)"
  extern "void SDL_UnlockTexture(SDL_Texture * texture)"
  extern "SDL_bool SDL_RenderTargetSupported(SDL_Renderer *renderer)"
  extern "int SDL_SetRenderTarget(SDL_Renderer *renderer, SDL_Texture *texture)"
  extern "SDL_Texture * SDL_GetRenderTarget(SDL_Renderer *renderer)"
  extern "int SDL_RenderSetLogicalSize(SDL_Renderer * renderer, int w, int h)"
  extern "void SDL_RenderGetLogicalSize(SDL_Renderer * renderer, int *w, int *h)"
  extern "int SDL_RenderSetIntegerScale(SDL_Renderer * renderer, SDL_bool enable)"
  extern "SDL_bool SDL_RenderGetIntegerScale(SDL_Renderer * renderer)"
  extern "int SDL_RenderSetViewport(SDL_Renderer * renderer, const SDL_Rect * rect)"
  extern "void SDL_RenderGetViewport(SDL_Renderer * renderer, SDL_Rect * rect)"
  extern "int SDL_RenderSetClipRect(SDL_Renderer * renderer, const SDL_Rect * rect)"
  extern "void SDL_RenderGetClipRect(SDL_Renderer * renderer, SDL_Rect * rect)"
  extern "SDL_bool SDL_RenderIsClipEnabled(SDL_Renderer * renderer)"
  extern "int SDL_RenderSetScale(SDL_Renderer * renderer, float scaleX, float scaleY)"
  extern "void SDL_RenderGetScale(SDL_Renderer * renderer, float *scaleX, float *scaleY)"
  extern "void SDL_RenderWindowToLogical(SDL_Renderer * renderer, int windowX, int windowY, float *logicalX, float *logicalY)"
  extern "void SDL_RenderLogicalToWindow(SDL_Renderer * renderer, float logicalX, float logicalY, int *windowX, int *windowY)"
  extern "int SDL_SetRenderDrawColor(SDL_Renderer * renderer, Uint8 r, Uint8 g, Uint8 b, Uint8 a)"
  extern "int SDL_GetRenderDrawColor(SDL_Renderer * renderer, Uint8 * r, Uint8 * g, Uint8 * b, Uint8 * a)"
  extern "int SDL_SetRenderDrawBlendMode(SDL_Renderer * renderer, SDL_BlendMode blendMode)"
  extern "int SDL_GetRenderDrawBlendMode(SDL_Renderer * renderer, SDL_BlendMode *blendMode)"
  extern "int SDL_RenderClear(SDL_Renderer * renderer)"
  extern "int SDL_RenderDrawPoint(SDL_Renderer * renderer, int x, int y)"
  extern "int SDL_RenderDrawPoints(SDL_Renderer * renderer, const SDL_Point * points, int count)"
  extern "int SDL_RenderDrawLine(SDL_Renderer * renderer, int x1, int y1, int x2, int y2)"
  extern "int SDL_RenderDrawLines(SDL_Renderer * renderer, const SDL_Point * points, int count)"
  extern "int SDL_RenderDrawRect(SDL_Renderer * renderer, const SDL_Rect * rect)"
  extern "int SDL_RenderDrawRects(SDL_Renderer * renderer, const SDL_Rect * rects, int count)"
  extern "int SDL_RenderFillRect(SDL_Renderer * renderer, const SDL_Rect * rect)"
  extern "int SDL_RenderFillRects(SDL_Renderer * renderer, const SDL_Rect * rects, int count)"
  extern "int SDL_RenderCopy(SDL_Renderer * renderer, SDL_Texture * texture, const SDL_Rect * srcrect, const SDL_Rect * dstrect)"
  extern "int SDL_RenderCopyEx(SDL_Renderer * renderer, SDL_Texture * texture, const SDL_Rect * srcrect, const SDL_Rect * dstrect, const double angle, const SDL_Point *center, const SDL_RendererFlip flip)"
  extern "int SDL_RenderDrawPointF(SDL_Renderer * renderer, float x, float y)"
  extern "int SDL_RenderDrawPointsF(SDL_Renderer * renderer, const SDL_FPoint * points, int count)"
  extern "int SDL_RenderDrawLineF(SDL_Renderer * renderer, float x1, float y1, float x2, float y2)"
  extern "int SDL_RenderDrawLinesF(SDL_Renderer * renderer, const SDL_FPoint * points, int count)"
  extern "int SDL_RenderDrawRectF(SDL_Renderer * renderer, const SDL_FRect * rect)"
  extern "int SDL_RenderDrawRectsF(SDL_Renderer * renderer, const SDL_FRect * rects, int count)"
  extern "int SDL_RenderFillRectF(SDL_Renderer * renderer, const SDL_FRect * rect)"
  extern "int SDL_RenderFillRectsF(SDL_Renderer * renderer, const SDL_FRect * rects, int count)"
  extern "int SDL_RenderCopyF(SDL_Renderer * renderer, SDL_Texture * texture, const SDL_Rect * srcrect, const SDL_FRect * dstrect)"
  extern "int SDL_RenderCopyExF(SDL_Renderer * renderer, SDL_Texture * texture, const SDL_Rect * srcrect, const SDL_FRect * dstrect, const double angle, const SDL_FPoint *center, const SDL_RendererFlip flip)"
  extern "int SDL_RenderGeometry(SDL_Renderer *renderer, SDL_Texture *texture, const SDL_Vertex *vertices, int num_vertices, const int *indices, int num_indices)"
  extern "int SDL_RenderGeometryRaw(SDL_Renderer *renderer, SDL_Texture *texture, const float *xy, int xy_stride, const SDL_Color *color, int color_stride, const float *uv, int uv_stride, int num_vertices, const void *indices, int num_indices, int size_indices)"
  extern "int SDL_RenderReadPixels(SDL_Renderer * renderer, const SDL_Rect * rect, Uint32 format, void *pixels, int pitch)"
  extern "void SDL_RenderPresent(SDL_Renderer * renderer)"
  extern "void SDL_DestroyTexture(SDL_Texture * texture)"
  extern "void SDL_DestroyRenderer(SDL_Renderer * renderer)"
  extern "int SDL_RenderFlush(SDL_Renderer * renderer)"
  extern "int SDL_GL_BindTexture(SDL_Texture *texture, float *texw, float *texh)"
  extern "int SDL_GL_UnbindTexture(SDL_Texture *texture)"
  extern "void * SDL_RenderGetMetalLayer(SDL_Renderer * renderer)"
  extern "void * SDL_RenderGetMetalCommandEncoder(SDL_Renderer * renderer)"
  extern "int SDL_RenderSetVSync(SDL_Renderer* renderer, int vsync)"
end
