# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "SDLRuby"

require "minitest/autorun"
require "fiddle"

module TestHelper
  include ::Fiddle, ::SDLRuby, ::SDLRuby::SDL

  module_function

  def sdl_clear_error = SDL.SDL_ClearError

  def sdl_get_error
    SDL.SDL_GetError.to_s
  end

  def sdl_init(flags)
    err = SDL.SDL_Init(flags)
    raise "SDL initialization failed" if err < 0
    if block_given?
      begin
        yield
      ensure
        sdl_quit
      end
    end
  end

  def sdl_was_init = SDL.SDL_WasInit(0)

  def sdl_quit = SDL.SDL_Quit

  def sdl_set_hint(key, val)
    SDL.SDL_SetHintWithPriority(key.to_s, val ? val.to_s : nil, SDL_HINT_OVERRIDE)
  end

  def sdl_flush_events
    SDL.SDL_FlushEvents(SDL_FIRSTEVENT, SDL_LASTEVENT)
  end

  def sdl_peep_events(e, num, action,
                      min_type = SDL_FIRSTEVENT, max_type = SDL_LASTEVENT)
    c = SDL.SDL_PeepEvents(e, num, action, min_type, max_type)
    raise sdl_get_error if c < 0
    c
  end

  def sdl_count_event = sdl_peep_events(nil, 0, SDL_PEEKEVENT)

  def sdl_get_event
    e = SDL_Event.malloc(RUBY_FREE)
    e if sdl_peep_events(e, 1, SDL_GETEVENT) == 1
  end

  def build_sdl_event(type: 0, **members)
    e = SDL_Event.malloc(RUBY_FREE)
    st = e.__send__(Event::Type[type])
    st.type = type
    members.each { |k, v| st.__send__("#{k}=", v) }
    e
  end

  def sdl_push_event(...)
    SDL.SDL_PushEvent(build_sdl_event(...))
  end
end
