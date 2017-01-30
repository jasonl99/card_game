div.chat-room id=dom_id data-item=dom_id
  div.message-holder id="#{dom_id}-message-holder" data-item="#{dom_id}-message-holder"
    == rendered_messages
  div#.form-holder id="#{dom_id}-form-holder" data-item="#{dom_id}-form-holder"
    == display_form
