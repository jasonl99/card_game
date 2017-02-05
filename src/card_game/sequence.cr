module CardGame
  class SequenceItem
  end

  class Sequence < Lattice::Connected::WebObject
    MAX_ITEMS = 10
    @items = RingBuffer(String).new(size: MAX_ITEMS)
    property items

    def add_item( from, to, message, detail )
      # @items << item
      puts "detail.class #{detail.class} ".colorize(:green).on(:white)
      puts "#{from} detail is string: #{detail}"
      puts "detail.to_s: #{detail.to_s}"
      # act({"id"=>dom_id,"action"=>"sequenceDiagram", "value"=>items.values.join("\n\r")})
    end

  end
end
