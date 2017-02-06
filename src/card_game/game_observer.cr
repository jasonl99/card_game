module CardGame
  # FIXME Need a generic way to get info from a session
  class GameEvent < Lattice::Connected::ConnectedEvent
    def content
      if session_id && (session = Session.get session_id.as(String))
        event_user = session.string?("name") || "Anonymous"
      end
      render "./src/card_game/game_observer.slang"
      # <<-CONTENT
      #   <div class="connected-event">
      #     <span class="user">#{event_user}</span>
      #     <span class="sender"  >#{sender.class.to_s.split("::").last}</span>
      #     <span class="dom_item">#{dom_item}</span>
      #     <span class="action">#{action}</span>
      #   </div>
      # CONTENT
    end
  end

  class GameObserver < Lattice::Connected::EventObserver(GameEvent)
    MAX_ITEMS = 20
    def on_event( event )
      insert({"id"=>dom_id, "value"=>event.content})
    end 
    def content
      @events.values.map(&.content).join("\n")
    end
  end
end
