module SDLRuby
  class RW
    class SeekClosure < Fiddle::Closure
      include Fiddle

      def initialize(obj)
        # Sint64 (*seek) (SDL_RWops *context, Sint64 offset, int whence)
        #
        super(TYPE_INT64_T, [TYPE_VOIDP, TYPE_INT64_T, TYPE_INT])
        @obj = obj
      end

      def call(_, offset, whence)
        @obj.seek(offset, whence)
        @obj.tell
      rescue => e
        SDL.last_error_message = e.message
        -1
      end
    end
  end
end
