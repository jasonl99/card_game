module CardGame

  class GameObserver < Lattice::Connected::ObjectList
    @max_items = 20 

    def after_initialize
      add_element_class "observed-events"
    end

    def content
      render "./src/card_game/game_observer.slang"
    end

    def observe_event( event : Lattice::Connected::IncomingEvent, target)
      user = event.user.as(Player).name
      action = event.action
      sender = "#{target.to_s} #{event.component}"
      direction = "In"
      dom_item = event.dom_item
      message = event.params
      add_content render "./src/card_game/observed_event.slang"
    end

  end
end
