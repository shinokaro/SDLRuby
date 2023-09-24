module SDLRuby
  class RW
    class ReadClosure < Fiddle::Closure
      include Fiddle

      def initialize(obj)
        # size_t (*read) (SDL_RWops *context, void *ptr, size_t size, size_t maxnum)
        #
        super(TYPE_SIZE_T, [TYPE_VOIDP, TYPE_VOIDP, TYPE_SIZE_T, TYPE_SIZE_T])
        @obj = obj
      end

      def call(_, ptr, size, maxnum)
        len = size * maxnum
        return 0 if len.zero?

        s = @obj.read(len)
        return 0 if s.nil? || s.empty? # EOF

        ptr[0, s.size] = s
        s.size / size
      rescue => e
        SDL.last_error_message = e.message
        0
      end
    end
  end
end
