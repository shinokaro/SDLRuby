module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  extern "char * SDL_GetBasePath(void)"
  extern "char * SDL_GetPrefPath(const char *org, const char *app)"
end
