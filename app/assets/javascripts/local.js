var blrpgStorage = {
  saveEnabled:false,
  changes:{},
  
  store:function(k, v) {
    if (blrpgStorage.saveEnabled)
    {
      localStorage.setItem(k, v);
    }
    blrpgStorage.changes[k] = v;
  },
  
  load:function(k){
    var value = null;
    if(blrpgStorage.saveEnabled)
    {
      value = localStorage.getItem(k);
    }
    blrpgStorage.changes[k] = value;
    return value;
  },
  
  remove:function(k){
    if(blrpgStorage.saveEnabled)
    {
      localStorage.removeItem(k);
    }
    blrpgStorage.changes[k] = null;
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