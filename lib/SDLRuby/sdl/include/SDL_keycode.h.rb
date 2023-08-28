module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_scancode.h.rb'
  typealias "SDL_Keycode", "Sint32"
  typealias "SDL_KeyCode", "int"
  typealias "SDL_Keymod", "int"
end
