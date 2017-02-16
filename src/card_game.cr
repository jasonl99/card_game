require "kemal"
require "kilt/slang"
require "colorize"
require "logger"
require "faker"
require "lattice-core"
require "baked_file_system"
require "./card_game/*"

module CardGame

  @@global_stats = GlobalStats.new(name: "global_stats")

  def self.global_stats
    @@global_stats
  end

  @@master_observer = MasterObserver.new name: "MasterObserver"
  class_getter master_observer

  Session.config do |config|
    config.cookie_name = "session_id"
    config.secret = "some_secret"
    config.gc_interval = 2.minutes # 2 minutes
  end

  PublicStorage.files.each do |file|
    puts "Establish path for PublicStorage: #{file.name} / #{file.mime_type} / #{file.size}"
    get file.path do |context|
      context.response.headers["Cache-Control"] = "max-age=#{24*60*60}"
      context.response.content_type = file.mime_type
      file.read
    end
  end

  get "/admin/initialize_storage" do |context|
    Storage.create
  end

  get "/stats" do |context|
    javascript, global_stats = GlobalStats.preload(name: "global_stats", session_id: context.session.id, create: true)
    if global_stats
      global_stats.update_stats
      render "src/card_game/stats.slang"
    end
  end

  get "/cardgame/:game" do |context|
    if (user_name = context.params.query["player_name"]?)
      context.session.string("name",user_name)
    end
    unless (user_name = context.session.string?("name"))
      user_name = Faker::Name.first_name
      context.session.string("name",user_name)
    end
    game_name = context.params.url["game"]
    begin
      javascript, card_game = CardGame.preload(name: game_name, session_id: context.session.id, create: true)
      games = [card_game].compact
      render "src/card_game/games.slang"
    rescue Lattice::Connected::TooManyInstances
      "There are too many games in progress.  Please try again later.  
      And sorry for this crappy unformatted page."
    end
  end

  Lattice::Core::Application.run

end

