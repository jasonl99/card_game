require "faker"
require "kemal"
require "kilt/slang"
require "colorize"
require "logger"
require "faker"
require "lattice-core"
require "./card_game/*"

module CardGame

  # Session.config do |config|
  #   config.secret = "some secret"
  # end


  Session.config do |config|
    config.cookie_name = "session_id"
    config.secret = "some_secret"
    config.gc_interval = 2.minutes # 2 minutes
  end

  # this is just a workaround until storable_object is fixed in kemal-session
  # class UserStorableObject
  #   JSON.mapping({
  #     id: Int32,
  #     name: String
  #   })
  #   include Session::StorableObject

  #   def initialize(@id : Int32, @name : String); end
  # end
  
  get "/admin/initialize_storage" do |context|
    Storage.create
  end

  get "/stats" do |context|
    javascript, global_stats = GlobalStats.preload(name: "global_stats", session_id: context.session.id, create: true)
    if global_stats
      render "src/card_game/stats.slang"
    end
    # javascript, card_game1 = CardGame.preload(name: game1, session_id: context.session.id, create: true)
  end

  get "/dbtest" do |context|
    Storage.connection.exec "insert into page_hit (page) values (?)", "/dbtest"
  end

  get "/cardgames/:games" do |context|
    unless (user_name = context.session.string?("name"))
      user_name = Faker::Name.first_name
      context.session.string("name",user_name)
    end
    puts "Username is #{user_name}"
    game1, game2 = context.params.url["games"].split(",").first(2)
    javascript, card_game1 = CardGame.preload(name: game1, session_id: context.session.id, create: true)
           js2, card_game2 = CardGame.preload(name: game2, session_id: context.session.id, create: true)
    games = [card_game1, card_game2].compact
    render "src/card_game/games.slang"
  end

  get "/cardgame/:game" do |context|
    if (user_name = context.params.query["player_name"]?)
      context.session.string("name",user_name)
    end
    unless (user_name = context.session.string?("name"))
      user_name = Faker::Name.first_name
      context.session.string("name",user_name)
    end
    puts "Username is #{user_name}"
    game_name = context.params.url["game"]
    javascript, card_game = CardGame.preload(name: game_name, session_id: context.session.id, create: true)
    games = [card_game].compact
    render "src/card_game/games.slang"
  end

  Lattice::Core::Application.run

end

