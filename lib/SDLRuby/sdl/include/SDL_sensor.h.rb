module SDLRuby::SDL
  require_relative 'SDL_stdinc.h.rb'
  require_relative 'SDL_error.h.rb'

  typealias "SDL_Sensor", "struct _SDL_Sensor"
  typealias "SDL_SensorID", "Sint32"
  typealias "SDL_SensorType", "int"
  extern "void SDL_LockSensors(void)"
  extern "void SDL_UnlockSensors(void)"
  extern "int SDL_NumSensors(void)"
  extern "const char * SDL_SensorGetDeviceName(int device_index)"
  extern "SDL_SensorType SDL_SensorGetDeviceType(int device_index)"
  extern "int SDL_SensorGetDeviceNonPortableType(int device_index)"
  extern "SDL_SensorID SDL_SensorGetDeviceInstanceID(int device_index)"
  extern "SDL_Sensor * SDL_SensorOpen(int device_index)"
  extern "SDL_Sensor * SDL_SensorFromInstanceID(SDL_SensorID instance_id)"
  extern "const char * SDL_SensorGetName(SDL_Sensor *sensor)"
  extern "SDL_SensorType SDL_SensorGetType(SDL_Sensor *sensor)"
  extern "int SDL_SensorGetNonPortableType(SDL_Sensor *sensor)"
  extern "SDL_SensorID SDL_SensorGetInstanceID(SDL_Sensor *sensor)"
  extern "int SDL_SensorGetData(SDL_Sensor *sensor, float *data, int num_values)"
  extern "int SDL_SensorGetDataWithTimestamp(SDL_Sensor *sensor, Uint64 *timestamp, float *data, int num_values)"
  extern "void SDL_SensorClose(SDL_Sensor *sensor)"
  extern "void SDL_SensorUpdate(void)"
end
