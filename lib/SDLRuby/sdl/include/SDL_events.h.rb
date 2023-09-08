module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_error.h"
  require_relative "SDL_video.h"
  require_relative "SDL_keyboard.h"
  require_relative "SDL_mouse.h"
  require_relative "SDL_joystick.h"
  require_relative "SDL_gamecontroller.h"
  require_relative "SDL_gesture.h"
  require_relative "SDL_touch.h"

  SDL_RELEASED = 0
  SDL_PRESSED = 1

  SDL_FIRSTEVENT = 0
  SDL_QUIT = 0x100
  SDL_APP_TERMINATING = 0x101
  SDL_APP_LOWMEMORY = 0x102
  SDL_APP_WILLENTERBACKGROUND = 0x103
  SDL_APP_DIDENTERBACKGROUND = 0x104
  SDL_APP_WILLENTERFOREGROUND = 0x105
  SDL_APP_DIDENTERFOREGROUND = 0x106
  SDL_LOCALECHANGED = 0x107
  SDL_DISPLAYEVENT = 0x150
  SDL_WINDOWEVENT = 0x200
  SDL_SYSWMEVENT = 0x201
  SDL_KEYDOWN = 0x300
  SDL_KEYUP = 0x301
  SDL_TEXTEDITING = 0x302
  SDL_TEXTINPUT = 0x303
  SDL_KEYMAPCHANGED = 0x304
  SDL_TEXTEDITING_EXT = 0x305
  SDL_MOUSEMOTION = 0x400
  SDL_MOUSEBUTTONDOWN = 0x401
  SDL_MOUSEBUTTONUP = 0x402
  SDL_MOUSEWHEEL = 0x403
  SDL_JOYAXISMOTION = 0x600
  SDL_JOYBALLMOTION = 0x601
  SDL_JOYHATMOTION = 0x602
  SDL_JOYBUTTONDOWN = 0x603
  SDL_JOYBUTTONUP = 0x604
  SDL_JOYDEVICEADDED = 0x605
  SDL_JOYDEVICEREMOVED = 0x606
  SDL_JOYBATTERYUPDATED = 0x607
  SDL_CONTROLLERAXISMOTION = 0x650
  SDL_CONTROLLERBUTTONDOWN = 0x651
  SDL_CONTROLLERBUTTONUP = 0x652
  SDL_CONTROLLERDEVICEADDED = 0x653
  SDL_CONTROLLERDEVICEREMOVED = 0x654
  SDL_CONTROLLERDEVICEREMAPPED = 0x655
  SDL_CONTROLLERTOUCHPADDOWN = 0x656
  SDL_CONTROLLERTOUCHPADMOTION = 0x657
  SDL_CONTROLLERTOUCHPADUP = 0x658
  SDL_CONTROLLERSENSORUPDATE = 0x659
  SDL_FINGERDOWN = 0x700
  SDL_FINGERUP = 0x701
  SDL_FINGERMOTION = 0x702
  SDL_DOLLARGESTURE = 0x800
  SDL_DOLLARRECORD = 0x801
  SDL_MULTIGESTURE = 0x802
  SDL_CLIPBOARDUPDATE = 0x900
  SDL_DROPFILE = 0x1000
  SDL_DROPTEXT = 0x1001
  SDL_DROPBEGIN = 0x1002
  SDL_DROPCOMPLETE = 0x1003
  SDL_AUDIODEVICEADDED = 0x1100
  SDL_AUDIODEVICEREMOVED = 0x1101
  SDL_SENSORUPDATE = 0x1200
  SDL_RENDER_TARGETS_RESET = 0x2000
  SDL_RENDER_DEVICE_RESET = 0x2001
  SDL_POLLSENTINEL = 0x7F00
  SDL_USEREVENT = 0x8000
  SDL_LASTEVENT = 0xFFFF
  typealias "SDL_EventType", "int"

  SDL_CommonEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
    ]
  )
  SDL_DisplayEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 display",
      "Uint8 event",
      "Uint8 padding1",
      "Uint8 padding2",
      "Uint8 padding3",
      "Sint32 data1",
    ]
  )
  SDL_WindowEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "Uint8 event",
      "Uint8 padding1",
      "Uint8 padding2",
      "Uint8 padding3",
      "Sint32 data1",
      "Sint32 data2",
    ]
  )
  SDL_KeyboardEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "Uint8 state",
      "Uint8 repeat",
      "Uint8 padding2",
      "Uint8 padding3",
      { keysym: SDL_Keysym },
    ]
  )
  SDL_TEXTEDITINGEVENT_TEXT_SIZE = (32)
  SDL_TextEditingEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "char text[#{SDL_TEXTEDITINGEVENT_TEXT_SIZE}]",
      "Sint32 start",
      "Sint32 length",
    ]
  )
  SDL_TextEditingExtEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "char* text",
      "Sint32 start",
      "Sint32 length",
    ]
  )
  SDL_TEXTINPUTEVENT_TEXT_SIZE = (32)
  SDL_TextInputEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "char text[#{SDL_TEXTINPUTEVENT_TEXT_SIZE}]",
    ]
  )
  SDL_MouseMotionEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "Uint32 which",
      "Uint32 state",
      "Sint32 x",
      "Sint32 y",
      "Sint32 xrel",
      "Sint32 yrel",
    ]
  )
  SDL_MouseButtonEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "Uint32 which",
      "Uint8 button",
      "Uint8 state",
      "Uint8 clicks",
      "Uint8 padding1",
      "Sint32 x",
      "Sint32 y",
    ]
  )
  SDL_MouseWheelEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "Uint32 which",
      "Sint32 x",
      "Sint32 y",
      "Uint32 direction",
      "float preciseX",
      "float preciseY",
      "Sint32 mouseX",
      "Sint32 mouseY",
    ]
  )
  SDL_JoyAxisEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Uint8 axis",
      "Uint8 padding1",
      "Uint8 padding2",
      "Uint8 padding3",
      "Sint16 value",
      "Uint16 padding4",
    ]
  )
  SDL_JoyBallEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Uint8 ball",
      "Uint8 padding1",
      "Uint8 padding2",
      "Uint8 padding3",
      "Sint16 xrel",
      "Sint16 yrel",
    ]
  )
  SDL_JoyHatEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Uint8 hat",
      "Uint8 value",
      "Uint8 padding1",
      "Uint8 padding2",
    ]
  )
  SDL_JoyButtonEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Uint8 button",
      "Uint8 state",
      "Uint8 padding1",
      "Uint8 padding2",
    ]
  )
  SDL_JoyDeviceEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Sint32 which",
    ]
  )
  SDL_JoyBatteryEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "SDL_JoystickPowerLevel level",
    ]
  )
  SDL_ControllerAxisEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Uint8 axis",
      "Uint8 padding1",
      "Uint8 padding2",
      "Uint8 padding3",
      "Sint16 value",
      "Uint16 padding4",
    ]
  )
  SDL_ControllerButtonEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Uint8 button",
      "Uint8 state",
      "Uint8 padding1",
      "Uint8 padding2",
    ]
  )
  SDL_ControllerDeviceEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Sint32 which",
    ]
  )
  SDL_ControllerTouchpadEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Sint32 touchpad",
      "Sint32 finger",
      "float x",
      "float y",
      "float pressure",
    ]
  )
  SDL_ControllerSensorEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_JoystickID which",
      "Sint32 sensor",
      "float data[3]",
      "Uint64 timestamp_us",
    ]
  )
  SDL_AudioDeviceEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 which",
      "Uint8 iscapture",
      "Uint8 padding1",
      "Uint8 padding2",
      "Uint8 padding3",
    ]
  )
  SDL_TouchFingerEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_TouchID touchId",
      "SDL_FingerID fingerId",
      "float x",
      "float y",
      "float dx",
      "float dy",
      "float pressure",
      "Uint32 windowID",
    ]
  )
  SDL_MultiGestureEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_TouchID touchId",
      "float dTheta",
      "float dDist",
      "float x",
      "float y",
      "Uint16 numFingers",
      "Uint16 padding",
    ]
  )
  SDL_DollarGestureEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_TouchID touchId",
      "SDL_GestureID gestureId",
      "Uint32 numFingers",
      "float error",
      "float x",
      "float y",
    ]
  )
  SDL_DropEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "char *file",
      "Uint32 windowID",
    ]
  )
  SDL_SensorEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Sint32 which",
      "float data[6]",
      "Uint64 timestamp_us",
    ]
  )
  SDL_QuitEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
    ]
  )
  SDL_OSEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
    ]
  )
  SDL_UserEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "Uint32 windowID",
      "Sint32 code",
      "void *data1",
      "void *data2",
    ]
  )
  SDL_SysWMEvent = struct(
    [
      "Uint32 type",
      "Uint32 timestamp",
      "SDL_SysWMmsg *msg",
    ]
  )
  SDL_Event = union(
    [
      "Uint32 type",
      { common: SDL_CommonEvent },
      { display: SDL_DisplayEvent },
      { window: SDL_WindowEvent },
      { key: SDL_KeyboardEvent },
      { edit: SDL_TextEditingEvent },
      { editExt: SDL_TextEditingExtEvent },
      { text: SDL_TextInputEvent },
      { motion: SDL_MouseMotionEvent },
      { button: SDL_MouseButtonEvent },
      { wheel: SDL_MouseWheelEvent },
      { jaxis: SDL_JoyAxisEvent },
      { jball: SDL_JoyBallEvent },
      { jhat: SDL_JoyHatEvent },
      { jbutton: SDL_JoyButtonEvent },
      { jdevice: SDL_JoyDeviceEvent },
      { jbattery: SDL_JoyBatteryEvent },
      { caxis: SDL_ControllerAxisEvent },
      { cbutton: SDL_ControllerButtonEvent },
      { cdevice: SDL_ControllerDeviceEvent },
      { ctouchpad: SDL_ControllerTouchpadEvent },
      { csensor: SDL_ControllerSensorEvent },
      { adevice: SDL_AudioDeviceEvent },
      { sensor: SDL_SensorEvent },
      { quit: SDL_QuitEvent },
      { user: SDL_UserEvent },
      { syswm: SDL_SysWMEvent },
      { tfinger: SDL_TouchFingerEvent },
      { mgesture: SDL_MultiGestureEvent },
      { dgesture: SDL_DollarGestureEvent },
      { drop: SDL_DropEvent },
      "Uint8 padding[#{Fiddle::SIZEOF_VOIDP <= 8 ? 56 : Fiddle::SIZEOF_VOIDP == 16 ? 64 : 3 * Fiddle::SIZEOF_VOIDP}]",
    ]
  )

  extern "void SDL_PumpEvents(void)"

  SDL_ADDEVENT = 0
  SDL_PEEKEVENT = 1
  SDL_GETEVENT = 2
  typealias "SDL_eventaction", "int"

  extern "int SDL_PeepEvents(SDL_Event * events, int numevents, SDL_eventaction action, Uint32 minType, Uint32 maxType)"
  extern "SDL_bool SDL_HasEvent(Uint32 type)"
  extern "SDL_bool SDL_HasEvents(Uint32 minType, Uint32 maxType)"
  extern "void SDL_FlushEvent(Uint32 type)"
  extern "void SDL_FlushEvents(Uint32 minType, Uint32 maxType)"
  extern "int SDL_PollEvent(SDL_Event * event)"
  extern "int SDL_WaitEvent(SDL_Event * event)"
  extern "int SDL_WaitEventTimeout(SDL_Event * event, int timeout)"
  extern "int SDL_PushEvent(SDL_Event * event)"

  typealias "SDL_EventFilter", "void*"

  extern "void SDL_SetEventFilter(SDL_EventFilter filter, void *userdata)"
  extern "SDL_bool SDL_GetEventFilter(SDL_EventFilter * filter, void **userdata)"
  extern "void SDL_AddEventWatch(SDL_EventFilter filter, void *userdata)"
  extern "void SDL_DelEventWatch(SDL_EventFilter filter, void *userdata)"
  extern "void SDL_FilterEvents(SDL_EventFilter filter, void *userdata)"

  SDL_QUERY = -1
  SDL_IGNORE = 0
  SDL_DISABLE = 0
  SDL_ENABLE = 1

  extern "Uint8 SDL_EventState(Uint32 type, int state)"
  extern "Uint32 SDL_RegisterEvents(int numevents)"
end
