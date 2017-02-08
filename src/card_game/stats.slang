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
            th Last Connected
            th Players

        tbody
          == global_stats.items.values.map(&.as(GameStat)).map(&.table_row).join
