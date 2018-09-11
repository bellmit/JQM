//菜单状态
var JSMenuState = 
{
  Normal : 1,
  Focused : 2
}

//菜单动作
var JSMenuAction = 
{
  swapIframePageDisplay : function(display)
  {
	 var iframePage = $id("iframePage");
	 var pageHref = iframePage.contentWindow.location.href;
     if (pageHref.indexOf("com.crc.eos.pet.sft.projectInformation.flow")   != -1
      || pageHref.indexOf("com.crc.eos.pet.sft.dueDiligenceResearch.flow") != -1
      || pageHref.indexOf("com.crc.eos.pet.sit.detailInfoSIT.flow")        != -1
      || pageHref.indexOf("com.crc.eos.pet.sft.detailInfoSFT.flow")        != -1
      || pageHref.indexOf("com.crc.eos.pet.sit.projectElementsMake.flow")  != -1
      || pageHref.indexOf("com.crc.eos.pet.sit.dueDiligenceResearch.flow") != -1
      || pageHref.indexOf("com.crc.eos.pet.sit.investmentManger.flow") != -1)
     {
        iframePage.style.visibility = display ? "visible" : "hidden";
     }
  },
  
  //为iframe的url路径添加随机数
  wrapRandUrlPara : function()
  {
     var date = new Date();
     return "pageParaObj/time=" + date.getTime() + "." + Math.random();
  },
  
  onClick : function(jsmenu)
  {
    var pm = jsmenu;
    while(!pm.isRootMenu())
    {
      pm = pm.parentMenu;
    }
    var menuBar = pm.menuBar;
    menuBar.activeMenu = pm;
    
    if(!jsmenu.isLeafMenu())
    {
      //有子级菜单：展示子菜单
      if(jsmenu.isExpand)
      {
        //do collapse
        jsmenu.hideChildren();
        this.swapIframePageDisplay(true);
      }else{
        //do expand
	    jsmenu.showChildren();
        this.swapIframePageDisplay(false);
      }
    }else{
      //无子级菜单：执行动作
      var pageurl = "";
      if(jsmenu.url.indexOf("?") == -1)
      {
         pageurl = jsmenu.url + "?";
      }else{
         pageurl = jsmenu.url + "&";
      }
      
      pageurl += "pageParaObj/pageName=" + jsmenu.text;
      pageurl += "&" + this.wrapRandUrlPara();
      if(jsmenu.urlTarget == "iframePage")
      {
        //在主框架中打开
        $id(jsmenu.urlTarget).src = contextPath + "/" + pageurl;
      }else if(jsmenu.urlTarget == "newDialog"){
        //在弹出窗口中打开
        DialogUtil.showModalCenter(contextPath + "/" + pageurl,null,null,jsmenu.dialogWidth,jsmenu.dialogHeight,jsmenu.text);
      }else{
        //未找到打开方式
        alert("page open type of this menu not set yet.");
      }
      
      var pm = jsmenu;
      while(!pm.isRootMenu())
      {
        pm = pm.parentMenu;
        pm.hideChildren();
      }
      var menuBar = pm.menuBar;
      menuBar.setFocusedMenu(pm);
      
      this.swapIframePageDisplay(true);
    }

    
    if(jsmenu.isRootMenu())
    {
      //主菜单：关闭其它展开的子菜单
      for(var i=0;i<jsmenu.menuBar.childMenus.length;i++)
      {
        if(jsmenu.id != jsmenu.menuBar.childMenus[i].id && jsmenu.menuBar.childMenus[i].isExpand)
        {
          jsmenu.menuBar.childMenus[i].hideChildren();
        }
      }
    }else{
      //子菜单：关闭其它展开的子菜单
      for(var i=0;i<jsmenu.parentMenu.childMenus.length;i++)
      {
        if(jsmenu.id != jsmenu.parentMenu.childMenus[i].id && jsmenu.parentMenu.childMenus[i].isExpand)
        {
          jsmenu.parentMenu.childMenus[i].hideChildren();
        }
      }
    }

    event.cancelBubble = true;
    
  },
  
  onMouseOver : function(jsmenu)
  {
    jsmenu.menuObject.className = (jsmenu.isRootMenu() ? "JSMenu_Root_Over" : "JSMenu_Child_Over");
  },
  
  onMouseOut : function(jsmenu)
  {
    if(jsmenu.state != JSMenuState.Focused)
    {
      jsmenu.menuObject.className = (jsmenu.isRootMenu() ? "JSMenu_Root_Normal" : "JSMenu_Child_Normal");
    }
  }
}

//菜单栏
function JSMenuBar()
{
  this.childMenus = [];
  this.container = null;
  this.containerId = "";
  this.focusedMenu = null;
  this.activeMenu = null;
  
  this.setContainerId = function(_id)
  {
    this.containerId = _id;
  };
  this.setContainer = function(_container)
  {
    this.container = _container;
  };
  this.addMenu = function(_menu)
  {
    _menu.menuBar = this;
    this.childMenus.add(_menu);
  };
  
  //显示菜单栏中的各主菜单
  this.show = function()
  {
    var menuBarDiv = null;
    if(this.container == null)
    {
      if(this.containerId != "")
      {
        this.container = $id(this.containerId);
      }
    }
    if(this.container == null)
    {
      alert("JSMenuBar's container not set yet!");
      return;
    }
    var menuHTML = "";
    for(var i=0;i<this.childMenus.length;i++)
    {
      this.container.appendChild(this.childMenus[i].getObject());
    }
  };
  
  //设置菜单栏中当前选中主菜单
  this.setFocusedMenu = function(_jsmenu)
  {
    if(this.focusedMenu != null)
    {
      this.focusedMenu.setState(JSMenuState.Normal);
    }
    _jsmenu.setState(JSMenuState.Focused);
    this.focusedMenu = _jsmenu;
  };
}

//菜单
function JSMenu()
{
  this.container = null;
  this.id = "";
  this.name = "";
  this.text = "";
  this.state = JSMenuState.Normal;
  this.isExpand = false;
  this.url = "";
  this.urlTarget = "";
  this.relaObject = null;
  this.childMenus = [];
  this.parentMenu = null;
  this.menuObject = null;
  this.childrenObject = null;
  this.menuBar = null;
  
  this.setContainer = function(_container){this.container = _container;};
  this.setId = function(_id){this.id = _id;};
  this.setName = function(_name){this.name = _name;};
  this.setText = function(_text){this.text = _text;};
  this.setUrl = function(_url){this.url = _url;};
  this.setUrlTarget = function(_urlTarget){this.urlTarget = _urlTarget;};
    
  //是否叶子菜单
  this.isLeafMenu = function()
  {
    return this.childMenus.length == 0 && this.url != "";
  };
  
  //是否根菜单
  this.isRootMenu = function()
  {
    return this.parentMenu == null;
  };
  
  //设置菜单状态（选中/非选中）并显示相关样式
  this.setState = function(_state)
  {
    this.state = _state;
    if(this.menuObject != null)
    {
	  switch(_state)
	  {
	  case JSMenuState.Normal:
	    this.menuObject.className = "JSMenu_Root_Normal";
	    break;
	  case JSMenuState.Focused:
	    this.menuObject.className = "JSMenu_Root_Focused";
	    break;
	  }
    }
  };
  
  //设置菜单相关数据
  this.setRelaObject = function(_obj){this.relaObject = _obj;};
  
  //追加子菜单
  this.addMenu = function(_jsmenu)
  {
    this.childMenus.add(_jsmenu);
    _jsmenu.parentMenu = this;
  };
  
  //返回本菜单对象对应的HTML对象
  this.getObject = function(maxChar)
  {
    var divMenu = document.createElement("div");
    if(this.isRootMenu())
    {
        //是根菜单
	    switch(this.state)
	    {
	    case JSMenuState.Normal:
	      divMenu.className = "JSMenu_Root_Normal";
	      break;
	    case JSMenuState.Focused:
	      divMenu.className = "JSMenu_Root_Focused";
	      break;
	    }
    }else{
        //是子菜单
	    switch(this.state)
	    {
	    case JSMenuState.Normal:
	      divMenu.className = "JSMenu_Child_Normal";
	      break;
	    case JSMenuState.Focused:
	      divMenu.className = "JSMenu_Child_Focused";
	      break;
	    }
    }
    divMenu.JSObject = this;
    divMenu.attachEvent("onclick",    function(){JSMenuAction.onClick(divMenu.JSObject);});
    divMenu.attachEvent("onmouseover",function(){JSMenuAction.onMouseOver(divMenu.JSObject);});
    divMenu.attachEvent("onmouseout", function(){JSMenuAction.onMouseOut(divMenu.JSObject);});
    
    var divMenuLeft = document.createElement("div");
    divMenuLeft.id = "divMenuLeft";
    divMenu.appendChild(divMenuLeft);
    
    var divMenuCenter = document.createElement("div");
    divMenuCenter.id = "divMenuCenter";
    if(maxChar != null)
    {
        //divMenuCenter.style.width = (maxChar * 14 + 16) + "px";
        //divMenu.style.width = (maxChar * 14 + 16 + 8) + "px";
        
        divMenuCenter.style.width = (maxChar * 18 + 10) + "px";
        divMenu.style.width = (maxChar * 18 + 10 + 8) + "px";
    }
    var txtMenuText = document.createTextNode(this.text);
    divMenuCenter.appendChild(txtMenuText);
    if(!this.isLeafMenu())
    {
      //非叶子菜单
      var imgMenuArrow = document.createElement("img");
      imgMenuArrow.style.width = "11px";
      imgMenuArrow.style.height = "16px";
      imgMenuArrow.style.marginTop = "2px";
      if(this.isRootMenu())
      {
        //是根菜单
        imgMenuArrow.src = contextPath + "/images/skinphfund/menu_arrow_down.gif";
      }else{
        //是子菜单
        imgMenuArrow.src = contextPath + "/images/skinphfund/menu_arrow_right.gif";
      }
      divMenuCenter.appendChild(imgMenuArrow);
    }
    divMenu.appendChild(divMenuCenter);
    
    var divMenuRight = document.createElement("div");
    divMenuRight.id = "divMenuRight";
    divMenu.appendChild(divMenuRight);
    
    this.menuObject = divMenu;
    
    return divMenu;
  };
  
  //获取子菜单最大字符数
  this.getChildMenuMaxCharNum = function()
  {
      var maxChar = 0;
      for(var i=0;i<this.childMenus.length;i++)
	  {
	      maxChar = Math.max(maxChar,this.childMenus[i].text.length + (this.childMenus[i].isLeafMenu() ? 0 : 1));
	  }
	  return maxChar;
  };
  
  //显示子菜单
  this.showChildren = function()
  {
	    var parentLeft = 0;
	    var parentTop = 0;
	    var parentObj = this.menuObject;
	    while(parentObj != null && parentObj.tagName != "BODY")
	    {
	      parentLeft += parentObj.offsetLeft;
	      parentTop += parentObj.offsetTop;
	      parentObj = parentObj.parentNode;
	    }
	    var divChildren = document.createElement("div");
	    
	    var maxChar = this.getChildMenuMaxCharNum();
	    for(var i=0;i<this.childMenus.length;i++)
	    {
	      divChildren.appendChild(this.childMenus[i].getObject(maxChar));
	    }
	    divChildren.style.position = "absolute";
	    if(this.isRootMenu())
	    {
	      //是根菜单：主菜单打开子菜单
	      divChildren.style.left = parentLeft;
	      divChildren.style.top  = parentTop + this.menuObject.offsetHeight;
	    }else{
	      //是子菜单：子菜单打开子菜单
	      divChildren.style.left = parentLeft + this.menuObject.childNodes[1].clientWidth + 6;
	      divChildren.style.top  = parentTop;
	    }
	    this.childrenObject = divChildren;
	    document.body.appendChild(divChildren);
	    this.isExpand = true;
  };
  
  //关闭子菜单
  this.hideChildren = function()
  {
    if(this.childrenObject != null)
    {
      if(!this.isLeafMenu())
      {
        for(var i=0;i<this.childMenus.length;i++)
        {
          this.childMenus[i].hideChildren();
        }
      }
      document.body.removeChild(this.childrenObject);
      this.childrenObject = null;
    }
    this.isExpand = false;
  };
}