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
    == card_game.content(session_id: context.session.id)
    /* hr */
    /* == card_game2.content */
