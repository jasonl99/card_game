div id=dom_id data-version=version
  div#hand
    - hand.each_with_index do |card,idx|
      button.card id="#{dom_id}-card-#{idx}"
        = card 
  div#stats
    | Cards Remaining in deck: 
    span id="#{dom_id}-cards-remaining"
      = deck.size
