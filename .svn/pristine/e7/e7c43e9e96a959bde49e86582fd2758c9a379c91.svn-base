var MsgUtil = {  
  Show : function(msg,msgType)
  {
    if(!msgType)
    {
      msgType = MsgType.Info;
    }
    switch(msgType)
    {
      case MsgType.Info:
        this.ShowInfo(msg);
        break;
      case MsgType.Warning:
        this.ShowWarning(msg);
        break;
      case MsgType.Error:
        this.ShowError(msg);
        break;
      case MsgType.Fatal:
        this.ShowFatal(msg);
        break;
    }
  },
  
  ShowInfo : function(msg)
  {
    alert("Info:"+msg);
  },
  
  ShowWarning : function(msg)
  {
    alert("Warning:"+msg);
  },
  
  ShowError : function(msg)
  {
    alert("Error:"+msg);
  },
  
  ShowFatal : function(msg)
  {
    alert("Fatal:"+msg);
  },
  
  Confirm : function(msg)
  {
    return confirm(msg);
  }
}

var MsgType = {
  Info : "Info",
  Warning : "Warning",
  Error : "Error",
  Fatal : "Fatal"
}