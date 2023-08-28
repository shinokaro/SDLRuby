module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_video.h.rb'

  typealias "SDL_MessageBoxFlags", "int"
  typealias "SDL_MessageBoxButtonFlags", "int"
  typealias "SDL_MessageBoxColorType", "int"
  extern "int SDL_ShowMessageBox(const SDL_MessageBoxData *messageboxdata, int *buttonid)"
  extern "int SDL_ShowSimpleMessageBox(Uint32 flags, const char *title, const char *message, SDL_Window *window)"
end
