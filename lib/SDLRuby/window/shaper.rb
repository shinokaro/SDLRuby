module SDLRuby
  class Window
    module Shaper
      def shape(shape, cutoff = nil)
        st = SDL_WindowShapeMode.malloc(Fiddle::RUBY_FREE)

        case cutoff
        when nil
          st.mode = ShapeModeDefault
        when Integer
          st.mode = cutoff >= 0 ? ShapeModeBinarizeAlpha : ShapeModeReverseBinarizeAlpha
          st.parameters.binarizationCutoff = cutoff.abs
        when Array
          st.mode = ShapeModeColorKey
          st.parameters.colorKey.tap { |c| c.r, c.g, c.b, c.a = *cutoff }
        else
          raise ArgumentError
        end

        case SDL.SDL_SetWindowShape(self, shape, st)
        when 0
          return
        when SDL_NONSHAPEABLE_WINDOW
          raise SDLError, "SDL_NONSHAPEABLE_WINDOW"
        when SDL_INVALID_SHAPE_ARGUMENT
          if shape.size != size
            raise SDLError, "the size of window and the size of surface do not match."
          elsif !shape.alpha?
            raise SDLError, "the color key is not specified in the surface without alpha channel."
          else
            raise SDLError, "SDL_INVALID_SHAPE_ARGUMENT"
          end
        else
          raise SDLError
        end
      end

      def cutoff
        st = SDL_WindowShapeMode.malloc(Fiddle::RUBY_FREE)

        case SDL.SDL_GetShapedWindowMode(self, st)
        when 0
          cutoff = case st.mode
                   when ShapeModeDefault
                     nil
                   when ShapeModeBinarizeAlpha
                     st.parameters.binarizationCutoff
                   when ShapeModeReverseBinarizeAlpha
                     -st.parameters.binarizationCutoff
                   when ShapeModeColorKey
                     st.parameters.colorKey.to_a[0..2]
                   else
                     nil
                   end
          return cutoff
        when SDL_NONSHAPEABLE_WINDOW
          raise SDLError, "SDL_NONSHAPEABLE_WINDOW"
        when SDL_WINDOW_LACKS_SHAPE
          raise SDLError, "SDL_WINDOW_LACKS_SHAPE"
        else
          raise SDLError
        end
      end

      def shaped? = SDL.SDL_IsShapedWindow(self) == 1
    end
  end
end
