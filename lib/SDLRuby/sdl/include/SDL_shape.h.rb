module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_pixels.h.rb'
  require_relative 'SDL_rect.h.rb'
  require_relative 'SDL_surface.h.rb'
  require_relative 'SDL_video.h.rb'

  typealias "WindowShapeMode", "int"
  extern "SDL_Window * SDL_CreateShapedWindow(const char *title,unsigned int x,unsigned int y,unsigned int w,unsigned int h,Uint32 flags)"
  extern "SDL_bool SDL_IsShapedWindow(const SDL_Window *window)"
  extern "int SDL_SetWindowShape(SDL_Window *window,SDL_Surface *shape,SDL_WindowShapeMode *shape_mode)"
  extern "int SDL_GetShapedWindowMode(SDL_Window *window,SDL_WindowShapeMode *shape_mode)"
end
