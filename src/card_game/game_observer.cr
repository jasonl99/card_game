module CardGame

  class GameObserver < Lattice::Connected::ObjectList
    @max_items = 20 

    def after_initialize
      add_element_class "observed-events"
    end

    def content
      render "./src/card_game/game_observer.slang"
    end

    def observe_event( event,  target)
      case event.class
      when Lattice::Connected::IncomingEvent
        event = event.as(Lattice::Connected::IncomingEvent)
        user = event.user.as(Player).name
        action = event.action
        sender = "#{target.to_s} #{event.component}"
        direction = "In"
        dom_item = event.dom_item
        message = event.params
        add_content render "./src/card_game/observed_event.slang"
      when Lattice::Connected::OutgoingEvent
        event = event.as(Lattice::Connected::OutgoingEvent)
        user = "[Server]"
        action = "Send"
        sender = "#{event.source.to_s}"
        direction = "Out"
        dom_item = ""
        message = event.message
        add_content render "./src/card_game/observed_event.slang"

      end
    end

  end
end
