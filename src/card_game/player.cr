class Player < Lattice::BasicUser
  @name : String?

  def timeout 
    puts "Player #{name} has left the table."
  end

  def load
    @name = @session.as(Session).string?("name") || "Visitor" if @session
  end

  def name=(@name)
    @session.as(Session).string("name",@name.as(String)) if @session && @name
  end
  def name 
    @name ||= session_string("name","Visitor").as(String)
    @name.as(String)
  end

  # TODO macros for each type
  def session_string( key : String, default ) : String
    if @session
      @session.as(Session).string?(key).as(String)
    else
      default
    end
  end


end
