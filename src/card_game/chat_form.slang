div.chat-form 
  form data-item="#{dom_id}-chat-form" autocomplete="false" data-track="submit"
    div.input-wrapper
      input data-track="input" type="text" data-item="#{dom_id}-msg" id="new-msg" placeholder="say something!" name="new-msg" autocomplete="off"
    div.button-wrapper
      input type="button" value="speak" disabled=true data-item="#{dom_id}-chatname"
