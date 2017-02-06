html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script src="/js/app.js"
    // script src="/js/chat.js"
    script
      == javascript
  body
    h1 Hi #{user_name}
    - games.each_with_index do |game,index|
      - "<hr>" if index>0
      == game.content
