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
  config.timeout = 30.seconds
  config.cookie_name = "session_id"
  config.secret = "some_secret"
  config.gc_interval = 15.seconds
end
puts "kemal-session config finished"

module CardGame

  @@global_stats = GlobalStats.new(name: "global_stats")

  def self.global_stats
    @@global_stats
  end

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


  # get "/stats" do |context|
  #   javascript, global_stats = GlobalStats.preload(name: "global_stats", session_id: context.session.id, create: true)
  #   global_stats = GlobalStats.find_or_create("global_stats")
  #   javascript = global_stats.javascript
  #   if global_stats
  #     global_stats.update_stats
  #     render "src/card_game/stats.slang"
  #   end
  # end

  get "/cardgame/:game" do |context|
    player = Player.find_or_create(context.session.id)
    user_name = player.name
    game_name = context.params.url["game"]
    begin
#      javascript, card_game = CardGame.preload(name: game_name, session_id: context.session.id, create: true)
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

