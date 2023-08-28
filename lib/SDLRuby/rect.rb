module SDLRuby
  class Rect < SDL::SDL_Rect
    class << self
      def [](*xywh)
        st = malloc(Fiddle::RUBY_FREE)
        st.x, st.y, st.w, st.h = *xywh
        st
      end
    end
  end
end
