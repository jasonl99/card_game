html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script type="text/javascript" src="/js/app.js"
    script
      == javascript
  body
    div#stats-table
      div.header
        div
          span.header.game Game
          span.header.connections Connections
          span.header.last-connected Last Subscribed
          span.header.players Players

     div.data data-item=global_stats.dom_id data-subscribe="" 
       == global_stats.content
       /* == global_stats.items.values.map(&.as(GameStat)).map(&.content).join */
