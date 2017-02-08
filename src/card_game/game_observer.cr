require "markdown"
module CardGame

  class GameObserver < Lattice::Connected::Container(String)
    @max_tems = 25
    def on_event( connected_event )
      if connected_event.session_id && (session = Session.get connected_event.session_id.as(String))
         event_user = session.string?("name") || ""
      end
      content = render "./src/card_game/game_observer.slang"
      @items << content
      insert({"id"=>dom_id, "value"=>content})
    end
    def content
      @items.values.join
    end
  end
end
