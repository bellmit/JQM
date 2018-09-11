<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): huangmizhi
  - Date: 2015-10-15 14:08:10
  - Description: 根据机构员工树选择员工
-->
<%@include file="/common.jsp" %>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/coframe/org/icons/icon.css"/>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>机构员工树选择员工</title>
</head>
<body>
<div class="nui-fit" style="width:100%;height:100%;">
   <table style="width:100%;height:89%;">
      <tr>
         <td>所有员工</td>
         <td></td>
         <td>已选员工</td>
      </tr>
      <tr>
         <td style="width:40%;height:100%;border:1px solid #878787;vertical-align:top;">
            <ul id="tree1" class="nui-tree" style="width:100%;" url="org.gocom.components.coframe.org.organization.queryTreeChildNodes.biz.ext"
	          dataField="treeNodes" showTreeIcon="true" textField="nodeName" idField="nodeId" resultAsTree="true" parentField="parentId"
	          onbeforeload="onBeforeTreeLoad" onnodedblclick="onNodeDbClick">
	        </ul>
         </td>
         <td style="width:20%;">
            <table style="width:100%;">
		    	<tr>
		    	  <td align="center">
		    	    <input type="button" id="addBtn" style="width:65px;text-align:center;" class='nui-button' plain='false' onclick="addEmpResource" text="添加" />
		    	  </td>
		    	</tr><%-- 添加 --%>
				<tr>
				  <td align="center">&nbsp;</td>
				</tr>
				<tr>
				  <td align="center">
				    <input type="button" id="allDeleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text="全部删除" onclick="deleteAllOrgResource"/>
				  </td>
				</tr><%-- 全部删除 --%>
				<tr>
				  <td align="center">
				    <input type="button" id="deleteBtn" class='nui-button' plain='false' style="width:65px;text-align:center;" text="删除" onclick="deleteEmpResource" />
				  </td>
				</tr><%-- 删除 --%>
			</table>
         </td>
         <td style="width:40%;">
            <div class="nui-fit">
              <div id="listbox1" class="nui-listbox" style="width:100%;height:100%;"
               textField="nodeName" valueField="nodeId" multiSelect="true">
              </div>
            </div>
         </td>
      </tr>
   </table>
   <div class="nui-toolbar" style="text-align:center;padding-top:8px;padding-bottom:8px;" 
        borderStyle="border:0;">
        <a class='nui-button' plain='false' style="width:60px;" iconCls="icon-ok" onclick="onOk()">确定</a>
        <span style="display:inline-block;width:25px;"></span>
        <a class='nui-button' plain='false' style="width:60px;" iconCls="icon-cancel" onclick="onCancel()">取消</a>
</div>
</div>

<script type="text/javascript">
    nui.parse();
    
    var contextPath = "<%=request.getContextPath() %>";
    var tree = nui.get("tree1");
    var listbox = nui.get("listbox1");
    
    function onBeforeTreeLoad(e) {
    	// 增加nodeType参数以便区分是加载机构下的结点还是岗位下的结点
		e.params.nodeType = e.node.nodeType;
    }
    
    function addEmpResource(){
        var node = tree.getSelectedNode();//获取选中的节点
        var items = listbox.getData();//获取已选中的员工
        if(!node){
            nui.alert("请选择机构或岗位或员工");
        }
        
        //获取节点类型：机构-OrgOrganization;岗位-OrgPosition;员工-OrgEmployee;
        var nodeType = node.nodeType;
        //若选择机构或岗位节点，则添加该机构或岗位下面的所有员工
        if(nodeType=="OrgOrganization" || nodeType=="OrgPosition"){
        	//遍历选中节点
        	tree.cascadeChild(node, function (childNode) {
        		//若节点类型为员工，则添加
            	if(childNode.nodeType=="OrgEmployee"){
            		var exist = false;
            		for(var i=0; i<items.length; i++){
		                if(childNode.nodeId==items[i].nodeId){
		                	exist = true;
		                	break;
		                }
		            }
		            //若之前未选中，则添加
		            if(exist==false){
		            	listbox.addItem(childNode);
		            }
            	}
	        });
	    
	    //选择的节点为员工 
        }else{
        	var exist = false;
    		for(var i=0; i<items.length; i++){
                if(node.nodeId==items[i].nodeId){
                	exist = true;
                	break;
                }
            }
            
            //若之前未选中，则添加
            if(exist==false){
            	listbox.addItem(node);
            }else{
            	nui.alert("已选中该员工");
            }
        }
    }
    
    function onNodeDbClick(){
        addEmpResource();
    }
    
    function SetData(data){
       data = nui.clone(data);
       var ids = data.ids.split(",");
       var texts = data.texts.split(",");
       if(ids!=""){
	       for(var i=0;i<ids.length;i++){
	          var id = ids[i].split(":");
	          var node ={
	             nodeId:id[0],
	             nodeName:texts[i]
	          };
	          listbox.addItem(node);
	       }
       }
    }
    
	function GetData() {
		var items = listbox.getData();
		var ids = [];
		var texts = [];
		for(var i=0;i<items.length;i++){
			ids.push(items[i].nodeId+":"+items[i].nodeName);
			texts.push(items[i].nodeName);
		}
        return {id:ids.join(","),text:texts.join(",")};
    }
    
    function deleteEmpResource(){
        var nodes = listbox.getSelecteds();
        if(nodes.length==0){
            nui.alert("请选择至少一个已选员工");
            return;
        }
        listbox.removeItems(nodes);
    }
    
    function deleteAllOrgResource(){
        listbox.removeAll();
    }
    
    function onOk() {
        CloseWindow("ok");
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
