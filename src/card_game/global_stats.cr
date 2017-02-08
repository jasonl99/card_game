module CardGame
  class GameStat < Lattice::Connected::WebObject

    property players : String?
    property connections : Int32?
    property game : String?

    def set(@game, @connections, @players)
    end

    def table_row
      render ".src/card_game/game_stat_tr.slang"
    end

    def content
      "<div data-item='#{dom_id}'>
      <span>#{@game}</span>
      <span>#{@connections}</span>
      <span>#{@players}</span>
      </div>"
    end
  end

  class GlobalStats < Lattice::Connected::WebObject
    def game_stats
      stats = {} of String=>Hash(String, String | Int32)
      sql = "select game, 
          group_concat(distinct player) as players, 
          count(*) as subscribed_count
          from player_game
          group by game
          order by started desc
          limit 40"
      Storage.connection.query(sql) do |rs|
        rs.each do
          game = rs.read(String)
          players = rs.read(String)
          connections = rs.read(Int32)
          @children[game] = GameStat.child_of(self)
          @children[game].as(GameStat).set game, connections, players
          stats[game] = {"players"=>players, "connections"=>connections}
        end
      end
      stats
    end
  end
end
