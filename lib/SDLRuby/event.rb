require_relative 'event/accessor'
require_relative 'event/type'

module SDLRuby
  class Event
    include Accessor, Fiddle, SDL

    class << self
      include SDL

      # SDL_WaitEvent, SDL_WaitEventTimeoutはRubyのスレッドを停止させるため実装しない。
      #   ※C関数呼び出し時にGVLを外せれば可能か？
      # SDL_RegisterEventsはSDLに対応するゲッターがないため実装しない。
      # SDL_PushEventは必要ならば実装する。ただしEventコンストラクターを含むため規模が大きい。
      #
      # SDL_AddEventWatch, SDL_SetEventFilterおよびSDL_FilterEventsは実装しない。
      #   イベントにポインターを含む場合、RubyのGCの管理下に置く方法が複雑なため。
      #   ※現実装ではイベントを取り込んだ時点でポインターをRubyの管理下に置いている。
      #   メンバーのポインター管理をファイナライザーに移行できれば可能だろう。
      #   ※そしてファイナライザーを設定するかどうか選択する。
      #   いずれもSDL_EventPumpを呼び出さなければ動作しない。
      #   非同期にイベントを取得できるわけではない。
      # SDL_PeepEventsは実装しない。
      #   SDL_ADDEVENT:
      #     イベントのメンバーにポインターを含む場合、それのSDL側へのコピーが必要になる。
      #     SDL_PushEventが実装されれば、それが同等の機能を持つ。
      #   SDL_PEEKEVENT:
      #     SDL_FilterEventsが実装できれば、それが同等の機能を持つ。
      #   SDL_GETEVENT:
      #     キューの削除が目的だと思う。それを行うならSDL_PollEventを利用して欲しい。
      #     イベントキューはコレクションではない。
      #
      #   SDL_PeepEventsは実行中にキューをロックすることに注意。
      #   また、SDL_SYSWMEVENTのmsgメンバーにコピーが必要か分からない。（要調査）
      #   ※このポインターだけSDLが管理しているようだ。

      def clear = (pump or flash)

      def count = SDL.SDL_PeepEvents(nil, 0, SDL_PEEKEVENT, 0, -1)

      def disable(type) = SDL.SDL_EventState(type, 0)

      def enable(type) = SDL.SDL_EventState(type, 1)

      def flash = SDL.SDL_FlushEvents(SDL_FIRSTEVENT, SDL_LASTEVENT)

      def get = poll(e = new)

      private :new

      private def poll(e) = (SDL.SDL_PollEvent(e).nonzero? and e.update)

      def pump = SDL.SDL_PumpEvents

      alias update pump

      def quit? = (pump or SDL.SDL_HasEvent(SDL_QUIT) != 0)
    end

    def initialize
      @st = SDL_Event.malloc(RUBY_FREE)
    end

    private attr_reader :entity

    def to_ptr = @st.to_ptr

    def to_sym = Type.to_sym(@st.type)

    def update
      unless @entity
        sym = to_sym
        @entity = @st.__send__(sym)
        extend(Accessor[sym])
      end

      self
    end
  end
end
