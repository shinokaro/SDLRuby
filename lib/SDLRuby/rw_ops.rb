require 'stringio'
require_relative 'rw/operational'
require_relative 'rw_ops/rw_object'

module SDLRuby
  class RWOps
    include Fiddle, RW::Operational, SDL

    class << self
      def [](obj)
        return obj if obj.kind_of?(RWOps)

        case obj
        in Fiddle::Pointer
          ptr = if obj.frozen?
                  SDL.SDL_RWFromConstMem(obj, obj.size)
                else
                  SDL.SDL_RWFromMem(obj, obj.size)
                end
          raise SDLError if ptr.null?
        in String
          obj = RWObject.new(StringIO.new(obj))
          ptr = obj.to_ptr
        else
          obj = RWObject.new(obj)
          ptr = obj.to_ptr
        end

        rw = allocate
        rw.__send__(:initialize, ptr, obj)
        rw
      end

      def new(file, mode = "rb")
        path = if file.instance_of?(String)
                 file
               elsif file.respond_to?(:to_path)
                 file.to_path
               end
        ptr = SDL.SDL_RWFromFile(path, mode)
        raise SDLError if ptr.null?

        rw = super(ptr)

        if block_given?
          begin
            yield(rw)
          ensure
            rw.close
          end
        else
          rw
        end
      end

      alias open new
    end

    def initialize(ptr, obj = nil)
      @obj = obj

      @st = SDL_RWops.new(ptr)

      # ポインターへC実装のfree関数を与えるため、終了時のGC処理でコアダンプしない。
      #
      @st.to_ptr.free = @st["close"]

      # close関数の差し替えをすることで、SDLがcloseを行ってもRuby側に伝達できる。
      # int (*close) (SDL_RWops *context)
      #
      @st["close"] = @close = Closure::BlockCaller.new(TYPE_INT, [TYPE_VOIDP]) do |_|
        # call_free はclose関数の戻り値が渡されないためcloseの失敗は分からない。
        to_ptr.call_free

        if $DEBUG
          warn format("SDL_RWops(0x%016x) closed", to_ptr.to_int)
        end

        0
      end
    end

    def initialize_copy(other)
      raise SDLError, "closed stream" if closed?

      super
    end

    def to_ptr = @st.to_ptr
  end
end
