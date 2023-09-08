module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"
  require_relative "SDL_rwops.h"
  require_relative "SDL_sensor.h"
  require_relative "SDL_joystick.h"

  SDL_CONTROLLER_TYPE_UNKNOWN = 0
  SDL_CONTROLLER_TYPE_XBOX360 = 1
  SDL_CONTROLLER_TYPE_XBOXONE = 2
  SDL_CONTROLLER_TYPE_PS3 = 3
  SDL_CONTROLLER_TYPE_PS4 = 4
  SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_PRO = 5
  SDL_CONTROLLER_TYPE_VIRTUAL = 6
  SDL_CONTROLLER_TYPE_PS5 = 7
  SDL_CONTROLLER_TYPE_AMAZON_LUNA = 8
  SDL_CONTROLLER_TYPE_GOOGLE_STADIA = 9
  SDL_CONTROLLER_TYPE_NVIDIA_SHIELD = 10
  SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_JOYCON_LEFT = 11
  SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_JOYCON_RIGHT = 12
  SDL_CONTROLLER_TYPE_NINTENDO_SWITCH_JOYCON_PAIR = 13
  typealias "SDL_GameControllerType", "int"

  SDL_CONTROLLER_BINDTYPE_NONE = 0
  SDL_CONTROLLER_BINDTYPE_BUTTON = 1
  SDL_CONTROLLER_BINDTYPE_AXIS = 2
  SDL_CONTROLLER_BINDTYPE_HAT = 3
  typealias "SDL_GameControllerBindType", "int"

  SDL_GameControllerButtonBind = struct(
    [
      "SDL_GameControllerBindType bindType",
      { value: union(
        [
          "int button",
          "int axis",
          { hat: struct(
            [
              "int hat",
              "int hat_mask",
            ]
          ) }
        ]
      ) }
    ]
  )

  extern "int SDL_GameControllerAddMappingsFromRW(SDL_RWops * rw, int freerw)"

  def self.SDL_GameControllerAddMappingsFromFile(file)
    SDL_GameControllerAddMappingsFromRW(SDL_RWFromFile(file, "rb"), 1)
  end

  extern "int SDL_GameControllerAddMapping(const char* mappingString)"
  extern "int SDL_GameControllerNumMappings(void)"
  extern "char * SDL_GameControllerMappingForIndex(int mapping_index)"
  # extern "char * SDL_GameControllerMappingForGUID(SDL_JoystickGUID guid)"
  extern "char * SDL_GameControllerMapping(SDL_GameController *gamecontroller)"
  extern "SDL_bool SDL_IsGameController(int joystick_index)"
  extern "const char * SDL_GameControllerNameForIndex(int joystick_index)"
  extern "const char * SDL_GameControllerPathForIndex(int joystick_index)"
  extern "SDL_GameControllerType SDL_GameControllerTypeForIndex(int joystick_index)"
  extern "char * SDL_GameControllerMappingForDeviceIndex(int joystick_index)"
  extern "SDL_GameController * SDL_GameControllerOpen(int joystick_index)"
  extern "SDL_GameController * SDL_GameControllerFromInstanceID(SDL_JoystickID joyid)"
  extern "SDL_GameController * SDL_GameControllerFromPlayerIndex(int player_index)"
  extern "const char * SDL_GameControllerName(SDL_GameController *gamecontroller)"
  extern "const char * SDL_GameControllerPath(SDL_GameController *gamecontroller)"
  extern "SDL_GameControllerType SDL_GameControllerGetType(SDL_GameController *gamecontroller)"
  extern "int SDL_GameControllerGetPlayerIndex(SDL_GameController *gamecontroller)"
  extern "void SDL_GameControllerSetPlayerIndex(SDL_GameController *gamecontroller, int player_index)"
  extern "Uint16 SDL_GameControllerGetVendor(SDL_GameController *gamecontroller)"
  extern "Uint16 SDL_GameControllerGetProduct(SDL_GameController *gamecontroller)"
  extern "Uint16 SDL_GameControllerGetProductVersion(SDL_GameController *gamecontroller)"
  extern "Uint16 SDL_GameControllerGetFirmwareVersion(SDL_GameController *gamecontroller)"
  extern "const char * SDL_GameControllerGetSerial(SDL_GameController *gamecontroller)"
  extern "SDL_bool SDL_GameControllerGetAttached(SDL_GameController *gamecontroller)"
  extern "SDL_Joystick * SDL_GameControllerGetJoystick(SDL_GameController *gamecontroller)"
  extern "int SDL_GameControllerEventState(int state)"
  extern "void SDL_GameControllerUpdate(void)"

  SDL_CONTROLLER_AXIS_INVALID = -1
  SDL_CONTROLLER_AXIS_LEFTX = 0
  SDL_CONTROLLER_AXIS_LEFTY = 1
  SDL_CONTROLLER_AXIS_RIGHTX = 2
  SDL_CONTROLLER_AXIS_RIGHTY = 3
  SDL_CONTROLLER_AXIS_TRIGGERLEFT = 4
  SDL_CONTROLLER_AXIS_TRIGGERRIGHT = 5
  SDL_CONTROLLER_AXIS_MAX = 6
  typealias "SDL_GameControllerAxis", "int"

  extern "SDL_GameControllerAxis SDL_GameControllerGetAxisFromString(const char *str)"
  extern "const char* SDL_GameControllerGetStringForAxis(SDL_GameControllerAxis axis)"
  # extern "SDL_GameControllerButtonBind SDL_GameControllerGetBindForAxis(SDL_GameController *gamecontroller, SDL_GameControllerAxis axis)"
  extern "SDL_bool SDL_GameControllerHasAxis(SDL_GameController *gamecontroller, SDL_GameControllerAxis axis)"
  extern "Sint16 SDL_GameControllerGetAxis(SDL_GameController *gamecontroller, SDL_GameControllerAxis axis)"

  SDL_CONTROLLER_BUTTON_INVALID = -1
  SDL_CONTROLLER_BUTTON_A = 0
  SDL_CONTROLLER_BUTTON_B = 1
  SDL_CONTROLLER_BUTTON_X = 2
  SDL_CONTROLLER_BUTTON_Y = 3
  SDL_CONTROLLER_BUTTON_BACK = 4
  SDL_CONTROLLER_BUTTON_GUIDE = 5
  SDL_CONTROLLER_BUTTON_START = 6
  SDL_CONTROLLER_BUTTON_LEFTSTICK = 7
  SDL_CONTROLLER_BUTTON_RIGHTSTICK = 8
  SDL_CONTROLLER_BUTTON_LEFTSHOULDER = 9
  SDL_CONTROLLER_BUTTON_RIGHTSHOULDER = 10
  SDL_CONTROLLER_BUTTON_DPAD_UP = 11
  SDL_CONTROLLER_BUTTON_DPAD_DOWN = 12
  SDL_CONTROLLER_BUTTON_DPAD_LEFT = 13
  SDL_CONTROLLER_BUTTON_DPAD_RIGHT = 14
  SDL_CONTROLLER_BUTTON_MISC1 = 15
  SDL_CONTROLLER_BUTTON_PADDLE1 = 16
  SDL_CONTROLLER_BUTTON_PADDLE2 = 17
  SDL_CONTROLLER_BUTTON_PADDLE3 = 18
  SDL_CONTROLLER_BUTTON_PADDLE4 = 19
  SDL_CONTROLLER_BUTTON_TOUCHPAD = 20
  SDL_CONTROLLER_BUTTON_MAX = 21
  typealias "SDL_GameControllerButton", "int"

  extern "SDL_GameControllerButton SDL_GameControllerGetButtonFromString(const char *str)"
  extern "const char* SDL_GameControllerGetStringForButton(SDL_GameControllerButton button)"
  # extern "SDL_GameControllerButtonBind SDL_GameControllerGetBindForButton(SDL_GameController *gamecontroller, SDL_GameControllerButton button)"
  extern "SDL_bool SDL_GameControllerHasButton(SDL_GameController *gamecontroller, SDL_GameControllerButton button)"
  extern "Uint8 SDL_GameControllerGetButton(SDL_GameController *gamecontroller, SDL_GameControllerButton button)"
  extern "int SDL_GameControllerGetNumTouchpads(SDL_GameController *gamecontroller)"
  extern "int SDL_GameControllerGetNumTouchpadFingers(SDL_GameController *gamecontroller, int touchpad)"
  extern "int SDL_GameControllerGetTouchpadFinger(SDL_GameController *gamecontroller, int touchpad, int finger, Uint8 *state, float *x, float *y, float *pressure)"
  extern "SDL_bool SDL_GameControllerHasSensor(SDL_GameController *gamecontroller, SDL_SensorType type)"
  extern "int SDL_GameControllerSetSensorEnabled(SDL_GameController *gamecontroller, SDL_SensorType type, SDL_bool enabled)"
  extern "SDL_bool SDL_GameControllerIsSensorEnabled(SDL_GameController *gamecontroller, SDL_SensorType type)"
  extern "float SDL_GameControllerGetSensorDataRate(SDL_GameController *gamecontroller, SDL_SensorType type)"
  extern "int SDL_GameControllerGetSensorData(SDL_GameController *gamecontroller, SDL_SensorType type, float *data, int num_values)"
  extern "int SDL_GameControllerGetSensorDataWithTimestamp(SDL_GameController *gamecontroller, SDL_SensorType type, Uint64 *timestamp, float *data, int num_values)"
  extern "int SDL_GameControllerRumble(SDL_GameController *gamecontroller, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms)"
  extern "int SDL_GameControllerRumbleTriggers(SDL_GameController *gamecontroller, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms)"
  extern "SDL_bool SDL_GameControllerHasLED(SDL_GameController *gamecontroller)"
  extern "SDL_bool SDL_GameControllerHasRumble(SDL_GameController *gamecontroller)"
  extern "SDL_bool SDL_GameControllerHasRumbleTriggers(SDL_GameController *gamecontroller)"
  extern "int SDL_GameControllerSetLED(SDL_GameController *gamecontroller, Uint8 red, Uint8 green, Uint8 blue)"
  extern "int SDL_GameControllerSendEffect(SDL_GameController *gamecontroller, const void *data, int size)"
  extern "void SDL_GameControllerClose(SDL_GameController *gamecontroller)"
  extern "const char* SDL_GameControllerGetAppleSFSymbolsNameForButton(SDL_GameController *gamecontroller, SDL_GameControllerButton button)"
  extern "const char* SDL_GameControllerGetAppleSFSymbolsNameForAxis(SDL_GameController *gamecontroller, SDL_GameControllerAxis axis)"
end
