module SDLRuby
  class Window
    module WindowRenderer
      def init_renderer(name = nil, flags = nil,
                        accelerated: nil, software: nil, vsync: nil)

        idx = if name
                i = Renderer.drivers.index(name)
                raise ArgumentError unless i
                i
              else
                -1
              end
        num = flags || 0 |
          (accelerated ? SDL_RENDERER_ACCELERATED : 0) |
          (software ? SDL_RENDERER_SOFTWARE : 0) |
          (vsync ? SDL_RENDERER_PRESENTVSYNC : 0)
        ptr = SDL.SDL_CreateRenderer(self, idx, num)
        raise SDLError if ptr.null?
      end

      private def renderer
        ptr = SDL.SDL_GetRenderer(self)
        raise SDLError if ptr.null?
        ptr
      end

      def destroy_renderer = SDL.SDL_DestroyRenderer(SDL.SDL_GetRenderer(self))
    end
  end
end
