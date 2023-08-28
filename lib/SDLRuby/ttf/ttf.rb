module SDLRuby
  module TTF
    require_relative "include/SDL_ttf.h"

    # ZERO WIDTH NO-BREAKSPACE (Unicode byte order mark)
    #
    UNICODE_BOM_NATIVE  = 0xFEFF
    UNICODE_BOM_SWAPPED = 0xFFFE

    # Font style flags
    #
    TTF_STYLE_NORMAL        = 0x00
    TTF_STYLE_BOLD          = 0x01
    TTF_STYLE_ITALIC        = 0x02
    TTF_STYLE_UNDERLINE     = 0x04
    TTF_STYLE_STRIKETHROUGH = 0x08

    # Hinting flags
    #
    TTF_HINTING_NORMAL         = 0
    TTF_HINTING_LIGHT          = 1
    TTF_HINTING_MONO           = 2
    TTF_HINTING_NONE           = 3
    TTF_HINTING_LIGHT_SUBPIXEL = 4

    # Special layout option for rendering wrapped text
    #
    TTF_WRAPPED_ALIGN_LEFT   = 0
    TTF_WRAPPED_ALIGN_CENTER = 1
    TTF_WRAPPED_ALIGN_RIGHT  = 2

    # Direction flags
    #
    TTF_DIRECTION_LTR = 0
    TTF_DIRECTION_RTL = 1
    TTF_DIRECTION_TTB = 2
    TTF_DIRECTION_BTT = 3

    TTF_CLOSE_FONT = import_symbol("TTF_CloseFont").to_int
  end
end
