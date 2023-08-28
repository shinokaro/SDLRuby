module SDLRuby
  class RWOps
    class RWObject
      include Fiddle, SDL

      # size_t (*read) (SDL_RWops *context, void *ptr, size_t size, size_t maxnum)
      #
      class ReadClosure < Fiddle::Closure
        include Fiddle

        def initialize(obj)
          super(TYPE_SIZE_T, [TYPE_VOIDP, TYPE_VOIDP, TYPE_SIZE_T, TYPE_SIZE_T])
          @obj = obj
        end

        def call(_, ptr, size, maxnum)
          len = size * maxnum
          return 0 if len.zero?

          s = @obj.read(len)
          return 0 if s.nil? || s.empty? # EOF

          ptr[0, s.size] = s
          s.size / size
        rescue => e
          SDL.last_error_message = e.full_message
          0
        end
      end

      # Sint64 (*seek) (SDL_RWops *context, Sint64 offset, int whence)
      #
      class SeekClosure < Fiddle::Closure
        include Fiddle

        def initialize(obj)
          super(TYPE_INT64_T, [TYPE_VOIDP, TYPE_INT64_T, TYPE_INT])
          @obj = obj
        end

        def call(_, offset, whence)
          @obj.seek(offset, whence)
          @obj.tell
        rescue => e
          SDL.last_error_message = e.full_message
          -1
        end
      end

      # Sint64 (*size) (SDL_RWops *context)
      #
      class SizeClosure < Fiddle::Closure
        include Fiddle

        def initialize(obj)
          super(TYPE_INT64_T, [TYPE_VOIDP])
          @obj = obj
        end

        def call(_)
          @obj.size
        rescue => e
          raise e if $DEBUG
          SDL.last_error_message = e.full_message
          -1
        end
      end

      # size_t (*write) (SDL_RWops *context, const void *ptr, size_t size, size_t num)
      #
      class WriteClosure < Fiddle::Closure
        include Fiddle

        def initialize(obj)
          super(TYPE_SIZE_T, [TYPE_VOIDP, TYPE_VOIDP, TYPE_SIZE_T, TYPE_SIZE_T])
          @obj = obj
        end

        def call(_, ptr, size, num)
          @obj.write(ptr.to_str(size * num)) / size
        rescue => e
          SDL.last_error_message = e.full_message
          0
        end
      end

      # closeにはC関数を設定する必要がある。
      # クロージャ―を設定するとGCによる回収の際に
      # 該当のクロージャ―が既に回収されているためコアダンプする。
      # また、NULLに設定するとSDL_RWclose関数の呼び出し時にコアダンプする。
      # SDLをハックしてmem_close関数を割り当てた。
      # この関数は内部でSDL_FreeRW関数を呼び出すだけである。
      #
      # int (*close) (SDL_RWops *context)
      #
      MEM_CLOSE = module_eval do
        _ptr = Pointer.malloc(1, RUBY_FREE)
        rw = SDL.SDL_RWFromMem(_ptr, _ptr.size)
        raise SDLError if rw.null?
        st = SDL_RWops.new(rw)

        st.close.freeze
      end

      # 引数 obj に与えたオブジェクトは SDL から close を呼び出されてもクローズしない。
      # このインスタンスを単独で扱う場合は使い終わったらclose関数を呼び出す必要がある。
      # そうしなければポインターは開放されずメモリーリークする。
      #
      def initialize(obj)
        ptr = SDL.SDL_AllocRW
        raise SDLError if ptr.null?

        # SDLではSDL_RWopsポインターの開放はclose関数から行うように実装されている。
        # これと同じ仕様とするため、このインスタンスではfreeの設定を行わない。
        #
        @st = SDL_RWops.new(ptr)

        @st.close = MEM_CLOSE
        @st.read = @read = ReadClosure.new(obj)
        @st.seek = @seek = SeekClosure.new(obj)
        @st.size = @size = SizeClosure.new(obj)
        @st.write = @write = WriteClosure.new(obj)
      end

      def to_ptr = @st.to_ptr
    end
  end
end
