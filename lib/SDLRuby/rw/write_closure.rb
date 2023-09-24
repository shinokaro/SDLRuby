module SDLRuby
  class RW
    class WriteClosure < Fiddle::Closure
      include Fiddle

      def initialize(obj)
        # size_t (*write) (SDL_RWops *context, const void *ptr, size_t size, size_t num)
        #
        super(TYPE_SIZE_T, [TYPE_VOIDP, TYPE_VOIDP, TYPE_SIZE_T, TYPE_SIZE_T])
        @obj = obj
      end

      def call(_, ptr, size, num)
        @obj.write(ptr.to_str(size * num)) / size
      rescue => e
        SDL.last_error_message = e.message
        0
      end
    end
  end
end
