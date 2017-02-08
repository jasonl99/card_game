module CardGame
  class ChatMessage < Lattice::Connected::WebObject
    property name : String
    property time : Time = Time.now
    property message : String?

    def self.build(creator, name, message, time = Time.now)
      obj = new(name)
      obj.message = message
      obj.time = time
      creator.insert({"id"=>"#{creator.dom_id}-message-holder", "value"=>obj.content})
      obj
    end

    def content
      render "./src/card_game/chat_message.slang"
    end

  end
end
