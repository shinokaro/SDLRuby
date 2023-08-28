module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  extern "void SDL_GetVersion(SDL_version *ver)"
  extern "const char * SDL_GetRevision(void)"
end
