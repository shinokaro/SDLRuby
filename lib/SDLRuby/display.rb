require_relative 'pixel_formatter'

module SDLRuby
  class DisplayMode
    include PixelFormatter, SDL
    extend Forwardable

    def initialize
      @st = SDL_DisplayMode.malloc(Fiddle::RUBY_FREE)
    end

    def_delegators :@st, :format, :w, :h, :refresh_rate

    def to_ptr = @st.to_ptr
  end

  class Display
    class << self
      include SDL

      # Videoの初期化がされていなければ0を戻す。
      #
      def count = (i = SDL.SDL_GetNumVideoDisplays) < 0 ? 0 : i

      def orientation(idx) = SDL.SDL_GetDisplayOrientation(idx)

      def orientation_name(idx)
        case orientation(idx)
        when SDL_ORIENTATION_UNKNOWN           then ""
        when SDL_ORIENTATION_LANDSCAPE         then "landscape"
        when SDL_ORIENTATION_LANDSCAPE_FLIPPED then "landscape_flipped"
        when SDL_ORIENTATION_PORTRAIT          then "portrait"
        when SDL_ORIENTATION_PORTRAIT_FLIPPED  then "portrait_flipped"
        else
          ""
        end
      end
    end

    attr_reader :bounds, :current_display_mode, :desktop_display_mode,
                :display_modes, :name, :orientation, :usable_bounds

    def initialize(num)
      # この実装では例外を出さない。
      # 基本的にSDLの内部構造体を読み出しているだけであり、
      # 関数からのエラー報告はインデックス境界に関するものである。
      #
      # ディスプレイの状態はユーザのハードウェアやOS操作によって常に変化する。
      # 一纏めにデータを取得する必要がある。
      #
      @bounds = Rect[].tap { |r| SDL.SDL_GetDisplayBounds(num, r) }.to_a

      @current_display_mode = DisplayMode.new.tap do |st|
        SDL.SDL_GetCurrentDisplayMode(num, st)
      end

      @desktop_display_mode = DisplayMode.new.tap do |st|
        SDL.SDL_GetDesktopDisplayMode(num, st)
      end

      @display_modes = SDL.SDL_GetNumDisplayModes(num).times.map do |idx|
        DisplayMode.new.tap { |st| SDL.SDL_GetDisplayMode(num, idx, st) }
      end

      ptr = SDL.SDL_GetDisplayName(num)
      @name = (ptr.null? ? nil : ptr).to_s.force_encoding("UTF-8")

      @orientation = Display.orientation(num)

      @usable_bounds = Rect[].tap do |r|
        SDL.SDL_GetDisplayUsableBounds(num, r)
      end.to_a

      @num = num
    end

    def to_i = @num
  end
end
