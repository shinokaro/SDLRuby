module SDLRuby
  module Audio
    include SDL

    class << self
      include SDL

      def default_device(capture: nil)
        name = SDL.tmp_value("void*")
        spec = SDL_AudioSpec.malloc(Fiddle::RUBY_FREE)
        is_capture = capture ? 1 : 0
        err = SDL. SDL_GetDefaultAudioInfo(name, spec, is_capture)
        raise SDLError if err != 0

        ptr = name.value
        s = if ptr.null?
              nil
            else
              ptr.free = SDL_FREE
              ptr.to_s.force_encoding("UTF-8")
            end

        [s, spec.to_h]
      end

      def devices(capture: nil)
        is_capture = capture ? 1 : 0
        num = SDL.SDL_GetNumAudioDevices(is_capture)
        num.times.map do |idx|
          SDL.SDL_GetAudioDeviceName(idx, is_capture).to_s.force_encoding("UTF-8")
        end
      end

      def device_spec(name, capture: nil)
        idx = devices(capture: capture).index(name.encode("UTF-8"))

        return unless idx

        is_capture = capture ? 1 : 0
        spec = SDL_AudioSpec.malloc(Fiddle::RUBY_FREE)

        if SDL.SDL_GetAudioDeviceSpec(idx, is_capture, spec) == 0
          spec.to_h
        end
      end

      def driver
        ptr = SDL.SDL_GetCurrentAudioDriver
        ptr.null? ? nil : ptr.to_s
      end

      def drivers
        num = SDL.SDL_GetNumAudioDrivers
        num.times.map { |idx| SDL.SDL_GetAudioDriver(idx).to_s }
      end

      def init(driver)
        err = SDL.SDL_AudioInit(driver)
        raise SDLError if err < 0
      end

      def quit = SDL.SDL_AudioQuit
    end
  end
end
