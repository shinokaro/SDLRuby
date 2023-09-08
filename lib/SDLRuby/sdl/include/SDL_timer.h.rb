module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"

  extern "Uint32 SDL_GetTicks(void)"
  extern "Uint64 SDL_GetTicks64(void)"

  def self.SDL_TICKS_PASSED(a, b)
    (((b) - (a)) <= 0)
  end

  extern "Uint64 SDL_GetPerformanceCounter(void)"
  extern "Uint64 SDL_GetPerformanceFrequency(void)"
  extern "void SDL_Delay(Uint32 ms)"

  typealias "SDL_TimerCallback", "void*"
  typealias "SDL_TimerID", "int"

  extern "SDL_TimerID SDL_AddTimer(Uint32 interval, SDL_TimerCallback callback, void *param)"
  extern "SDL_bool SDL_RemoveTimer(SDL_TimerID id)"
end
