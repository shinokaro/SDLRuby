module SDLRuby
  module SDL
    # struct
    #
    typealias "SDL_GUID", "void*"
    typealias "SDL_GameControllerButtonBind", "void*"

    # function ptr
    #
    typealias "SDL_EventFilter", "void*"
    typealias "SDL_HintCallback", "void*"
    typealias "SDL_HitTest", "void*"
    typealias "SDL_TimerCallback", "void*"
    typealias "SDL_WindowsMessageHook", "void*"
    typealias "SDL_calloc_func", "void*"
    typealias "SDL_free_func", "void*"
    typealias "SDL_joystick_lock", "void*"
    typealias "SDL_main_func", "void*"
    typealias "SDL_malloc_func", "void*"
    typealias "SDL_realloc_func", "void*"

    require_relative 'include/SDL.h.rb'

    require_relative 'sdl_audio'
    require_relative 'sdl_blendmode'
    require_relative 'sdl_error'
    require_relative 'sdl_events'
    require_relative 'sdl_hints'
    require_relative 'sdl_keyboard'
    require_relative 'sdl_locale'
    require_relative 'sdl_message_box'
    require_relative 'sdl_mouse'
    require_relative 'sdl_palette'
    require_relative 'sdl_pixels'
    require_relative 'sdl_rect'
    require_relative 'sdl_render'
    require_relative 'sdl_rw_ops'
    require_relative 'sdl_scancode'
    require_relative 'sdl_surface'
    require_relative 'sdl_version'
    require_relative 'sdl_video'

    SDL_INIT_TIMER      = 0x00000001
    SDL_INIT_AUDIO      = 0x00000010
    SDL_INIT_VIDEO      = 0x00000020
    SDL_INIT_JOYSTICK   = 0x00000200
    SDL_INIT_HAPTIC     = 0x00001000
    SDL_INIT_GAMEPAD    = 0x00002000
    SDL_INIT_EVENTS     = 0x00004000
    SDL_INIT_SENSOR     = 0x00008000
    SDL_INIT_EVERYTHING =
      SDL_INIT_TIMER | SDL_INIT_AUDIO | SDL_INIT_VIDEO | SDL_INIT_EVENTS |
      SDL_INIT_JOYSTICK | SDL_INIT_HAPTIC | SDL_INIT_GAMEPAD | SDL_INIT_SENSOR
  end
end
