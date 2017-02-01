require "faker"
require "kemal"
require "kilt/slang"
require "colorize"
require "logger"
require "faker"
require "lattice-core"
require "./card_game/*"

module CardGame

  Session.config do |config|
    config.secret = "some secret"
  end
  
  get "/cardgames/:games" do |context|
    # if (user_name = context.params.["user_name"])
    puts context.params.inspect
    # if 
    #   context.session.string("name",user_name)
    # end
    unless (user_name = context.session.string?("name"))
      user_name = Faker::Name.first_name
      context.session.string("name",user_name)
    end
    puts "Username is #{user_name}"
    game1, game2 = context.params.url["games"].split(",").first(2)
    javascript, card_game1 = CardGame.preload(name: game1, session_id: context.session.id, create: true)
           js2, card_game2 = CardGame.preload(name: game2, session_id: context.session.id, create: true)
    games = [card_game1, card_game2]
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
    games = [card_game]
    render "src/card_game/games.slang"
  end

  Lattice::Core::Application.run

end

