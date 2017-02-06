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
h3 GameObserver (events sent and received by the server)
div.observed-events data-item=game_observer.dom_id data-subscribe="" data-maxChildren=GameObserver::MAX_ITEMS
  div.connected-event
    span.header.user User 
    span.header.sender Sender
    span.header.dom_item Target
    span.header.action Action
  == game_observer.content
