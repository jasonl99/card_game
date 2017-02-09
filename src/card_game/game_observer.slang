div.connected-event
  span.direction =event.direction
  span.user      =event_user
  span.sender    =event.sender.class.to_s.split("::").last
  span.dom_item  =event.dom_item
  span.action    =event.action 
