module SDLRuby
  class Event
    module Accessor
      include SDL

      @modules = Hash.new

      (SDL_Event.members - %w[type padding]).each do |name, members|
        @modules[name.to_sym] = Module.new do
          extend Forwardable
          # ネストした構造体の場合は親のみを選択する。
          #
          def_delegators :entity, *members.flatten(1).select { |a| !(Array === a) }
        end
      end

      class << self
        def [](sym)
          @modules[sym] || raise(KeyError, "undefined member(#{sym})")
        end
      end

      self[:drop].module_eval do
        undef file

        def file = char_ptr_to_str(entity.file)

        alias text file

        def self.extended(obj)
          obj.__send__(:keep_member_pointer, :file)
        end
      end

      self[:edit].module_eval do
        undef text

        def text = char_ary_to_str(entity.text)
      end

      self[:editExt].module_eval do
        undef text

        def text = char_ptr_to_str(entity.text)

        def self.extended(obj)
          obj.__send__(:keep_member_pointer, :text)
        end
      end

      self[:key].module_eval do
        undef keysym

        def keysym = entity.keysym.to_h
      end

      self[:text].module_eval do
        undef text

        def text = char_ary_to_str(entity.text)
      end

      # イベント構造体へのアクセスをSTIとして実装する。
      # メンバー全てのゲッターに応答できるようにする。（NoMethodErrorを出さない）
      # ※これはKernel#yメソッドにオブジェクトが応答してしまうため、
      # 事前にattr_readerでオーバーライドする。
      #
      attr_reader *%w[
        axis ball button clicks code dDist dTheta data data1 data2 direction
        display dx dy error event file finger fingerId gestureId hat iscapture
        keysym length level mouseX mouseY msg numFingers
        padding padding1 padding2 padding3 padding4
        preciseX preciseY pressure repeat sensor start state text timestamp
        timestamp_us touchId touchpad type value which windowID x xrel y yrel
      ]

      # Ruby like accessor
      #
      alias d_dist dDist
      alias d_theta dTheta
      alias finger_id fingerId
      alias gesture_id gestureId
      alias mouse_x mouseX
      alias mouse_y mouseY
      alias num_fingers numFingers
      alias precise_x preciseX
      alias precise_y preciseY
      alias touch_id touchId
      alias window_id windowID

      # for adevice
      #
      # iscapture = nil => false
      # iscapture = 0   => false
      # iscapture = 1   => true
      #
      def capture? = iscapture&.nonzero? ? true : false

      # for button, cbutton, jbutton
      #
      def pressed? = state == SDL_PRESSED

      # for key
      #
      def scancode = keysym&.[]("scancode")

      def sym = keysym&.[]("sym")

      def mod = keysym&.[]("mod")

      private

      def char_ary_to_str(a)
        a[0, a.find_index(0)].pack("C*").force_encoding("UTF-8")
      end

      def char_ptr_to_str(ptr)
        ptr.null? ? "" : ptr.to_s.force_encoding("UTF-8")
      end

      def keep_member_pointer(attr)
        @_ptr ||= entity.__send__(attr).tap { |ptr| ptr.free = SDL_FREE }
      end
    end
  end
end
