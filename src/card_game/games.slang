html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script type="text/javascript" src="/js/app.js"
    script
      == javascript
  body
    == master_observer.to_html
    div#games
      - games.each_with_index do |game,index|
        - "<hr>" if index>0
        == game.to_html
