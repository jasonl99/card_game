div data-item=dom_id data-subscribe=""
  - @game_stats.each do |stat,val|
    - dom = dom_id(stat.gsub(" ","-").downcase)
    div.stat
      span.name = stat
      span.value data-item=dom = val
