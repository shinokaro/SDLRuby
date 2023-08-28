module SDLRuby
  module SDL
    SDL_Keysym = struct(
      [
        "SDL_Scancode scancode",
        "SDL_Keycode sym",
        "Uint16 mod",
        "Uint32 unused"
      ]
    )
  end
end
