div.chat-room id=dom_id
  div.message-holder id="#{dom_id}-message-holder" data-track
    == rendered_messages
  div#.form-holder id="#{dom_id}-form-holder"
    == display_form
