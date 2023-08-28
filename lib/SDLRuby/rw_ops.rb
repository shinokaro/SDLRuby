require_relative 'rw_ops/rw_object'

module SDLRuby
  class RWOps
    include Fiddle, SDL

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

    def close
      unless closed?
        err = SDL.SDL_RWclose(self)

        raise SDLError if err != 0
      end
    end

    def closed? = @st.to_ptr.freed?

    def eof?
      raise IOError, "closed" if closed?

      s = SDL.SDL_RWsize(self)
      raise SDLError if s < 0

      t = SDL.SDL_RWtell(self)
      raise SDLError if t < 0

      s == t
    end

    def read(length = nil, buffer = nil)
      raise IOError, "closed" if closed?

      len = if length.nil?
              size - tell
            else
              length.to_i
            end

      if len < 0
        raise ArgumentError, "length"
      elsif len > 0 && eof?
        return nil
      end

      case buffer
      when nil
        return "" if len == 0

        buffer = "\x00" * len
        buf_size = len
      when String
        return buffer.clear if len == 0

        buffer = buffer
        buf_size = buffer.bytesize
      when Fiddle::Pointer
        if len == 0
          buffer.size = 0
          return buffer
        end

        buffer = buffer
        buf_size = buffer.size
      else
        raise TypeError, "buffer"
      end

      if len > buf_size
        raise ArgumentError, "length is greater than buffer size."
      end

      n = SDL.SDL_RWread(self, buffer, 1, len)
      raise SDLError if n == 0

      if String === buffer
        buffer.slice!(n, buffer.bytesize)
      else
        buffer.size = n
      end

      buffer
    end

    def seek(offset, whence = IO::SEEK_SET)
      raise IOError, "closed" if closed?

      n = SDL.SDL_RWseek(self, offset, whence)
      raise SDLError if n < 0
      n
    end

    alias pos= seek

    def size
      raise IOError, "closed" if closed?

      n = SDL.SDL_RWsize(self)
      raise SDLError if n < 0
      n
    end

    def tell
      raise IOError, "closed" if closed?

      n = SDL.SDL_RWtell(self)
      raise SDLError if n < 0
      n
    end

    alias pos tell

    def to_ptr
      raise SDLError, "released" if closed?
      @st.to_ptr
    end

    def type
      raise SDLError, "released" if closed?
      @st.type
    end

    def write(obj)
      raise IOError, "closed" if closed?

      case obj
      when String
        ptr = obj
        len = obj.bytesize
      when Fiddle::Pointer
        ptr = obj
        len = obj.size
      else
        ptr = obj.to_s
        len = ptr.bytesize
      end

      n = SDL.SDL_RWwrite(self, ptr, 1, len)
      raise SDLError if n < len
      n
    end
  end
end
