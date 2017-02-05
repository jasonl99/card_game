html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script src="/js/app.js"
    // script src="/js/chat.js"
    script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.1.1/jquery.min.js"
    script src="https://cdnjs.cloudflare.com/ajax/libs/webfont/1.6.27/webfontloader.js"
    script src="https://cdnjs.cloudflare.com/ajax/libs/snap.svg/0.4.1/snap.svg-min.js"
    script src="https://cdnjs.cloudflare.com/ajax/libs/underscore.js/1.8.3/underscore-min.js"
    script src="https://cdnjs.cloudflare.com/ajax/libs/js-sequence-diagrams/1.0.6/sequence-diagram-min.js"
    script
      == javascript
  body
    h1 Hi #{user_name}
    - games.each_with_index do |game,index|
      - "<hr>" if index>0
      == game.content
