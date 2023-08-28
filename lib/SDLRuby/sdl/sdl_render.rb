module SDLRuby
  module SDL
    SDL_RENDERER_SOFTWARE = 0x00000001
    SDL_RENDERER_ACCELERATED = 0x00000002
    SDL_RENDERER_PRESENTVSYNC = 0x00000004
    SDL_RENDERER_TARGETTEXTURE = 0x00000008
    typealias "SDL_RendererFlags", "int"

    SDL_RendererInfo = struct(
      [
        "const char *name",
        "Uint32 flags",
        "Uint32 num_texture_formats",
        "Uint32 texture_formats[16]",
        "int max_texture_width",
        "int max_texture_height"
      ]
    )

    SDL_FLIP_NONE = 0x00000000
    SDL_FLIP_HORIZONTAL = 0x00000001
    SDL_FLIP_VERTICAL = 0x00000002
    typealias "SDL_RendererFlip", "int"

    SDL_SCALEMODE_NEAREST = 0
    SDL_SCALEMODE_LINEAR = 1
    SDL_SCALEMODE_BEST = 2
    typealias "SDL_ScaleMode", "int"

    SDL_TEXTUREACCESS_STATIC = 0
    SDL_TEXTUREACCESS_STREAMING = 1
    SDL_TEXTUREACCESS_TARGET = 2
    typealias "SDL_TextureAccess", "int"
  end
end
