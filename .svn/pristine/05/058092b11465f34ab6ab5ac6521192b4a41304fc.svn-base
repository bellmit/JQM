	
/* 设置页面只读 */
function g_SetPageReadonly()
{
  var inputs = document.getElementsByTagName("input");
  for(var i=0;i<inputs.length;i++)
  {
    var input = inputs[i];
    if(input.type == "text")
    {
      input.className = "g_txtReadonlyUnderline";
      input.readOnly = true;
    }else if(input.type == "button" || input.type == "submit" || input.type == "reset"){
      if(input.value == "返回")
      {
        //返回按钮不处理
      }else{
        input.style.display = "none";
      }
    }else if(input.type == "checkbox" || input.type == "radio"){
      //input.disabled = true;
      //隐藏选择框
      input.style.visibility = "hidden";
      if(!input.checked)
      {
      	if(input.nextSibling.nextSibling.tagName == "SPAN")
      	{
      		//未选中状态下，将选择框后的SPAN文本置为灰色
        	input.nextSibling.nextSibling.style.color = "silver";
      	}
      }
    }
  }
  
  var selects = document.getElementsByTagName("select");
  for(var i=0;i<selects.length;i++)
  {
    var select = selects[i];
    //select.disabled = true;
    //将select元素替换为SPAN文本
    var replaceLabel = document.createElement("SPAN");
    replaceLabel.innerText = select.options[select.selectedIndex].text;
    select.outerHTML = replaceLabel.outerHTML;
  }
  
  var textareas = document.getElementsByTagName("textarea");
  for(var i=0;i<textareas.length;i++)
  {
    var textarea = textareas[i];
    textarea.readOnly = true;
    textarea.className = "g_txtReadonlyUnderline";
  }
  
  var imgs = document.getElementsByTagName("img");
  for(var i=0;i<imgs.length;i++)
  {
    var img = imgs[i];
    if(img.className == "eos-ic-button")
    {
      img.style.display = "none";
    }
  }
}

/* 自动调整模式窗口大小 */
function g_autoResizeModalWin()
{
  window.resize(Math.min(document.body.scrollWidth + 34 + 3
                        ,window.parent.document.body.clientWidth - 80 + 3)
               ,Math.min(document.body.scrollHeight +34 + 3
                        ,window.parent.document.body.clientHeight - 50 + 3));
  window.moveCenter();
  PageParameter.HasResetHeight = true;
}



/*页面高度调整*/
function g_refreshHeight()
{
  var minHeight = 0;// window.parent.document.getElementById("tdLeft").scrollHeight;
  var maxHeight = Math.max(minHeight,document.body.scrollHeight+10);
  window.parent.setIframeHeight(window.frameElement.id,maxHeight);
}

/* 表格单元格行合并 */
/* @para tableId : 表格ID */
/* @para condCol : 条件列列号 */
/* @para mergeCols : 需合并列列号数组 */
/* @para ignoreLastRow : 是否忽略最后一行 */
/* 例：g_mergeTableCellsRowspan("tableTodoList",0,[0,1,2]); */
function g_mergeTableCellsRowspan(tableId,condCol,mergeCols,ignoreLastRow)
{
  var table = $id(tableId);
  var rows = table.rows.length;
  if(rows == 1)
  {
    return;
  }
  if(ignoreLastRow)
  {
    rows--;
  }
  var prevCondStr = "";
  var currCondStr = "";
  for(var row=1;row<rows;row++)
  {
    prevCondStr = table.rows[row].cells[condCol].innerText.trim();
    var findEnd = false;
    var newrow = row + 1;
    for(; newrow<rows && !findEnd;)
    {
      currCondStr = table.rows[newrow].cells[condCol].innerText.trim();
      findEnd = (currCondStr != prevCondStr);
      if(!findEnd)
      {
        newrow++;
      }
    }
    var mergeRows = newrow - row;
    if(mergeRows > 1)
    {
      for(var i=mergeCols.length-1;i>=0;i--)
      {
        table.rows[row].cells[mergeCols[i]].rowSpan = mergeRows;
      }
      for(var r=row+1;r<newrow;r++)
      {
        for(var i=mergeCols.length-1;i>=0;i--)
        {
          table.rows[r].cells[mergeCols[i]].removeNode(true);
        }
      }
    }
    row = newrow - 1;
  }
}

/* 全选checkGroup */
function g_doSelectAll(ckb,checkgroupId)
{
  var isChecked = ckb.checked;
  var checkgroup = $id(checkgroupId);
  if(isChecked)
  {
    checkgroup.selectAll();
  }else{
    checkgroup.disSelectAll();
  }
}
/* 取消全选 */
function g_doDisSelect(ckbId)
{
  $id(ckbId).checked = false;
}

//数据字典选择框联动
//selectedControl被选择的控件
//changeControlList需联动的控件列表
//dictList需联动的控件对应的数据字典列表
function g_combSelet(selectedControl,changeControlList,dictList)
{
	for(var i = 0;i<changeControlList.length;i++)
	{
		var myAjax = new Ajax("com.crc.eos.pet.com.utils.dictChildInfoQueryByType.getChildDictInfoQueryByType.biz");
            //添加参数, 第一个为参数名, 第二个为参数值)
            myAjax.addParam("parentDictId",selectedControl.value);
            myAjax.addParam("childDictTypeId",dictList[i]);
            
            //开始调用
            myAjax.submit();

            //取得调用后的结果
            var entrieID = myAjax.getValues("root/data/entries/dictID")
			var entrieName = myAjax.getValues("root/data/entries/dictName")
			
			//清除控件原来选项
			for(var k = changeControlList[i].options.length -1 ;k>= 0 ;k--)
			{
				changeControlList[i].options.remove(k);
			}
			
			//添加变动后选项
			for(var k = 0;k<entrieID.length;k++)
			{
				var option = new Option(entrieName[k],entrieID[k]);
				changeControlList[i].options.add(option);
			}
		}
}

/* 判断singlecode是否包含在allcodes中 */
function g_IsCodeIn(allcodes,singlecode)
{
	var isIn = false;
	var allCodesArr = allcodes.split(",");
	for(var i=0;i<allCodesArr.length;i++)
	{
		if(allCodesArr[i] == singlecode)
		{
			isIn = true;
			break;
		}
	}
	return isIn;
}
/*******************************************************
 *@function : 根据数据区域调整窗口大小
 *@params   : 无
 *@return   : 无
 *@for      : crc_pet_com_busi/dataChoose.jsp
 *@desc     : 自动调整窗口大小并居中
 *******************************************************
 *@author   : 2010-04-02 chendong 创建
 *******************************************************/
function g_autoResize()
{
  window.resize(document.body.scrollWidth,Math.min(document.body.scrollHeight+34,400));
  window.moveCenter();
}
/*******************************************************
 *@function : 显示底色改变
 *@params   : 当前时点，要求经办时点
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_color(nNowTime,nLogTime)
{
	var temp = nLogTime-nNowTime ;
	var returnColor = "";
	if(temp < 0)
	{
		returnColor = "#FFB6C1";
	}else if(temp < 30)
	{
		returnColor ="#FFA500";
	}else if(temp < 60)
	{
		returnColor = "#FFFF99";
	}
	return returnColor;
}
/*******************************************************
 *@function : 显示底色改变
 *@params   : 当前时点，要求经办时点
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_colorRemind(nLogTime,nFinishMoment)
{
	var temp = nLogTime-nFinishMoment ;
	var returnColor = "";
	if(temp < 0)
	{
		returnColor = "#DDA0DD";
	}
	return returnColor;
}
/*******************************************************
 *@function : 将时间转变为分钟
 *@params   : 时点
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_convertToMinite(nMoment)
{
	var hour = nMoment.toString().substr(0,2) * 60;
	var minite = nMoment.toString().substr(2,4) * 1;
	return hour + minite;
}
/*******************************************************
 *@function : 将时间转变为分钟
 *@params   : 用户名
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_checkUserIsInHoliday(userId,userName)
{
	var isInHoliday=false;
	if(userId !=null&&userId!="")
	{
		var myAjax= new Ajax('com.phfund.clear.sys.holidaySetting.checkUserIsInHoliday.biz');
		myAjax.addParam('cPer',userId);
		myAjax.addParam('nStartDate', $id("cStartDate").value.replaceAll("-",""));
		
		myAjax.submit ();
		isInHoliday= myAjax.getValue("root/data/isInHoliday");
		var cStartDate= myAjax.getValue("root/data/cStartDate");
		var cEndDate= myAjax.getValue("root/data/cEndDate");
		if(isInHoliday == "true")
		{
			alert(userName+"在"+cStartDate+"到"+cEndDate+"期间处于请假状态，不能交接工作！");
		}
	}
	return isInHoliday;
}
/*******************************************************
 *@function : 获取隐藏值
 *@params   : 行，值名称
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_getHiddenValue(row,name)
{
	var value = "";
	for(var i = 0;i<row.getElementsByTagName("TD").length;i++)
	{
		for(var j = 0;j<row.getElementsByTagName("TD")[i].getElementsByTagName("input").length;j++)
		{
			if(row.getElementsByTagName("TD")[i].getElementsByTagName("input")[j].name==name)
			{
				value = row.getElementsByTagName("TD")[i].getElementsByTagName("input")[j].value.trim();
				return value;
			}
		}
	}
	return value;
}

/*******************************************************
 *@function : 初始化状态
 *@params   : 经办人控件
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_initStyle(tableName,nMomentId,nowMoment,staName,nowDate,colorCol)
{

	var table = $id(tableName);
	if(table == null)
	{
		return;
	}
	//最大行数
	var maxCol = table.rows[0].cells.length;
	//当前时间
	nNowTime = g_convertToMinite(nowMoment);
	var nMoment = "";
	var nLogTime="";
	var dateFlag ="";
	for(var i = 0 ;i<table.rows.length;i++)
	{
		for(var j = 0;j<table.rows[i].getElementsByTagName("TD").length;j++)
		{
			//寻找时点单元格
			if(table.rows[i].getElementsByTagName("TD")[j].id == nMomentId)
			{
				nMoment =  g_getHiddenValue(table.rows[i],nMomentId);
				nLogTime ="";
				dateFlag="";
				//若时间为年月日
				if(nMoment.length > 4)
				{
					if(nMoment < nowDate)
					{
						dateFlag = "#FFB6C1";
					}else if(nMoment == nowDate)
					{
						dateFlag ="#FFFF99";
					}
				}else
				{
					//时间为时点
					nLogTime=g_convertToMinite(nMoment);
				}
				
				//若不存在时点，则跳到下一行
				if(table.rows[i].getElementsByTagName("TD")[j].getElementsByTagName("input").length <= 0)
				{
					break;
				}
				
				//获取经办状态
				var cHandlerSta = g_getHiddenValue(table.rows[i],staName);
				if((nLogTime == "" && dateFlag =="") ||cHandlerSta == "010" )
				{
					continue;
				}else
				{
					var backColor ="";
					if(dateFlag != "")
					{
						backColor = dateFlag;
					}else
					{
						backColor = g_color(nNowTime,nLogTime);
					}
					
					g_setColor(table,backColor,colorCol,i);
				}
			}
		}
	}
}
/*******************************************************
 *@function : 初始化状态
 *@params   : 经办人控件
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLog.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-18 魏凤 创建
 *******************************************************/
function g_colorRemaind(tableName,nMoment,finishMoment,colorCol)
{
	var table = $id(tableName);
	if(table == null)
	{
		return;
	}
	var maxCol = table.rows[0].cells.length;
	
	for(var i = 0 ;i<table.rows.length;i++)
	{
		var nLogTime=g_convertToMinite(g_getHiddenValue(table.rows[i],nMoment));
		var nFinishMoment = g_convertToMinite(g_getHiddenValue(table.rows[i],finishMoment));
		if(nFinishMoment == 0 || nLogTime==0)
		{
			continue;
		}else
		{
			var backColor = g_colorRemind(nLogTime,nFinishMoment);
			g_setColor(table,backColor,colorCol,i);
			
		}
	}
}
function g_setColor(table,backColor,colorCol,i)
{
		var maxCol = table.rows[i].cells.length;
		for( var k = 0;k<colorCol;k++)
		{	
			table.rows[i].cells[maxCol-k-1].style.backgroundColor = backColor;
		}
}
/*******************************************************
 *@function : radChange
 *@params   : 点击radio
 *@return   : 无
 *@for      : phfund_clear_worklog/taSettleLogTasklib_edit.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-19 魏凤 创建
 *******************************************************/
function g_radChange(frequency)
{
	var radWeekDayPer = "radWeekDayPer";
	var txtWeekDayPer = "txtWeekDayPer";
	
	var radWeekDayNext = "radWeekDayNext";
	var txtWeekDayNext = "txtWeekDayNext";
	
	var radNaturalDayPer = "radNaturalDayPer";
	var txtNaturalDayPer = "txtNaturalDayPer";
	
	var radNaturalDayNext = "radNaturalDayNext";
	var txtNaturalDayNext = "txtNaturalDayNext";
	
	var radMonthNaturalDay = "radNaturalDay";
	var txtMonthNaturalDay = "txtNaturalDay";
		
		if(frequency == "WeekDayPer")
		{
			$id(radWeekDayPer).checked = true;
			$id(txtWeekDayPer).readOnly = false;
			
			$id(radWeekDayNext).checked = false;
			$id(txtWeekDayNext).readOnly = true;	
			$id(txtWeekDayNext).value = "";
			
			$id(radNaturalDayPer).checked = false;
			$id(txtNaturalDayPer).readOnly = true;	
			$id(txtNaturalDayPer).value = "";
			
			$id(radNaturalDayNext).checked = false;
			$id(txtNaturalDayNext).readOnly = true;	
			$id(txtNaturalDayNext).value = "";
			
			$id(radMonthNaturalDay).checked = false;
			$id(txtMonthNaturalDay).readOnly = true;	
			$id(txtMonthNaturalDay).value = "";
		}else if(frequency == "WeekDayNext")
		{
			$id(radWeekDayPer).checked = false;
			$id(txtWeekDayPer).readOnly = true;
			$id(txtWeekDayPer).value = "";
			
			$id(radWeekDayNext).checked = true;
			$id(txtWeekDayNext).readOnly = false;	
			
			$id(radNaturalDayPer).checked = false;
			$id(txtNaturalDayPer).readOnly = true;	
			$id(txtNaturalDayPer).value = "";
			
			$id(radNaturalDayNext).checked = false;
			$id(txtNaturalDayNext).readOnly = true;	
			$id(txtNaturalDayNext).value = "";
			
			$id(radMonthNaturalDay).checked = false;
			$id(txtMonthNaturalDay).readOnly = true;	
			$id(txtMonthNaturalDay).value = "";
		}else if(frequency == "NaturalDayPer")
		{
			$id(radWeekDayPer).checked = false;
			$id(txtWeekDayPer).readOnly = true;
			$id(txtWeekDayPer).value = "";
			
			$id(radWeekDayNext).checked = false;
			$id(txtWeekDayNext).readOnly = true;	
			$id(txtWeekDayNext).value = "";
			
			$id(radNaturalDayPer).checked = true;
			$id(txtNaturalDayPer).readOnly = false;	
			
			$id(radNaturalDayNext).checked = false;
			$id(txtNaturalDayNext).readOnly = true;	
			$id(txtNaturalDayNext).value = "";
			
			$id(radMonthNaturalDay).checked = false;
			$id(txtMonthNaturalDay).readOnly = true;	
			$id(txtMonthNaturalDay).value = "";
		}else if(frequency == "NaturalDayNext")
		{
			$id(radWeekDayPer).checked = false;
			$id(txtWeekDayPer).readOnly = true;
			$id(txtWeekDayPer).value = "";
			
			$id(radWeekDayNext).checked = false;
			$id(txtWeekDayNext).readOnly = true;	
			$id(txtWeekDayNext).value = "";
			
			$id(radNaturalDayPer).checked = false;
			$id(txtNaturalDayPer).readOnly = true;	
			$id(txtNaturalDayPer).value = "";
			
			$id(radNaturalDayNext).checked = true;
			$id(txtNaturalDayNext).readOnly = false;	
			
			$id(radMonthNaturalDay).checked = false;
			$id(txtMonthNaturalDay).readOnly = true;	
			$id(txtMonthNaturalDay).value = "";
		}else
		{
			$id(radWeekDayPer).checked = false;
			$id(txtWeekDayPer).readOnly = true;
			$id(txtWeekDayPer).value = "";
			
			$id(radWeekDayNext).checked = false;
			$id(txtWeekDayNext).readOnly = true;	
			$id(txtWeekDayNext).value = "";
			
			$id(radNaturalDayNext).checked = false;
			$id(txtNaturalDayNext).readOnly = true;	
			$id(txtNaturalDayNext).value = "";
			
			$id(radMonthNaturalDay).checked = false;
			$id(txtMonthNaturalDay).readOnly = true;	
			$id(txtMonthNaturalDay).value = "";
			
			$id(radMonthNaturalDay).checked = true;
			$id(txtMonthNaturalDay).readOnly = false;	
		}
}
/*******************************************************
 *@function : checkValue
 *@params   : 提交时检查值输入
 *@return   : none
 *@for      : phfund_clear_worklog/taSettleLogTasklib_edit.jsp
 *@desc     : 无
 *******************************************************
 *@author   : 2011-05-19 魏凤 创建
 *******************************************************/
function f_check_NaturalDay(obj){

        var str = obj.value;
		var period = $id("radPeriod").getValue();
		//月
		if(period == "030")
		{
			if(str>31)
			{
				f_alert(obj,"日期不得大于每月31日！");
				return false;
			}
		}
		//季度
		else if(period == "040")
		{
			var reg = /0[1-3]{1}[0-3]{1}[0-9]{1}/;
			if(str.length != 4)
			{
				f_alert(obj,"请按照格式[MMDD]输入季度的第几月第几日！");
                return false;
			}
		    if(!reg.test(str)){
                    f_alert(obj,"请按照格式[MMDD]输入季度的第几月第几日！");
                    return false;
                }else
                {
                	if(str.substring(2,4) > 31)
                	{
                		f_alert(obj,"日期不得大于每月31日！");
                		return false;
                	}
                }
                
		}
		//半年
		else if(period == "050")
		{
			var reg = /0[1-6]{1}[0-3]{1}[0-9]{1}/;
			if(str.length != 4)
			{
				f_alert(obj,"请按照格式[MMDD]输入每半年度的第几月第几日！");
                return false;
			}
		    if(!reg.test(str)){
                    f_alert(obj,"请按照格式[MMDD]输入每半年度的第几月第几日！");
                    return false;
                }else
                {
                	if(str.substring(2,4) > 31)
                	{
                		f_alert(obj,"日期不得大于每月31日！");
                		return false;
                	}
                }
		}
		//每年
		else if(period == "060")
		{
			var reg = /[0-1]{1}[0-9]{1}[0-3]{1}[0-9]{1}/;
			if(str.length != 4)
			{
				f_alert(obj,"请按照格式[MMDD]输入年度的第几月第几日！");
                return false;
			}
		    if(!reg.test(str)){
                    f_alert(obj,"请按照格式[MMDD]输入年度的第几月第几日！");
                    return false;
                }else
                {
                	if(str.substring(0,2) > 12)
                	{
                		f_alert(obj,"月份不得大于12月！");
                		return false;
                	}
                	if(str.substring(2,4) > 31)
                	{
                		f_alert(obj,"日期不得大于每月31日！");
                		return false;
                	}
                }
		}
        return true;

    }
    /*
    *检查指定的datacell的内容是否超过指定的长度
    *例如：g_checkDataCellValue("cell1",[3,4],[2000,2000]);
    */
    function g_checkDataCellValue(dataCellName,checkCols,checkColsLength)
    {
    	var dataCell = $id(dataCellName);
    	//检查dataCell的值
    	for(var i = 0 ;i<dataCell.getCurrentRowCount();i++)
    	{
    		//循环需要检查的列号
    		for(var j = 0;j<checkCols.length;j++)
    		{
    			var Cell = dataCell.getCell(i,checkCols[j]);
    			var cellValue = dataCell.getCellValue(Cell);
    			//替换多余的换行符
    			if(cellValue!=null)
    			{
	    			dataCell.setCellValue(Cell,cellValue.replaceAll("\n\n","\n"));
    			}
    			//再次获取值
    			cellValue = dataCell.getCellValue(Cell);
    			if(cellValue != null && cellValue != "" && cellValue.length >checkColsLength[j])
    			{
    				alert("长度超过"+checkColsLength[j]+"，请修改！");
    				dataCell.setActiveCell(Cell);
    				return false;
    			}
    		}
    	}
    	return true;
    }



    //将null转换为空字符串
    function changeNull(val){
    	return val==null?"":val;
    }
    
    
    /**
    * 将数值四舍五入后格式化. 
    * @param num 数值(Number或者String) 
    * @param cent 要保留的小数位(Number) 
    * @param isThousand 是否需要千分位 0:不需要,1:需要(数值类型); 
    * @return 格式的字符串,如'1,234,567.45' 
    * @type String 
    * @author huangmizhi
    */
    function formatNumber(num,cent,isThousand) {
    	num=num==null?"":num;
	    num = num.toString().replace(/\$|\,/g,'');
	    
	    // 检查传入数值为数值类型
	    if(isNaN(num))
	    num = "0";
	
	    // 获取符号(正/负数)  
	    sign = (num == (num = Math.abs(num)));
	
	    num = Math.floor(num*Math.pow(10,cent)+0.50000000001);  // 把指定的小数位先转换成整数.多余的小数位四舍五入
	    cents = num%Math.pow(10,cent);              // 求出小数位数值
	    num = Math.floor(num/Math.pow(10,cent)).toString();   // 求出整数位数值
	    cents = cents.toString();               // 把小数位转换成字符串,以便求小数位长度
	
	    // 补足小数位到指定的位数
	    while(cents.length<cent)
	    	cents = "0" + cents;
	
	    if(isThousand) {
	    // 对整数部分进行千分位格式化.
	    	for (var i = 0; i < Math.floor((num.length-(1+i))/3); i++)
	    		num = num.substring(0,num.length-(4*i+3))+','+ num.substring(num.length-(4*i+3));  
	    }  
	
	    if (cent > 0)
	    	return (((sign)?'':'-') + num + '.' + cents);  
	    else
	    	return (((sign)?'':'-') + num);
    }
    
    
    /**
     * 在form表单中新增元素
     * @param formId 表单ID
     * @param formElement 表单元素
     * @param formElementType 表单元素类型
     * @param formElementName 表单元素名称
     * @param formElementValue 表单元素值
     * @author huangmizhi
     */
     function formAppendChild(formId,formElement,formElementType,formElementName,formElementValue) {
    	 var form = document.getElementById(formId);
    	 var isExist = false;
    	 var elementCmp;
    	 for(var i=0; i<form.childNodes.length; i++){
    		 if(formElementName==form.childNodes[i].name){
    			 elementCmp = form.childNodes[i];
    			 isExist = true;
    			 break;
    		 }
    	 }
    	 if(isExist==true){
    		 elementCmp.value = formElementValue;
    	 }else{
    		 elementCmp = document.createElement(formElement);
        	 elementCmp.type = formElementType;
        	 elementCmp.name = formElementName;
        	 elementCmp.value = formElementValue;
        	 form.appendChild(elementCmp);
    	 }
     }

