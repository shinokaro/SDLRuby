module SDLRuby
  module Timer
    class << self
      def ticks
        # Use the same Ticks as the one utilized for SDL event timestamps.
        #
        SDL.SDL_GetTicks
      end

      def inspect
        n = SDL.SDL_GetTicks64
        epoch_time = n / 1000

        sprintf(
          "%d %02d:%02d:%02d.%03d0000",
          epoch_time / 86400,     # days
          epoch_time / 3600 % 24, # hours
          epoch_time / 60 % 60,   # minutes
          epoch_time % 60,        # seconds
          n % 1000                # fractional seconds
        )
      end
    end
  end
end
