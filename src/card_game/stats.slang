html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script type="text/javascript" src="/js/app.js"
    script
      == javascript
  body
    div data-item=global_stats.dom_id data-subscribe=""
      table
        thead
          tr
            th Game
            th Connections
            th Players

        tbody
        - global_stats.as(GlobalStats).game_stats.each do |game, values|
          tr
            td = game
            td = values["connections"]
            td = values["players"]
      == global_stats.children.values.map(&.as(GameStat)).map(&.content).join
