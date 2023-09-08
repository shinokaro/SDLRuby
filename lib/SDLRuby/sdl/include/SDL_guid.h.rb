module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"

  SDL_GUID = struct(
    [
      "Uint8 data[16]"
    ]
  )

  # extern "void SDL_GUIDToString(SDL_GUID guid, char *pszGUID, int cbGUID)"
  # extern "SDL_GUID SDL_GUIDFromString(const char *pchGUID)"
end
