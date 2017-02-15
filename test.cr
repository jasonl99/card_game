abstract class Parent
  property home = "United States"
end

abstract class Child < Parent
end

class GrandChild < Child
	def initialize
    @home = "Boston"
	end
end

g = GrandChild.new

