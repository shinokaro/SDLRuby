# frozen_string_literal: true

require "test_helper"

class EventTest < Minitest::Test
  include ::SDLRuby, ::SDLRuby::SDL

  def setup
    SDL.init(SDL_INIT_EVENTS)
    flush_event_all
  end

  def teardown
    SDL.quit
  end

  def flush_event_all
    SDL.SDL_FlushEvents(SDL_FIRSTEVENT, SDL_LASTEVENT)
  end

  def build_event(type: 0, **members)
    e = SDL_Event.malloc
    st = e.__send__(Event::Type[type])
    st.type = type
    members.each { |k, v| st.__send__("#{k}=", v) }
    e
  end

  def count_event
    SDL.SDL_PeepEvents(nil, 0, SDL_PEEKEVENT, 0, -1)
  end

  def push_event(...)
    SDL.SDL_PushEvent(build_event(...))
  end

  def test_event_clear
    assert_respond_to Event, :clear

    flush_event_all

    assert_nil Event.clear
    assert_equal 0, count_event

    push_event
    assert_nil Event.clear
    assert_equal 0, count_event
  end

  def test_event_deq
    assert_respond_to Event, :deq

    flush_event_all

    Thread.new {
      sleep 1
      push_event
    }
    assert_instance_of Event, Event.deq

    flush_event_all

    e = assert_raises ::SDLRuby::SDLError do
      Event.deq(true)
    end

    assert_equal "event queue empty", e.message

    push_event

    assert_instance_of Event, Event.deq(true)
  end

  def test_event_empty?
    assert_respond_to Event, :empty?

    flush_event_all

    assert_equal true, Event.empty?

    push_event

    assert_equal false, Event.empty?
  end

  def test_event_get
    assert_respond_to Event, :get

    flush_event_all
    push_event

    assert_raises ::SDLRuby::SDLError,
                  "can be called from a non-main thread" do
      t = Thread.new do
        Thread.pass
        Event.get
      end
      t.report_on_exception = false
      t.join
    end
    assert_equal 1, count_event,
                 "getting events from calls by non-main threads"

    flush_event_all
    Thread.new {
      sleep 1
      push_event
    }
    assert_instance_of Event, Event.get

    push_event

    assert_instance_of Event, Event.get
  end

  def test_event_length
    assert_respond_to Event, :length

    flush_event_all
    # que is empty
    assert_equal 0, Event.length

    push_event
    assert_equal 1, Event.length
  end

  def test_event_quit?
    assert_respond_to Event, :quit?

    assert_raises ::SDLRuby::SDLError,
                  "can be called from a non-main thread" do
      t = Thread.new do
        Thread.pass
        Event.quit?
      end
      t.report_on_exception = false
      t.join
    end

    flush_event_all
    # que is empty
    refute Event.quit?

    push_event
    refute Event.quit?

    push_event(type: SDL_QUIT)
    assert Event.quit?
  end

  def test_event_reserve
    assert_respond_to Event, :reserve

    rest = SDL_LASTEVENT - SDL_USEREVENT

    assert_equal SDL_USEREVENT, Event.reserve(rest)

    e = assert_raises ::SDLRuby::SDLError do
      Event.reserve(1)
    end

    assert_equal "cannot register any more user events", e.message
  end

  def test_event_update
    assert_respond_to Event, :update

    assert_raises ::SDLRuby::SDLError,
                  "can be called from a non-main thread" do
      t = Thread.new do
        Thread.pass
        Event.update
      end
      t.report_on_exception = false
      t.join
    end

    assert_nil Event.update
  end

  def test_event_wait
    assert_respond_to Event, :wait

    flush_event_all

    refute Thread.new { Event.wait }.value,
           "returns a true value when called from a non-main thread"

    push_event

    assert Thread.new { Event.wait }.value,
           "returns a false value when called from a non-main thread despite pending events"

    flush_event_all

    push_event

    assert Event.wait,
           "found pending events in the queue but did not return a true value"
    assert_equal 1, count_event,
                 "consuming events from the queue"

    assert Event.wait(1),
           "found pending events in the queue but did not return a true value"
    assert_equal 1, count_event,
                 "consuming events from the queue"

    flush_event_all

    Thread.new {
      sleep 1
      push_event
    }
    assert Event.wait,
           "found pending events in the queue but did not return a true value"
    assert_equal 1, count_event,
                 "consuming events from the queue"

    flush_event_all

    Thread.new {
      sleep 1
      push_event
    }
    assert Event.wait(2),
           "found pending events in the queue but did not return a true value"
    assert_equal 1, count_event,
                 "consuming events from the queue"

    flush_event_all

    Thread.new {
      sleep 1
      push_event
    } => t
    refute Event.wait(0.1),
           "did not return a false value despite timing out"
    t.join
    assert_equal 1, count_event,
                 "consuming events from the queue"
  end

  def test_read_accessors
    %w[
      axis
      ball button
      clicks code
      dDist dTheta data data1 data2 direction display dx dy
      error event
      file finger fingerId
      gestureId
      hat
      iscapture
      keysym
      length level
      mouseX mouseY msg
      numFingers
      padding padding1 padding2 padding3 padding4 preciseX preciseY pressure
      repeat
      sensor start state text
      timestamp timestamp_us touchId touchpad type
      value
      which windowID
      x xrel
      y yrel
    ] => all

    e = Event.new(SDL_Event.malloc)

    all.each do |name|
      assert_respond_to e, name
    end

    (all - %w[timestamp type]).each do |name|
      assert_nil e.__send__(name)
    end

    %w[
      d_dist
      d_theta
      finger_id
      gesture_id
      mouse_x
      mouse_y
      num_fingers
      precise_x
      precise_y
      touch_id
      window_id
    ] => aliases

    aliases.each do |name|
      assert_respond_to e, name
    end

    aliases.each do |name|
      assert_nil e.__send__(name)
    end

    assert_equal 0, e.timestamp
    assert_equal 0, e.type

    assert_respond_to e, :capture?
    assert_equal false, e.capture?

    assert_respond_to e, :pressed?
    assert_equal false, e.pressed?

    assert_respond_to e, :scancode
    assert_nil e.scancode

    assert_respond_to e, :sym
    assert_nil e.sym

    assert_respond_to e, :mod
    assert_nil e.mod
  end

  def test_capture?
    e = Event.new(build_event)
    assert_equal false, e.capture?

    e = Event.new(build_event(type: SDL_AUDIODEVICEADDED, iscapture: 1))
    assert_equal true, e.capture?
  end

  def test_keysym
    e = Event.new(build_event(type: SDL_KEYUP))
    assert_instance_of Hash, e.keysym

    e = Event.new(build_event(type: SDL_KEYDOWN))
    assert_instance_of Hash, e.keysym
  end

  def test_text
    e = Event.new(build_event(type: SDL_TEXTEDITING))
    act = e.text
    assert_equal "", act
    assert_equal Encoding::UTF_8, act.encoding

    e = Event.new(build_event(type: SDL_TEXTEDITING_EXT))
    act = e.text
    assert_equal "", act
    assert_equal Encoding::UTF_8, act.encoding

    e = Event.new(build_event(type: SDL_TEXTINPUT))
    act = e.text
    assert_equal "", act
    assert_equal Encoding::UTF_8, act.encoding

    e = Event.new(build_event(type: SDL_DROPTEXT))
    act = e.text
    assert_equal "", act
    assert_equal Encoding::UTF_8, act.encoding
  end

  def test_pressed?
    e = Event.new(build_event)
    assert_equal false, e.pressed?

    e = Event.new(build_event(type: SDL_MOUSEBUTTONDOWN, state: SDL_PRESSED))
    assert_equal true, e.pressed?

    e = Event.new(build_event(type: SDL_CONTROLLERBUTTONDOWN, state: SDL_PRESSED))
    assert_equal true, e.pressed?

    e = Event.new(build_event(type: SDL_JOYBUTTONDOWN, state: SDL_PRESSED))
    assert_equal true, e.pressed?
  end

  def test_scancode
    e = Event.new(build_event)
    assert_nil e.scancode

    e = Event.new(build_event(type: SDL_KEYUP))
    assert_instance_of Integer, e.scancode
  end

  def test_sym
    e = Event.new(build_event)
    assert_nil e.sym

    e = Event.new(build_event(type: SDL_KEYUP))
    assert_instance_of Integer, e.sym
  end

  def test_mod
    e = Event.new(build_event)
    assert_nil e.mod

    e = Event.new(build_event(type: SDL_KEYUP))
    assert_instance_of Integer, e.mod
  end
end
