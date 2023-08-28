module SDLRuby
  module Mixer
    typealias "Uint8", "uint8_t"
    typealias "Uint16", "uint16_t"
    typealias "Uint32", "uint32_t"
    typealias "Sint16", "int16_t"
    typealias "SDL_bool", "int"
    typealias "Mix_EffectFunc_t", "void*"
    typealias "Mix_EffectDone_t", "void*"

    require_relative 'include/SDL_mixer.h'

    MIX_INIT_FLAC   = 0x00000001
    MIX_INIT_MOD    = 0x00000002
    MIX_INIT_MP3    = 0x00000008
    MIX_INIT_OGG    = 0x00000010
    MIX_INIT_MID    = 0x00000020
    MIX_INIT_OPUS   = 0x00000040

    MIX_CHANNELS = 8

    MIX_DEFAULT_FREQUENCY = 44100
    #if SDL_BYTEORDER == SDL_LIL_ENDIAN
    MIX_DEFAULT_FORMAT = AUDIO_S16LSB
    #else
    # MIX_DEFAULT_FORMAT = AUDIO_S16MSB
    #endif

    MIX_DEFAULT_CHANNELS = 2
    MIX_MAX_VOLUME = SDL_MIX_MAXVOLUME

    Mix_Chunk = struct(
      [
        "int allocated",
        "Uint8 *abuf",
        "Uint32 alen",
        "Uint8 volume"
      ]
    )

    MIX_NO_FADING = 0
    MIX_FADING_OUT = 1
    MIX_FADING_IN = 2

    MUS_NONE = 0
    MUS_CMD = 1
    MUS_WAV = 2
    MUS_MOD = 3
    MUS_MID = 4
    MUS_OGG = 5
    MUS_MP3 = 6
    MUS_MP3_MAD_UNUSED = 7
    MUS_FLAC = 8
    MUS_MODPLUG_UNUSED = 9
    MUS_OPUS = 10

    MIX_FREE_MUSIC = import_symbol("Mix_FreeMusic").to_int
    MIX_FREE_CHUNK = import_symbol("Mix_FreeChunk").to_int
  end
end
