module SDLRuby
  class RW
    class SizeClosure < Fiddle::Closure
      include Fiddle

      def initialize(obj)
        # Sint64 (*size) (SDL_RWops *context)
        #
        super(TYPE_INT64_T, [TYPE_VOIDP])
        @obj = obj
      end

      def call(_)
        @obj.size
      rescue => e
        SDL.last_error_message = e.message
        -1
      end
    end
  end
end
