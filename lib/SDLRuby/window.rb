require_relative 'display'
require_relative 'pixel_formatter'
require_relative 'window/accessor'
require_relative 'window/controller'
require_relative 'window/display_info'
require_relative 'window/flag'
require_relative 'window/hit_tester'
require_relative 'window/input'
require_relative 'window/shaper'
require_relative 'window/surfacer'
require_relative 'window/window_renderer'

module SDLRuby
  class Window
    include Accessor, Controller, DisplayInfo, HitTester, Input,
            PixelFormatter, Renderer, SDL, Shaper, Surfacer, WindowRenderer

    class << self
      include SDL

      # 該当するウィンドウがない場合はnilを戻す。
      #
      def [](obj)
        id = obj.to_int
        ptr = SDL.SDL_GetWindowFromID(id)
        return nil if ptr.null?

        new(ptr)
      end

      def _from(ptr)
        ptr = SDL.SDL_CreateWindowFrom(ptr)
        raise SDLError if ptr.null?

        new(ptr)
      end

      def create(title, x = nil, y = nil, w = 640, h = 480, flags = nil,
                 shaped: nil, **opts)

        _title = title.encode("UTF-8")
        _x = x ? x : SDL_WINDOWPOS_UNDEFINED
        _y = y ? y : SDL_WINDOWPOS_UNDEFINED
        _flags = flags || Flag.to_i(**opts)
        ptr = if shaped
                SDL.SDL_CreateShapedWindow(_title, _x, _y, w, h, _flags)
              else
                SDL.SDL_CreateWindow(_title, _x, _y, w, h, _flags)
              end
        raise SDLError if ptr.null?

        new(ptr)
      end
    end

    attr_reader :id

    def initialize(ptr)
      id = SDL.SDL_GetWindowID(ptr)
      raise SDLError if id == 0

      @id = id
    end

    def ==(other) = other.respond_to?(:to_ptr) && to_ptr == other.to_ptr

    def destroy = SDL.SDL_DestroyWindow(self)

    def flags = SDL.SDL_GetWindowFlags(self)

    def flash(op)
      _op = op ? SDL_FLASH_UNTIL_FOCUSED : SDL_FLASH_CANCEL
      err = SDL.SDL_FlashWindow(self, _op)
      raise SDLError if err < 0
    end

    def focus! = SDL.SDL_RaiseWindow(self)

    def format = SDL.SDL_GetWindowPixelFormat(self)

    alias to_int id
    alias to_i id

    def to_ptr
      ptr = SDL.SDL_GetWindowFromID(@id)
      raise SDLError if ptr.null?
      ptr
    end
  end
end
