div id=dom_id data-version=version
  div#hand
    - hand.each_with_index do |card,idx|
      span.card-holder
        img.card src=card_image(card) id="#{dom_id}-card-#{idx}" data-track="click,pointerover"
  div#chat-room
    == chat_room.content
  div#stats
    span.game-name = "game: #{name}"
    | Cards Remaining in deck: 
    span id="#{dom_id}-cards-remaining"
      = deck.size
