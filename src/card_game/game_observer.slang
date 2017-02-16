div.observed-events
  div.connected-event.header
    span.header.direction In/Out
    span.header.user User 
    span.header.sender WebObject
    span.header.dom_item DOM Target
    span.header.action Action
div.observed-events data-item=dom_id(%{items})
  == item_content
