module SDLRuby::SDL
  typealias "SDL_BlendMode", "int"
  typealias "SDL_BlendOperation", "int"
  typealias "SDL_BlendFactor", "int"
  extern "SDL_BlendMode SDL_ComposeCustomBlendMode(SDL_BlendFactor srcColorFactor, SDL_BlendFactor dstColorFactor, SDL_BlendOperation colorOperation, SDL_BlendFactor srcAlphaFactor, SDL_BlendFactor dstAlphaFactor, SDL_BlendOperation alphaOperation)"
end
