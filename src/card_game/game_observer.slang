div.connected-event
  span.direction =connected_event.direction
  span.user      =connected_event.event_user
  span.sender    =connected_event.sender.class.to_s.split("::").last
  span.dom_item  =connected_event.dom_item
  span.action    =connected_event.action 
