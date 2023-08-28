module SDLRuby::SDL
  require_relative 'SDL_config.h.rb'

  typealias "SDL_bool", "int"
  typealias "Sint8", "int8_t"
  typealias "Uint8", "uint8_t"
  typealias "Sint16", "int16_t"
  typealias "Uint16", "uint16_t"
  typealias "Sint32", "int32_t"
  typealias "Uint32", "uint32_t"
  typealias "Sint64", "int64_t"
  typealias "Uint64", "uint64_t"
  typealias "SDL_iconv_t", "struct _SDL_iconv_t*"
  typealias "SDL_bool", "int"
  typealias "SDL_DUMMY_ENUM", "int"
  extern "void * SDL_malloc(size_t size)"
  extern "void * SDL_calloc(size_t nmemb, size_t size)"
  extern "void * SDL_realloc(void *mem, size_t size)"
  extern "void SDL_free(void *mem)"
  extern "void SDL_GetOriginalMemoryFunctions(SDL_malloc_func *malloc_func, SDL_calloc_func *calloc_func, SDL_realloc_func *realloc_func, SDL_free_func *free_func)"
  extern "void SDL_GetMemoryFunctions(SDL_malloc_func *malloc_func, SDL_calloc_func *calloc_func, SDL_realloc_func *realloc_func, SDL_free_func *free_func)"
  extern "int SDL_SetMemoryFunctions(SDL_malloc_func malloc_func, SDL_calloc_func calloc_func, SDL_realloc_func realloc_func, SDL_free_func free_func)"
  extern "int SDL_GetNumAllocations(void)"
end
