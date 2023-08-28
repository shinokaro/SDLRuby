require 'fiddle/import'

module SDLRuby
  # Supported formats
  # AVIF, BMP, CUR, GIF, ICO, JPG, JXL, LBM, PCX, PNG, PNM, QOI, SVG, TGA,
  # TIF, WEBP, XCF, XPM, XV
  module Image
    extend Fiddle::Importer

    dlload "SDL2_image"

    require_relative 'image/include/SDL_image.h'
    require_relative 'image/image'

    class << self
      def init(flags = nil)
        num = flags || 0 |
          IMG_INIT_JPG  | IMG_INIT_PNG | IMG_INIT_TIF |
          IMG_INIT_WEBP | IMG_INIT_JXL | IMG_INIT_AVIF

        err = Image.IMG_Init(num)
        raise SDLError if err == 0
      end

      def load(file, type: nil)
        if String === file
          rw = SDL.SDL_RWFromFile(file, "rb")
          free = 1
        elsif file.respond_to?(:to_path)
          rw = SDL.SDL_RWFromFile(file.to_path, "rb")
          free = 1
        else
          rw = RWOps[file]
          free = 0
        end

        ptr = Image.IMG_LoadTyped_RW(rw, free, type)
        raise SDLError if ptr.null?

        Surface.new(ptr)
      end

      def save(file, surface, type: nil, quality: 85)
        if String === file
          rw = SDL.SDL_RWFromFile(file, "wb")
          free = 1
        elsif file.respond_to?(:to_path)
          rw = SDL.SDL_RWFromFile(file.to_path, "wb")
          free = 1
        else
          rw = RWOps[file]
          free = 0
        end

        err = if type == "PNG"
                Image.IMG_SavePNG_RW(surface, rw, free)
              else
                Image.IMG_SaveJPG_RW(surface, rw, free, quality)
              end

        raise SDLError if err != 0
      end

      def quit = Image.IMG_Quit

      def version = SDL::SDL_version.new(Image.IMG_Linked_Version).to_a.join(".")
    end
  end
end
