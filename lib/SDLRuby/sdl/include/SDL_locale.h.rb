module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"

  SDL_Locale = struct(
    [
      "const char *language",
      "const char *country",
    ]
  )

  extern "SDL_Locale * SDL_GetPreferredLocales(void)"
end
