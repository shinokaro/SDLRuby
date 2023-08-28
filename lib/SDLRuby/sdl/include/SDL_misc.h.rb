module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  extern "int SDL_OpenURL(const char *url)"
end
