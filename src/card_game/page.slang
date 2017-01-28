html
  head
    meta charset="UTF-8"
    link rel="stylesheet" type="text/css" href="/css/style.css"
    script
      == javascript
    script src="/js/app.js"
  body
    h1 Hi #{name}
    == card_game.content
    hr
    == card_game2.content
