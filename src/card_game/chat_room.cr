require "./chat_message"
module CardGame
  class ChatRoom < Lattice::Connected::StaticBuffer

    # Each chaat message rolls off the display (we don't keep all of them around)
    # for this demo, we only keep the last five message.
    @max_items = 5

    def send_chat(chat_message : ChatMessage)
      add_content new_content: chat_message.content
    end

    # when a new user is subscribed, the chat input box is personalized with their name
    # All users get the same initial page, but each is individuall customized
    # over the socket.
    def subscribed(session_id : String, socket : HTTP::WebSocket)
      if (user_name = session_string(session_id: session_id, value_of: "name"))
        personalize = {"id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>user_name}
        update_attribute(personalize, [socket])
      end
      super
    end

    # the only event we really do anything with is an action submit (we don't even bother
    # checking the dom-item since we only have one input form).  
    # this is where censoring could occurr (message = params["new-mesg"]...)
    def on_event(event, sender)
      if event.direction == "In" && event.session_id && (player_name = session_string(session_id: event.session_id.as(String), value_of: "name"))
        message = event.message.as(Hash(String,JSON::Type))
        action = message["action"]
        if action == "submit" && player_name
          params = message["params"].as(Hash(String,JSON::Type))
          message = params["new-msg"].as(String)
          # censor a few words
          %w(fuck shit cunt).each {|w| message = message.gsub(w,"*"*w.size)}
          send_chat ChatMessage.new name: player_name, message: message if message.size > 0
        end
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
