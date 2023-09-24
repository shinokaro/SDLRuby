require_relative '../rw/read_closure'
require_relative '../rw/seek_closure'
require_relative '../rw/size_closure'
require_relative '../rw/write_closure'

module SDLRuby
  class RWOps
    class RWObject
      include Fiddle, SDL

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
        SDL_RWops.new(rw, SDL_FREE_RW)["close"].to_int
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
        @st.read  = @read  = RW::ReadClosure.new(obj)
        @st.seek  = @seek  = RW::SeekClosure.new(obj)
        @st.size  = @size  = RW::SizeClosure.new(obj)
        @st.write = @write = RW::WriteClosure.new(obj)
      end

      def to_ptr = @st.to_ptr
    end
  end
end
