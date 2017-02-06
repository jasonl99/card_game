div data-version=version data-item=dom_id data-subscribe=""
  div#hand
    - hand.each_with_index do |card,idx|
      span.card-holder
        img.card src=card_image(card) data-item="#{dom_id}-card-#{idx}" data-event-attributes="src" data-events="click"
  div#chat-room
    == chat_room.content
  div#stats
    span.game-name = "game: #{name}"
    span.cards-remaining
      | Cards Remaining in deck: 
      span data-item="#{dom_id}-cards-remaining"
        = deck.size
div data-item=game_observer.dom_id data-subscribe=""
