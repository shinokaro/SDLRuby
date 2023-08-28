module SDLRuby
  module Image
    IMG_INIT_JPG    = 0x00000001
    IMG_INIT_PNG    = 0x00000002
    IMG_INIT_TIF    = 0x00000004
    IMG_INIT_WEBP   = 0x00000008
    IMG_INIT_JXL    = 0x00000010
    IMG_INIT_AVIF   = 0x00000020
    typealias "IMG_InitFlags", "int"

    IMG_Animation = struct(
      [
        "int w",
        "int h",
        "int count",
        "SDL_Surface **frames",
        "int *delays"
      ]
    )

    IMG_FREE_ANIMATION = import_symbol("IMG_FreeAnimation").to_int
  end
end
