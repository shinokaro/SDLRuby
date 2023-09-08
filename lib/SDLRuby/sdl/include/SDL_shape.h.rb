module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_pixels.h"
  require_relative "SDL_rect.h"
  require_relative "SDL_surface.h"
  require_relative "SDL_video.h"

  SDL_NONSHAPEABLE_WINDOW = -1
  SDL_INVALID_SHAPE_ARGUMENT = -2
  SDL_WINDOW_LACKS_SHAPE = -3

  extern "SDL_Window * SDL_CreateShapedWindow(const char *title,unsigned int x,unsigned int y,unsigned int w,unsigned int h,Uint32 flags)"
  extern "SDL_bool SDL_IsShapedWindow(const SDL_Window *window)"

  ShapeModeDefault = 0
  ShapeModeBinarizeAlpha = 1
  ShapeModeReverseBinarizeAlpha = 2
  ShapeModeColorKey = 3
  typealias "WindowShapeMode", "int"

  def self.SDL_SHAPEMODEALPHA(mode)
    (mode == ShapeModeDefault || mode == ShapeModeBinarizeAlpha || mode == ShapeModeReverseBinarizeAlpha)
  end

  SDL_WindowShapeParams = union(
    [
      "Uint8 binarizationCutoff",
      { colorKey: SDL_Color }
    ]
  )
  SDL_WindowShapeMode = struct(
    [
      "WindowShapeMode mode",
      { parameters: SDL_WindowShapeParams }
    ]
  )

  extern "int SDL_SetWindowShape(SDL_Window *window,SDL_Surface *shape,SDL_WindowShapeMode *shape_mode)"
  extern "int SDL_GetShapedWindowMode(SDL_Window *window,SDL_WindowShapeMode *shape_mode)"
end
