div id=dom_id data-version=version data-item=dom_id
  div#hand
    - hand.each_with_index do |card,idx|
      span.card-holder
        img.card src=card_image(card) data-item="#{dom_id}-card-#{idx}" id="#{dom_id}-card-#{idx}"  data-track="click,mouseenter,mouseleave"
  div#chat-room
    == chat_room.content
  div#stats
    span.game-name = "game: #{name}"
    span.cards-remaining
      | Cards Remaining in deck: 
      span id="#{dom_id}-cards-remaining" data-item="#{dom_id}-cards-remaining"
        = deck.size
