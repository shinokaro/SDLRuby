module SDLRuby
  class Window
    module Flag
      class << self
        def to_i(allow_highdpi: nil, always_on_top: nil, borderless: nil,
                 foreign: nil, fullscreen: nil, fullscreen_desktop: nil,
                 hidden: nil, input_focus: nil, input_grabbed: nil,
                 keyboard_grabbed: nil, maximized: nil, metal: nil,
                 minimized: nil, mouse_capture: nil, mouse_focus: nil,
                 mouse_grabbed: nil, opengl: nil, popup_menu: nil,
                 resizable: nil, shown: nil, skip_taskbar: nil, tooltip: nil,
                 utility: nil, vulkan: nil, **)
          0 |
            (allow_highdpi ? SDL_WINDOW_ALLOW_HIGHDPI : 0) |
            (always_on_top ? SDL_WINDOW_ALWAYS_ON_TOP : 0) |
            (borderless ? SDL_WINDOW_BORDERLESS : 0) |
            (foreign ? SDL_WINDOW_FOREIGN : 0) |
            (fullscreen ? SDL_WINDOW_FULLSCREEN : 0) |
            (fullscreen_desktop ? SDL_WINDOW_FULLSCREEN_DESKTOP : 0) |
            (hidden ? SDL_WINDOW_HIDDEN : 0) |
            (input_focus ? SDL_WINDOW_INPUT_FOCUS : 0) |
            (input_grabbed ? SDL_WINDOW_INPUT_GRABBED : 0) |
            (keyboard_grabbed ? SDL_WINDOW_KEYBOARD_GRABBED : 0) |
            (maximized ? SDL_WINDOW_MAXIMIZED : 0) |
            (metal ? SDL_WINDOW_METAL : 0) |
            (minimized ? SDL_WINDOW_MINIMIZED : 0) |
            (mouse_capture ? SDL_WINDOW_MOUSE_CAPTURE : 0) |
            (mouse_focus ? SDL_WINDOW_MOUSE_FOCUS : 0) |
            (mouse_grabbed ? SDL_WINDOW_MOUSE_GRABBED : 0) |
            (opengl ? SDL_WINDOW_OPENGL : 0) |
            (popup_menu ? SDL_WINDOW_POPUP_MENU : 0) |
            (resizable ? SDL_WINDOW_RESIZABLE : 0) |
            (shown ? SDL_WINDOW_SHOWN : 0) |
            (skip_taskbar ? SDL_WINDOW_SKIP_TASKBAR : 0) |
            (tooltip ? SDL_WINDOW_TOOLTIP : 0) |
            (utility ? SDL_WINDOW_UTILITY : 0) |
            (vulkan ? SDL_WINDOW_VULKAN : 0)
        end
      end
    end
  end
end
