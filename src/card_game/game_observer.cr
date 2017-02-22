module CardGame

  class GameObserver < Lattice::Connected::ObjectList
    @max_items = 20 
    # When an event occurs, render it and add the rendered content
    # def content
    #   # by putting this in rendered content we orverrid the autorendering
    #   render "./src/card_game/game_observer.slang"
    # end
    def after_initialize
      @items_dom_id = dom_id("items")
      add_element_class "observed-events"
    end

    def content
      render "./src/card_game/game_observer.slang"
    end

    def on_event( event, speaker )
      if (player = event.user)
        event_user = player.as(Player).name
      else
        event_user = "Visitor"
      end
      add_content render "./src/card_game/observed_event.slang"
    end

  end
end
