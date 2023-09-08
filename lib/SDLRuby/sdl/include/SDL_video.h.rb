module SDLRuby::SDL
  require_relative "SDL_stdinc.h"
  require_relative "SDL_pixels.h"
  require_relative "SDL_rect.h"
  require_relative "SDL_surface.h"

  SDL_DisplayMode = struct(
    [
      "Uint32 format",
      "int w",
      "int h",
      "int refresh_rate",
      "void *driverdata",
    ]
  )

  SDL_WINDOW_FULLSCREEN = 0x00000001
  SDL_WINDOW_OPENGL = 0x00000002
  SDL_WINDOW_SHOWN = 0x00000004
  SDL_WINDOW_HIDDEN = 0x00000008
  SDL_WINDOW_BORDERLESS = 0x00000010
  SDL_WINDOW_RESIZABLE = 0x00000020
  SDL_WINDOW_MINIMIZED = 0x00000040
  SDL_WINDOW_MAXIMIZED = 0x00000080
  SDL_WINDOW_MOUSE_GRABBED = 0x00000100
  SDL_WINDOW_INPUT_FOCUS = 0x00000200
  SDL_WINDOW_MOUSE_FOCUS = 0x00000400
  SDL_WINDOW_FULLSCREEN_DESKTOP = ( SDL_WINDOW_FULLSCREEN | 0x00001000 )
  SDL_WINDOW_FOREIGN = 0x00000800
  SDL_WINDOW_ALLOW_HIGHDPI = 0x00002000
  SDL_WINDOW_MOUSE_CAPTURE = 0x00004000
  SDL_WINDOW_ALWAYS_ON_TOP = 0x00008000
  SDL_WINDOW_SKIP_TASKBAR = 0x00010000
  SDL_WINDOW_UTILITY = 0x00020000
  SDL_WINDOW_TOOLTIP = 0x00040000
  SDL_WINDOW_POPUP_MENU = 0x00080000
  SDL_WINDOW_KEYBOARD_GRABBED = 0x00100000
  SDL_WINDOW_VULKAN = 0x10000000
  SDL_WINDOW_METAL = 0x20000000
  SDL_WINDOW_INPUT_GRABBED = SDL_WINDOW_MOUSE_GRABBED
  typealias "SDL_WindowFlags", "int"

  SDL_WINDOWPOS_UNDEFINED_MASK = 0x1FFF0000
  def self.SDL_WINDOWPOS_UNDEFINED_DISPLAY(x)
    (SDL_WINDOWPOS_UNDEFINED_MASK|(x))
  end
  SDL_WINDOWPOS_UNDEFINED = SDL_WINDOWPOS_UNDEFINED_DISPLAY(0)
  def self.SDL_WINDOWPOS_ISUNDEFINED(x)
    (((x)&0xFFFF0000) == SDL_WINDOWPOS_UNDEFINED_MASK)
  end

  SDL_WINDOWPOS_CENTERED_MASK = 0x2FFF0000
  def self.SDL_WINDOWPOS_CENTERED_DISPLAY(x)
    (SDL_WINDOWPOS_CENTERED_MASK|(x))
  end
  SDL_WINDOWPOS_CENTERED = self.SDL_WINDOWPOS_CENTERED_DISPLAY(0)
  def self.SDL_WINDOWPOS_ISCENTERED(x)
    (((x)&0xFFFF0000) == SDL_WINDOWPOS_CENTERED_MASK)
  end

  SDL_WINDOWEVENT_NONE = 0
  SDL_WINDOWEVENT_SHOWN = 1
  SDL_WINDOWEVENT_HIDDEN = 2
  SDL_WINDOWEVENT_EXPOSED = 3
  SDL_WINDOWEVENT_MOVED = 4
  SDL_WINDOWEVENT_RESIZED = 5
  SDL_WINDOWEVENT_SIZE_CHANGED = 6
  SDL_WINDOWEVENT_MINIMIZED = 7
  SDL_WINDOWEVENT_MAXIMIZED = 8
  SDL_WINDOWEVENT_RESTORED = 9
  SDL_WINDOWEVENT_ENTER = 10
  SDL_WINDOWEVENT_LEAVE = 11
  SDL_WINDOWEVENT_FOCUS_GAINED = 12
  SDL_WINDOWEVENT_FOCUS_LOST = 13
  SDL_WINDOWEVENT_CLOSE = 14
  SDL_WINDOWEVENT_TAKE_FOCUS = 15
  SDL_WINDOWEVENT_HIT_TEST = 16
  SDL_WINDOWEVENT_ICCPROF_CHANGED = 17
  SDL_WINDOWEVENT_DISPLAY_CHANGED = 18
  typealias "SDL_WindowEventID", "int"

  SDL_DISPLAYEVENT_NONE = 0
  SDL_DISPLAYEVENT_ORIENTATION = 1
  SDL_DISPLAYEVENT_CONNECTED = 2
  SDL_DISPLAYEVENT_DISCONNECTED = 3
  SDL_DISPLAYEVENT_MOVED = 4
  typealias "SDL_DisplayEventID", "int"

  SDL_ORIENTATION_UNKNOWN = 0
  SDL_ORIENTATION_LANDSCAPE = 1
  SDL_ORIENTATION_LANDSCAPE_FLIPPED = 2
  SDL_ORIENTATION_PORTRAIT = 3
  SDL_ORIENTATION_PORTRAIT_FLIPPED = 4
  typealias "SDL_DisplayOrientation", "int"

  SDL_FLASH_CANCEL = 0
  SDL_FLASH_BRIEFLY = 1
  SDL_FLASH_UNTIL_FOCUSED = 2
  typealias "SDL_FlashOperation", "int"

  typealias "SDL_GLContext", "void*"

  SDL_GL_RED_SIZE = 0
  SDL_GL_GREEN_SIZE = 1
  SDL_GL_BLUE_SIZE = 2
  SDL_GL_ALPHA_SIZE = 3
  SDL_GL_BUFFER_SIZE = 4
  SDL_GL_DOUBLEBUFFER = 5
  SDL_GL_DEPTH_SIZE = 6
  SDL_GL_STENCIL_SIZE = 7
  SDL_GL_ACCUM_RED_SIZE = 8
  SDL_GL_ACCUM_GREEN_SIZE = 9
  SDL_GL_ACCUM_BLUE_SIZE = 10
  SDL_GL_ACCUM_ALPHA_SIZE = 11
  SDL_GL_STEREO = 12
  SDL_GL_MULTISAMPLEBUFFERS = 13
  SDL_GL_MULTISAMPLESAMPLES = 14
  SDL_GL_ACCELERATED_VISUAL = 15
  SDL_GL_RETAINED_BACKING = 16
  SDL_GL_CONTEXT_MAJOR_VERSION = 17
  SDL_GL_CONTEXT_MINOR_VERSION = 18
  SDL_GL_CONTEXT_EGL = 19
  SDL_GL_CONTEXT_FLAGS = 20
  SDL_GL_CONTEXT_PROFILE_MASK = 21
  SDL_GL_SHARE_WITH_CURRENT_CONTEXT = 22
  SDL_GL_FRAMEBUFFER_SRGB_CAPABLE = 23
  SDL_GL_CONTEXT_RELEASE_BEHAVIOR = 24
  SDL_GL_CONTEXT_RESET_NOTIFICATION = 25
  SDL_GL_CONTEXT_NO_ERROR = 26
  SDL_GL_FLOATBUFFERS = 27
  typealias "SDL_GLattr", "int"

  SDL_GL_CONTEXT_PROFILE_CORE = 0x0001
  SDL_GL_CONTEXT_PROFILE_COMPATIBILITY = 0x0002
  SDL_GL_CONTEXT_PROFILE_ES = 0x0004
  typealias "SDL_GLprofile", "int"

  SDL_GL_CONTEXT_DEBUG_FLAG = 0x0001
  SDL_GL_CONTEXT_FORWARD_COMPATIBLE_FLAG = 0x0002
  SDL_GL_CONTEXT_ROBUST_ACCESS_FLAG = 0x0004
  SDL_GL_CONTEXT_RESET_ISOLATION_FLAG = 0x0008
  typealias "SDL_GLcontextFlag", "int"

  SDL_GL_CONTEXT_RELEASE_BEHAVIOR_NONE = 0x0000
  SDL_GL_CONTEXT_RELEASE_BEHAVIOR_FLUSH = 0x0001
  typealias "SDL_GLcontextReleaseFlag", "int"

  SDL_GL_CONTEXT_RESET_NO_NOTIFICATION = 0x0000
  SDL_GL_CONTEXT_RESET_LOSE_CONTEXT = 0x0001
  typealias "SDL_GLContextResetNotification", "int"

  extern "int SDL_GetNumVideoDrivers(void)"
  extern "const char * SDL_GetVideoDriver(int index)"
  extern "int SDL_VideoInit(const char *driver_name)"
  extern "void SDL_VideoQuit(void)"
  extern "const char * SDL_GetCurrentVideoDriver(void)"
  extern "int SDL_GetNumVideoDisplays(void)"
  extern "const char * SDL_GetDisplayName(int displayIndex)"
  extern "int SDL_GetDisplayBounds(int displayIndex, SDL_Rect * rect)"
  extern "int SDL_GetDisplayUsableBounds(int displayIndex, SDL_Rect * rect)"
  extern "int SDL_GetDisplayDPI(int displayIndex, float * ddpi, float * hdpi, float * vdpi)"
  extern "SDL_DisplayOrientation SDL_GetDisplayOrientation(int displayIndex)"
  extern "int SDL_GetNumDisplayModes(int displayIndex)"
  extern "int SDL_GetDisplayMode(int displayIndex, int modeIndex, SDL_DisplayMode * mode)"
  extern "int SDL_GetDesktopDisplayMode(int displayIndex, SDL_DisplayMode * mode)"
  extern "int SDL_GetCurrentDisplayMode(int displayIndex, SDL_DisplayMode * mode)"
  extern "SDL_DisplayMode * SDL_GetClosestDisplayMode(int displayIndex, const SDL_DisplayMode * mode, SDL_DisplayMode * closest)"
  extern "int SDL_GetPointDisplayIndex(const SDL_Point * point)"
  extern "int SDL_GetRectDisplayIndex(const SDL_Rect * rect)"
  extern "int SDL_GetWindowDisplayIndex(SDL_Window * window)"
  extern "int SDL_SetWindowDisplayMode(SDL_Window * window, const SDL_DisplayMode * mode)"
  extern "int SDL_GetWindowDisplayMode(SDL_Window * window, SDL_DisplayMode * mode)"
  extern "void* SDL_GetWindowICCProfile(SDL_Window * window, size_t* size)"
  extern "Uint32 SDL_GetWindowPixelFormat(SDL_Window * window)"
  extern "SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)"
  extern "SDL_Window * SDL_CreateWindowFrom(const void *data)"
  extern "Uint32 SDL_GetWindowID(SDL_Window * window)"
  extern "SDL_Window * SDL_GetWindowFromID(Uint32 id)"
  extern "Uint32 SDL_GetWindowFlags(SDL_Window * window)"
  extern "void SDL_SetWindowTitle(SDL_Window * window, const char *title)"
  extern "const char * SDL_GetWindowTitle(SDL_Window * window)"
  extern "void SDL_SetWindowIcon(SDL_Window * window, SDL_Surface * icon)"
  extern "void* SDL_SetWindowData(SDL_Window * window, const char *name, void *userdata)"
  extern "void * SDL_GetWindowData(SDL_Window * window, const char *name)"
  extern "void SDL_SetWindowPosition(SDL_Window * window, int x, int y)"
  extern "void SDL_GetWindowPosition(SDL_Window * window, int *x, int *y)"
  extern "void SDL_SetWindowSize(SDL_Window * window, int w, int h)"
  extern "void SDL_GetWindowSize(SDL_Window * window, int *w, int *h)"
  extern "int SDL_GetWindowBordersSize(SDL_Window * window, int *top, int *left, int *bottom, int *right)"
  extern "void SDL_GetWindowSizeInPixels(SDL_Window * window, int *w, int *h)"
  extern "void SDL_SetWindowMinimumSize(SDL_Window * window, int min_w, int min_h)"
  extern "void SDL_GetWindowMinimumSize(SDL_Window * window, int *w, int *h)"
  extern "void SDL_SetWindowMaximumSize(SDL_Window * window, int max_w, int max_h)"
  extern "void SDL_GetWindowMaximumSize(SDL_Window * window, int *w, int *h)"
  extern "void SDL_SetWindowBordered(SDL_Window * window, SDL_bool bordered)"
  extern "void SDL_SetWindowResizable(SDL_Window * window, SDL_bool resizable)"
  extern "void SDL_SetWindowAlwaysOnTop(SDL_Window * window, SDL_bool on_top)"
  extern "void SDL_ShowWindow(SDL_Window * window)"
  extern "void SDL_HideWindow(SDL_Window * window)"
  extern "void SDL_RaiseWindow(SDL_Window * window)"
  extern "void SDL_MaximizeWindow(SDL_Window * window)"
  extern "void SDL_MinimizeWindow(SDL_Window * window)"
  extern "void SDL_RestoreWindow(SDL_Window * window)"
  extern "int SDL_SetWindowFullscreen(SDL_Window * window, Uint32 flags)"
  extern "SDL_bool SDL_HasWindowSurface(SDL_Window *window)"
  extern "SDL_Surface * SDL_GetWindowSurface(SDL_Window * window)"
  extern "int SDL_UpdateWindowSurface(SDL_Window * window)"
  extern "int SDL_UpdateWindowSurfaceRects(SDL_Window * window, const SDL_Rect * rects, int numrects)"
  extern "int SDL_DestroyWindowSurface(SDL_Window *window)"
  extern "void SDL_SetWindowGrab(SDL_Window * window, SDL_bool grabbed)"
  extern "void SDL_SetWindowKeyboardGrab(SDL_Window * window, SDL_bool grabbed)"
  extern "void SDL_SetWindowMouseGrab(SDL_Window * window, SDL_bool grabbed)"
  extern "SDL_bool SDL_GetWindowGrab(SDL_Window * window)"
  extern "SDL_bool SDL_GetWindowKeyboardGrab(SDL_Window * window)"
  extern "SDL_bool SDL_GetWindowMouseGrab(SDL_Window * window)"
  extern "SDL_Window * SDL_GetGrabbedWindow(void)"
  extern "int SDL_SetWindowMouseRect(SDL_Window * window, const SDL_Rect * rect)"
  extern "const SDL_Rect * SDL_GetWindowMouseRect(SDL_Window * window)"
  extern "int SDL_SetWindowBrightness(SDL_Window * window, float brightness)"
  extern "float SDL_GetWindowBrightness(SDL_Window * window)"
  extern "int SDL_SetWindowOpacity(SDL_Window * window, float opacity)"
  extern "int SDL_GetWindowOpacity(SDL_Window * window, float * out_opacity)"
  extern "int SDL_SetWindowModalFor(SDL_Window * modal_window, SDL_Window * parent_window)"
  extern "int SDL_SetWindowInputFocus(SDL_Window * window)"
  extern "int SDL_SetWindowGammaRamp(SDL_Window * window, const Uint16 * red, const Uint16 * green, const Uint16 * blue)"
  extern "int SDL_GetWindowGammaRamp(SDL_Window * window, Uint16 * red, Uint16 * green, Uint16 * blue)"

  SDL_HITTEST_NORMAL = 0
  SDL_HITTEST_DRAGGABLE = 1
  SDL_HITTEST_RESIZE_TOPLEFT = 2
  SDL_HITTEST_RESIZE_TOP = 3
  SDL_HITTEST_RESIZE_TOPRIGHT = 4
  SDL_HITTEST_RESIZE_RIGHT = 5
  SDL_HITTEST_RESIZE_BOTTOMRIGHT = 6
  SDL_HITTEST_RESIZE_BOTTOM = 7
  SDL_HITTEST_RESIZE_BOTTOMLEFT = 8
  SDL_HITTEST_RESIZE_LEFT = 9
  typealias "SDL_HitTestResult", "int"

  typealias "SDL_HitTest", "void*"

  extern "int SDL_SetWindowHitTest(SDL_Window * window, SDL_HitTest callback, void *callback_data)"
  extern "int SDL_FlashWindow(SDL_Window * window, SDL_FlashOperation operation)"
  extern "void SDL_DestroyWindow(SDL_Window * window)"
  extern "SDL_bool SDL_IsScreenSaverEnabled(void)"
  extern "void SDL_EnableScreenSaver(void)"
  extern "void SDL_DisableScreenSaver(void)"
  extern "int SDL_GL_LoadLibrary(const char *path)"
  extern "void * SDL_GL_GetProcAddress(const char *proc)"
  extern "void SDL_GL_UnloadLibrary(void)"
  extern "SDL_bool SDL_GL_ExtensionSupported(const char *extension)"
  extern "void SDL_GL_ResetAttributes(void)"
  extern "int SDL_GL_SetAttribute(SDL_GLattr attr, int value)"
  extern "int SDL_GL_GetAttribute(SDL_GLattr attr, int *value)"
  extern "SDL_GLContext SDL_GL_CreateContext(SDL_Window * window)"
  extern "int SDL_GL_MakeCurrent(SDL_Window * window, SDL_GLContext context)"
  extern "SDL_Window* SDL_GL_GetCurrentWindow(void)"
  extern "SDL_GLContext SDL_GL_GetCurrentContext(void)"
  extern "void SDL_GL_GetDrawableSize(SDL_Window * window, int *w, int *h)"
  extern "int SDL_GL_SetSwapInterval(int interval)"
  extern "int SDL_GL_GetSwapInterval(void)"
  extern "void SDL_GL_SwapWindow(SDL_Window * window)"
  extern "void SDL_GL_DeleteContext(SDL_GLContext context)"
end
