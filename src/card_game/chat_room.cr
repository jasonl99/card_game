require "./chat_message"
module CardGame
  class ChatRoom < Lattice::Connected::WebObject
    MAX_MESSAGES = 5
    @messages = Lattice::RingBuffer(ChatMessage).new(size: MAX_MESSAGES)
    property messages

    def send_chat(chat_message : ChatMessage)
      messages << chat_message
      # insert({"id"=>"#{dom_id}-message-holder", "value"=>chat_message.content})
    end

    def subscribed(session_id : String, socket : HTTP::WebSocket)
      if (user_name = session_string(session_id: session_id, value_of: "name"))
        personalize = {"id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>user_name}
        update_attribute(personalize, [socket])
      end
    end

    def subscriber_action(dom_item : String, action : Hash(String,JSON::Type), session_id : String?, socket)
      player_name = "Anon"
      player_name = Session.get(session_id.as(String)).as(Session).string?("name") if session_id
      if action["action"] == "submit" && player_name
        params = action["params"].as(Hash(String,JSON::Type))
        send_chat ChatMessage.build self, name: player_name, message: params["new-msg"].as(String)
      end
    end

    def rendered_messages
      messages.values.map(&.content).join("\n")
    end

		def display_form
			render "./src/card_game/chat_form.slang"
		end

    def content
      render "./src/card_game/chat_room.slang"
    end

  end
end
