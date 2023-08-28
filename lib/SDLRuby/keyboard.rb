module SDLRuby
  module Keyboard
    module_eval do
      num_keys = SDL.tmp_value("int")

      # SDL_GetKeyboardState() が戻すポインターはSDLがロードされた時点で作成されている。
      # この関数は SDL_Init() より前に呼ぶことができる。
      ptr = SDL.SDL_GetKeyboardState(num_keys)

      # エラーになるのはnum_keysにNULLを渡したとき。
      raise SDLError if ptr.null?

      ptr.size = num_keys.value
      @state = ptr
    end

    class << self
      def [](idx)
        raise IndexError if idx < 0 || @state.size <= idx
        @state[idx] != 0
      end

      def any? = to_a.any?

      def clear = SDL.SDL_ResetKeyboard

      # キー名からキーコードを得る
      def keycode(s) = SDL.GetKeyFromName(s).nonzero?

      # キーコードからキー名を得る
      def keycode_name(num)
        (s = SDL.GetKeyName(num).to_s).empty? ? nil : s
      end

      # 修飾キーの状態を得る
      def mod
        SDL.SDL_GetModState #=> integer
      end

      # 修飾キーを設定する
      def mod=(modstate)
        SDL.SDL_SetModState(modstate)
      end

      # キー名からスキャンコードを得る
      def scancode(s) = SDL.GetScancodeFromName(s).nonzero?

      # スキャンコードからキー名を得る
      def scancode_name(num)
        (s = SDL.GetScancodeName(num).to_s).empty? ? nil : s
      end

      def to_a = to_str.unpack("C*").map(&:nonzero?)

      def to_str = @state.to_str
    end
  end
end
