require "./chat_message"
module CardGame
  class ChatRoom < Lattice::Connected::ObjectList

    # Each chaat message rolls off the display (we don't keep all of them around)
    # for this demo, we only keep the last five message.
    @max_items = 5

    def after_initialize
      @items_dom_id = dom_id("items")
      add_element_class "chat-room"
    end

    def send_chat(chat_message : ChatMessage)
      add_content new_content: chat_message.content
    end

    def subscribed( player : Player )
      if ( player_name = player.name ) && (socket = player.socket)
        personalize = {"id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>player_name}
        update_attribute(personalize, [socket])
      end
      super
    end

    def on_event( event : Lattice::Connected::IncomingEvent )
      player_name = event.user.as(Player).name || "Visitor"
      if event.action == "submit"
        message = event.params["new-msg"].as(String)
        %w(fuck shit cunt).each {|w| message = message.gsub(w,"*"*w.size)}
        send_chat ChatMessage.new name: player_name, message: message if message.size > 0
      end
    end

		def display_form
			render "./src/card_game/chat_form.slang"
		end

    def content
      render "./src/card_game/chat_room.slang"
    end

  end
end
