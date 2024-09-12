require 'SDLRuby'

SDLRuby.load_sdl
include SDLRuby
SDL.init
w = Window.create(__FILE__)
sleep 10
