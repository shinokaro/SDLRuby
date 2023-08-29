# frozen_string_literal: true

require "test_helper"

class TestSDLRuby < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::SDLRuby::VERSION
  end

  def test_it_does_something_useful
    assert true
  end

  def test_sdl_pixelformat_constant_value
    assert_respond_to ::SDLRuby::SDL, :SDL_GetPixelFormatName
    m = -> (x) { ::SDLRuby::SDL.SDL_GetPixelFormatName(x).to_s }

    assert_equal "SDL_PIXELFORMAT_INDEX1LSB",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_INDEX1LSB)
    assert_equal "SDL_PIXELFORMAT_INDEX1MSB",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_INDEX1MSB)
    assert_equal "SDL_PIXELFORMAT_INDEX4LSB",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_INDEX4LSB)
    assert_equal "SDL_PIXELFORMAT_INDEX4MSB",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_INDEX4MSB)
    assert_equal "SDL_PIXELFORMAT_INDEX8",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_INDEX8)
    assert_equal "SDL_PIXELFORMAT_RGB332",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGB332)
    assert_equal "SDL_PIXELFORMAT_RGB444",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGB444)
    assert_equal "SDL_PIXELFORMAT_BGR444",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGR444)
    assert_equal "SDL_PIXELFORMAT_RGB555",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGB555)
    assert_equal "SDL_PIXELFORMAT_BGR555",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGR555)
    assert_equal "SDL_PIXELFORMAT_ARGB4444",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ARGB4444)
    assert_equal "SDL_PIXELFORMAT_RGBA4444",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGBA4444)
    assert_equal "SDL_PIXELFORMAT_ABGR4444",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ABGR4444)
    assert_equal "SDL_PIXELFORMAT_BGRA4444",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGRA4444)
    assert_equal "SDL_PIXELFORMAT_ARGB1555",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ARGB1555)
    assert_equal "SDL_PIXELFORMAT_RGBA5551",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGBA5551)
    assert_equal "SDL_PIXELFORMAT_ABGR1555",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ABGR1555)
    assert_equal "SDL_PIXELFORMAT_BGRA5551",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGRA5551)
    assert_equal "SDL_PIXELFORMAT_RGB565",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGB565)
    assert_equal "SDL_PIXELFORMAT_BGR565",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGR565)
    assert_equal "SDL_PIXELFORMAT_RGB24",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGB24)
    assert_equal "SDL_PIXELFORMAT_BGR24",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGR24)
    assert_equal "SDL_PIXELFORMAT_RGB888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGB888)
    assert_equal "SDL_PIXELFORMAT_RGBX8888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGBX8888)
    assert_equal "SDL_PIXELFORMAT_BGR888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGR888)
    assert_equal "SDL_PIXELFORMAT_BGRX8888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGRX8888)
    assert_equal "SDL_PIXELFORMAT_ARGB8888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ARGB8888)
    assert_equal "SDL_PIXELFORMAT_RGBA8888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_RGBA8888)
    assert_equal "SDL_PIXELFORMAT_ABGR8888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ABGR8888)
    assert_equal "SDL_PIXELFORMAT_BGRA8888",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_BGRA8888)
    assert_equal "SDL_PIXELFORMAT_ARGB2101010",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_ARGB2101010)
    assert_equal "SDL_PIXELFORMAT_YV12",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_YV12)
    assert_equal "SDL_PIXELFORMAT_IYUV",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_IYUV)
    assert_equal "SDL_PIXELFORMAT_YUY2",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_YUY2)
    assert_equal "SDL_PIXELFORMAT_UYVY",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_UYVY)
    assert_equal "SDL_PIXELFORMAT_YVYU",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_YVYU)
    assert_equal "SDL_PIXELFORMAT_NV12",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_NV12)
    assert_equal "SDL_PIXELFORMAT_NV21",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_NV21)
    assert_equal "SDL_PIXELFORMAT_EXTERNAL_OES",
                 m.(::SDLRuby::SDL::SDL_PIXELFORMAT_EXTERNAL_OES)
  end

  def test_sdl_ticks
    assert_respond_to ::SDLRuby::SDL, :ticks
    assert_instance_of Integer, ::SDLRuby::SDL.ticks
  end
end
