module SDLRuby::SDL
  require_relative "SDL_stdinc.h"

  SDL_version = struct(
    [
      "Uint8 major",
      "Uint8 minor",
      "Uint8 patch",
    ]
  )

  extern "void SDL_GetVersion(SDL_version * ver)"
  extern "const char * SDL_GetRevision(void)"
end
