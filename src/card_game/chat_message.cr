module CardGame
  class ChatMessage
    property name : String
    property time : Time
    property message : String

    def initialize(@name, @message, @time = Time.now)
    end

    def content
      render "./src/card_game/chat_message.slang"
    end

  end
end
