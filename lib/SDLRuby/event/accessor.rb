module SDLRuby
  class Event
    module Accessor
      include SDL

      union_members = SDL_Event.members.inject([]) do |result, (name, members)|
        if members
          # ネストした構造体の場合は親のみを選択する。
          result << [name, members.flatten(1).select { |a| !(Array === a) }]
        end

        result
      end

      @modules = Hash.new do |_, key|
        raise KeyError, "undefined SDL_Event member(#{key})"
      end

      union_members.each do |name, members|
        @modules[name.to_sym] = Module.new do
          extend Forwardable

          def_delegators :entity, *members
        end
      end

      class << self
        def [](sym) = @modules[sym]
      end

      self[:adevice].module_eval do
        def capture? = entity.iscapture != 0
      end

      self[:cbutton].module_eval do
        def pressed? = state == SDL_PRESSED
      end

      self[:drop].module_eval do
        undef file

        def file = char_ptr_to_str(entity.file)

        alias_method :text, :file

        def self.extended(obj)
          @_ptr ||= entity.file.tap { |ptr| ptr.free = SDL_FREE unless ptr.null? }
        end
      end

      self[:edit].module_eval  do
        undef text

        def text = char_ary_to_str(entity.text)
      end

      self[:editExt].module_eval do
        undef text

        def text = char_ptr_to_str(entity.text)

        def self.extended(obj)
          @_ptr ||= entity.text.tap { |ptr| ptr.free = SDL_FREE }
        end
      end

      self[:jbutton].module_eval do
        def pressed? = state == SDL_PRESSED
      end

      self[:key].module_eval do
        undef keysym

        def keysym = entity.keysym.to_h
      end

      self[:syswm].module_eval do
        undef msg

        def msg = entity.msg
      end

      self[:text].module_eval do
        undef text

        def text = char_ary_to_str(entity.text)
      end

      self[:user].module_eval do
        undef data1, data2

        def data1 = entity.data1

        def data2 = entity.data2
      end

      # STIの実装としてメンバー全てのゲッターに例外を出さず応答するようにする。
      # これは"y"メソッドにRubyが応答してしまうため。事前にオーバーライドしておく。
      #
      all_members = union_members.map { |a| a.last }.flatten.uniq

      attr_reader(*all_members)

      # Ruby like accessor
      #
      alias_method :d_dist, :dDist
      alias_method :d_theta, :dTheta
      alias_method :finger_id, :fingerId
      alias_method :gesture_id, :gestureId
      alias_method :mouse_x, :mouseX
      alias_method :mouse_y, :mouseY
      alias_method :num_fingers, :numFingers
      alias_method :precise_x, :preciseX
      alias_method :precise_y, :preciseY
      alias_method :touch_id, :touchId
      alias_method :window_id, :windowID

      private def char_ary_to_str(a)
        a[0, a.find_index(0)].pack("C*").force_encoding("UTF-8")
      end

      private def char_ptr_to_str(ptr)
        ptr.null? ? "" : ptr.to_s.force_encoding("UTF-8")
      end
    end
  end
end
