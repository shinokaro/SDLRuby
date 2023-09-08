module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"
  require_relative "SDL_guid.h"

  # typealias "SDL_JoystickGUID", "SDL_GUID"
  typealias "SDL_JoystickID", "Sint32"

  SDL_JOYSTICK_TYPE_UNKNOWN = 0
  SDL_JOYSTICK_TYPE_GAMECONTROLLER = 1
  SDL_JOYSTICK_TYPE_WHEEL = 2
  SDL_JOYSTICK_TYPE_ARCADE_STICK = 3
  SDL_JOYSTICK_TYPE_FLIGHT_STICK = 4
  SDL_JOYSTICK_TYPE_DANCE_PAD = 5
  SDL_JOYSTICK_TYPE_GUITAR = 6
  SDL_JOYSTICK_TYPE_DRUM_KIT = 7
  SDL_JOYSTICK_TYPE_ARCADE_PAD = 8
  SDL_JOYSTICK_TYPE_THROTTLE = 9
  typealias "SDL_JoystickType", "int"

  SDL_JOYSTICK_POWER_UNKNOWN = -1
  SDL_JOYSTICK_POWER_EMPTY = 0
  SDL_JOYSTICK_POWER_LOW = 1
  SDL_JOYSTICK_POWER_MEDIUM = 2
  SDL_JOYSTICK_POWER_FULL = 3
  SDL_JOYSTICK_POWER_WIRED = 4
  SDL_JOYSTICK_POWER_MAX = 5
  typealias "SDL_JoystickPowerLevel", "int"

  SDL_IPHONE_MAX_GFORCE = 5.0

  extern "void SDL_LockJoysticks(void)"
  extern "void SDL_UnlockJoysticks(void)"
  extern "int SDL_NumJoysticks(void)"
  extern "const char * SDL_JoystickNameForIndex(int device_index)"
  extern "const char * SDL_JoystickPathForIndex(int device_index)"
  extern "int SDL_JoystickGetDevicePlayerIndex(int device_index)"
  # extern "SDL_JoystickGUID SDL_JoystickGetDeviceGUID(int device_index)"
  extern "Uint16 SDL_JoystickGetDeviceVendor(int device_index)"
  extern "Uint16 SDL_JoystickGetDeviceProduct(int device_index)"
  extern "Uint16 SDL_JoystickGetDeviceProductVersion(int device_index)"
  extern "SDL_JoystickType SDL_JoystickGetDeviceType(int device_index)"
  extern "SDL_JoystickID SDL_JoystickGetDeviceInstanceID(int device_index)"
  extern "SDL_Joystick * SDL_JoystickOpen(int device_index)"
  extern "SDL_Joystick * SDL_JoystickFromInstanceID(SDL_JoystickID instance_id)"
  extern "SDL_Joystick * SDL_JoystickFromPlayerIndex(int player_index)"
  extern "int SDL_JoystickAttachVirtual(SDL_JoystickType type, int naxes, int nbuttons, int nhats)"

  SDL_VirtualJoystickDesc = struct(
    [
      "Uint16 version",
      "Uint16 type",
      "Uint16 naxes",
      "Uint16 nbuttons",
      "Uint16 nhats",
      "Uint16 vendor_id",
      "Uint16 product_id",
      "Uint16 padding",
      "Uint32 button_mask",
      "Uint32 axis_mask",
      "const char *name",
      "void *userdata",
      "void *Update",
      "void *SetPlayerIndex",
      "void *Rumble",
      "void *RumbleTriggers",
      "void *SetLED",
      "void *SendEffect",
    ]
  )

  SDL_VIRTUAL_JOYSTICK_DESC_VERSION = 1

  extern "int SDL_JoystickAttachVirtualEx(const SDL_VirtualJoystickDesc *desc)"
  extern "int SDL_JoystickDetachVirtual(int device_index)"
  extern "SDL_bool SDL_JoystickIsVirtual(int device_index)"
  extern "int SDL_JoystickSetVirtualAxis(SDL_Joystick *joystick, int axis, Sint16 value)"
  extern "int SDL_JoystickSetVirtualButton(SDL_Joystick *joystick, int button, Uint8 value)"
  extern "int SDL_JoystickSetVirtualHat(SDL_Joystick *joystick, int hat, Uint8 value)"
  extern "const char * SDL_JoystickName(SDL_Joystick *joystick)"
  extern "const char * SDL_JoystickPath(SDL_Joystick *joystick)"
  extern "int SDL_JoystickGetPlayerIndex(SDL_Joystick *joystick)"
  extern "void SDL_JoystickSetPlayerIndex(SDL_Joystick *joystick, int player_index)"
  # extern "SDL_JoystickGUID SDL_JoystickGetGUID(SDL_Joystick *joystick)"
  extern "Uint16 SDL_JoystickGetVendor(SDL_Joystick *joystick)"
  extern "Uint16 SDL_JoystickGetProduct(SDL_Joystick *joystick)"
  extern "Uint16 SDL_JoystickGetProductVersion(SDL_Joystick *joystick)"
  extern "Uint16 SDL_JoystickGetFirmwareVersion(SDL_Joystick *joystick)"
  extern "const char * SDL_JoystickGetSerial(SDL_Joystick *joystick)"
  extern "SDL_JoystickType SDL_JoystickGetType(SDL_Joystick *joystick)"
  # extern "void SDL_JoystickGetGUIDString(SDL_JoystickGUID guid, char *pszGUID, int cbGUID)"
  # extern "SDL_JoystickGUID SDL_JoystickGetGUIDFromString(const char *pchGUID)"
  # extern "void SDL_GetJoystickGUIDInfo(SDL_JoystickGUID guid, Uint16 *vendor, Uint16 *product, Uint16 *version, Uint16 *crc16)"
  extern "SDL_bool SDL_JoystickGetAttached(SDL_Joystick *joystick)"
  extern "SDL_JoystickID SDL_JoystickInstanceID(SDL_Joystick *joystick)"
  extern "int SDL_JoystickNumAxes(SDL_Joystick *joystick)"
  extern "int SDL_JoystickNumBalls(SDL_Joystick *joystick)"
  extern "int SDL_JoystickNumHats(SDL_Joystick *joystick)"
  extern "int SDL_JoystickNumButtons(SDL_Joystick *joystick)"
  extern "void SDL_JoystickUpdate(void)"
  extern "int SDL_JoystickEventState(int state)"

  SDL_JOYSTICK_AXIS_MAX = 32767
  SDL_JOYSTICK_AXIS_MIN = -32768

  extern "Sint16 SDL_JoystickGetAxis(SDL_Joystick *joystick, int axis)"
  extern "SDL_bool SDL_JoystickGetAxisInitialState(SDL_Joystick *joystick, int axis, Sint16 *state)"

  SDL_HAT_CENTERED = 0x00
  SDL_HAT_UP = 0x01
  SDL_HAT_RIGHT = 0x02
  SDL_HAT_DOWN = 0x04
  SDL_HAT_LEFT = 0x08
  SDL_HAT_RIGHTUP = (SDL_HAT_RIGHT|SDL_HAT_UP)
  SDL_HAT_RIGHTDOWN = (SDL_HAT_RIGHT|SDL_HAT_DOWN)
  SDL_HAT_LEFTUP = (SDL_HAT_LEFT|SDL_HAT_UP)
  SDL_HAT_LEFTDOWN = (SDL_HAT_LEFT|SDL_HAT_DOWN)

  extern "Uint8 SDL_JoystickGetHat(SDL_Joystick *joystick, int hat)"
  extern "int SDL_JoystickGetBall(SDL_Joystick *joystick, int ball, int *dx, int *dy)"
  extern "Uint8 SDL_JoystickGetButton(SDL_Joystick *joystick, int button)"
  extern "int SDL_JoystickRumble(SDL_Joystick *joystick, Uint16 low_frequency_rumble, Uint16 high_frequency_rumble, Uint32 duration_ms)"
  extern "int SDL_JoystickRumbleTriggers(SDL_Joystick *joystick, Uint16 left_rumble, Uint16 right_rumble, Uint32 duration_ms)"
  extern "SDL_bool SDL_JoystickHasLED(SDL_Joystick *joystick)"
  extern "SDL_bool SDL_JoystickHasRumble(SDL_Joystick *joystick)"
  extern "SDL_bool SDL_JoystickHasRumbleTriggers(SDL_Joystick *joystick)"
  extern "int SDL_JoystickSetLED(SDL_Joystick *joystick, Uint8 red, Uint8 green, Uint8 blue)"
  extern "int SDL_JoystickSendEffect(SDL_Joystick *joystick, const void *data, int size)"
  extern "void SDL_JoystickClose(SDL_Joystick *joystick)"
  extern "SDL_JoystickPowerLevel SDL_JoystickCurrentPowerLevel(SDL_Joystick *joystick)"
end
