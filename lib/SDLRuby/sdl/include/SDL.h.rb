module SDLRuby::SDL
  require_relative 'SDL_main.h.rb'
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_audio.h.rb'
  require_relative 'SDL_clipboard.h.rb'
  require_relative 'SDL_cpuinfo.h.rb'
  require_relative 'SDL_endian.h.rb'
  require_relative 'SDL_error.h.rb'
  require_relative 'SDL_events.h.rb'
  require_relative 'SDL_filesystem.h.rb'
  require_relative 'SDL_gamecontroller.h.rb'
  require_relative 'SDL_guid.h.rb'
  require_relative 'SDL_hints.h.rb'
  require_relative 'SDL_joystick.h.rb'
  require_relative 'SDL_messagebox.h.rb'
  require_relative 'SDL_power.h.rb'
  require_relative 'SDL_render.h.rb'
  require_relative 'SDL_rwops.h.rb'
  require_relative 'SDL_sensor.h.rb'
  require_relative 'SDL_shape.h.rb'
  require_relative 'SDL_system.h.rb'
  require_relative 'SDL_timer.h.rb'
  require_relative 'SDL_version.h.rb'
  require_relative 'SDL_video.h.rb'
  require_relative 'SDL_locale.h.rb'
  require_relative 'SDL_misc.h.rb'

  SDL_INIT_TIMER = 0x00000001
  SDL_INIT_AUDIO = 0x00000010
  SDL_INIT_VIDEO = 0x00000020
  SDL_INIT_JOYSTICK = 0x00000200
  SDL_INIT_HAPTIC = 0x00001000
  SDL_INIT_GAMECONTROLLER = 0x00002000
  SDL_INIT_EVENTS = 0x00004000
  SDL_INIT_SENSOR = 0x00008000
  SDL_INIT_NOPARACHUTE = 0x00100000
  SDL_INIT_EVERYTHING = ( SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS | SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMECONTROLLER | SDL_INIT_SENSOR )

  extern "int SDL_Init(Uint32 flags)"
  extern "int SDL_InitSubSystem(Uint32 flags)"
  extern "void SDL_QuitSubSystem(Uint32 flags)"
  extern "Uint32 SDL_WasInit(Uint32 flags)"
  extern "void SDL_Quit(void)"
end
