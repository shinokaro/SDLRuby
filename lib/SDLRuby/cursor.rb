module SDLRuby
  class Cursor
    include SDL

    class << self
      def [](obj, hot: nil)
        case obj
        when Surface
          SDL.SDL_CreateColorCursor(obj, *hot && [0, 0])
        when Integer
          SDL.SDL_CreateSystemCursor(obj)
        else
          raise ArgumentError
        end => ptr

        raise SDLError if ptr.null?

        new(ptr)
      end

      def default! = SDL.SDL_SetCursor(SDL.SDL_GetDefaultCursor)

      def hide = SDL.SDL_ShowCursor(0)

      def redraw = SDL.SDL_SetCursor(nil)

      def show = SDL.SDL_ShowCursor(1)

      def shown? = SDL.SDL_ShowCursor(-1) == 1
    end

    def initialize(ptr)
      ptr.free = SDL_FREE_CURSOR
      @ptr = ptr
    end

    def current? = SDL.SDL_GetCursor == @ptr

    def show
      SDL.SDL_SetCursor(self)
      Cursor.show
    end

    def to_ptr = @ptr
  end
end
