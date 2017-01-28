module CardGame
  class CardGame < Lattice::Connected::WebObject
    VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    SUITS  = %w(Hearts Diamonds Spades Clubs)
    @version = 1
    property url : String?
    property deck : Array(String) = new_deck
    property hand = [] of String
    property version

    def content
      render "./src/card_game/card_game.slang"
    end

    def initialize(@name)
      (1..5).each {|c| hand << draw_card}
      super
    end

    # action comes in the form of dom=>param
    def subscriber_action(action : Hash(String,JSON::Type), session_id : String)
      puts "action #{action} by session #{session_id} to #{self.class.to_s.colorize(:green).to_s} #{name.colorize(:green).to_s}"
      if action.first_value == "click"
        clicked_id = action.first_key
        if clicked_id.match(/card-[0-4]/) && (card = index_from( source: clicked_id, max: hand.size - 1))
          player_name = Session.get(session_id).as(Session).string("name")  # we assume that this has been validated and a session exists and name is set
          hand[card] = draw_card
          update({"id"=>clicked_id, "value"=>hand[card]})
          update({"id"=>"#{dom_id}-cards-remaining", "value"=>deck.size})
        end
      end
    end

    def draw_card
      card = deck.sample
      deck.delete card
      card  # OPTIMIZE does delete already return this?
    end

    def new_deck : Array(String)
      VALUES.product(SUITS).map(&.join(" of ")) 
    end

  end
end
