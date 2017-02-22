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
      @chat_room ||= ChatRoom.new("ChatRoom-#{dom_id}")
    end

    def game_observer : GameObserver
      @game_observer ||= GameObserver.new("GameObserver-#{dom_id}")
    end

    def after_initialize
      (1..5).each {|c| hand << draw_card}
      add_observer game_observer
      chat_room.add_observer game_observer
    end

    def card_image(card)
      "/images/#{card.gsub(" ","_").downcase}.png"
    end

    def on_event(event, sender)
      component_id = component_id(event.dom_item)
      card_index = component_index(component_id)
      puts "Cardgame event received: #{event.message}"
      if (player = event.user)
        puts "Player: #{player}".colorize(:white).on(:blue)
        player_name = player.as(Player).name
      else
        player_name = "Visitor"
      end
      if event.message
        message = event.message.as(Hash(String,JSON::Type))
        action = message["action"]
        if card_index && event.event_type == "subscriber" && action=="click" 
          hand[card_index] = draw_card
          update_component "cards-remaining", deck.size
          update_attribute({"id"=>dom_id(component_id), "attribute"=>"src", "value"=>card_image hand[card_index]})
          chat_room.send_chat ChatMessage.new name: player_name, message: hand[card_index]
        end
      end

    end

    def subscribed( session_id, socket)
      chat_room.subscribe(socket, session_id)  ##
      game_observer.subscribe(socket, session_id)
      # if (session = Session.get session_id) && (player_name = session.string?("name") )
      #   Storage.connection.exec "insert into player_game (player, game) values (?,?)", player_name, name
      # end
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
