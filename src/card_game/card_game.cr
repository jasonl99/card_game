require "./chat_room"
require "./game_observer"
module CardGame
  class CardGame < Lattice::Connected::WebObject
    VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    SUITS  = %w(Hearts Diamonds Spades Clubs)
    property hand = [] of String
    property url : String?
    property deck : Array(String) = new_deck
    @@max_instances = 25 
    @chat_room : ChatRoom?
    @game_observer : GameObserver?

    def content
      render "./src/card_game/card_game.slang"
    end

    def chat_room : ChatRoom
      @chat_room ||= ChatRoom.new("ChatRoom-#{dom_id}", self)
    end

    def game_observer : GameObserver
      @game_observer ||= GameObserver.new("GameObserver-#{dom_id}", self)
    end

    def after_initialize
      (1..5).each {|c| hand << draw_card}
      add_observer game_observer
      chat_room.add_observer game_observer
    end

    def card_image(card)
      "/images/#{card.gsub(" ","_").downcase}.png"
    end

    def on_event( event : Lattice::Connected::IncomingEvent)
      if event.action == "click" && (card_index = event.index)
        player_name = event.user.as(Player).name || "Visitor"
        hand[card_index] = draw_card
        update_component "cards-remaining", deck.size
        update_attribute({"id"=>dom_id("card-#{card_index}"), "attribute"=>"src", "value"=>card_image hand[card_index]})
        chat_room.send_chat ChatMessage.new name: player_name, message: hand[card_index]
      end

    end

    def subscribed( player : Player )
      if ( player_name = player.name ) && (socket = player.socket)
        personalize = {"id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>player_name}
        update_attribute(personalize, [socket])
      end
    end

    def draw_card
      self.deck = new_deck if self.deck.size == 0
      card = deck.sample
      deck.delete card
      card
    end

    def new_deck : Array(String)
      VALUES.product(SUITS).map(&.join(" of ")) 
    end

  end
end
