module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  typealias "SDL_errorcode", "int"
  extern "const char * SDL_GetError(void)"
  extern "char * SDL_GetErrorMsg(char *errstr, int maxlen)"
  extern "void SDL_ClearError(void)"
  extern "int SDL_Error(SDL_errorcode code)"
end
