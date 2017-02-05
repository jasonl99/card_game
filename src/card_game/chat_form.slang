div.chat-form 
  form data-item="#{dom_id}-chat-form" autocomplete="false" data-events="submit"
    div.input-wrapper
      input data-events="xinput" type="text" data-item="#{dom_id}-msg" id="new-msg" placeholder="say something!" name="new-msg" autocomplete="off"
    div.button-wrapper
      input type="button" name="player_name" value="speak" disabled=true data-item="#{dom_id}-chatname"
