module SDLRuby
  class Window
    module HitTester

      module Remover
        def destroy
          Window.set_hit_test_proc(self, nil)
          super
        end
      end

      class << self
        private def included(klass) = klass.prepend(Remover)
      end

      # SDL_HitTestResult SDL_HitTest(SDL_Window* win, const SDL_Point* area, void* data)
      #
      class HitTestClosure < Fiddle::Closure
        include Fiddle, SDL

        def initialize(obj)
          super(TYPE_INT, [TYPE_VOIDP, TYPE_VOIDP, TYPE_VOIDP])
          @obj = obj
        end

        def call(_win, area, _data) = @obj.call(*SDL_Point.new(area)).to_i
      end

      @hit_tests = {}

      class << self
        def get_hit_test_proc(window)
          id = window.to_int
          @hit_tests[id].last
        end

        def set_hit_test_proc(window, obj)
          func = obj ? HitTestClosure.new(obj) : nil
          err = SDL.SDL_SetWindowHitTest(window, func, nil)
          raise SDLError if err < 0

          id = window.to_int

          if obj
            @hit_tests[id] = [func, obj]
          else
            @hit_tests.delete(id)
          end
        end
      end

      def hit_test_proc = HitTester.get_hit_test_proc(self)

      # objはcallメソッドを持つオブジェクトであること。
      #
      def hit_test_proc=(obj)
        HitTester.set_hit_test_proc(self, obj)
      end
    end
  end
end
