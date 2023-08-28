module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  typealias "SDL_HintPriority", "int"
  extern "SDL_bool SDL_SetHintWithPriority(const char *name, const char *value, SDL_HintPriority priority)"
  extern "SDL_bool SDL_SetHint(const char *name, const char *value)"
  extern "SDL_bool SDL_ResetHint(const char *name)"
  extern "void SDL_ResetHints(void)"
  extern "const char * SDL_GetHint(const char *name)"
  extern "SDL_bool SDL_GetHintBoolean(const char *name, SDL_bool default_value)"
  extern "void SDL_AddHintCallback(const char *name, SDL_HintCallback callback, void *userdata)"
  extern "void SDL_DelHintCallback(const char *name, SDL_HintCallback callback, void *userdata)"
  extern "void SDL_ClearHints(void)"
end
