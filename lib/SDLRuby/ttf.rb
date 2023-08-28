require 'fiddle/import'

module SDLRuby
  module TTF
    include SDL
    extend Fiddle::Importer

    dlload "SDL2_ttf"

    typealias "Uint32", "uint32_t"
    typealias "SDL_bool", "int"
    typealias "SDL_Color", "void*"

    require_relative 'ttf/ttf'

    class << self
      def byte_swapped_unicode=(b)
        TTF.TTF_ByteSwappedUNICODE(b ? 1 : 0)
      end

      def free_type_version
        major, minor, patch = SDL.tmp_value("int", "int", "int")
        TTF.TTF_GetFreeTypeVersion(major, minor, patch)

        "#{major}.#{minor}.#{patch}"
      end

      def harf_bazz_version
        major, minor, patch = SDL.tmp_value("int", "int", "int")
        TTF.TTF_GetHarfBuzzVersion(major, minor, patch)

        "#{major}.#{minor}.#{patch}"
      end

      def init
        return if init?
        err = TTF.TTF_Init
        raise SDLError if err < 0
      end

      # 初期化した回数を戻す。その回数分だけquitを呼ばなければならない。
      #
      def init? = TTF.TTF_WasInit.nonzero?

      # 使用中のフォントがある場合、quitを呼ぶとフォントを閉じることができなくなる！
      # これを呼び出す前に全てのフォントを閉じておくこと。
      # しかし、Rubyがポインターを管理するためアプリケーションでは制御できないだろう・・・
      #
      def quit = TTF.TTF_Quit

      def version = SDL_version.new(TTF.TTF_Linked_Version).to_a.join(".")
    end
  end
end
