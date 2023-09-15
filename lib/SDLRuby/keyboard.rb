module SDLRuby
  module Keyboard
    module_eval do
      num_keys = SDL.tmp_value("int")

      # The SDL_GetKeyboardState function can be called before SDL_Init.
      #
      ptr = SDL.SDL_GetKeyboardState(num_keys)

      # SDL_GetKeyboardState returns an error when num_keys is NULL.
      #
      raise SDLError if ptr.null?

      ptr.size = num_keys.value
      @ptr = ptr.freeze
    end

    class << self
      include SDL

      # This method specifies the ability to check for a match with
      # the characters appearing in the 'when' clause of a 'case' statement.
      #
      # see also: String#===
      #
      def ==(other)
        case other
        when Integer
          0 <= other && other < @ptr.size && @ptr[other] != 0
        when String, Symbol
          (idx = scancode(other)) != 0 && @ptr[idx] != 0
        else
          super
        end
      end

      def any?
        # SDL sets a byte to either 0x00 or 0x01 for each scancode.
        # It does not fill the byte sequence with 0x80, so this should work.
        #
        to_str.sum != 0
      end

      def clear
        # SDL_ResetKeyboard should be preceded by initializing SDL events since
        # it sends SDLK_KEYUP events for pressed keys.
        #
        # Calling SDL_ResetKeyboard when the SDL event subsystem is not initialized
        # results in a core dump.
        #
        SDL.SDL_ResetKeyboard if SDL.init?(SDL_INIT_EVENTS)
      end

      def mod = SDL.SDL_GetModState

      def scancode(s) = SDL.SDL_GetScancodeFromName(s.to_s)

      def scancode_name(num) = SDL.SDL_GetScancodeName(num).to_s

      def size = @ptr.size

      alias length size

      def to_a = size.times.select { |i| @ptr[i] != 0 }

      def to_str = @ptr.to_str
    end
  end
end
