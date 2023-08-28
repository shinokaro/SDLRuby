require 'fiddle/import'

module SDLRuby
  module Mixer
    include SDL
    extend Fiddle::Importer

    dlload "SDL2_mixer"

    require_relative 'mixer/sdl_mixer'

    require_relative 'mixer/channel'
    require_relative 'mixer/chunk'
    require_relative 'mixer/controller'

    class << self
      include Controller, SDL

      def close = Mixer.Mix_CloseAudio

      def decoders = Chunk.decoders

      def init(flags = nil)
        num = flags || 0 |
          MIX_INIT_FLAC | MIX_INIT_MOD | MIX_INIT_MP3 |
          MIX_INIT_OGG | MIX_INIT_MID | MIX_INIT_OPUS

        Mixer.Mix_Init(num)
      end

      def load_chank(...) = Chunk.load(...)

      def master_volume = Mixer.Mix_MasterVolume(-1)

      def master_volume=(v)
        Mixer.Mix_MasterVolume(v)
      end

      def open(device = nil,
               allow_changes: true, channels: 2, chunksize: 2048,
               format: MIX_DEFAULT_FORMAT, frequency: 48_000)

        err = Mixer.Mix_OpenAudioDevice(
          frequency, format, channels, chunksize, device,
          allow_changes ? SDL_AUDIO_ALLOW_ANY_CHANGE : 0
        )
        raise SDLError if err < 0
      end

      def quit = Mixer.Mix_Quit

      def reserve_channels=(num)
        Mixer.Mix_ReserveChannels(num)
      end

      def spec
        fq, ft, ch = SDL.tmp_value("int", "Uint16", "int")

        if Mixer.Mix_QuerySpec(fq, ft, ch) == 1
          { frequency: fq.value, format: ft.value, channels: ch.value }
        end
      end

      def to_int = -1

      def version = SDL_version.new(Mixer.Mix_Linked_Version).to_a.join(".")
    end

    # Channel manage
    #
    @channels = []

    class << self
      def [](channel)
        raise IndexError if channel < 0 || channels <= channel
        @channels[channel] ||= Channel.new(channel)
      end

      def channels = Mixer.Mix_AllocateChannels(-1)

      def channels=(num)
        @channels.slice!(num..)
        Mixer.Mix_AllocateChannels(num)
      end
    end
  end
end
