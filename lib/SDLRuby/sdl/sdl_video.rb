module SDLRuby
  module SDL
    # SDL_WindowFlags
    #
    SDL_WINDOW_FULLSCREEN = 0x00000001
    SDL_WINDOW_OPENGL = 0x00000002
    SDL_WINDOW_SHOWN = 0x00000004
    SDL_WINDOW_HIDDEN = 0x00000008
    SDL_WINDOW_BORDERLESS = 0x00000010
    SDL_WINDOW_RESIZABLE = 0x00000020
    SDL_WINDOW_MINIMIZED = 0x00000040
    SDL_WINDOW_MAXIMIZED = 0x00000080
    SDL_WINDOW_MOUSE_GRABBED = 0x00000100
    SDL_WINDOW_INPUT_FOCUS = 0x00000200
    SDL_WINDOW_MOUSE_FOCUS = 0x00000400
    SDL_WINDOW_FULLSCREEN_DESKTOP = SDL_WINDOW_FULLSCREEN | 0x00001000
    SDL_WINDOW_FOREIGN = 0x00000800
    SDL_WINDOW_ALLOW_HIGHDPI = 0x00002000
    SDL_WINDOW_MOUSE_CAPTURE    = 0x00004000
    SDL_WINDOW_ALWAYS_ON_TOP    = 0x00008000
    SDL_WINDOW_SKIP_TASKBAR     = 0x00010000
    SDL_WINDOW_UTILITY          = 0x00020000
    SDL_WINDOW_TOOLTIP          = 0x00040000
    SDL_WINDOW_POPUP_MENU       = 0x00080000
    SDL_WINDOW_KEYBOARD_GRABBED = 0x00100000
    SDL_WINDOW_VULKAN           = 0x10000000
    SDL_WINDOW_METAL            = 0x20000000
    SDL_WINDOW_INPUT_GRABBED = SDL_WINDOW_MOUSE_GRABBED

    # Window position
    #
    SDL_WINDOWPOS_UNDEFINED = 0x1FFF0000
    SDL_WINDOWPOS_CENTERED = 0x2FFF0000

    # SDL_HitTestResult
    #
    SDL_HITTEST_NORMAL = 0
    SDL_HITTEST_DRAGGABLE = 1
    SDL_HITTEST_RESIZE_TOPLEFT = 2
    SDL_HITTEST_RESIZE_TOP = 3
    SDL_HITTEST_RESIZE_TOPRIGHT = 4
    SDL_HITTEST_RESIZE_RIGHT = 5
    SDL_HITTEST_RESIZE_BOTTOMRIGHT = 6
    SDL_HITTEST_RESIZE_BOTTOM = 7
    SDL_HITTEST_RESIZE_BOTTOMLEFT = 8
    SDL_HITTEST_RESIZE_LEFT = 9

    # Display orientation
    #
    SDL_ORIENTATION_UNKNOWN = 0
    SDL_ORIENTATION_LANDSCAPE = 1
    SDL_ORIENTATION_LANDSCAPE_FLIPPED = 2
    SDL_ORIENTATION_PORTRAIT = 3
    SDL_ORIENTATION_PORTRAIT_FLIPPED = 4

    # Window flash operation
    #
    SDL_FLASH_CANCEL = 0
    SDL_FLASH_BRIEFLY = 1
    SDL_FLASH_UNTIL_FOCUSED =2

    SDL_DisplayMode = struct(
      [
        "Uint32 format",
        "int w",
        "int h",
        "int refresh_rate",
        "void *driverdata"
      ]
    )

    # SDL_shape.h
    #
    SDL_NONSHAPEABLE_WINDOW = -1
    SDL_INVALID_SHAPE_ARGUMENT = -2
    SDL_WINDOW_LACKS_SHAPE = -3

    # WindowShapeMode
    #
    ShapeModeDefault = 0
    ShapeModeBinarizeAlpha = 1
    ShapeModeReverseBinarizeAlpha = 2
    ShapeModeColorKey = 3
    typealias "WindowShapeMode", "int"

    SDL_SHAPEMODEALPHA = -> (mode) {
      mode == ShapeModeDefault || mode == ShapeModeBinarizeAlpha || mode == ShapeModeReverseBinarizeAlpha
    }

    SDL_WindowShapeParams = union(
      [
        "Uint8 binarizationCutoff",
        { colorKey: SDL_Color }
      ]
    )

    SDL_WindowShapeMode = struct(
      [
        "WindowShapeMode mode",
        { parameters: SDL_WindowShapeParams }
      ]
    )
  end
end
