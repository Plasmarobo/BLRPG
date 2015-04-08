@saveEnabled = false
@changes = {}

$ ->
  @saveAllowed

@store = (key, value) ->
  if @saveEnabled
    localStorage.setItem(key, value)
  @changes[key] = value

@load = (key) ->
  if @saveEnabled
    localStorage.getItem(key, value)
  @changes[key] = value

@saveAllowed = () ->
    if typeof(Storage) !== "undefined"
      savedChanges = localStorage.getItem("blrpg_recovery")
      if savedChanges == null
        @confirmDialog "BLRPG would like to store your changes locally to prevent you from accidently losing work. Not allowing this simply disables recovery mode.",
          () ->
            @saveEnabled = true
    else
      alert("Save games not supported by your browser")