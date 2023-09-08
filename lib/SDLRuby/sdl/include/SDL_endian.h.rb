module SDLRuby::SDL
  require_relative "SDL_stdinc.h"

  SDL_LIL_ENDIAN = 1234
  SDL_BIG_ENDIAN = 4321

  if "\x01\x02\x03\x04".unpack("I") == 0x1020304
    SDL_BYTEORDER = SDL_BIG_ENDIAN
  else
    SDL_BYTEORDER = SDL_LIL_ENDIAN
  end
end
