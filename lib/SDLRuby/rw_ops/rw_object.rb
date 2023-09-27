require_relative '../rw/read_closure'
require_relative '../rw/seek_closure'
require_relative '../rw/size_closure'
require_relative '../rw/write_closure'
require_relative 'mem_close'

module SDLRuby
  class RWOps
    class RWObject
      include Fiddle, SDL

      # 引数objに与えたオブジェクトはSDLからcloseを呼び出されてもクローズしない。
      # このインスタンスを単独で扱う場合は使い終わったらclose関数を呼び出す必要がある。
      # そうしなければポインターは開放されずメモリーリークする。
      #
      def initialize(obj)
        ptr = SDL.SDL_AllocRW
        raise SDLError if ptr.null?

        @st = SDL_RWops.new(ptr)

        # SDLではSDL_RWopsポインターの開放はclose関数ポインターを呼び出して行う仕様となっている。
        #
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
