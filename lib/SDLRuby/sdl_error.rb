module SDLRuby
  class SDLError < StandardError
    def initialize(msg = nil)
      super(msg || SDL.last_error_message)
      SDL.SDL_ClearError
    end
  end
end
