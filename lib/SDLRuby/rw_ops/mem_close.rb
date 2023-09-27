module SDLRuby
  class RWOps
    include Fiddle, SDL

    # これはSDL3では不要になります。
    # SDL3ではメンバーの関数ポインターにNULLを設定できます。
    # それは”適切な”デフォルトの動作を意味します。
    #
    #
    #
    # SDL2ではcloseにはC関数ポインターを設定する必要がある。
    # Rubyのクロージャ―を設定するとGCが動作時に該当のクロージャ―が既に回収されているため
    # コアダンプする。
    # また、NULLに設定するとSDL_RWclose関数の呼び出し時にコアダンプする。
    # ここではSDLをハックしてmem_close関数を割り当てた。
    # この関数は内部でSDL_FreeRW関数を呼び出すだけである。
    #
    # int (*close) (SDL_RWops *context)
    #
    MEM_CLOSE = module_eval do
      ptr = Pointer.malloc(1, RUBY_FREE)
      rw = SDL.SDL_RWFromMem(ptr, ptr.size)
      raise SDLError if rw.null?
      SDL_RWops.new(rw, SDL_FREE_RW)["close"].to_int
    end
  end
end
