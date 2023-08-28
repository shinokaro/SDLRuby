module SDLRuby
  module SDL
    SDL_Palette = struct(
      [
        "int ncolors",
        "SDL_Color* colors",
        "Uint32 version",
        "int refcount"
      ]
    )
  end
end
