require_relative 'event/accessor'
require_relative 'event/type'

module SDLRuby
  class Event
    include Accessor, Fiddle, SDL

    class << self
      include SDL

      private def __malloc__ = Fiddle.malloc(SDL_Event.size)

      def clear = SDL.SDL_FlushEvents(SDL_FIRSTEVENT, SDL_LASTEVENT)

      # The deq method can be called from any thread.
      #
      def deq(non_block = false)
        if non_block && empty?
          raise SDLError, "event queue empty"
        end

        e = __malloc__

        case SDL.SDL_PeepEvents(e, 1, SDL_GETEVENT, 0, -1)
        when 1
          return new(e)
        when 0
          sleep(0.001)
        else # -1 "The event system has been shut down"
          return
        end while true
      end

      def disable(type) = SDL.SDL_EventState(type, 0)

      def empty? = SDL.SDL_PeepEvents(nil, 1, SDL_PEEKEVENT, 0, -1) != 1

      def enable(type) = SDL.SDL_EventState(type, 1)

      def get
        unless Thread.current == Thread.main
          raise SDLError, "called from a non-main thread"
        end

        e = __malloc__
        SDL.SDL_WaitEvent(e)
        new(e)
      end

      def length = SDL.SDL_PeepEvents(nil, 0, SDL_PEEKEVENT, 0, -1)
      alias size length

      def quit? = (update or SDL.SDL_HasEvent(SDL_QUIT) == 1)

      def reserve(num)
        base = SDL.SDL_RegisterEvents(num)

        if base == 0xFFFF_FFFF
          raise SDLError, "cannot register any more user events"
        end

        base
      end

      def update
        unless Thread.current == Thread.main
          raise SDLError, "called from a non-main thread"
        end

        SDL.SDL_PumpEvents
      end

      def wait(timeout = nil)
        return self unless empty?

        return nil  unless Thread.current == Thread.main

        if timeout
          SDL.SDL_WaitEventTimeout(nil, timeout * 1000)
        else
          SDL.SDL_WaitEvent(nil)
        end == 1 ? self : nil
      end
    end

    def initialize(ptr)
      st = SDL_Event.new(ptr)
      sym = Type[st.type]
      @entity = st.__send__(sym)
      @entity.to_ptr.free = RUBY_FREE
      extend(Accessor[sym])
    end

    private attr_reader :entity

    def to_ptr = @entity.to_ptr
  end
end
