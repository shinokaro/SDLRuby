module SDLRuby
  module Mixer
    module Controller
      def expire(sec) = Mixer.Mix_ExpireChannel(sec * 1000)

      def fade_out(sec) = Mixer.Mix_FadeOutChannel(-1, sec * 1000)

      def fading? = Mixer.Mix_FadingChanne(self) != MIX_NO_FADING

      def fading_in? = Mixer.Mix_FadingChanne(self) == MIX_FADING_IN

      def fading_out? = Mixer.Mix_FadingChanne(self) == MIX_FADING_OUT

      def halt = Mixer.Mix_HaltChannel(self)

      def pause = Mixer.Mix_Pause(self)

      def paused? = Mixer.Mix_Paused(self).nonzero?

      def play(chunk, fade_in_time: nil, loops: nil, time: nil)
        l = loops ? loops - 1 : 0
        t = time ? time * 1000 : -1

        if fade_in_time
          Mixer.Mix_FadeInChannelTimed(self, chunk, l, fade_in_time * 1000, t)
        else
          Mixer.Mix_PlayChannelTimed(self, chunk, l, t)
        end => err

        raise SDLError if err < 0
      end

      def playing? = Mixer.Mix_Playing(self).nonzero?

      def resume = Mixer.Mix_Resume(self)

      def volume = Mixer.Mix_Volume(self, -1)

      def volume=(v)
        Mixer.Mix_Volume(self, v)
      end
    end
  end
end
