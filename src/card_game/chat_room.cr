require "./chat_message"
module CardGame
  class ChatRoom < Lattice::Connected::WebObject
    MAX_MESSAGES = 100
    property messages = Array(ChatMessage | Nil).new(size: MAX_MESSAGES, value: nil)
    property current_message = 0  # an index in the circular buffer for messages

    def initialize(@name)
      super
    end

    def send(chat_message : ChatMessage)
      puts "Sending message: #{chat_message.inspect}"
      insert({"id"=>"#{dom_id}-message-holder", "value"=>chat_message.content})
    end

    def subscriber_action(action : Hash(String,JSON::Type), session_id : String)
      puts "ChatRoom action received: #{action} from #{session_id}"
    end

    def rendered_messages
      messages.reject(&.nil?).map(&.as(ChatMessage).content).join("\n")
    end

		def display_form
			render "./src/card_game/chat_form.slang"
		end

    def content
      render "./src/card_game/chat_room.slang"
    end

  end
end
