require "kemal"
require "kilt/slang"
require "colorize"
require "logger"
require "faker"
require "lattice-core"
require "baked_file_system"
require "./card_game/*"

puts "kemal-session config"
Session.config do |config|
  config.timeout = 1.hour
  config.cookie_name = "session_id"
  config.secret = "some_secret"
  config.gc_interval = 30.minutes
end
puts "kemal-session config finished"

module CardGame

  @@master_observer = MasterObserver.new name: "MasterObserver"
  class_getter master_observer


  PublicStorage.files.each do |file|
    puts "Establish path for PublicStorage: #{file.name} / #{file.mime_type} / #{file.size}"
    get file.path do |context|
      context.response.headers["Cache-Control"] = "max-age=#{24*60*60}"
      context.response.content_type = file.mime_type
      file.read
    end
  end

  Lattice::Core::Application.route_socket(user_class: Player)

  get "/cardgame/:game" do |context|
    player = Player.find_or_create(context.session.id)
    user_name = player.name
    game_name = context.params.url["game"]
    @@master_observer.refresh
    begin
      card_game = CardGame.find_or_create(game_name).as(CardGame)
      games = [card_game].compact
      render "src/card_game/games.slang"
    rescue Lattice::Connected::TooManyInstances
      "There are too many games in progress.  Please try again later.  
      And sorry for this crappy unformatted page."
    end
  end

  Lattice::Core::Application.run

end

