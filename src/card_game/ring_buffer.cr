module CardGame
  class RingBuffer(T)
    property current_index = -1	
    
    def initialize(@size = 10)
      @storage = Array(T | Nil).new(@size,nil)
    end

    def delete(val : T)
      if (pos = @storage.index(val))
        @storage.delete(val)
        @storage << nil
        @current_index -= 1
      end
    end

    def <<(val : T)
      @current_index = (@current_index + 1) % @size 
      @storage[@current_index] = val
    end

    def values
      (@storage[@current_index + 1..-1] + @storage[0..@current_index]).compact
    end

  end
end
