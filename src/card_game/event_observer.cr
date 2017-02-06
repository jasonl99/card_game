module CardGame
  class ConnectedEvent
    property sender : Lattice::Connected::WebObject
    property dom_item : String
    property action : Lattice::Connected::IncomingMessage | Lattice::Connected::OutgoingMessage
    property session_id : String?
    property socket : HTTP::WebSocket
    def initialize(@sender, @dom_item, @action, @session_id, @socket)
    end
  end

  class EventObserver < Lattice::Connected::WebObject
    MAX_EVENTS = 25
    @events = RingBuffer(ConnectedEvent).new(size: MAX_EVENTS)

    def listen_to(talker, dom_item, action, session_id, socket)
      @events << ConnectedEvent.new( talker, dom_item, action, session_id, socket)
      super
    end

  end

end
