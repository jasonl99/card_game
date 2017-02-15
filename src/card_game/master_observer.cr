module CardGame
  # This class monitors all games by observing events at the CardGame level
  # so all events across all card games come in.
  class MasterObserver < Lattice::Connected::WebObject

    @game_stats = Hash(String, String | Int32 ).new

    def after_initialize
      CardGame.add_observer(self)
    end

    def game_stats
      @game_stats
    end

    def load_stats
      total_subs = 0
      empty_games = 0
      @game_stats["Games"] = CardGame.instances.size
      CardGame.instances.each do |(instance_name, instance_int)|
        puts "#{instance_int} #{instance_int.class}"
        if (game = CardGame::INSTANCES[instance_int])
          empty_games += 1 if game.subscribers.size == 0
          total_subs += game.subscribers.size
        end
      end
      @game_stats["Maximum Subs"] = total_subs if total_subs > @game_stats.fetch("Maximum Subs",-1).to_i
      @game_stats["Empty Games"] = empty_games
      @game_stats["Total Subs"] = total_subs
      @game_stats["Total Events"] = @game_stats.fetch("Total Events",0).as(Int32) + 1
    end

    def content
      load_stats
      render "src/card_game/master_observer.slang"
    end

    def on_event(event, sender)
      load_stats
      @game_stats.each do |(k,v)|
        update_component k.gsub(" ","-").downcase, v
      end
    end
  end
end
