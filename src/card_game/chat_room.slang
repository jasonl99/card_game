div.chat-room data-item=dom_id
  div.message-holder data-maxChildren=MAX_MESSAGES data-item="#{dom_id}-message-holder"
    == rendered_messages
  div#.form-holder data-item="#{dom_id}-form-holder"
    == display_form
