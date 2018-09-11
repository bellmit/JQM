var XSLPage = {};

/*
function $(id)
{
  return document.getElementById(id);
}
*/

Array.prototype.add = function(obj)
{
  this[this.length] = obj;
}

function XSLTable(tableName,tableId)
{
  this.tableName = tableName;
  this.tableId = tableId;
}

XSLPage.tables = [];
XSLPage.regTable = function(tableName,tableId)
{
  var xslTable = new XSLTable(tableName,tableId);
  XSLPage.tables.add(xslTable);
}

//正则表达式验证
//1.验证类
function XSLPattern(itemName,xPath,patternStr)
{
  this.itemName = itemName;
  this.xPath = xPath;
  this.patternStr = patternStr;
}
//2.验证数组
XSLPage.patterns = [];
//3.注册验证
XSLPage.regPattern = function(itemName,xPath,patternStr)
{
  var xslPattern = new XSLPattern(itemName,xPath,patternStr);
  XSLPage.patterns.add(xslPattern);
}
//4.保存前验证
XSLPage.validPatterns = function()
{
  var patternsValid = true;
  for(var i=0;i<XSLPage.patterns.length;i++)
  {
    patternsValid = XSLPage.validPattern(XSLPage.patterns[i]);
    if(!patternsValid)
    {
      return patternsValid;
    }
  }
  return patternsValid;
}
//4.1.验证单输入项
XSLPage.validPattern = function(pattern)
{
  var patternValid = true;
  var itemInput = $name(pattern.xPath);
  var reg = new RegExp(pattern.patternStr);
  patternValid = reg.test(itemInput.value);
  if(!patternValid)
  {
     //alert("“" + pattern.itemName + "”应输入的格式为“" + pattern.patternStr + "”！");
     alert(pattern.itemName + "为必填项！");
     itemInput.focus();
  }
  return patternValid;
}

XSLPage.prepareForSubmit = function(form)
{
    var patternsValid = XSLPage.validPatterns();
    if(!patternsValid)
    {
      //alert("输入项目合法性检查未通过！");
      return patternsValid;
    }

    //提交
    for(var i=0;i<XSLPage.tables.length;i++)
    {
      var xslTable = XSLPage.tables[i];
      var table = $id(xslTable.tableId);
      if(table != null)
      {
        var tbody = table.firstChild;
        var rows = table.rows;
        for(var j=2;j<rows.length-1;j++)
        {
          var row = table.rows[j];
          
          var inputs = table.rows[j].getElementsByTagName("input");
          //k=1,忽略选择checkbox
          for(var k=1; k<inputs.length; k++)
          {
            var input = inputs[k];
            if(input.type != "button")
            {
              var objNamePos = input.name.lastIndexOf("/");
              input.name = input.name.substring(0,objNamePos) + "[" + j + "]" + input.name.substring(objNamePos);
            }
          }
          
          //下拉框
          var selects = table.rows[j].getElementsByTagName("select");
          for(var k=0; k<selects.length; k++)
          {
            var select = selects[k];
            var objNamePos = select.name.lastIndexOf("/");
            select.name = select.name.substring(0,objNamePos) + "[" + j + "]" + select.name.substring(objNamePos);
          }
          
        }
        tbody.removeChild(table.rows[1]);
      }
    }
}

XSLPage.tableAddRow = function(tableId)
{
  var table = $id(tableId);
  if(table == null)
  {
    return;
  }
  var newRow = Element.clone(table.rows[1]);
  newRow.style.display = "";
  var tbody = table.firstChild;
  tbody.insertBefore(newRow,tbody.lastChild);
}

XSLPage.tableDelRow = function(tableId)
{
  var table = $id(tableId);
  if(table == null)
  {
    return;
  }
  var tbody = table.firstChild;
  var delCount = 0;
  for(var i = table.rows.length-2;i>0;i--)
  {
    if(table.rows[i].firstChild.firstChild.checked)
    {
      delCount++;
    }
  }
  if(delCount > 0)
  {
    if(confirm("确定要删除这"+delCount+"行吗？"))
    {
	  for(var i = table.rows.length-2;i>0;i--)
	  {
	    if(table.rows[i].firstChild.firstChild.checked)
	    {
	      tbody.removeChild(table.rows[i]);
	    }
	  }
	}
  }
}

XSLPage.uploadFile = function()
{
  XSLPage.uploadFileRow = event.srcElement.parentNode.parentNode;
  //隐藏XSD iframe
  window.frameElement.style.visibility = "hidden";
  
  DialogUtil.showModalCenter(
    contextPath + "/crc_pet_sys/com.crc.eos.pet.com.utils.fileUpload.flow",
    null,
    XSLPage.callbackUploadFile,
    500,
    240,
    "上传文件"
  );
}

XSLPage.callbackUploadFile = function(returnValue)
{
  if(returnValue != null)
  {
	  var returnInfo ="";
	  for(var i in returnValue)
	  {
	     returnInfo += i + ":" + returnValue[i];
	     returnInfo += "\r\n";
	  }
	  var fileRow = XSLPage.uploadFileRow;
	  fileRow.childNodes[1].childNodes[0].value = returnValue["cFileName"];
	  fileRow.childNodes[1].childNodes[1].fileId = returnValue["nFileId"];
	  fileRow.childNodes[1].childNodes[1].innerText = returnValue["cFileName"];
	  fileRow.childNodes[2].childNodes[0].value = returnValue["cMemo"] == "null" ? "" : returnValue["cMemo"];
	  fileRow.childNodes[3].childNodes[0].value = returnValue["nFileId"];
	  XSLPage.uploadFileRow = null;
  }
  
  //显示XSD iframe
  window.frameElement.style.visibility = "visible";
}

XSLPage.doFileDownload = function()
{
  window.open(
       contextPath
     + "/phfund_clear_common/com.crc.eos.pet.com.utils.fileDownload.flow"
     + "?downloadParaObj/nFileID=" + event.srcElement.fileId
  );
}