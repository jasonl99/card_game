div data-item=dom_id data-subscribe=""
  - @game_stats.each do |stat,val|
    div.stat
      span.name = stat
      span.value = val
