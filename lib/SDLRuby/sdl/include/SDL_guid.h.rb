module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'

  extern "void SDL_GUIDToString(SDL_GUID guid, char *pszGUID, int cbGUID)"
  extern "SDL_GUID SDL_GUIDFromString(const char *pchGUID)"
end
