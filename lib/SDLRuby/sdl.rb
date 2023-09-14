require "fiddle/import"

module SDLRuby
  module SDL
    extend Fiddle::Importer

    dlload "SDL2"

    SDL_DESTROY_RENDERER = import_symbol("SDL_DestroyRenderer").to_int
    SDL_DESTROY_TEXTURE = import_symbol("SDL_DestroyTexture").to_int

    # SDL_freeはSDL_SetMemoryFunctionsで設定された関数を使用する。
    # SDL側のメモリーを開放する場合はFiddle::PointerへSDL_FREEを設定してよい。
    #
    SDL_FREE = SDL.import_symbol("SDL_free").to_int
    SDL_FREE_CURSOR = import_symbol("SDL_FreeCursor").to_int
    SDL_FREE_FORMAT = import_symbol("SDL_FreeFormat").to_int
    SDL_FREE_PALETTE = import_symbol("SDL_FreePalette").to_int
    SDL_FREE_RW = import_symbol("SDL_FreeRW").to_int
    SDL_FREE_SURFACE = import_symbol("SDL_FreeSurface").to_int

    def self.tmp_value(*a, &)
      raise ArgumentError if a.empty?

      a.map { |ty|
        st = create_value(ty)
        st.to_ptr.free = Fiddle::RUBY_FREE
        st
      } => vals

      v = vals.one? ? vals.first : vals
      block_given? ? yield(*v) : v
    end

    require_relative 'sdl/sdl'
    require_relative 'sdl_error'

    require_relative 'audio'
    require_relative 'cursor'
    require_relative 'display'
    require_relative 'event'
    require_relative 'hint'
    require_relative 'keyboard'
    require_relative 'mouse'
    require_relative 'palette'
    require_relative 'pixel_formatter'
    require_relative 'rect'
    require_relative 'renderer'
    require_relative 'rw_ops'
    require_relative 'surface'
    require_relative 'text_input'
    require_relative 'texture'
    require_relative 'window'

    class << self
      # sdl
      #
      def init(flags = nil)
        err = SDL.SDL_Init(flags || SDL_INIT_EVERYTHING)
        raise SDLError if err < 0
      end

      # Description:
      #
      # This method checks the initialization status of SDL subsystems based on
      # the provided flags. You can specify the SDL subsystems you want to check
      # by combining the SDL_INIT_* flags using bitwise OR.
      #
      # Parameters:
      #
      # flags (optional): An integer or a combination of SDL_INIT_* flags
      # representing the SDL subsystems to check. Default is nil.
      #
      # Return Value:
      #
      # If all the specified SDL subsystems in flags are initialized,
      # the method returns true.
      # If any of the specified SDL subsystems are not initialized,
      # it returns false.
      # If flags is given as nil or 0,
      # the method returns true if any of the SDL subsystems are initialized.
      #
      def init?(flags = nil)
        if flags && flags != 0
          SDL.SDL_WasInit(flags) == flags
        else
          SDL.SDL_WasInit(0) != 0
        end
      end

      def quit = SDL.SDL_Quit

      # clipboard
      #
      def clipboard_text
        ptr = SDL.SDL_GetClipboardText
        raise SDLError if ptr.null?

        ptr.free = SDL_FREE
        ptr.to_s.force_encoding("UTF-8")
      end

      def clipboard_text? = SDL.SDL_HasClipboardText == 1

      def clipboard_text=(s)
        err = SDL.SDL_SetClipboardText(s.to_s.encode("UTF-8"))
        raise SDLError if err < 0
      end

      # cpu info
      #
      def cpu_cache_line_size = SDL.SDL_GetCPUCacheLineSize

      def cpu_count = SDL.SDL_GetCPUCount

      def system_ram = SDL.SDL_GetSystemRAM

      # error
      #
      def last_error_message = SDL.SDL_GetError.to_s

      def last_error_message=(s)
        SDL.SDL_SetError(s.to_s.gsub(/%/, "%%"))
      end

      # filesystem
      #
      def base_path
        ptr = SDL.SDL_GetBasePath
        raise SDLError if ptr.null?

        ptr.free = SDL_FREE
        ptr.to_s
      end

      # locale
      #
      def locales
        ptr = SDL.SDL_GetPreferredLocales
        return [] if ptr.null?

        ptr.free = SDL_FREE
        size = SDL_Locale.size
        (0..).inject([]) do |memo, i|
          st = SDL_Locale.new(ptr + i * size)
          break memo if st.language.null?
          memo << [st.language.to_s,
                   (c = st.country).null? ? nil : c.to_s]
        end
      end

      # message box
      #
      def alert(message, title = nil, flags: nil, window: nil)
        err = SDL.SDL_ShowSimpleMessageBox(flags,
                                           title.to_s.encode("UTF-8"),
                                           message.to_s.encode("UTF-8"),
                                           window)
        raise SDLError if err < 0
      end

      def error_alert(message, title = "Error")
        alert(message, title, flags: SDL_MESSAGEBOX_ERROR)
      end

      def warn_alert(message, title = "Warning")
        alert(message, title, flags: SDL_MESSAGEBOX_WARNING)
      end

      def info_alert(message, title = "Information")
        alert(message, title, flags: SDL_MESSAGEBOX_INFORMATION)
      end

      # misc
      #
      def open_url(url)
        raise SDLError if SDL.SDL_OpenURL(url) < 0
      end

      # platform
      #
      def platform = SDL.SDL_GetPlatform.to_s

      # timer
      #
      def ticks = SDL.SDL_GetTicks

      # version
      #
      def revision = SDL.SDL_GetRevision.to_s

      def version
        st = SDL_version.malloc(Fiddle::RUBY_FREE)
        SDL.SDL_GetVersion(st)
        st.to_a.join(".")
      end

      # video
      #
      def video_driver
        (ptr = SDL.SDL_GetCurrentVideoDriver).null? ? nil : ptr.to_s
      end

      def screen_saver=(b)
        b ? SDL.SDL_EnableScreenSaver : SDL.SDL_DisableScreenSaver
      end

      def screen_saver? = SDL.SDL_IsScreenSaverEnabled != 0

      def video_drivers
        SDL.SDL_GetNumVideoDrivers.times.map do |i|
          (ptr = SDL.SDL_GetVideoDriver(i)).null? ? nil : ptr.to_s
        end
      end
    end
  end
end
