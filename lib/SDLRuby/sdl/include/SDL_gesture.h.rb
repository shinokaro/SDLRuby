module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_video.h.rb'
  require_relative 'SDL_touch.h.rb'

  typealias "SDL_GestureID", "Sint64"
  extern "int SDL_RecordGesture(SDL_TouchID touchId)"
  extern "int SDL_SaveAllDollarTemplates(SDL_RWops *dst)"
  extern "int SDL_SaveDollarTemplate(SDL_GestureID gestureId,SDL_RWops *dst)"
  extern "int SDL_LoadDollarTemplates(SDL_TouchID touchId, SDL_RWops *src)"
end
