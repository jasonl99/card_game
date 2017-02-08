require "db"
require "sqlite3"
module CardGame
  class Storage
    @@file = "sqlite3:./card_game.db"
    @@connection : DB::Database = DB.open(@@file)

    def self.connection
      @@connection
    end

    def self.close
      @@connection.close if @@connection
    end

    #TODO Sanity check for already-iniited db.
    def self.create
      begin
        connection.exec "create table settings (name string not null, value string not null)"
        connection.exec "create table player_game(player string not null, game string not null, started timestamp not null default (strftime('%s','now')))"
        connection.exec "create table page_hit (page text not null, occurred timestamp not null default (strftime('%s','now')))"
        connection.exec "insert into settings values (?,?)", "Initialized", Time.now
      rescue
        puts "Error with db"
      end
    end

  end
end
