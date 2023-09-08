module SDLRuby::SDL
  require_relative "SDL_stdinc.h"

  extern "int SDL_SetError(const char *fmt, ...)"
  extern "const char * SDL_GetError(void)"
  extern "char * SDL_GetErrorMsg(char *errstr, int maxlen)"
  extern "void SDL_ClearError(void)"

  def self.SDL_OutOfMemory()
    SDL_Error(SDL_ENOMEM)
  end
  def self.SDL_Unsupported()
    SDL_Error(SDL_UNSUPPORTED)
  end
  def self.SDL_InvalidParamError(param)
    SDL_SetError("Parameter '%s' is invalid", (param))
  end

  SDL_ENOMEM = 0
  SDL_EFREAD = 1
  SDL_EFWRITE = 2
  SDL_EFSEEK = 3
  SDL_UNSUPPORTED = 4
  SDL_LASTERROR = 5
  typealias "SDL_errorcode", "int"

  extern "int SDL_Error(SDL_errorcode code)"
end
