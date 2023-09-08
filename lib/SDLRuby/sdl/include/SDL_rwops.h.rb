module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"

  SDL_RWOPS_UNKNOWN = 0
  SDL_RWOPS_WINFILE = 1
  SDL_RWOPS_STDFILE = 2
  SDL_RWOPS_JNIFILE = 3
  SDL_RWOPS_MEMORY = 4
  SDL_RWOPS_MEMORY_RO = 5

  SDL_RWops = struct(
    [
      "void *size",
      "void *seek",
      "void *read",
      "void *write",
      "void *close",
      "Uint32 type",
      { hidden: union(
        [
          # if defined(__ANDROID__)
          { androidio: struct(["void *asset"]) },
          # elsif defined(__WIN32__) || defined(__GDK__)
          { windowsio: struct([
                                "SDL_bool append",
                                "void *h",
                                { buffer: struct(["void *data", "size_t size", "size_t left"]) }
                              ]) },
          # end
          # if defined(HAVE_STDIO_H)
          { stdio: struct(["SDL_bool autoclose", "FILE *fp"]) },
          # end
          { mem: struct(["Uint8 *base", "Uint8 *here", "Uint8 *stop"]) },
          { unknown: struct(["void *data1", "void *data2"]) }
        ]
      ) }
    ]
  )

  extern "SDL_RWops * SDL_RWFromFile(const char *file, const char *mode)"
  # if defined(HAVE_STDIO_H)
  #   extern "SDL_RWops * SDL_RWFromFP(FILE * fp, SDL_bool autoclose)"
  # else
  #   extern "SDL_RWops * SDL_RWFromFP(void * fp, SDL_bool autoclose)"
  # end
  extern "SDL_RWops * SDL_RWFromMem(void *mem, int size)"
  extern "SDL_RWops * SDL_RWFromConstMem(const void *mem, int size)"
  extern "SDL_RWops * SDL_AllocRW(void)"
  extern "void SDL_FreeRW(SDL_RWops * area)"

  RW_SEEK_SET = 0
  RW_SEEK_CUR = 1
  RW_SEEK_END = 2

  extern "Sint64 SDL_RWsize(SDL_RWops *context)"
  extern "Sint64 SDL_RWseek(SDL_RWops *context, Sint64 offset, int whence)"
  extern "Sint64 SDL_RWtell(SDL_RWops *context)"
  extern "size_t SDL_RWread(SDL_RWops *context, void *ptr, size_t size, size_t maxnum)"
  extern "size_t SDL_RWwrite(SDL_RWops *context, const void *ptr, size_t size, size_t num)"
  extern "int SDL_RWclose(SDL_RWops *context)"
  extern "void * SDL_LoadFile_RW(SDL_RWops *src, size_t *datasize, int freesrc)"
  extern "void * SDL_LoadFile(const char *file, size_t *datasize)"
  extern "Uint8 SDL_ReadU8(SDL_RWops * src)"
  extern "Uint16 SDL_ReadLE16(SDL_RWops * src)"
  extern "Uint16 SDL_ReadBE16(SDL_RWops * src)"
  extern "Uint32 SDL_ReadLE32(SDL_RWops * src)"
  extern "Uint32 SDL_ReadBE32(SDL_RWops * src)"
  extern "Uint64 SDL_ReadLE64(SDL_RWops * src)"
  extern "Uint64 SDL_ReadBE64(SDL_RWops * src)"
  extern "size_t SDL_WriteU8(SDL_RWops * dst, Uint8 value)"
  extern "size_t SDL_WriteLE16(SDL_RWops * dst, Uint16 value)"
  extern "size_t SDL_WriteBE16(SDL_RWops * dst, Uint16 value)"
  extern "size_t SDL_WriteLE32(SDL_RWops * dst, Uint32 value)"
  extern "size_t SDL_WriteBE32(SDL_RWops * dst, Uint32 value)"
  extern "size_t SDL_WriteLE64(SDL_RWops * dst, Uint64 value)"
  extern "size_t SDL_WriteBE64(SDL_RWops * dst, Uint64 value)"
end
