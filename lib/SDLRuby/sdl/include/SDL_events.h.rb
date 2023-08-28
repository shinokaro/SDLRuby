module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_video.h.rb'
  require_relative 'SDL_keyboard.h.rb'
  require_relative 'SDL_mouse.h.rb'
  require_relative 'SDL_joystick.h.rb'
  require_relative 'SDL_gamecontroller.h.rb'
  require_relative 'SDL_gesture.h.rb'
  require_relative 'SDL_touch.h.rb'

  typealias "SDL_SysWMmsg", "struct SDL_SysWMmsg"
  typealias "SDL_EventType", "int"
  typealias "SDL_eventaction", "int"
  extern "void SDL_PumpEvents(void)"
  extern "int SDL_PeepEvents(SDL_Event *events, int numevents, SDL_eventaction action, Uint32 minType, Uint32 maxType)"
  extern "SDL_bool SDL_HasEvent(Uint32 type)"
  extern "SDL_bool SDL_HasEvents(Uint32 minType, Uint32 maxType)"
  extern "void SDL_FlushEvent(Uint32 type)"
  extern "void SDL_FlushEvents(Uint32 minType, Uint32 maxType)"
  extern "int SDL_PollEvent(SDL_Event *event)"
  extern "int SDL_WaitEvent(SDL_Event *event)"
  extern "int SDL_WaitEventTimeout(SDL_Event *event, int timeout)"
  extern "int SDL_PushEvent(SDL_Event *event)"
  extern "void SDL_SetEventFilter(SDL_EventFilter filter, void *userdata)"
  extern "SDL_bool SDL_GetEventFilter(SDL_EventFilter *filter, void **userdata)"
  extern "void SDL_AddEventWatch(SDL_EventFilter filter, void *userdata)"
  extern "void SDL_DelEventWatch(SDL_EventFilter filter, void *userdata)"
  extern "void SDL_FilterEvents(SDL_EventFilter filter, void *userdata)"
  extern "Uint8 SDL_EventState(Uint32 type, int state)"
  extern "Uint32 SDL_RegisterEvents(int numevents)"
end
