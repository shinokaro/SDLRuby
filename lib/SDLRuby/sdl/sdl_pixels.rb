module SDLRuby
  module SDL
    SDL_ALPHA_OPAQUE = 255
    SDL_ALPHA_TRANSPARENT = 0

    SDL_Color = struct ["Uint8 r", "Uint8 g", "Uint8 b", "Uint8 a"]

    # SDL_PixelType
    i1 = 1
    i4 = 2
    i8 = 3
    p8 = 4
    p16 = 5
    p32 = 6
    a_u8 = 7

    # SDL_BitmapOrder
    b_4321 = 1
    b_1234 = 2

    # SDL_PackedOrder
    p_xrgb = 1
    p_rgbx = 2
    p_argb = 3
    p_rgba = 4
    p_xbgr = 5
    p_bgrx = 6
    p_abgr = 7
    p_bgra = 8

    # SDL_ArrayOrder
    a_rgb = 1
    a_bgr = 4

    # SDL_PackedLayout
    l_332 = 1
    l_4444 = 2
    l_1555 = 3
    l_5551 = 4
    l_565 = 5
    l_8888 = 6
    l_2101010 = 7

    pixelformat = -> (type, order, layout, bits, bytes) {
      1 << 28 | type << 24 | order << 20 | layout << 16 | bits << 8 | bytes << 0
    }

    SDL_PIXELFORMAT_UNKNOWN = 0
    SDL_PIXELFORMAT_INDEX1LSB = pixelformat.(i1, b_4321, 0, 1, 0)
    SDL_PIXELFORMAT_INDEX1MSB = pixelformat.(i1, b_1234, 0, 1, 0)
    SDL_PIXELFORMAT_INDEX4LSB = pixelformat.(i4, b_4321, 0, 4, 0)
    SDL_PIXELFORMAT_INDEX4MSB = pixelformat.(i4, b_1234, 0, 4, 0)
    SDL_PIXELFORMAT_INDEX8 = pixelformat.(i8, 0, 0, 8, 1)
    SDL_PIXELFORMAT_RGB332 = pixelformat.(p8, p_xrgb, l_332, 8, 1)
    SDL_PIXELFORMAT_XRGB4444 = pixelformat.(p16, p_xrgb, l_4444, 12, 2)
    SDL_PIXELFORMAT_RGB444 = SDL_PIXELFORMAT_XRGB4444
    SDL_PIXELFORMAT_XBGR4444 = pixelformat.(p16, p_xbgr, l_4444, 12, 2)
    SDL_PIXELFORMAT_BGR444 = SDL_PIXELFORMAT_XBGR4444
    SDL_PIXELFORMAT_XRGB1555 = pixelformat.(p16, p_xrgb, l_1555, 15, 2)
    SDL_PIXELFORMAT_RGB555 = SDL_PIXELFORMAT_XRGB1555
    SDL_PIXELFORMAT_XBGR1555 = pixelformat.(p16, p_xbgr, l_1555, 15, 2)
    SDL_PIXELFORMAT_BGR555 = SDL_PIXELFORMAT_XBGR1555
    SDL_PIXELFORMAT_ARGB4444 = pixelformat.(p16, p_argb, l_4444, 16, 2)
    SDL_PIXELFORMAT_RGBA4444 = pixelformat.(p16, p_rgba, l_4444, 16, 2)
    SDL_PIXELFORMAT_ABGR4444 = pixelformat.(p16, p_abgr, l_4444, 16, 2)
    SDL_PIXELFORMAT_BGRA4444 = pixelformat.(p16, p_bgra, l_4444, 16, 2)
    SDL_PIXELFORMAT_ARGB1555 = pixelformat.(p16, p_argb, l_1555, 16, 2)
    SDL_PIXELFORMAT_RGBA5551 = pixelformat.(p16, p_rgba, l_5551, 16, 2)
    SDL_PIXELFORMAT_ABGR1555 = pixelformat.(p16, p_abgr, l_1555, 16, 2)
    SDL_PIXELFORMAT_BGRA5551 = pixelformat.(p16, p_bgra, l_5551, 16, 2)
    SDL_PIXELFORMAT_RGB565 = pixelformat.(p16, p_xrgb, l_565, 16, 2)
    SDL_PIXELFORMAT_BGR565 = pixelformat.(p16, p_xbgr, l_565, 16, 2)
    SDL_PIXELFORMAT_RGB24 = pixelformat.(a_u8, a_rgb, 0, 24, 3)
    SDL_PIXELFORMAT_BGR24 = pixelformat.(a_u8, a_bgr, 0, 24, 3)
    SDL_PIXELFORMAT_XRGB8888 = pixelformat.(p32, p_xrgb, l_8888, 24, 4)
    SDL_PIXELFORMAT_RGB888 = SDL_PIXELFORMAT_XRGB8888
    SDL_PIXELFORMAT_RGBX8888 = pixelformat.(p32, p_rgbx, l_8888, 24, 4)
    SDL_PIXELFORMAT_XBGR8888 = pixelformat.(p32, p_xbgr, l_8888, 24, 4)
    SDL_PIXELFORMAT_BGR888 = SDL_PIXELFORMAT_XBGR8888
    SDL_PIXELFORMAT_BGRX8888 = pixelformat.(p32, p_bgrx, l_8888, 24, 4)
    SDL_PIXELFORMAT_ARGB8888 = pixelformat.(p32, p_argb, l_8888, 32, 4)
    SDL_PIXELFORMAT_RGBA8888 = pixelformat.(p32, p_rgba, l_8888, 32, 4)
    SDL_PIXELFORMAT_ABGR8888 = pixelformat.(p32, p_abgr, l_8888, 32, 4)
    SDL_PIXELFORMAT_BGRA8888 = pixelformat.(p32, p_bgra, l_8888, 32, 4)
    SDL_PIXELFORMAT_ARGB2101010 = pixelformat.(p32, p_argb, l_2101010, 32, 4)

    if "\x01\x02\x03\x04".unpack("I") == 0x1020304
      # BIG ENDIAN
      SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_RGBA8888
      SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_ARGB8888
      SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_BGRA8888
      SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_ABGR8888
    else
      SDL_PIXELFORMAT_RGBA32 = SDL_PIXELFORMAT_ABGR8888
      SDL_PIXELFORMAT_ARGB32 = SDL_PIXELFORMAT_BGRA8888
      SDL_PIXELFORMAT_BGRA32 = SDL_PIXELFORMAT_ARGB8888
      SDL_PIXELFORMAT_ABGR32 = SDL_PIXELFORMAT_RGBA8888
    end

    pixel_fourcc = -> (a, b, c, d) {
      _a, _b, _c, _d = [a, b, c, d].map { |s| s.encode("ASCII").bytes.first }
      _a << 0 | _b << 8 | _c << 16 | _d << 24
    }

    SDL_PIXELFORMAT_YV12 = pixel_fourcc.('Y', 'V', '1', '2')
    SDL_PIXELFORMAT_IYUV = pixel_fourcc.('I', 'Y', 'U', 'V')
    SDL_PIXELFORMAT_YUY2 = pixel_fourcc.('Y', 'U', 'Y', '2')
    SDL_PIXELFORMAT_UYVY = pixel_fourcc.('U', 'Y', 'V', 'Y')
    SDL_PIXELFORMAT_YVYU = pixel_fourcc.('Y', 'V', 'Y', 'U')
    SDL_PIXELFORMAT_NV12 = pixel_fourcc.('N', 'V', '1', '2')
    SDL_PIXELFORMAT_NV21 = pixel_fourcc.('N', 'V', '2', '1')
    SDL_PIXELFORMAT_EXTERNAL_OES = pixel_fourcc.('O', 'E', 'S', ' ')

    SDL_PixelFormat = struct(
      [
        "Uint32 format",
        "SDL_Palette* palette",
        "Uint8 BitsPerPixel",
        "Uint8 BytesPerPixel",
        "Uint8 padding[2]",
        "Uint32 Rmask",
        "Uint32 Gmask",
        "Uint32 Bmask",
        "Uint32 Amask",
        "Uint8 Rloss",
        "Uint8 Gloss",
        "Uint8 Bloss",
        "Uint8 Aloss",
        "Uint8 Rshift",
        "Uint8 Gshift",
        "Uint8 Bshift",
        "Uint8 Ashift",
        "int refcount",
        "SDL_PixelFormat* next"
      ]
    )
  end
end
