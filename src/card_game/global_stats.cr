module CardGame
  class GameStat < Lattice::Connected::WebObject

    property players : String?
    property connections : Int32?
    property game : String?
    property last_connected : String?

    def set(@game, @connections, @players, @last_connected)
    end

    def table_row
      render "./src/card_game/game_stat_tr.slang"
    end

  end

  class GlobalStats < Lattice::Connected::Container(GameStat)

    def update_stats
      sql = "select game, group_concat(distinct player), 
        count(*),
        max(datetime(started,'unixepoch','localtime'))
        from player_game
        group by game
        order by started desc
        limit #{@max_items}"

      Storage.connection.query(sql) do |rs|
        rs.each do
          game = rs.read(String)
          players = rs.read(String)
          connections = rs.read(Int32)
          last_connected = rs.read(String)
          item = GameStat.child_of(self)
          item.set game, connections, players, last_connected
          @items << item
        end
      end
    end
  end
end
