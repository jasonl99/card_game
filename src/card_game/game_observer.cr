module CardGame

  class GameObserver < Lattice::Connected::StaticBuffer
    @max_items = 20 
    # When an event occurs, render it and add the rendered content
    # def content
    #   # by putting this in rendered content we orverrid the autorendering
    #   render "./src/card_game/game_observer.slang"
    # end
    def on_event( event, speaker )
      if event.session_id && (session = Session.get event.session_id.as(String))
         event_user = session.string?("name") || ""
      end
      add_content render "./src/card_game/observed_event.slang"
    end

    def after_initialize
      @element_class = "observed-events"
    end

  end
end
