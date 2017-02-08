div.chat-message
  span.name
    = name
  span.time
    = time.to_s("%I:%M:%S %p")
  span.msg
    = message
