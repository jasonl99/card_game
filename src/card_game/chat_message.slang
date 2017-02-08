div.chat-message data-item=dom_id
  span.name
    = name
  span.time
    = time.to_s("%I:%M:%S %p")
  span.msg
    = message
