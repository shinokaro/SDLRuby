module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_video.h.rb'
  require_relative 'SDL_version.h.rb'

  typealias "NSWindow", "struct _NSWindow"
  typealias "UIWindow", "struct _UIWindow"
  typealias "UIViewController", "struct _UIViewController"
  typealias "GLuint", "Uint32"
  typealias "ANativeWindow", "struct ANativeWindow"
  typealias "EGLSurface", "void*"
  typealias "SDL_SysWMinfo", "struct SDL_SysWMinfo"
  typealias "SDL_SYSWM_TYPE", "int"
  extern "SDL_bool SDL_GetWindowWMInfo(SDL_Window *window, SDL_SysWMinfo *info)"
end
