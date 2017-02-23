class Player < Lattice::BasicUser
  @name : String?

  def timeout 
    puts "Player #{name} has left the table."
  end

  def default_name
    Faker::Name.first_name
  end

  def load
    if @session
      @name = @session.as(Session).string?("name")
    end
    unless @name
      @name = default_name
      save
    end

  end

  def save
    if (session = @session )
      session.string("name",@name.as(String)) if @name
    end
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
    if (session = @session) && (key = session.as(Session).string?(key))
      key.as(String)
      # @session.as(Session).string?(key).as(String)
    else
      default
    end
  end


end
