module SDLRuby
  module Hint
    class << self
      include SDL

      def [](name) = SDL.SDL_GetHint(name.to_s).to_s

      # value が nil の場合はヒントの値はNULLに設定される。
      #
      def []=(name, value)
        s = name.to_s
        if value
          SDL.SDL_SetHintWithPriority(s, value.to_s, SDL_HINT_OVERRIDE)
        else
          SDL.SDL_SetHintWithPriority(s, nil, SDL_HINT_OVERRIDE)
        end
      end

      # 全てのヒントを関連付けられた環境変数の値,
      # または環境変数がない場合はNULLにリセットする.
      #
      def clear = SDL.SDL_ResetHints

      def freeze = raise(TypeError, "cannot freeze Hint")

      def include?(name) = SDL.SDL_GetHintBoolean(name.to_s, -1) != -1
      alias has_key? include?
      alias member? include?
      alias key? include?

      # ヒントを環境変数の値にリセットする。
      #
      def reset(s) = SDL.SDL_ResetHint(s)
    end
  end
end
