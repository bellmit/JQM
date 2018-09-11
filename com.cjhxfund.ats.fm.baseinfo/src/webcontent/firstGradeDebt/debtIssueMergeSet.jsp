<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 章璐
  - Date: 2016-09-01 08:08:10
  - Description: 设置去重条件
-->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>自定义去重策略</title>
</head>
<body>

<div class="nui-fit" style="width:100%;height:100%;">
   <table style="width:100%;height:85%;">
      <tr>
         <td>可选策略</td>
         <td></td>
         <td>已选策略</td>
      </tr>
      <tr>
         <td style="width:40%;height:100%;solid #878787;vertical-align:top;">		
			<div class="nui-fit">
              <div id="listbox2" class="nui-listbox" style="width:100%;height:100%;"
               textField="nodeName" valueField="nodeId" multiSelect="true" onnodedblclick="onNodeDbClick">
              </div>
            </div>
       </td>
         <td style="width:20%;">
            <table style="width:100%;">
		    	<tr>
		    	  <td align="center">
		    	    <input type="button" id="addBtn" style="width:65px;text-align:center;" class='nui-button' plain='false' onclick="addEmpResource" text=">" />
		    	  </td>
		    	</tr><%-- 添加 --%>
				<tr>
				  <td align="center">
				    <input type="button" id="allDeleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text=">>" onclick="addAllOrgResource"/>
				  </td>
				</tr><%-- 全部添加 --%>
				<tr>
		    	  <td align="center">
		    	  		&nbsp;
		    	  </td>
		    	</tr>
				<tr>
				  <td align="center">
				    <input type="button" id="allDeleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text="&lt;&lt;" onclick="deleteAllOrgResource"/>
				  </td>
				</tr><%-- 全部删除 --%>
				<tr>
				  <td align="center">
				    <input type="button" id="deleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text="&lt;" onclick="deleteEmpResource" />
				  </td>
				</tr><%-- 删除 --%>
			</table>
         </td>
         <td style="width:40%;">
            <div class="nui-fit">
              <div id="listbox1" class="nui-listbox" style="width:100%;height:100%;vertical-align:top;" 
               textField="nodeName" valueField="nodeId" multiSelect="true">
              </div>
            </div>
         </td>
      </tr>
   </table>
</div>

<div class="nui-toolbar" style="border:0;">
    <table style="width:100%;">
       <tr>
           <td style="text-align:center;">
               	<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-ok" onclick="onOk()">保存</a>
        		<span style="display:inline-block;width:25px;"></span>
        		<a class='nui-button' plain='false' style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
           </td>
       </tr>
    </table>
</div>

<script type="text/javascript">
    nui.parse();
    var memo = "";
    var listbox = nui.get("listbox1");
    var listbox2 = nui.get("listbox2");

    function addEmpResource(){
        var items = listbox2.getSelecteds();
        listbox2.removeItems(items);
        listbox.addItems(items);
    }
    
    function addAllOrgResource(){
    	var items = listbox2.getData();
        listbox2.removeItems(items);
        listbox.addItems(items);
    }
    
    function onNodeDbClick(){
        addEmpResource();
    }
    
    function SetData(data){
    	$.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.queryUserParamConf.biz.ext",
	            type:'POST',
	            data:null,
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var udata = nui.decode(text);
					
					if(udata.paramconf[0] != null){
						var b = false;
						if(udata.paramconf[0].vcConfValue == "" || udata.paramconf[0].vcConfValue == null){
							lefts = udata.paramconf[0].vcConfRange.split(";");//去重字段的值域
							for(var i=0;i<lefts.length;i++){
								var leftItem = lefts[i].split("|");								
								var node1=null;
					       		var node=null;
					       		if(leftItem[1]=="vc_issuer_name_full"||leftItem[1]=="vc_stock_name_full"){
					       			node1 ={
						             nodeId:leftItem[1],
						             nodeName:leftItem[0]
						          	};
					       		}else{
					       			node ={
						             nodeId:leftItem[1],
						             nodeName:leftItem[0]
						          	};
					       		}				       		
					          	listbox.addItem(node1);					          	
					          	listbox2.addItem(node);
							}
						}else{
							rights = udata.paramconf[0].vcConfValue.split(";");//用户保存的策略  
							lefts = udata.paramconf[0].vcConfRange.split(";");//去重字段的值域 
							for(var i=0;i<lefts.length;i++){
						       var leftItem = lefts[i].split("|");
						       for(var j=0;j<rights.length;j++){
						       	  var rightItem = rights[j].split("|");
						       	  if(rightItem[1] == leftItem[1]){	//判断是不是用户保存的策略 
						       	  		b = true;
						       	  }	
						       }
					       		var node ={
					             nodeId:leftItem[1],
					             nodeName:leftItem[0]
					          	};
					          	if(b == true){
					          	listbox.addItem(node);
					          	}else{
					          	listbox2.addItem(node);
					          	}
					          	b = false;  
						       }
					    }   
					}else{
						data = nui.clone(data);
			    		memo = data.mergeSet.paramMemo;
				       var texts = data.mergeSet.paramMemo.split(";");
					   if(texts!=""){
					       for(var i=0;i<texts.length;i++){
					       var mergemap = texts[i].split("|");
				       		var node1=null;
				       		var node=null;
				       		if(mergemap[1]=="vc_issuer_name_full"||mergemap[1]=="vc_stock_name_full"){
				       			node1 ={
					             nodeId:mergemap[1],
					             nodeName:mergemap[0]
					          	};
				       		}else{
				       			node ={
					             nodeId:mergemap[1],
					             nodeName:mergemap[0]
					          	};
				       		}				       		
				          	listbox.addItem(node1);
				       		listbox2.addItem(node);	   
					       }
					   }
					}
				}    
			});
    }
    
	function saveData(){
        var items = listbox.getData();
        var values = "";
		for(var i=0;i<items.length;i++){
			if(i==(items.length-1)){			
			values = values+items[i].nodeName+"|"+items[i].nodeId;
			}else{
			values = values+items[i].nodeName+"|"+items[i].nodeId+";";
			}
		}
		if(values==""){
			nui.confirm("系统默认去重策略包括：债券全称、发行人全称!", "系统提示", function (a){
       		if(a=='ok'){
      			$.ajax({
					url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.saveUserParamConf.biz.ext",
		            type:'POST',
		            data:nui.encode({conf_val:values,range:memo}),
		            cache:false,
		            contentType:'text/json',
		            success:function(text){
						var returnJson = nui.decode(text);
		    			if(returnJson.exception == null){
		    			    if(returnJson.returnCode="1"){
		        			    nui.alert("保存成功", "系统提示", function(action){
		                        		CloseWindow("saveSuccess");
		            			});
		    			    }else{
		    			    	 nui.alert("保存失败", "系统提示", function(action){
		            			});
		    			    }       			
		    			}else{
		       	 			nui.alert("保存失败", "系统提示", function(action){
		                		if(action == "ok" || action == "close"){
		                		}
		            		});
		        		}
					}    
				});
      		 }else{
      		 	return;
      		 }
			});
		}else{
			$.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.DebtIssueManager.saveUserParamConf.biz.ext",
	            type:'POST',
	            data:nui.encode({conf_val:values,range:memo}),
	            cache:false,
	            contentType:'text/json',
	            success:function(text){
					var returnJson = nui.decode(text);
	    			if(returnJson.exception == null){
	    			    if(returnJson.returnCode="1"){
	        			    nui.alert("保存成功", "系统提示", function(action){
	                        		CloseWindow("saveSuccess");
	            			});
	    			    }else{
	    			    	 nui.alert("保存失败", "系统提示", function(action){
	            			});
	    			    }       			
	    			}else{
	       	 			nui.alert("保存失败", "系统提示", function(action){
	                		if(action == "ok" || action == "close"){
	                		}
	            		});
	        		}
				}    
			});
		}		
    }
    
    function deleteEmpResource(){
        var nodes = listbox.getSelecteds();
        if(nodes.length==0){
            nui.alert("请选择至少一个字段");
            return;
        }
        listbox.removeItems(nodes);
        listbox2.addItems(nodes);
    }
    
    function deleteAllOrgResource(){
    	var items = listbox.getData();
        listbox.removeAll();
        listbox2.addItems(items);
    }
    
    function onOk() {
    //保存用户的 去重条件 
       	saveData();
    }
    
    function onCancel() {
        CloseWindow("cancel");
    }
    
	function CloseWindow(action) {
        if (window.CloseOwnerWindow) return window.CloseOwnerWindow(action);
        else window.close();
    }
	
	
</script>

</body>
</html>
