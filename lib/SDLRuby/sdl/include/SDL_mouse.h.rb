module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"
  require_relative "SDL_video.h"

  SDL_SYSTEM_CURSOR_ARROW = 0
  SDL_SYSTEM_CURSOR_IBEAM = 1
  SDL_SYSTEM_CURSOR_WAIT = 2
  SDL_SYSTEM_CURSOR_CROSSHAIR = 3
  SDL_SYSTEM_CURSOR_WAITARROW = 4
  SDL_SYSTEM_CURSOR_SIZENWSE = 5
  SDL_SYSTEM_CURSOR_SIZENESW = 6
  SDL_SYSTEM_CURSOR_SIZEWE = 7
  SDL_SYSTEM_CURSOR_SIZENS = 8
  SDL_SYSTEM_CURSOR_SIZEALL = 9
  SDL_SYSTEM_CURSOR_NO = 10
  SDL_SYSTEM_CURSOR_HAND = 11
  SDL_NUM_SYSTEM_CURSORS = 12
  typealias "SDL_SystemCursor", "int"

  SDL_MOUSEWHEEL_NORMAL = 0
  SDL_MOUSEWHEEL_FLIPPED = 1
  typealias "SDL_MouseWheelDirection", "int"

  extern "SDL_Window * SDL_GetMouseFocus(void)"
  extern "Uint32 SDL_GetMouseState(int *x, int *y)"
  extern "Uint32 SDL_GetGlobalMouseState(int *x, int *y)"
  extern "Uint32 SDL_GetRelativeMouseState(int *x, int *y)"
  extern "void SDL_WarpMouseInWindow(SDL_Window * window, int x, int y)"
  extern "int SDL_WarpMouseGlobal(int x, int y)"
  extern "int SDL_SetRelativeMouseMode(SDL_bool enabled)"
  extern "int SDL_CaptureMouse(SDL_bool enabled)"
  extern "SDL_bool SDL_GetRelativeMouseMode(void)"
  extern "SDL_Cursor * SDL_CreateCursor(const Uint8 * data, const Uint8 * mask, int w, int h, int hot_x, int hot_y)"
  extern "SDL_Cursor * SDL_CreateColorCursor(SDL_Surface *surface, int hot_x, int hot_y)"
  extern "SDL_Cursor * SDL_CreateSystemCursor(SDL_SystemCursor id)"
  extern "void SDL_SetCursor(SDL_Cursor * cursor)"
  extern "SDL_Cursor * SDL_GetCursor(void)"
  extern "SDL_Cursor * SDL_GetDefaultCursor(void)"
  extern "void SDL_FreeCursor(SDL_Cursor * cursor)"
  extern "int SDL_ShowCursor(int toggle)"

  def self.SDL_BUTTON(x)
    (1 << ((x)-1))
  end

  SDL_BUTTON_LEFT = 1
  SDL_BUTTON_MIDDLE = 2
  SDL_BUTTON_RIGHT = 3
  SDL_BUTTON_X1 = 4
  SDL_BUTTON_X2 = 5
  SDL_BUTTON_LMASK = SDL_BUTTON(SDL_BUTTON_LEFT)
  SDL_BUTTON_MMASK = SDL_BUTTON(SDL_BUTTON_MIDDLE)
  SDL_BUTTON_RMASK = SDL_BUTTON(SDL_BUTTON_RIGHT)
  SDL_BUTTON_X1MASK = SDL_BUTTON(SDL_BUTTON_X1)
  SDL_BUTTON_X2MASK = SDL_BUTTON(SDL_BUTTON_X2)
end
