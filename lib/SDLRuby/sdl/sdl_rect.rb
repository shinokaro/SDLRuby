module SDLRuby
  module SDL
    SDL_Point = struct(["int x", "int y"])

    SDL_FPoint = struct(["float x", "float y"])

    SDL_Rect = struct(["int x", "int y", "int w", "int h"])

    SDL_FRect = struct(["float x", "float y", "float w", "float h"])
  end
end
