require 'SDLRuby'

SDLRuby.load_sdl
include SDLRuby
SDL.alert("ALERT", __FILE__)
SDL.error_alert("ERROR ALERT")
SDL.warn_alert("WARNING ALERT")
SDL.info_alert("INFO ALERT")
