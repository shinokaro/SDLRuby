module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_keycode.h.rb'
  require_relative 'SDL_video.h.rb'

  extern "SDL_Window * SDL_GetKeyboardFocus(void)"
  extern "const Uint8 * SDL_GetKeyboardState(int *numkeys)"
  extern "void SDL_ResetKeyboard(void)"
  extern "SDL_Keymod SDL_GetModState(void)"
  extern "void SDL_SetModState(SDL_Keymod modstate)"
  extern "SDL_Keycode SDL_GetKeyFromScancode(SDL_Scancode scancode)"
  extern "SDL_Scancode SDL_GetScancodeFromKey(SDL_Keycode key)"
  extern "const char * SDL_GetScancodeName(SDL_Scancode scancode)"
  extern "SDL_Scancode SDL_GetScancodeFromName(const char *name)"
  extern "const char * SDL_GetKeyName(SDL_Keycode key)"
  extern "SDL_Keycode SDL_GetKeyFromName(const char *name)"
  extern "void SDL_StartTextInput(void)"
  extern "SDL_bool SDL_IsTextInputActive(void)"
  extern "void SDL_StopTextInput(void)"
  extern "void SDL_ClearComposition(void)"
  extern "SDL_bool SDL_IsTextInputShown(void)"
  extern "void SDL_SetTextInputRect(const SDL_Rect *rect)"
  extern "SDL_bool SDL_HasScreenKeyboardSupport(void)"
  extern "SDL_bool SDL_IsScreenKeyboardShown(SDL_Window *window)"
end
