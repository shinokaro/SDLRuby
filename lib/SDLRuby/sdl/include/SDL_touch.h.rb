module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_video.h.rb'

  typealias "SDL_TouchID", "Sint64"
  typealias "SDL_FingerID", "Sint64"
  typealias "SDL_TouchDeviceType", "int"
  extern "int SDL_GetNumTouchDevices(void)"
  extern "SDL_TouchID SDL_GetTouchDevice(int index)"
  extern "const char* SDL_GetTouchName(int index)"
  extern "SDL_TouchDeviceType SDL_GetTouchDeviceType(SDL_TouchID touchID)"
  extern "int SDL_GetNumTouchFingers(SDL_TouchID touchID)"
  extern "SDL_Finger * SDL_GetTouchFinger(SDL_TouchID touchID, int index)"
end
