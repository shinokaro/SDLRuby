module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'

  extern "SDL_Locale * SDL_GetPreferredLocales(void)"
end
