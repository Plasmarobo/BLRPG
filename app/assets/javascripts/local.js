var blrpgStorage = {
  saveEnabled:false,
  changes:{},
  
  store:function(key, value) {
    if (blrpgStorage.saveEnabled)
    {
      localStorage.setItem(key, value);
    }
    blrpgStorage.changes[key] = value;
  },
  
  load:function(key){
    var value = null;
    if(blrpgStorage.saveEnabled)
    {
      value = localStorage.getItem(key);
    }
    blrpgStorage.changes[key] = value;
    return value;
  },
  
  remove:function(key){
    if(blrpgStorage.saveEnabled)
    {
      localStorage.removeItem(key);
    }
    blrpgStorage.changes[key] = null;
  },
  
  saveAllowed:function(){
    var savedChanges = null;
    if (typeof(Storage) !== "undefined")
    {
      savedChanges = localStorage.getItem("saveEnabled");
      if (savedChanges == null)
      {
        blrpgWindows.confirmDialog("BLRPG would like to store your changes locally to prevent you from accidently losing work. Not allowing this simply disables recovery mode.",
          function(){blrpgStorage.saveEnabled = true; localStorage.setItem("saveEnabled", "true");});
      }
      else
      {
        blrpgStorage.saveEnabled = true;
      }
    }
    else
    {
      alert("Save games not supported by your browser");
    }
  },
};

$.ready(blrpgStorage.saveAllowed);