module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'

  extern "int SDL_SetClipboardText(const char *text)"
  extern "char * SDL_GetClipboardText(void)"
  extern "SDL_bool SDL_HasClipboardText(void)"
  extern "int SDL_SetPrimarySelectionText(const char *text)"
  extern "char * SDL_GetPrimarySelectionText(void)"
  extern "SDL_bool SDL_HasPrimarySelectionText(void)"
end
