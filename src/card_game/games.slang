html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script type="text/javascript" src="/js/app.js"
    script
      == javascript
  body
    div.fixed-stats data-item=::CardGame.master_observer.dom_id
    div#games
      - games.each_with_index do |game,index|
        - "<hr>" if index>0
        == game.rendered_content
