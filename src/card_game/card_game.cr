module CardGame
  class CardGame < Lattice::Connected::WebObject
    VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    SUITS  = %w(Hearts Diamonds Spades Clubs)
    property url : String?
    property cards : Array(String) = new_deck

    def content
      render "./src/card_game/card_game.slang"
    end

    def subscriber_action(action : Hash(String,JSON::Type), session_id : String)
      puts "action #{action} by session #{session_id} to #{self.class.to_s.colorize(:green).to_s} #{name.colorize(:green).to_s}"
      if action.first_key == "click"
        dom_id = action.first_value
        return if dom_id == "hand"  # just a hack for the time being to avoid testing domid
        player_name = Session.get(session_id).as(Session).string("name")  # we assume that this has been validated and a session exists and name is set
        card = draw_card
        subscribers.each &.send({"message"=>"#{player_name} drew card is #{card} for #{dom_id}"}.to_json)
        subscribers.each &.send({"dom"=>{"action"=>"update", "id"=>dom_id, "value"=>card}}.to_json)
      end
    end

    def draw_card
      card = cards.sample
      cards.delete card
      card  # OPTIMIZE does delete already return this?
    end

    def new_deck : Array(String)
      VALUES.product(SUITS).map(&.join(" of ")) 
    end

  end
end
