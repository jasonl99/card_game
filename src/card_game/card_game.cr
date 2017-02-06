require "./chat_room"
module CardGame
  class CardGame < Lattice::Connected::WebObject
    VALUES = %w(2 3 4 5 6 7 8 9 10 Jack Queen King Ace)
    SUITS  = %w(Hearts Diamonds Spades Clubs)
    @version = 1
    @chat_room = ChatRoom.new(dom_id)
    @game_observer = GameObserver.new(dom_id)
    @hand = [] of String
    property chat_room, hand, version, game_observer
    property url : String?
    property deck : Array(String) = new_deck



    def content
      render "./src/card_game/card_game.slang"
    end

    def initialize(@name)
      (1..5).each {|c| hand << draw_card}
      @chat_room.add_observer(self)
      chat_room.add_observer @game_observer
      super
      add_observer @game_observer
    end

    def card_image(card)
      "/images/#{card.gsub(" ","_").downcase}.png"
    end

    # action comes in the form of dom=>param
    # { "cardgame-1234-card-5" => {"clicked"=>"true"}}
    def subscriber_action(data_item : String, action : Hash(String,JSON::Type), session_id : String, socket)
      puts "In #{self.class.to_s.split("::").last.colorize(:white).on(:green).to_s}: data_item: #{data_item.colorize(:green).to_s} action #{action.inspect.colorize(:yellow).to_s}"
      # msg = "In #{self.class.to_s.split("::").last.colorize(:white).on(:green).to_s}: data_item: #{data_item.colorize(:green).to_s} action #{action.inspect.colorize(:yellow).to_s}"
      # Lattice::Connected::SOCKET_LOGGER.debug msg
      begin
        player_name = Session.get(session_id).as(Session).string("name")  # we assume that this has been validated and a session exists and name is set
      rescue
        player_name = "Anon"
      end
      if action["action"]=="click" && (card = index_from(source: data_item, max: hand.size-1))
        # player_name = Session.get(session_id).as(Session).string("name")  # we assume that this has been validated and a session exists and name is set
        hand[card] = draw_card
        update_attribute({"id"=>data_item, "attribute"=>"src", "value"=>card_image hand[card]})
        update({"id"=>"#{dom_id}-cards-remaining", "value"=>deck.size})
        chat_room.send_chat ChatMessage.new(name: player_name, message: hand[card])
      end

      # acted_upon = action.first_key
      # action_taken = action.first_value.as(Hash(String,JSON::Type))  #FIXME need to make sure this is typed correctly as a parameter
      # if action_taken.first_key=="click" && acted_upon.match(/card-[0-4]/) && (card = index_from( source: acted_upon, max: hand.size - 1))
      #   player_name = Session.get(session_id).as(Session).string("name")  # we assume that this has been validated and a session exists and name is set
      #   hand[card] = draw_card
      #   update_attribute({"id"=>acted_upon, "attribute"=>"src", "value"=>card_image hand[card]})
      #   update({"id"=>"#{dom_id}-cards-remaining", "value"=>deck.size})
      #   chat_room.send ChatMessage.new(name: player_name, time: Time.now, mesg: hand[card])
      # end
    end

    def subscribed( session_id, socket)
      chat_room.subscribe(socket, session_id)  ##
    end

    def draw_card
      self.deck = new_deck if self.deck.size == 0
      card = deck.sample
      deck.delete card
      card  # OPTIMIZE does delete already return this?
    end

    def new_deck : Array(String)
      VALUES.product(SUITS).map(&.join(" of ")) 
    end

  end
end
