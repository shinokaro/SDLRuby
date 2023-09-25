require_relative 'rw/operational'
require_relative 'rw_ops/rw_object'

module SDLRuby
  class RWOps
    include Fiddle, RW::Operational, SDL

    class << self
      def [](src, autoclose: nil, readonly: nil)
        case src
        when RWOps
          return src
        when String
          size = src.bytesize
          ptr = if readonly
                  SDL.SDL_RWFromConstMem(src, size)
                else
                  SDL.SDL_RWFromMem(src, size)
                end
          raise SDLError if ptr.null?
        when Fiddle::Pointer
          size = src.size
          ptr = if readonly
                  SDL.SDL_RWFromConstMem(src, size)
                else
                  SDL.SDL_RWFromMem(src, size)
                end
          raise SDLError if ptr.null?
        else
          src = RWObject.new(src)
          ptr = src.to_ptr
        end

        obj = allocate
        obj.__send__(:initialize, ptr, src)
        obj
      end

      def new(file, mode = "rb")
        ptr = SDL.SDL_RWFromFile(file, mode)
        raise SDLError if ptr.null?

        rw = super(ptr)

        if block_given?
          obj = yield(rw)
          rw.close
          obj
        else
          rw
        end
      end

      alias open new
    end

    def initialize(ptr, obj = nil)
      @st = SDL_RWops.new(ptr)
      @obj = obj

      # ポインターへC実装のfree関数を与えるため、終了時のGC処理でコアダンプしない。
      #
      @st.to_ptr.free = @st.close

      # close関数の差し替えをすることで、SDLがcloseを行ってもRuby側に伝達できる。
      # int (*close) (SDL_RWops *context)
      #
      st = @st
      @st.close = @close = Closure::BlockCaller.new(
        TYPE_INT, [TYPE_VOIDP]
      ) do |context|
        # call_free はclose関数の戻り値が渡されないためcloseの失敗は分からない。
        st.to_ptr.call_free

        if $DEBUG
          warn "SDL_RWops(0x#{st.to_i.to_s(16)}) closed."
        end

        0
      end
    end

    def to_ptr
      raise SDLError, "released" if closed?
      @st.to_ptr
    end
  end
end
