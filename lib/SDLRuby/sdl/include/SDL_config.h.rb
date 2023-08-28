module SDLRuby::SDL
  require_relative 'SDL_platform.h.rb'
  typealias "int8_t", "signed __int8"
  typealias "uint8_t", "unsigned __int8"
  typealias "int16_t", "signed __int16"
  typealias "uint16_t", "unsigned __int16"
  typealias "int32_t", "signed __int32"
  typealias "uint32_t", "unsigned __int32"
  typealias "int64_t", "signed __int64"
  typealias "uint64_t", "unsigned __int64"
  typealias "uintptr_t", "unsigned __int64"
  typealias "uintptr_t", "unsigned int"
end
