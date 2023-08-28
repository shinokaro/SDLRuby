require_relative 'mixer'

module SDLRuby
  class Music
    module Information
      include Mixer

      def album = Mixer.Mix_GetMusicAlbumTag(self).to_s

      def artist = Mixer.Mix_GetMusicArtistTag(self).to_s

      def copyright = Mixer.Mix_GetMusicCopyrightTag(self).to_s

      def duration = Mixer.Mix_MusicDuration(self)

      def loop_end_time = Mixer.Mix_GetMusicLoopEndTime(self)

      def loop_length_time = Mixer.Mix_GetMusicLoopLengthTime(self)

      def loop_start_time = Mixer.Mix_GetMusicLoopStartTime(self)

      def name = Mixer.Mix_GetMusicTitle(self).to_s

      def pos = Mixer.Mix_GetMusicPosition(self)

      def title = Mixer.Mix_GetMusicTitleTag(self).to_s

      def type
        case Mixer.Mix_GetMusicType(self)
        when MUS_NONE then nil
        when MUS_CMD then "CMD"
        when MUS_WAV then "WAVE"
        when MUS_MOD then "MOD"
        when MUS_MID then "MIDI"
        when MUS_OGG then "OGG"
        when MUS_MP3 then "MP3"
        when MUS_MP3_MAD_UNUSED then "MP3_MAD_UNUSED"
        when MUS_FLAC then "FLAC"
        when MUS_MODPLUG_UNUSED then "MODPLUG_UNUSED"
        when MUS_OPUS then "OPUS"
        else
          nil
        end
      end

      def volume = Mixer.Mix_GetMusicVolume(self)
    end

    include Information

    class << self
      include Information, Mixer

      def decoders
        Mixer.Mix_GetNumMusicDecoders.times.map do |idx|
          ptr = Mixer.Mix_GetMusicDecoder(idx)
          ptr.null? ? nil : ptr.to_s
        end
      end

      def fading? = Mixer.Mix_FadingMusic != MIX_NO_FADING

      def fading_in? = Mixer.Mix_FadingMusic == MIX_FADING_IN

      def fading_out? = Mixer.Mix_FadingMusic == MIX_FADING_OUT

      def halt = Mixer.Mix_HaltMusic

      def fade_out(sec) = Mixer.Mix_FadeOutMusic(sec * 1000)

      def load(file, type: MUS_NONE)
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

        ptr = Mixer.Mix_LoadMUSType_RW(rw, type, free)
        raise SDLError if ptr.null?

        new(ptr)
      end

      # MOD形成の場合のみ
      def order=(i)
        err = Mixer.Mix_ModMusicJumpToOrder(i)
        raise SDLError if err < 0
      end

      def playing? = Mixer.Mix_PlayingMusic == 1

      def pause = Mixer.Mix_PauseMusic

      def paused? = Mixer.Mix_PausedMusic == 1

      def pos=(sec)
        err = Mixer.Mix_SetMusicPosition(sec)
        raise SDLError if err < 0
      end

      def resume = Mixer.Mix_ResumeMusic

      def rewind = Mixer.Mix_RewindMusic

      def volume=(v)
        Mixer.Mix_VolumeMusic(v)
      end

      private def to_ptr = nil

      # MIDI
      #
      def sound_fonts_path
        ptr = Mixer.Mix_GetSoundFonts
        ptr.null? ? nil : ptr.to_s
      end

      # セミコロン区切りで複数のパスを指定できます。
      def sound_fonts_path=(paths)
        err = Mixer.Mix_SetSoundFonts(paths)
        raise SDLError if err == 0
      end

      def timidity_config_path
        ptr = Mixer.Mix_GetTimidityCfg
        ptr.null? ? nil : ptr.to_s
      end

      def timidity_config_path=(path)
        err = Mixer.Mix_SetTimidityCfg(path)
        raise SDLError if err == 0
      end
    end

    def initialize(ptr)
      ptr.free = MIX_FREE_MUSIC
      @ptr = ptr
    end

    # loops が 0 の時は1回のみ再生する。それ以外は1も含めて指定した回数を再生する。
    # fade_in_time はミリ秒で指定する。
    # non_block はフェードアウト中にブロックせずに即座に新しい音楽を再生する。
    #
    def play(loops: 0, fade_in_time: 0, pos: 0, non_block: nil)
      Music.halt if non_block

      err = Mixer.Mix_FadeInMusicPos(self, loops, fade_in_time * 1000, pos)
      raise SDLError if err < 0
    end

    def to_ptr = @ptr
  end
end
