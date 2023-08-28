module SDLRuby
  module Renderer
    class RendererInfo
      include SDL
      extend Forwardable

      def initialize
        @st = SDL_RendererInfo.malloc(Fiddle::RUBY_FREE)
      end

      def_delegators :@st,
                     :flags, :to_ptr, :max_texture_height, :max_texture_width

      def accelerated? = flags & SDL_RENDERER_ACCELERATED != 0

      def renderer_formats = @st.texture_formats[0, @st.num_texture_formats]

      def renderer_name = @st.name.to_s

      def software_renderer? = flags & SDL_RENDERER_SOFTWARE != 0

      def max_texture_size = [@st.max_texture_height, @st.max_texture_width]

      def vsync? = flags & SDL_RENDERER_PRESENTVSYNC != 0
    end
  end
end
