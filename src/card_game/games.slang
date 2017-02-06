html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"
    script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/webfont/1.6.27/webfontloader.js"
    script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.4.1/snap.svg-min.js"
    script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"
    script src="/js/sequence-diagram-min.js"
    script type="text/javascript" src="/js/app.js"
    // script src="/js/chat.js"
    script
      == javascript
  body
    div#games
      - games.each_with_index do |game,index|
        - "<hr>" if index>0
        == game.content
