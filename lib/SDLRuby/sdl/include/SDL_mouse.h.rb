module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_video.h.rb'

  typealias "SDL_Cursor", "struct SDL_Cursor"
  typealias "SDL_SystemCursor", "int"
  typealias "SDL_MouseWheelDirection", "int"
  extern "SDL_Window * SDL_GetMouseFocus(void)"
  extern "Uint32 SDL_GetMouseState(int *x, int *y)"
  extern "Uint32 SDL_GetGlobalMouseState(int *x, int *y)"
  extern "Uint32 SDL_GetRelativeMouseState(int *x, int *y)"
  extern "void SDL_WarpMouseInWindow(SDL_Window *window, int x, int y)"
  extern "int SDL_WarpMouseGlobal(int x, int y)"
  extern "int SDL_SetRelativeMouseMode(SDL_bool enabled)"
  extern "int SDL_CaptureMouse(SDL_bool enabled)"
  extern "SDL_bool SDL_GetRelativeMouseMode(void)"
  extern "SDL_Cursor * SDL_CreateCursor(const Uint8 *data, const Uint8 *mask, int w, int h, int hot_x, int hot_y)"
  extern "SDL_Cursor * SDL_CreateColorCursor(SDL_Surface *surface, int hot_x, int hot_y)"
  extern "SDL_Cursor * SDL_CreateSystemCursor(SDL_SystemCursor id)"
  extern "void SDL_SetCursor(SDL_Cursor *cursor)"
  extern "SDL_Cursor * SDL_GetCursor(void)"
  extern "SDL_Cursor * SDL_GetDefaultCursor(void)"
  extern "void SDL_FreeCursor(SDL_Cursor *cursor)"
  extern "int SDL_ShowCursor(int toggle)"
end
