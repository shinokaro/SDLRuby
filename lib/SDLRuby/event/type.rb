module SDLRuby
  class Event
    module Type
      include SDL

      QUIT_EVENT = SDL_QUIT..SDL_QUIT
      DISPLAY_EVENT = SDL_DISPLAYEVENT..SDL_DISPLAYEVENT
      WINDOW_EVENT = SDL_WINDOWEVENT..SDL_WINDOWEVENT
      SYSWM_EVENT = SDL_SYSWMEVENT..SDL_SYSWMEVENT
      KEY_EVENT = SDL_KEYDOWN..SDL_KEYUP
      EDIT_EVENT = SDL_TEXTEDITING..SDL_TEXTEDITING
      TEXT_EVENT = SDL_TEXTINPUT..SDL_TEXTINPUT
      EDIT_EXT_EVENT = SDL_TEXTEDITING_EXT..SDL_TEXTEDITING_EXT
      MOTION_EVENT = SDL_MOUSEMOTION..SDL_MOUSEMOTION
      BUTTON_EVENT = SDL_MOUSEBUTTONDOWN..SDL_MOUSEBUTTONUP
      WHEEL_EVENT = SDL_MOUSEWHEEL..SDL_MOUSEWHEEL
      JAXIS_EVENT = SDL_JOYAXISMOTION..SDL_JOYAXISMOTION
      JBALL_EVENT = SDL_JOYBALLMOTION..SDL_JOYBALLMOTION
      JHAT_EVENT = SDL_JOYHATMOTION..SDL_JOYHATMOTION
      JBUTTON_EVENT = SDL_JOYBUTTONDOWN..SDL_JOYBUTTONUP
      JDEVICE_EVENT = SDL_JOYDEVICEADDED..SDL_JOYDEVICEREMOVED
      JBATTERY_EVENT = SDL_JOYBATTERYUPDATED..SDL_JOYBATTERYUPDATED
      CAXIS_EVENT = SDL_CONTROLLERAXISMOTION..SDL_CONTROLLERAXISMOTION
      CBUTTON_EVENT = SDL_CONTROLLERBUTTONDOWN..SDL_CONTROLLERBUTTONUP
      CDEVICE_EVENT = SDL_CONTROLLERDEVICEADDED..SDL_CONTROLLERDEVICEREMAPPED
      CTOUCHPAD_EVENT = SDL_CONTROLLERTOUCHPADDOWN..SDL_CONTROLLERTOUCHPADUP
      CSENSOR_EVENT = SDL_CONTROLLERSENSORUPDATE..SDL_CONTROLLERSENSORUPDATE
      TFINGER_EVENT = SDL_FINGERDOWN..SDL_FINGERMOTION
      DGESTURE_EVENT = SDL_DOLLARGESTURE..SDL_DOLLARRECORD
      MGESTURE_EVENT = SDL_MULTIGESTURE..SDL_MULTIGESTURE
      DROP_EVENT = SDL_DROPFILE..SDL_DROPCOMPLETE
      ADEVICE_EVENT = SDL_AUDIODEVICEADDED..SDL_AUDIODEVICEREMOVED
      SENSOR_EVENT = SDL_SENSORUPDATE..SDL_SENSORUPDATE
      USER_EVENT = SDL_USEREVENT...SDL_LASTEVENT

      class << self
        def to_sym(type)
          case type
          when DISPLAY_EVENT   then :display
          when WINDOW_EVENT    then :window
          when KEY_EVENT       then :key
          when EDIT_EVENT      then :edit
          when EDIT_EXT_EVENT  then :editExt
          when TEXT_EVENT      then :text
          when MOTION_EVENT    then :motion
          when BUTTON_EVENT    then :button
          when WHEEL_EVENT     then :wheel
          when JAXIS_EVENT     then :jaxis
          when JBALL_EVENT     then :jball
          when JHAT_EVENT      then :jhat
          when JBUTTON_EVENT   then :jbutton
          when JDEVICE_EVENT   then :jdevice
          when JBATTERY_EVENT  then :jbattery
          when CAXIS_EVENT     then :caxis
          when CBUTTON_EVENT   then :cbutton
          when CDEVICE_EVENT   then :cdevice
          when CTOUCHPAD_EVENT then :ctouchpad
          when CSENSOR_EVENT   then :csensor
          when ADEVICE_EVENT   then :adevice
          when SENSOR_EVENT    then :sensor
          when QUIT_EVENT      then :quit
          when USER_EVENT      then :user
          when SYSWM_EVENT     then :syswm
          when TFINGER_EVENT   then :tfinger
          when MGESTURE_EVENT  then :mgesture
          when DGESTURE_EVENT  then :dgesture
          when DROP_EVENT      then :drop
          else
            :common
          end
        end
      end
    end
  end
end
