module SDLRuby
  module SDL
    SDL_DONTFREE = 0x00000004

    SDL_Surface = struct(
      [
        "Uint32 flags",
        "SDL_PixelFormat* format",
        "int w",
        "int h",
        "int pitch",
        "void* pixels",
        "void* userdata",
        "int locked",
        "void* list_blitmap",
        { clip_rect: SDL_Rect },
        "SDL_BlitMap* map",
        "int refcount"
      ]
    )

    extern "int SDL_UpperBlit(SDL_Surface * src, const SDL_Rect * srcrect,
                              SDL_Surface * dst, SDL_Rect * dstrect)"
    extern "int SDL_UpperBlitScaled(SDL_Surface * src, const SDL_Rect * srcrect,
                                    SDL_Surface * dst, SDL_Rect * dstrect)"
  end
end
