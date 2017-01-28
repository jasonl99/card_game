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
  
  get "/cardgame/:game" do |context|
    unless (name = context.session.string?("name"))
      name = Faker::Name.first_name
      context.session.string("name",name)
    end
    game_name = context.params.url["game"]
    javascript, card_game = CardGame.preload(name: game_name, session_id: context.session.id, create: true)
    javascript2, card_game2 = CardGame.preload(name: "second", session_id: context.session.id, create: true)
    render "src/card_game/page.slang"
  end

  Lattice::Core::Application.run

end

