module SDLRuby
  module SDL
    SDL_RWOPS_UNKNOWN   = 0
    SDL_RWOPS_WINFILE   = 1
    SDL_RWOPS_STDFILE   = 2
    SDL_RWOPS_JNIFILE   = 3
    SDL_RWOPS_MEMORY    = 4
    SDL_RWOPS_MEMORY_RO = 5

    # アクセッサ用の構造体。実際のSDL_RWopsとは違い隠し領域のメンバーを含まない。
    #
    SDL_RWops = struct(
      [
        "void *size",
        "void *seek",
        "void *read",
        "void *write",
        "void *close",
        "Uint32 type"
      ]
    )

    SDL_RWops.module_eval do
      class << self
        undef malloc
      end
    end
  end
end
