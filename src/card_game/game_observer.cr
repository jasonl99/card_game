require "markdown"
module CardGame

  class GameObserver < Lattice::Connected::StaticBuffer
    @max_items = 20 
    # When an event occurs, render it and add the rendered content
    def on_event( event, speaker )
      if event.session_id && (session = Session.get event.session_id.as(String))
         event_user = session.string?("name") || ""
      end
      add_content render "./src/card_game/game_observer.slang"
    end

  end
end
