module CardGame
  class ChatMessage
    property name : String
    property time : Time
    property mesg : String

    def initialize(@name, @time, @mesg)
    end

    def content
      render "./src/card_game/chat_message.slang"
    end

  end
end
