# frozen_string_literal: true

require 'minitest/autorun'

module SDLRuby
  class SDLTest < Minitest::Test
    include ::SDLRuby, ::SDLRuby::SDL

    def test_sdlk_constants_is_integer_all
      a = SDL.constants(false).select { |s| s.match?(/^SDLK_/, 0) }

      assert a.all? { |s| SDL.const_get(s).instance_of?(Integer) },
             "The definition of SDLK constants includes non-numeric characters.\
 Perhaps, the failure to convert char characters to numbers is the cause"
    end
  end
end
