module SDLRuby
  class Palette
    include SDL
    extend Forwardable

    class << self
      def create(n)
        ptr = SDL.SDL_AllocPalette(n)
        raise SDLError if ptr.null?
        new(ptr)
      end
    end

    def initialize(ptr, add_ref: nil)
      @st = SDL_Palette.new(ptr, SDL_FREE_PALETTE)
      @st.refcount += 1 if add_ref
    end

    def_delegator :@st, :ncolors, :size
    def_delegators :@st, :refcount, :to_ptr, :version

    def ==(other)
      (other.respond_to?(:to_ptr) && @st.to_ptr == other.to_ptr) ||
        (Palette === other && other.respond_to?(:to_a) && to_a == other.to_a)
    end

    def [](n)
      raise ArgumentError if n < 0 || n >= size
      SDL_Color.new(@st.colors + SDL_Palette.size * n).to_a
    end

    def []=(n, obj)
      c = SDL_Color.malloc(Fiddle::RUBY_FREE)
      c.r, c.g, c.b, c.a = *obj
      err = SDL.SDL_SetPaletteColors(self, c, n, 1)
      raise SDLError if err < 0
    end

    def each
      if block_given?
        size.times { |n| yield(self[n]) }
      else
        to_enum
      end
    end

    def to_a = each.to_a
  end
end
