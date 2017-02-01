require "./chat_message"
require "./ring_buffer"
module CardGame
  class ChatRoom < Lattice::Connected::WebObject
    MAX_MESSAGES = 5
    # property messages = Array(ChatMessage | Nil).new(size: MAX_MESSAGES, value: nil)
    # property current_message = 0  # an index in the circular buffer for messages
    @messages = RingBuffer(ChatMessage).new(size: MAX_MESSAGES)
    property messages

    # def initialize(@name)
    #   super
    # end

    def send(chat_message : ChatMessage)
      messages << chat_message
      insert({"id"=>"#{dom_id}-message-holder", "value"=>chat_message.content})
    end

    # switch to using #update_attribute once it has been modified to update
    # specific sockets
    def subscribed(session_id : String, socket : HTTP::WebSocket)
      if (user_name = session_string(session_id: session_id, value_of: "name"))
        personalize = {"action"=>"update_attribute", "id"=>"#{dom_id}-chatname", "attribute"=>"value", "value"=>user_name}
        update_attribute(personalize, [socket])
      end
    end


    def subscriber_action(dom_item : String, action : Hash(String,JSON::Type), session_id : String?)
      player_name = "Anon"
      player_name = Session.get(session_id.as(String)).as(Session).string?("name") if session_id
      puts "#{dom_item} / #{player_name}: #{action}"
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
