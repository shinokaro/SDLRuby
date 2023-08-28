module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'

  typealias "SDL_TimerID", "int"
  extern "Uint32 SDL_GetTicks(void)"
  extern "Uint64 SDL_GetTicks64(void)"
  extern "Uint64 SDL_GetPerformanceCounter(void)"
  extern "Uint64 SDL_GetPerformanceFrequency(void)"
  extern "void SDL_Delay(Uint32 ms)"
  extern "SDL_TimerID SDL_AddTimer(Uint32 interval, SDL_TimerCallback callback, void *param)"
  extern "SDL_bool SDL_RemoveTimer(SDL_TimerID id)"
end
