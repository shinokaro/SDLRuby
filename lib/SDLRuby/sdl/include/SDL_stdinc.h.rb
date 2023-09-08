module SDLRuby::SDL
  require_relative "SDL_config.h"

  def self.SDL_static_cast(type, expression)
    expression
  end
  def self.SDL_FOURCC(a, b, c, d)
    ((SDL_static_cast(:Uint32, SDL_static_cast(:Uint8, (a))) << 0) |
      (SDL_static_cast(:Uint32, SDL_static_cast(:Uint8, (b))) << 8) |
      (SDL_static_cast(:Uint32, SDL_static_cast(:Uint8, (c))) << 16) |
      (SDL_static_cast(:Uint32, SDL_static_cast(:Uint8, (d))) << 24))
  end

  SDL_FALSE = 0
  SDL_TRUE = 1
  typealias "SDL_bool", "int"

  SDL_MAX_SINT8 = (0x7F)
  SDL_MIN_SINT8 = ((~0x7F))
  typealias "Sint8", "int8_t"

  SDL_MAX_UINT8 = (0xFF)
  SDL_MIN_UINT8 = (0x00)
  typealias "Uint8", "uint8_t"

  SDL_MAX_SINT16 = (0x7FFF)
  SDL_MIN_SINT16 = ((~0x7FFF))
  typealias "Sint16", "int16_t"

  SDL_MAX_UINT16 = (0xFFFF)
  SDL_MIN_UINT16 = (0x0000)
  typealias "Uint16", "uint16_t"

  SDL_MAX_SINT32 = (0x7FFFFFFF)
  SDL_MIN_SINT32 = ((~0x7FFFFFFF))
  typealias "Sint32", "int32_t"

  SDL_MAX_UINT32 = (0xFFFFFFFF)
  SDL_MIN_UINT32 = (0x00000000)
  typealias "Uint32", "uint32_t"

  SDL_MAX_SINT64 = (0x7FFFFFFFFFFFFFFF)
  SDL_MIN_SINT64 = ((~0x7FFFFFFFFFFFFFFF))
  typealias "Sint64", "int64_t"

  SDL_MAX_UINT64 = (0xFFFFFFFFFFFFFFFF)
  SDL_MIN_UINT64 = ((0x0000000000000000))
  typealias "Uint64", "uint64_t"

  extern "void * SDL_malloc(size_t size)"
  extern "void * SDL_calloc(size_t nmemb, size_t size)"
  extern "void * SDL_realloc(void *mem, size_t size)"
  extern "void SDL_free(void *mem)"
  typealias "SDL_malloc_func", "void*"
  typealias "SDL_calloc_func", "void*"
  typealias "SDL_realloc_func", "void*"
  typealias "SDL_free_func", "void"
  extern "void SDL_GetOriginalMemoryFunctions(SDL_malloc_func *malloc_func, SDL_calloc_func *calloc_func, SDL_realloc_func *realloc_func, SDL_free_func *free_func)"
  extern "void SDL_GetMemoryFunctions(SDL_malloc_func *malloc_func, SDL_calloc_func *calloc_func, SDL_realloc_func *realloc_func, SDL_free_func *free_func)"
  extern "int SDL_SetMemoryFunctions(SDL_malloc_func malloc_func, SDL_calloc_func calloc_func, SDL_realloc_func realloc_func, SDL_free_func free_func)"
  extern "int SDL_GetNumAllocations(void)"
end
