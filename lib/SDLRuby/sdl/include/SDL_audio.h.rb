module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"
  require_relative "SDL_endian.h"
  require_relative "SDL_rwops.h"

  typealias "SDL_AudioFormat", "Uint16"

  SDL_AUDIO_MASK_BITSIZE = (0xFF)
  SDL_AUDIO_MASK_DATATYPE = (1<<8)
  SDL_AUDIO_MASK_ENDIAN = (1<<12)
  SDL_AUDIO_MASK_SIGNED = (1<<15)

  def self.SDL_AUDIO_BITSIZE(x)
    (x & SDL_AUDIO_MASK_BITSIZE)
  end
  def self.SDL_AUDIO_ISFLOAT(x)
    (x & SDL_AUDIO_MASK_DATATYPE)
  end
  def self.SDL_AUDIO_ISBIGENDIAN(x)
    (x & SDL_AUDIO_MASK_ENDIAN)
  end
  def self.SDL_AUDIO_ISSIGNED(x)
    (x & SDL_AUDIO_MASK_SIGNED)
  end
  def self.SDL_AUDIO_ISINT(x)
    (!SDL_AUDIO_ISFLOAT(x))
  end
  def self.SDL_AUDIO_ISLITTLEENDIAN(x)
    (!SDL_AUDIO_ISBIGENDIAN(x))
  end
  def self.SDL_AUDIO_ISUNSIGNED(x)
    (!SDL_AUDIO_ISSIGNED(x))
  end

  AUDIO_U8 = 0x0008
  AUDIO_S8 = 0x8008
  AUDIO_U16LSB = 0x0010
  AUDIO_S16LSB = 0x8010
  AUDIO_U16MSB = 0x1010
  AUDIO_S16MSB = 0x9010
  AUDIO_U16 = AUDIO_U16LSB
  AUDIO_S16 = AUDIO_S16LSB
  AUDIO_S32LSB = 0x8020
  AUDIO_S32MSB = 0x9020
  AUDIO_S32 = AUDIO_S32LSB
  AUDIO_F32LSB = 0x8120
  AUDIO_F32MSB = 0x9120
  AUDIO_F32 = AUDIO_F32LSB

  if SDL_BYTEORDER == SDL_LIL_ENDIAN
    AUDIO_U16SYS = AUDIO_U16LSB
    AUDIO_S16SYS = AUDIO_S16LSB
    AUDIO_S32SYS = AUDIO_S32LSB
    AUDIO_F32SYS = AUDIO_F32LSB
  else
    AUDIO_U16SYS = AUDIO_U16MSB
    AUDIO_S16SYS = AUDIO_S16MSB
    AUDIO_S32SYS = AUDIO_S32MSB
    AUDIO_F32SYS = AUDIO_F32MSB
  end

  SDL_AUDIO_ALLOW_FREQUENCY_CHANGE = 0x00000001
  SDL_AUDIO_ALLOW_FORMAT_CHANGE = 0x00000002
  SDL_AUDIO_ALLOW_CHANNELS_CHANGE = 0x00000004
  SDL_AUDIO_ALLOW_SAMPLES_CHANGE = 0x00000008
  SDL_AUDIO_ALLOW_ANY_CHANGE = (SDL_AUDIO_ALLOW_FREQUENCY_CHANGE|SDL_AUDIO_ALLOW_FORMAT_CHANGE|SDL_AUDIO_ALLOW_CHANNELS_CHANGE|SDL_AUDIO_ALLOW_SAMPLES_CHANGE)

  typealias "SDL_AudioCallback", "void*"

  SDL_AudioSpec = struct(
    [
      "int freq",
      "SDL_AudioFormat format",
      "Uint8 channels",
      "Uint8 silence",
      "Uint16 samples",
      "Uint16 padding",
      "Uint32 size",
      "SDL_AudioCallback callback",
      "void *userdata",
    ]
  )

  typealias "SDL_AudioFilter", "void*"

  SDL_AUDIOCVT_MAX_FILTERS = 9

  SDL_AudioCVT = struct(
    [
      "int needed",
      "SDL_AudioFormat src_format",
      "SDL_AudioFormat dst_format",
      "double rate_incr",
      "Uint8 *buf",
      "int len",
      "int len_cvt",
      "int len_mult",
      "double len_ratio",
      "SDL_AudioFilter filters[#{SDL_AUDIOCVT_MAX_FILTERS + 1}]",
      "int filter_index",
    ]
  )

  extern "int SDL_GetNumAudioDrivers(void)"
  extern "const char * SDL_GetAudioDriver(int index)"
  extern "int SDL_AudioInit(const char *driver_name)"
  extern "void SDL_AudioQuit(void)"
  extern "const char * SDL_GetCurrentAudioDriver(void)"
  extern "int SDL_OpenAudio(SDL_AudioSpec * desired, SDL_AudioSpec * obtained)"

  typealias "SDL_AudioDeviceID", "Uint32"

  extern "int SDL_GetNumAudioDevices(int iscapture)"
  extern "const char * SDL_GetAudioDeviceName(int index, int iscapture)"
  extern "int SDL_GetAudioDeviceSpec(int index, int iscapture, SDL_AudioSpec *spec)"
  extern "int SDL_GetDefaultAudioInfo(char **name, SDL_AudioSpec *spec, int iscapture)"
  extern "SDL_AudioDeviceID SDL_OpenAudioDevice( const char *device, int iscapture, const SDL_AudioSpec *desired, SDL_AudioSpec *obtained, int allowed_changes)"

  SDL_AUDIO_STOPPED = 0
  SDL_AUDIO_PLAYING = 1
  SDL_AUDIO_PAUSED = 2
  typealias "SDL_AudioStatus", "int"

  extern "SDL_AudioStatus SDL_GetAudioStatus(void)"
  extern "SDL_AudioStatus SDL_GetAudioDeviceStatus(SDL_AudioDeviceID dev)"
  extern "void SDL_PauseAudio(int pause_on)"
  extern "void SDL_PauseAudioDevice(SDL_AudioDeviceID dev, int pause_on)"
  extern "SDL_AudioSpec * SDL_LoadWAV_RW(SDL_RWops * src, int freesrc, SDL_AudioSpec * spec, Uint8 ** audio_buf, Uint32 * audio_len)"

  def self.SDL_LoadWAV(file, spec, audio_buf, audio_len)
    SDL_LoadWAV_RW(SDL_RWFromFile(file, "rb"),1, spec,audio_buf,audio_len)
  end

  extern "void SDL_FreeWAV(Uint8 * audio_buf)"
  extern "int SDL_BuildAudioCVT(SDL_AudioCVT * cvt, SDL_AudioFormat src_format, Uint8 src_channels, int src_rate, SDL_AudioFormat dst_format, Uint8 dst_channels, int dst_rate)"
  extern "int SDL_ConvertAudio(SDL_AudioCVT * cvt)"
  extern "SDL_AudioStream * SDL_NewAudioStream(const SDL_AudioFormat src_format, const Uint8 src_channels, const int src_rate, const SDL_AudioFormat dst_format, const Uint8 dst_channels, const int dst_rate)"
  extern "int SDL_AudioStreamPut(SDL_AudioStream *stream, const void *buf, int len)"
  extern "int SDL_AudioStreamGet(SDL_AudioStream *stream, void *buf, int len)"
  extern "int SDL_AudioStreamAvailable(SDL_AudioStream *stream)"
  extern "int SDL_AudioStreamFlush(SDL_AudioStream *stream)"
  extern "void SDL_AudioStreamClear(SDL_AudioStream *stream)"
  extern "void SDL_FreeAudioStream(SDL_AudioStream *stream)"

  SDL_MIX_MAXVOLUME = 128

  extern "void SDL_MixAudio(Uint8 * dst, const Uint8 * src, Uint32 len, int volume)"
  extern "void SDL_MixAudioFormat(Uint8 * dst, const Uint8 * src, SDL_AudioFormat format, Uint32 len, int volume)"
  extern "int SDL_QueueAudio(SDL_AudioDeviceID dev, const void *data, Uint32 len)"
  extern "Uint32 SDL_DequeueAudio(SDL_AudioDeviceID dev, void *data, Uint32 len)"
  extern "Uint32 SDL_GetQueuedAudioSize(SDL_AudioDeviceID dev)"
  extern "void SDL_ClearQueuedAudio(SDL_AudioDeviceID dev)"
  extern "void SDL_LockAudio(void)"
  extern "void SDL_LockAudioDevice(SDL_AudioDeviceID dev)"
  extern "void SDL_UnlockAudio(void)"
  extern "void SDL_UnlockAudioDevice(SDL_AudioDeviceID dev)"
  extern "void SDL_CloseAudio(void)"
  extern "void SDL_CloseAudioDevice(SDL_AudioDeviceID dev)"
end
