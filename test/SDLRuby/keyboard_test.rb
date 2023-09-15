# frozen_string_literal: true

require "test_helper"

module SDLRuby
  class KeyboardTest < Minitest::Test
    include ::Fiddle, ::SDLRuby, ::SDLRuby::SDL

    def setup
      num_keys = Pointer.malloc(SIZEOF_INT, RUBY_FREE)
      ptr = SDL.SDL_GetKeyboardState(num_keys)
      raise if ptr.null?
      ptr.size = num_keys.to_str.unpack1("i")
      @keystate = ptr.freeze
    end

    def keystate_reset
      @keystate.size.times { |i| @keystate[i] = 0 }
    end

    def test_equality_operator
      assert_respond_to Keyboard, :==

      assert_equal true,  Keyboard == Keyboard
      assert_equal false, Keyboard == Object
      assert_equal false, Keyboard == nil
      assert_equal false, Keyboard == Object.new

      msg = "Comparing with objects out of range returns false"
      assert_equal false, Keyboard == 0   , msg
      assert_equal false, Keyboard == -1  , msg
      assert_equal false, Keyboard == 1234, msg
      assert_equal false, Keyboard == ""  , msg
      assert_equal false, Keyboard == nil , msg

      @keystate[42] = 1

      assert_equal true,  Keyboard == 42,
                   "It returns true if the given integer matches the scancode\
 of a currently pressed key"
      assert_equal true,  Keyboard == "Backspace",
                   "It returns true if the given string matches the scancode\
 name of a currently pressed key"
      assert_equal true,  Keyboard == :Backspace,
                   "It returns true if the given symbol matches the scancode\
 name of a currently pressed key"

      assert case Keyboard
             when "Backspace"
               true
             else
               false
             end,
             "The goal is to be usable in a case statement"

      assert case Keyboard
             when 42
               true
             else
               false
             end,
             "The goal is to be usable in a case statement"
    end

    def test_any?
      assert_respond_to Keyboard, :any?

      keystate_reset

      assert_equal false, Keyboard.any?

      @keystate[42] = 1

      assert_equal true, Keyboard.any?
    end

    def test_clear
      assert_respond_to Keyboard, :clear

      # SDL_ResetKeyboard should be preceded by initializing SDL events since
      # it sends SDLK_KEYUP events for pressed keys.
      #
      @keystate[42] = 1
      assert_nil Keyboard.clear # "Expecting not to core dump"

      SDL.SDL_Init(SDL_INIT_EVENTS)

      @keystate[42] = 1
      assert_nil Keyboard.clear
      assert @keystate.to_str.bytes.none? { |i| i != 0 },
             "The keyboard state was not cleared"

      SDL.SDL_Quit
    end

    def test_mod
      assert_respond_to Keyboard, :mod
      assert_instance_of Integer, Keyboard.mod
    end

    def test_scancode
      assert_respond_to Keyboard, :scancode

      assert_equal 42, Keyboard.scancode("Backspace")
      assert_equal 42, Keyboard.scancode("backspace"),
                   "It is affected by uppercase and lowercase"
      assert_equal 42, Keyboard.scancode("BACKSPACE"),
                   "It is affected by uppercase and lowercase"

      assert_equal 0, Keyboard.scancode("")
      assert_equal 0, Keyboard.scancode("@*!? bad scancode name @*!?")
      assert_equal 0, Keyboard.scancode("*"),
                   "I think it's getting the key codes"

      assert_equal 0, Keyboard.scancode(nil),
                   "Please accept objects that respond to 'to_s'"
      assert_equal 42, Keyboard.scancode(:Backspace),
                   "Please accept objects that respond to 'to_s'"
      assert_equal 39, Keyboard.scancode(0),
                   "Please return the scan code corresponding to the result of\
 calling 'to_s' on the object"
    end

    def test_scancode_name
      assert_respond_to Keyboard, :scancode_name

      assert_equal "Backspace", Keyboard.scancode_name(42)

      assert_equal "", Keyboard.scancode_name(0)
      assert_equal "", Keyboard.scancode_name(1234)
      assert_equal "", Keyboard.scancode_name(-1)
    end

    def test_size
      assert_respond_to Keyboard, :size
      assert_equal @keystate.size, Keyboard.size
    end

    def test_to_a
      assert_respond_to Keyboard, :to_a

      keystate_reset

      assert_empty Keyboard.to_a

      @keystate[42] = 1

      assert_equal [42], Keyboard.to_a

      @keystate[SDL_SCANCODE_C] = 1

      assert_equal [SDL_SCANCODE_C, 42], Keyboard.to_a
    end

    def test_to_str
      assert_respond_to Keyboard, :to_str

      keystate_reset

      state = "\x00" * @keystate.size

      assert_equal state, Keyboard.to_str

      @keystate[42] = 1
      state[42] = "\x01"

      assert_equal state, Keyboard.to_str
    end
  end
end
