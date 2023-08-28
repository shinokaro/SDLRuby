module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  typealias "SDL_PowerState", "int"
  extern "SDL_PowerState SDL_GetPowerInfo(int *seconds, int *percent)"
end
