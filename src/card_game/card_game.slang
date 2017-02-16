div#hand
  - hand.each_with_index do |card,idx|
    span.card-holder
      img.card src=card_image(card) data-item="#{dom_id}-card-#{idx}" data-event-attributes="src" data-events="click"
== chat_room.to_html
div#stats
  span.game-name = "game: #{name}"
  span.cards-remaining
    | Cards Remaining in deck: 
    - # workaround: Slang can't handle quotes in dom_id(""), so use dom_id(%{})
    span data-item="#{dom_id(%[cards-remaining])}"
      = deck.size
h3 GameObserver (events from server's perspective)
== game_observer.to_html
