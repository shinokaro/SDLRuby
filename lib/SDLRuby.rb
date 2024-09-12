# frozen_string_literal: true

require 'forwardable'
require_relative 'SDLRuby/version'

module SDLRuby
  class Error < StandardError; end

  class << self
    def load_sdl
      require_relative 'SDLRuby/sdl'
    end

    # Extended libraries
    #
    def load_sdl_font
      require_relative 'SDLRuby/font'
    end

    def load_sdl_image
      require_relative 'SDLRuby/image'
    end

    def load_sdl_mixer
      require_relative 'SDLRuby/mixer'
    end

    def load_sdl_music
      require_relative 'SDLRuby/music'
    end
  end
end
