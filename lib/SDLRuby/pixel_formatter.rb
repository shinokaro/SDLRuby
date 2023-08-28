module SDLRuby
  module PixelFormatter
    include SDL

    INDEXED_PIXELFORMATS = [
      SDL_PIXELFORMAT_INDEX1LSB, SDL_PIXELFORMAT_INDEX1MSB,
      SDL_PIXELFORMAT_INDEX4LSB, SDL_PIXELFORMAT_INDEX4MSB,
      SDL_PIXELFORMAT_INDEX8
    ].freeze

    ALPHA_PIXELFORMATS = [
      SDL_PIXELFORMAT_ARGB4444, SDL_PIXELFORMAT_RGBA4444,
      SDL_PIXELFORMAT_ABGR4444, SDL_PIXELFORMAT_BGRA4444,
      SDL_PIXELFORMAT_ARGB1555, SDL_PIXELFORMAT_RGBA5551,
      SDL_PIXELFORMAT_ABGR1555, SDL_PIXELFORMAT_BGRA5551,
      SDL_PIXELFORMAT_ARGB8888, SDL_PIXELFORMAT_RGBA8888,
      SDL_PIXELFORMAT_ABGR8888, SDL_PIXELFORMAT_BGRA8888,
      SDL_PIXELFORMAT_ARGB2101010
    ].freeze

    class << self
      def alpha?(x) = ALPHA_PIXELFORMATS.include?(x)

      def bits_per_pixel(x) = fourcc?(x) ? nil : x >> 8 & 0xFF

      def bytes_per_pixel(x)
        if fourcc?(x)
          x == SDL_PIXELFORMAT_YUY2 ||
            x == SDL_PIXELFORMAT_UYVY ||
            x == SDL_PIXELFORMAT_YVYU ? 2 : 1
        else
          x >> 0 & 0xFF
        end
      end

      def format_name(x) = SDL.SDL_GetPixelFormatName(x).to_s

      def fourcc?(x)
        if x != 0 && x >> 28 & 0x0F != 1
          [x].pack("L")
        end
      end

      def indexed_color?(x) = INDEXED_PIXELFORMATS.include?(x)

      def rgb_color?(x) = !(fourcc?(x) || indexed_color?(x) || alpha?(x))
    end

    def alpha? = PixelFormatter.alpha?(format)

    def bits_per_pixel = PixelFormatter.bits_per_pixel(format)

    alias depth bits_per_pixel

    def bytes_per_pixel = PixelFormatter.bytes_per_pixel(format)

    def format_name = PixelFormatter.format_name(format)

    alias pixel_format_name format_name

    def fourcc? = PixelFormatter.fourcc?(format)

    def indexed_color? = PixelFormatter.indexed_color?(format)

    def rgb_color? = PixelFormatter.rgb_color?(format)
  end
end
