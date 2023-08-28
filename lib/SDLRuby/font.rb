require_relative 'ttf'

module SDLRuby
  class Font
    include TTF

    class << self
      def open(file, pt, face: nil, dpi: nil)
        TTF.init

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

        index = face ? face : 0
        hdpi, vdpi = *(dpi ? dpi : [0, 0])

        ptr = TTF.TTF_OpenFontIndexDPIRW(rw, free, pt, index, hdpi, vdpi)
        raise SDLError if ptr.null?

        new(ptr)
      end
    end

    def initialize(ptr)
      ptr.free = TTF_CLOSE_FONT
      @ptr = ptr
    end

    def align
      case TTF.TTF_GetFontWrappedAlign(self)
      when TTF_WRAPPED_ALIGN_LEFT   then "left"
      when TTF_WRAPPED_ALIGN_CENTER then "center"
      when TTF_WRAPPED_ALIGN_RIGHT  then "right"
      else
        nil
      end
    end

    def align=(s)
      case s
      when "left"   then TTF_WRAPPED_ALIGN_LEFT
      when "center" then TTF_WRAPPED_ALIGN_CENTER
      when "right"  then TTF_WRAPPED_ALIGN_RIGHT
      else
        raise ArgumentError
      end => align

      TTF.TTF_SetFontWrappedAlign(self, align)
    end

    def ascent = TTF.TTF_FontAscent(self)

    def descent = TTF.TTF_FontDescent(self)

    def direction=(s)
      case s
      when "left"   then TTF_DIRECTION_LTR
      when "right"  then TTF_DIRECTION_RTL
      when "top"    then TTF_DIRECTION_TTB
      when "bottom" then TTF_DIRECTION_BTT
      else
        raise ArgumentError
      end => direction

      err = TTF.TTF_SetFontDirection(self, direction)
      raise SDLError if err < 0
    end

    def draw(text, alpha: nil, color: nil, width: nil)
      t = text.encode("UTF-8")
      c = SDL_Color.malloc(Fiddle::RUBY_FREE)
      c.r, c.g, c.b, c.a = color
      w = width || 0

      if alpha
        TTF.TTF_RenderUTF8_Blended_Wrapped(self, t, c, w)
      else
        TTF.TTF_RenderUTF8_Solid_Wrapped(self, t, c, w)
      end => ptr

      raise SDLError if ptr.null?

      Surface.new(ptr)
    end

    def drew_size(text)
      t = text.encode("UTF-8")
      w, h = SDL.tmp_value("int", "int")
      err = TTF.TTF_SizeUTF8(self, t, w, h)
      raise SDLError if err < 0

      [w.value, h.value]
    end

    def face_count = TTF.TTF_FontFaces(self)

    def family_name = TTF.TTF_FontFaceFamilyName(self).to_s

    def fixed_width? = TTF.TTF_FontFaceIsFixedWidth(self) == 0

    def glyph?(s)
      raise ArgumentError if s.empty? || s.size > 1

      uint32 = s[0].encode("UTF-32LE").unpack1("L")

      TTF.TTF_GlyphIsProvided32(self, uint32) != 0
    end

    def glyph_metrics(s)
      raise ArgumentError if s.empty? || s.size > 1

      uint32 = s[0].encode("UTF-32LE").unpack1("L")

      minx, maxx, miny, maxy, advance =
        SDL.tmp_value("int", "int", "int", "int", "int")

      TTF.TTF_GlyphMetrics32(self, uint32, minx, maxx, miny, maxy, advance)

      [minx.value, maxx.value, miny.value, maxy.value, advance.value]
    end

    def height = TTF.TTF_FontHeight(self)

    alias h height

    def hinting
      case TTF.TTF_GetFontHinting(self)
      when TTF_HINTING_NORMAL         then "normal"
      when TTF_HINTING_LIGHT          then "light"
      when TTF_HINTING_MONO           then "mono"
      when TTF_HINTING_NONE           then "none"
      when TTF_HINTING_LIGHT_SUBPIXEL then "light_subpixel"
      else
        nil
      end
    end

    def hinting=(s)
      case s
      when "normal"         then TTF_HINTING_NORMAL
      when "light"          then TTF_HINTING_LIGHT
      when "mono"           then TTF_HINTING_MONO
      when "none"           then TTF_HINTING_NONE
      when "light_subpixel" then TTF_HINTING_LIGHT_SUBPIXEL
      else
        raise ArgumentError
      end => hinting

      TTF.TTF_SetFontHinting(self, hinting)
    end

    def kerning? = TTF.TTF_GetFontKerning(self) == 0

    def kerning=(b)
      TTF.TTF_SetFontKerning(self, b ? 1 : 0)
    end

    def line_skip = TTF.TTF_FontLineSkip(self)

    def measure(text, width)
      t = text.encode("UTF-8")
      extent, count = SDL.tmp_value("int", "int")
      err = TTF.TTF_MeasureUTF8(self, t, width, extent, count)
      raise SDLError if err < 0

      [extent.value, count.value]
    end

    def outline = TTF.TTF_GetFontOutline(self)

    def outline=(n)
      TTF.TTF_SetFontOutline(self, n)
    end

    def pt=(v)
      err = TTF.TTF_SetFontSize(self, v)
      raise SDLError if err < 0
    end

    # see also ISO 15924
    #
    def script_name=(four_characters)
      err = TTF.TTF_SetFontScriptName(self, four_characters)
      raise SDLError if err < 0
    end

    def size_pt(pt, hdpi, vdpi)
      err = TTF.TTF_SetFontSizeDPI(self, pt, hdpi, vdpi)
      raise SDLError if err < 0
    end

    def style
      num = TTF.TTF_GetFontStyle(self)

      a = []
      a << "normal"    if num & TTF_STYLE_NORMAL != 0
      a << "bold"      if num & TTF_STYLE_BOLD != 0
      a << "italic"    if num & TTF_STYLE_ITALIC != 0
      a << "underline" if num & TTF_STYLE_UNDERLINE != 0
      a << "strike"    if num & TTF_STYLE_STRIKETHROUGH != 0
      a
    end

    def style=(a)
      num = 0 |
        (a.include?("normal")    ? TTF_STYLE_NORMAL : 0) |
        (a.include?("bold")      ? TTF_STYLE_BOLD : 0) |
        (a.include?("italic")    ? TTF_STYLE_ITALIC : 0) |
        (a.include?("underline") ? TTF_STYLE_UNDERLINE : 0) |
        (a.include?("strike")    ? TTF_STYLE_STRIKETHROUGH : 0)

      TTF.TTF_SetFontStyle(self, num)
    end

    def style_name = TTF.TTF_FontFaceStyleName(self).to_s

    def to_ptr = @ptr
  end
end
