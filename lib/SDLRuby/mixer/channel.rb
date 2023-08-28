require_relative 'controller'

module SDLRuby
  module Mixer
    class Channel
      include Controller

      def initialize(ch)
        @ch = ch
      end

      def __chank_id__ = Mixer.Mix_GetChunk(self).to_i

      def to_int = @ch

      # Effect
      #
      # Mix_RegisterEffect - エフェクト関数を登録する
      # Mix_UnregisterEffect - エフェクト関数を解除する
      # Mix_UnregisterAllEffects - 全てのエフェクト関数を解除する

      def distance(distance)
        err = Mixer.Mix_SetDistance(self, distance)
        raise SDLError if err == 0
      end

      def panning(left, right)
        err = Mixer.Mix_SetPanning(self, left, right)
        raise SDLError if err == 0
      end

      def position(angle, distance)
        err = Mixer.Mix_SetPosition(self, angle, distance)
        raise SDLError if err == 0
      end

      def reverse_stereo(flip)
        err = Mixer.Mix_SetReverseStereo(self, flip ? 1 : 0)
        raise SDLError if err == 0
      end
    end
  end
end
