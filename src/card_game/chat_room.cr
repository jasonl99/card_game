require "./chat_message"
module CardGame
  class ChatRoom < Lattice::Connected::StaticBuffer

    @max_items = 5

    def send_chat(chat_message : ChatMessage)
      add_content new_content: chat_message.content, dom_id: "#{dom_id}-message-holder"
    end

    def subscribed(session_id : String, socket : HTTP::WebSocket)
      if (user_name = session_string(session_id: session_id, value_of: "name"))
        personalize = {"id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>user_name}
        update_attribute(personalize, [socket])
      end
    end

    def on_event(event, sender)
      player_name = "Anon"
      player_name = Session.get(event.session_id.as(String)).as(Session).string?("name") if event.session_id
      message = event.message.as(Hash(String,JSON::Type))
      puts "Chatroom message #{event.direction} (#{message.class} #{message}".colorize(:blue).on(:white)
      action = message["action"]
      puts "Chatroom action (#{action.class}): #{action}"
        # action = message["action"] #.as(Hash(String, String | Hash(String,JSON::Type)))
        # puts action
        # puts action.class
        # puts action
        # puts action.class
      # puts "Chatroom action (#{action.class} #{action}".colorize(:blue).on(:white)
      # if action == "submit" && player_name
      #   params = message["params"].as(Hash(String,JSON::Type))
      #   send_chat ChatMessage.new name: player_name, message: params["new-msg"].as(String)
      # end
    end

    # def subscriber_action(dom_item : String, action : Hash(String,JSON::Type), session_id : String?, socket)
    #   player_name = "Anon"
    #   player_name = Session.get(session_id.as(String)).as(Session).string?("name") if session_id
    #   if action["action"] == "submit" && player_name
    #     params = action["params"].as(Hash(String,JSON::Type))
    #     send_chat ChatMessage.new name: player_name, message: params["new-msg"].as(String)
    #   end
    # end

    def rendered_messages
      @items.values.join
    end

		def display_form
			render "./src/card_game/chat_form.slang"
		end

    def content
      render "./src/card_game/chat_room.slang"
    end

  end
end
