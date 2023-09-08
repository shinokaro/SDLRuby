module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_video.h.rb'
  require_relative 'SDL_version.h.rb'

  typealias "SDL_SysWMinfo", "struct SDL_SysWMinfo"

  extern "SDL_bool SDL_GetWindowWMInfo(SDL_Window *window, SDL_SysWMinfo *info)"
end
