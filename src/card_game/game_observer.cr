module CardGame
  # FIXME Need a generic way to get info from a session
  class GameEvent < Lattice::Connected::ConnectedEvent
    def render
      if event.session_id && (session = Session.get event.session_id.as(String))
        event_user = session.string?("name") || "Anonymous"
      end
      <<-CONTENT
        <div class="connected-event">
          <span class="sender"  >#{sender.dom_id}</span>
          <span class="dom_item">#{dom_item}</span>
          <span class="action">#{action}</span>
          <span class="session>#{session_id}</span>
          <span class="user">#{event_user}</span>
        <div>
      CONTENT
    end
  end
  class GameObserver < Lattice::Connected::EventObserver(GameEvent)
    @events = Lattice::RingBuffer(GameEvent).new(size: MAX_EVENTS)
    def on_event( event )
      if event.session_id && (session = Session.get event.session_id.as(String))
        event_user = session.string?("name") || "Anonymous"
      end
      content = event.render
      insert({"id"=>dom_id, "value"=>content})
    end 
  end
end
