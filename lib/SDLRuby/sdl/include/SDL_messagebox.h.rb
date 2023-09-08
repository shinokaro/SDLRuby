module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_video.h"

  SDL_MESSAGEBOX_ERROR = 0x00000010
  SDL_MESSAGEBOX_WARNING = 0x00000020
  SDL_MESSAGEBOX_INFORMATION = 0x00000040
  SDL_MESSAGEBOX_BUTTONS_LEFT_TO_RIGHT = 0x00000080
  SDL_MESSAGEBOX_BUTTONS_RIGHT_TO_LEFT = 0x00000100
  typealias "SDL_MessageBoxFlags", "int"

  SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT = 0x00000001
  SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT = 0x00000002
  typealias "SDL_MessageBoxButtonFlags", "int"

  SDL_MessageBoxButtonData = struct(
    [
      "Uint32 flags",
      "int buttonid",
      "const char * text",
    ]
  )
  SDL_MessageBoxColor = struct(
    [
      "Uint8 r",
      "Uint8 g",
      "Uint8 b",
    ]
  )

  SDL_MESSAGEBOX_COLOR_BACKGROUND = 0
  SDL_MESSAGEBOX_COLOR_TEXT = 1
  SDL_MESSAGEBOX_COLOR_BUTTON_BORDER = 2
  SDL_MESSAGEBOX_COLOR_BUTTON_BACKGROUND = 3
  SDL_MESSAGEBOX_COLOR_BUTTON_SELECTED = 4
  SDL_MESSAGEBOX_COLOR_MAX = 5
  typealias "SDL_MessageBoxColorType", "int"

  SDL_MessageBoxColorScheme = struct(
    [
      "colors[#{SDL_MESSAGEBOX_COLOR_MAX}]": SDL_MessageBoxColor
    ]
  )
  SDL_MessageBoxData = struct(
    [
      "Uint32 flags",
      "SDL_Window *window",
      "const char *title",
      "const char *message",
      "int numbuttons",
      "const SDL_MessageBoxButtonData *buttons",
      "const SDL_MessageBoxColorScheme *colorScheme",
    ]
  )

  extern "int SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid)"
  extern "int SDL_ShowSimpleMessageBox(Uint32 flags, const char *title, const char *message, SDL_Window *window)"
end
