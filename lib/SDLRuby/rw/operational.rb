module SDLRuby
  class RW
    module Operational
      def close
        unless closed?
          err = SDL.SDL_RWclose(to_ptr)

          raise SDLError if err < 0
        end
      end

      def closed? = to_ptr.freed?

      def eof?
        raise SDLError, "closed and freed rw" if closed?

        s = SDL.SDL_RWsize(to_ptr)
        raise SDLError if s < 0

        t = SDL.SDL_RWtell(to_ptr)
        raise SDLError if t < 0

        s == t
      end

      def read(length = nil, buffer = nil)
        raise SDLError, "closed and freed rw" if closed?

        if length.nil?
          len = size - tell
        else
          len = Integer.try_convert(length)
          if len.nil?
            raise TypeError,
                  "no implicit conversion of #{length.class} into Integer"
          end
        end

        if len < 0
          raise ArgumentError, "negative length #{len} given"
        end

        if buffer.nil?
          buffer = ""
        else
          buffer = String.try_convert(buffer)
          if buffer.nil?
            raise TypeError,
                  "no implicit conversion of #{buffer.class} into String"
          end
        end

        if eof? || len == 0
          buffer.clear
          return len == 0 ? buffer : nil
        end

        bytesize = buffer.bytesize
        if len == bytesize
          buffer
        elsif len > bytesize
          buffer.gsub!(/\z/nm, "\x00" * (len - bytesize))
        elsif len < bytesize
          buffer.gsub!(/[\x00-\xFF]{#{bytesize - len}}\z/nm, "")
        end

        n = SDL.SDL_RWread(to_ptr, buffer, 1, len)
        if n < len
          buffer.gsub!(/[\x00-\xFF]{#{n}}$/nm, "")
        end
        raise SDLError if n == 0

        buffer
      end

      def seek(offset, whence = IO::SEEK_SET)
        raise SDLError, "closed and freed rw" if closed?

        n = SDL.SDL_RWseek(to_ptr, offset, whence)
        raise SDLError if n < 0
        0
      end

      alias pos= seek

      def size
        raise SDLError, "closed and freed rw" if closed?

        n = SDL.SDL_RWsize(to_ptr)
        raise SDLError if n < 0
        n
      end

      def tell
        raise SDLError, "closed and freed rw" if closed?

        n = SDL.SDL_RWtell(to_ptr)
        raise SDLError if n < 0
        n
      end

      alias pos tell

      def write(obj)
        raise SDLError, "closed and freed rw" if closed?

        ptr = obj.to_s
        len = ptr.bytesize

        n = SDL.SDL_RWwrite(to_ptr, ptr, 1, len)
        raise SDLError if n < len
        n
      end
    end
  end
end
