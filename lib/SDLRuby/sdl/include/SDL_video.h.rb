module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_pixels.h.rb'
  require_relative 'SDL_rect.h.rb'
  require_relative 'SDL_surface.h.rb'

  typealias "SDL_Window", "struct SDL_Window"
  typealias "SDL_GLContext", "void*"
  typealias "SDL_WindowFlags", "int"
  typealias "SDL_WindowEventID", "int"
  typealias "SDL_DisplayEventID", "int"
  typealias "SDL_DisplayOrientation", "int"
  typealias "SDL_FlashOperation", "int"
  typealias "SDL_GLattr", "int"
  typealias "SDL_GLprofile", "int"
  typealias "SDL_GLcontextFlag", "int"
  typealias "SDL_GLcontextReleaseFlag", "int"
  typealias "SDL_GLContextResetNotification", "int"
  typealias "SDL_HitTestResult", "int"
  extern "int SDL_GetNumVideoDrivers(void)"
  extern "const char * SDL_GetVideoDriver(int index)"
  extern "int SDL_VideoInit(const char *driver_name)"
  extern "void SDL_VideoQuit(void)"
  extern "const char * SDL_GetCurrentVideoDriver(void)"
  extern "int SDL_GetNumVideoDisplays(void)"
  extern "const char * SDL_GetDisplayName(int displayIndex)"
  extern "int SDL_GetDisplayBounds(int displayIndex, SDL_Rect *rect)"
  extern "int SDL_GetDisplayUsableBounds(int displayIndex, SDL_Rect *rect)"
  extern "int SDL_GetDisplayDPI(int displayIndex, float *ddpi, float *hdpi, float *vdpi)"
  extern "SDL_DisplayOrientation SDL_GetDisplayOrientation(int displayIndex)"
  extern "int SDL_GetNumDisplayModes(int displayIndex)"
  extern "int SDL_GetDisplayMode(int displayIndex, int modeIndex, SDL_DisplayMode *mode)"
  extern "int SDL_GetDesktopDisplayMode(int displayIndex, SDL_DisplayMode *mode)"
  extern "int SDL_GetCurrentDisplayMode(int displayIndex, SDL_DisplayMode *mode)"
  extern "SDL_DisplayMode * SDL_GetClosestDisplayMode(int displayIndex, const SDL_DisplayMode *mode, SDL_DisplayMode *closest)"
  extern "int SDL_GetPointDisplayIndex(const SDL_Point *point)"
  extern "int SDL_GetRectDisplayIndex(const SDL_Rect *rect)"
  extern "int SDL_GetWindowDisplayIndex(SDL_Window *window)"
  extern "int SDL_SetWindowDisplayMode(SDL_Window *window, const SDL_DisplayMode *mode)"
  extern "int SDL_GetWindowDisplayMode(SDL_Window *window, SDL_DisplayMode *mode)"
  extern "void* SDL_GetWindowICCProfile(SDL_Window *window, size_t*size)"
  extern "Uint32 SDL_GetWindowPixelFormat(SDL_Window *window)"
  extern "SDL_Window * SDL_CreateWindow(const char *title, int x, int y, int w, int h, Uint32 flags)"
  extern "SDL_Window * SDL_CreateWindowFrom(const void *data)"
  extern "Uint32 SDL_GetWindowID(SDL_Window *window)"
  extern "SDL_Window * SDL_GetWindowFromID(Uint32 id)"
  extern "Uint32 SDL_GetWindowFlags(SDL_Window *window)"
  extern "void SDL_SetWindowTitle(SDL_Window *window, const char *title)"
  extern "const char * SDL_GetWindowTitle(SDL_Window *window)"
  extern "void SDL_SetWindowIcon(SDL_Window *window, SDL_Surface *icon)"
  extern "void* SDL_SetWindowData(SDL_Window *window, const char *name, void *userdata)"
  extern "void * SDL_GetWindowData(SDL_Window *window, const char *name)"
  extern "void SDL_SetWindowPosition(SDL_Window *window, int x, int y)"
  extern "void SDL_GetWindowPosition(SDL_Window *window, int *x, int *y)"
  extern "void SDL_SetWindowSize(SDL_Window *window, int w, int h)"
  extern "void SDL_GetWindowSize(SDL_Window *window, int *w, int *h)"
  extern "int SDL_GetWindowBordersSize(SDL_Window *window, int *top, int *left, int *bottom, int *right)"
  extern "void SDL_GetWindowSizeInPixels(SDL_Window *window, int *w, int *h)"
  extern "void SDL_SetWindowMinimumSize(SDL_Window *window, int min_w, int min_h)"
  extern "void SDL_GetWindowMinimumSize(SDL_Window *window, int *w, int *h)"
  extern "void SDL_SetWindowMaximumSize(SDL_Window *window, int max_w, int max_h)"
  extern "void SDL_GetWindowMaximumSize(SDL_Window *window, int *w, int *h)"
  extern "void SDL_SetWindowBordered(SDL_Window *window, SDL_bool bordered)"
  extern "void SDL_SetWindowResizable(SDL_Window *window, SDL_bool resizable)"
  extern "void SDL_SetWindowAlwaysOnTop(SDL_Window *window, SDL_bool on_top)"
  extern "void SDL_ShowWindow(SDL_Window *window)"
  extern "void SDL_HideWindow(SDL_Window *window)"
  extern "void SDL_RaiseWindow(SDL_Window *window)"
  extern "void SDL_MaximizeWindow(SDL_Window *window)"
  extern "void SDL_MinimizeWindow(SDL_Window *window)"
  extern "void SDL_RestoreWindow(SDL_Window *window)"
  extern "int SDL_SetWindowFullscreen(SDL_Window *window, Uint32 flags)"
  extern "SDL_bool SDL_HasWindowSurface(SDL_Window *window)"
  extern "SDL_Surface * SDL_GetWindowSurface(SDL_Window *window)"
  extern "int SDL_UpdateWindowSurface(SDL_Window *window)"
  extern "int SDL_UpdateWindowSurfaceRects(SDL_Window *window, const SDL_Rect *rects, int numrects)"
  extern "int SDL_DestroyWindowSurface(SDL_Window *window)"
  extern "void SDL_SetWindowGrab(SDL_Window *window, SDL_bool grabbed)"
  extern "void SDL_SetWindowKeyboardGrab(SDL_Window *window, SDL_bool grabbed)"
  extern "void SDL_SetWindowMouseGrab(SDL_Window *window, SDL_bool grabbed)"
  extern "SDL_bool SDL_GetWindowGrab(SDL_Window *window)"
  extern "SDL_bool SDL_GetWindowKeyboardGrab(SDL_Window *window)"
  extern "SDL_bool SDL_GetWindowMouseGrab(SDL_Window *window)"
  extern "SDL_Window * SDL_GetGrabbedWindow(void)"
  extern "int SDL_SetWindowMouseRect(SDL_Window *window, const SDL_Rect *rect)"
  extern "const SDL_Rect * SDL_GetWindowMouseRect(SDL_Window *window)"
  extern "int SDL_SetWindowBrightness(SDL_Window *window, float brightness)"
  extern "float SDL_GetWindowBrightness(SDL_Window *window)"
  extern "int SDL_SetWindowOpacity(SDL_Window *window, float opacity)"
  extern "int SDL_GetWindowOpacity(SDL_Window *window, float *out_opacity)"
  extern "int SDL_SetWindowModalFor(SDL_Window *modal_window, SDL_Window *parent_window)"
  extern "int SDL_SetWindowInputFocus(SDL_Window *window)"
  extern "int SDL_SetWindowGammaRamp(SDL_Window *window, const Uint16 *red, const Uint16 *green, const Uint16 *blue)"
  extern "int SDL_GetWindowGammaRamp(SDL_Window *window, Uint16 *red, Uint16 *green, Uint16 *blue)"
  extern "int SDL_SetWindowHitTest(SDL_Window *window, SDL_HitTest callback, void *callback_data)"
  extern "int SDL_FlashWindow(SDL_Window *window, SDL_FlashOperation operation)"
  extern "void SDL_DestroyWindow(SDL_Window *window)"
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
  extern "SDL_GLContext SDL_GL_CreateContext(SDL_Window *window)"
  extern "int SDL_GL_MakeCurrent(SDL_Window *window, SDL_GLContext context)"
  extern "SDL_Window* SDL_GL_GetCurrentWindow(void)"
  extern "SDL_GLContext SDL_GL_GetCurrentContext(void)"
  extern "void SDL_GL_GetDrawableSize(SDL_Window *window, int *w, int *h)"
  extern "int SDL_GL_SetSwapInterval(int interval)"
  extern "int SDL_GL_GetSwapInterval(void)"
  extern "void SDL_GL_SwapWindow(SDL_Window *window)"
  extern "void SDL_GL_DeleteContext(SDL_GLContext context)"
end
