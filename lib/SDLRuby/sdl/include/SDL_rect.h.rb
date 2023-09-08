module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"
  require_relative "SDL_pixels.h"
  require_relative "SDL_rwops.h"

  SDL_Point = struct(
    [
      "int x",
      "int y",
    ]
  )
  SDL_FPoint = struct(
    [
      "float x",
      "float y",
    ]
  )
  SDL_Rect = struct(
    [
      "int x",
      "int y",
      "int w",
      "int h",
    ]
  )
  SDL_FRect = struct(
    [
      "float x",
      "float y",
      "float w",
      "float h",
    ]
  )

  extern "SDL_bool SDL_HasIntersection(const SDL_Rect * A, const SDL_Rect * B)"
  extern "SDL_bool SDL_IntersectRect(const SDL_Rect * A, const SDL_Rect * B, SDL_Rect * result)"
  extern "void SDL_UnionRect(const SDL_Rect * A, const SDL_Rect * B, SDL_Rect * result)"
  extern "SDL_bool SDL_EnclosePoints(const SDL_Point * points, int count, const SDL_Rect * clip, SDL_Rect * result)"
  extern "SDL_bool SDL_IntersectRectAndLine(const SDL_Rect * rect, int *X1, int *Y1, int *X2, int *Y2)"
  extern "SDL_bool SDL_HasIntersectionF(const SDL_FRect * A, const SDL_FRect * B)"
  extern "SDL_bool SDL_IntersectFRect(const SDL_FRect * A, const SDL_FRect * B, SDL_FRect * result)"
  extern "void SDL_UnionFRect(const SDL_FRect * A, const SDL_FRect * B, SDL_FRect * result)"
  extern "SDL_bool SDL_EncloseFPoints(const SDL_FPoint * points, int count, const SDL_FRect * clip, SDL_FRect * result)"
  extern "SDL_bool SDL_IntersectFRectAndLine(const SDL_FRect * rect, float *X1, float *Y1, float *X2, float *Y2)"
end
