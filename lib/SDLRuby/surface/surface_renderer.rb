module SDLRuby
  class Surface
    module SurfaceRenderer
      include SDL

      # サーフェス用のレンダラーは複数作ることができる。
      # また、サーフェス側からはそれが見えない。
      # サーフェスのインスタンスごとにレンダラーを保持する。
      # そのためテクスチャーの共有ができない。
      # このケースはサーフェスインスタンスをdup, cloneした時のみだろう。
      # この分離が認められない場合は、サーフェス側のポインターの中にレンダラーを埋め込む。
      #

      def init_renderer(*)
        ptr = SDL.SDL_CreateSoftwareRenderer(self)
        raise SDLError if ptr.null?
        ptr.free = SDL_DESTROY_RENDERER
        @renderer = ptr
      end

      private def renderer = @renderer ||= init_renderer

      def destroy_renderer = @renderer = @renderer.call_free
    end
  end
end
