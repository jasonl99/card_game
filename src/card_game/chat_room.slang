div.chat-room data-item=dom_id
  div.message-holder data-maxChildren=max_items data-item="#{dom_id}-message-holder"
    == item_content
  div#.form-holder data-item="#{dom_id}-form-holder"
    == display_form
