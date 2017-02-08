require "./chat_message"
module CardGame
  class ChatRoom < Lattice::Connected::WebObject
    MAX_MESSAGES = 5
    # property messages = Array(ChatMessage | Nil).new(size: MAX_MESSAGES, value: nil)
    # property current_message = 0  # an index in the circular buffer for messages
    @messages = Lattice::RingBuffer(ChatMessage).new(size: MAX_MESSAGES)
    property messages

    # def initialize(@name)
    #   super
    # end

    def subscriber_name(socket)
      name = "anon"
      if (session_id = Lattice::Connected::WebSocket::REGISTERED_SESSIONS[socket.object_id])
        if (session = Session.get session_id)
          name = session.string? "name" || "anon"
        end
      end
    end

    def send_chat(chat_message : ChatMessage)
      messages << chat_message
      # insert({"id"=>"#{dom_id}-message-holder", "value"=>chat_message.content})
    end

    # switch to using #update_attribute once it has been modified to update
    # specific sockets
    def subscribed(session_id : String, socket : HTTP::WebSocket)
      if (user_name = session_string(session_id: session_id, value_of: "name"))
        personalize = {"id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>user_name}
        update_attribute(personalize, [socket])
      end
    end
    # div data-item="chatroom-#{dom_id}-typing"
    # - subscribers.each do |sub|
    #   div data-item="chatroom-#{dom_id}-typing-#{sub.object_id}"
    #   end


    def subscriber_action(dom_item : String, action : Hash(String,JSON::Type), session_id : String?, socket)
      puts "In #{self.class.to_s.split("::").last.colorize(:white).on(:green).to_s}: data_item: #{dom_item.colorize(:green).to_s} action #{action.inspect.colorize(:yellow).to_s}"
      player_name = "Anon"
      player_name = Session.get(session_id.as(String)).as(Session).string?("name") if session_id
      if action["action"] == "submit" && player_name
        params = action["params"].as(Hash(String,JSON::Type))
        send_chat ChatMessage.build self, name: player_name, message: params["new-msg"].as(String)
      end
      if action["action"] == "input"
        params = action["params"].as(Hash(String,JSON::Type))
        new_val = params["value"].as(String)
      end
    end

    def rendered_messages
      messages.values.reject(&.nil?).map(&.as(ChatMessage).content).join("\n")
    end

		def display_form
			render "./src/card_game/chat_form.slang"
		end

    def content
      render "./src/card_game/chat_room.slang"
    end

  end
end
