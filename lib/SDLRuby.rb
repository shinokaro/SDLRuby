# frozen_string_literal: true

require 'forwardable'
require_relative 'SDLRuby/version'
require_relative 'SDLRuby/sdl'

# Extended libraries
#
require_relative 'SDLRuby/font'
require_relative 'SDLRuby/image'
require_relative 'SDLRuby/mixer'
require_relative 'SDLRuby/music'

module SDLRuby
  class Error < StandardError; end
end
