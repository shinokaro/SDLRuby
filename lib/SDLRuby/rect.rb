module SDLRuby
  class Rect < SDL::SDL_Rect
    class << self
      def [](*rect)
        st = malloc(Fiddle::RUBY_FREE)
        st.x, st.y, st.w, st.h = *rect
        st
      end
    end
  end
end
