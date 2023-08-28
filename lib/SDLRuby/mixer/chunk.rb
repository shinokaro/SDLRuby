module SDLRuby
  module Mixer
    class Chunk
      include Mixer

      class << self
        def decoders
          Mixer.Mix_GetNumChunkDecoders.times.map do |idx|
            ptr = Mixer.Mix_GetChunkDecoder(idx)
            ptr.null? ? nil : ptr.to_s
          end
        end

        def load(file)
          if String === file
            rw = SDL.SDL_RWFromFile(file, "rb")
            free = 1
          elsif file.respond_to?(:to_path)
            rw = SDL.SDL_RWFromFile(file.to_path, "rb")
            free = 1
          else
            rw = RWOps[file]
            free = 0
          end

          ptr = Mixer.Mix_LoadWAV_RW(rw, free)
          raise SDLError if ptr.null?

          new(ptr)
        end
      end

      def initialize(ptr)
        ptr.free = MIX_FREE_CHUNK
        @ptr = ptr
      end

      def play(...) = Mixer.play(self, ...)

      def volume = Mixer.Mix_VolumeChunk(self, -1)

      def volume=(v)
        Mixer.Mix_VolumeChunk(self, v)
      end

      def to_ptr = @ptr
    end
  end
end
