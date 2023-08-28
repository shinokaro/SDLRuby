require_relative 'renderer/accessor'
require_relative 'renderer/drawer'
require_relative 'renderer/renderer_info'

module SDLRuby
  module Renderer
    include Accessor, Drawer, SDL
    extend Forwardable

    class << self
      def drivers
        num = SDL.SDL_GetNumRenderDrivers
        raise SDLError if num < 0

        num.times.map do |idx|
          st = RendererInfo.new
          err = SDL.SDL_GetRenderDriverInfo(idx, st)
          raise SDLError if err < 0

          st.renderer_name
        end
      end

      def driver_info(name)
        idx = drivers.index(name)
        return unless idx

        st = RendererInfo.new
        err = SDL.SDL_GetRenderDriverInfo(idx, st)
        raise SDLError if err < 0

        st
      end
    end

    private def renderer_info
      st = RendererInfo.new
      err = SDL.SDL_GetRendererInfo(renderer, st)
      raise SDLError if err < 0

      @renderer_info ||= st
    end

    def_delegators :renderer_info,
                   :renderer_name, :software_renderer?, :max_texture_size

    def create_texture(w, h, format, access: nil)
      ac = access || SDL_TEXTUREACCESS_TARGET
      ptr = SDL.SDL_CreateTexture(renderer, format, ac, w, h)
      raise SDLError if ptr.null?
      Texture.new(ptr)
    end

    def import_texture(surface)
      ptr = SDL.SDL_CreateTextureFromSurface(renderer, surface)
      raise SDLError if ptr.null?
      Texture.new(ptr)
    end

    def load_texture(file, type: nil)
      if String === file
        rw = SDL.SDL_RWFromFile(file, "rb")
        free = 1
      elsif file.respond_to?(:to_path)
        rw = SDL.SDL_RWFromFile(file.to_path, "rb")
        free = 1
      else
        rw = RWOps[file]
        free = 0
      end

      ptr = Image.IMG_LoadTextureTyped_RW(renderer, rw, free, type)
      raise SDLError if ptr.null?
      Texture.new(ptr)
    end

    def present = SDL.SDL_RenderPresent(renderer)

    def default_texture? = SDL.SDL_GetRenderTarget(renderer).null?

    # 値がnilの時はデフォルトのレンダーターゲット
    #
    def target_texture=(texture)
      err = SDL.SDL_SetRenderTarget(renderer, texture)
      raise SDLError if err < 0
    end

    def vsync?
      st = RendererInfo.new
      err = SDL.SDL_GetRendererInfo(renderer, st)
      raise SDLError if err < 0

      st.vsync?
    end

    def vsync=(b)
      err = SDL.SDL_RenderSetVSync(renderer, b ? 1 : 0)
      raise SDLError if err != 0
    end
  end
end
