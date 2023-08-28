module SDLRuby
  module TextInput
    class << self
      include SDL

      # テキスト入力イベントが有効かチェックする
      def active? = SDL.SDL_IsTextInputActive != 0

      # コンポジションウィンドウ/IMEをIMEを無効化せずに閉じる
      #
      def hide = SDL.SDL_ClearComposition

      # テキスト入力で使う領域を設定する
      # ※ 表示はされるが指定が行われない。調査が必要。
      # もし指定ができないのならば show メソッドに名前を変えた方が良い。
      # NOTICE:
      # システムの IMEウィンドウを使う場合はSDL_HINT_IME_SHOW_UIヒントを1に設定する。
      # これはウィンドウの生成前に行う必要がある。※SDL_Initの後でも問題はない。
      #
      def rect=(rect)
        SDL.SDL_SetTextInputRect(Rect[*rect])
      end

      # 環境がスクリーンキーボードに対応しているかチェックする
      def screen_keyboard_supported? = SDL.SDL_HasScreenKeyboardSupport != 0

      # スクリーンキーボードが指定のウィンドウに表示されているかチェックする
      def screen_keyboard_shown?(window) = SDL.SDL_IsScreenKeyboardShown(window) != 0

      # IMEコンポジット(変換中ウィンドウ・矩形)または変換候補が現在表示されているかを戻す
      def shown? = SDL.SDL_IsTextInputShown != 0

      def start = SDL.SDL_StartTextInput

      def stop = SDL.SDL_StopTextInput
    end
  end
end
