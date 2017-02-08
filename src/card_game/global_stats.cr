module CardGame
  class GlobalStats < Lattice::Connected::WebObject
    def get_data
      game_stats = {} of String=>Hash(String,String | Int32)
      sql = "select game, 
          group_concat(distinct player) as players, 
          count(*) as subscribed_count
          from player_game
          group by game
          order by started desc"
      Storage.connection.query(sql) do |rs|
        rs.each do
          game = rs.read(String)
          players = rs.read(String)
          connections = rs.read(Int32)
          game_stats[game] = {"players"=>players, "connections"=>connections}
        end
      end
      game_stats
    end
  end
end
