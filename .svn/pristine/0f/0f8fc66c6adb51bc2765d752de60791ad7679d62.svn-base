<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 杨敏
  - Date: 2016-08-22 13:25:25
  - Description:
-->
<head>
	<title>产品信息管理</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
</head>
<body>

<div style="margin:0px;width:100%;height:100%;" >
	<div style="width:100%;height:100%;">
			
			
					<!-- 列表数据  -->	
					<div id="form1" class="nui-form" style="padding:2px;" align="center" >
				        <input id="lParentId" type="hidden" class="nui-hidden"style="width:95%" name="lParentId"/>
				    </div>	
				   
				   <div id="groupButton" class="nui-toolbar" style="border-bottom:0;padding:0px;">
		                <table style="width:100%;">
		                    <tr>
		                        <td style="width:100%;">
		                            <privilege:operation sourceId="ATS_MOM_CPSXZJD" sid="addProd" clazz="nui-button" onClick="addProd()" lableName="添加产品"  iconCls="icon-add" ></privilege:operation>
		                            <privilege:operation sourceId="ATS_MOM_CPSSCJD" sid="deleteProd" clazz="nui-button" onClick="deleteProd()" lableName="删除产品"  iconCls="icon-remove" ></privilege:operation>
		                        </td>
		                    </tr>
		                </table>
		            </div>

		            <div class="nui-fit">
				   		<div id="datagrid1" dataField="data"
				   			class="nui-datagrid" style="width:100%;height:100%;"
				        	url="com.cjhxfund.jy.ProductProcess.o32tcjc.getGroupInfo.biz.ext"
				           	allowSortColumn="true" sortMode="client"
				         	enableHotTrack="true" allowHeaderWrap="true"
				           	showPager="false"
				           	allowCellEdit="true"
							allowCellSelect="true"
							enterNextCell="true"
							allowMoveColumn="true"
							editNextOnEnterKey="true"
							onload="format"
							multiSelect="true"   showfooter="false">
		                    <div property="columns">
		                        <div type="indexcolumn"></div>
		                        <div type="checkcolumn"></div>
		
		                        <div field="vcProductCode" headerAlign="center" allowSort="true" align="left" width="80px">
		                            产品代码
		                        </div>
		                        <div field="vcProductName" headerAlign="center" allowSort="true" align="left" width="150px">
		                            产品名称
		                        </div>
		                        <div field="vcProductCaption" headerAlign="center" allowSort="true" align="left" width="100px">
		                            产品全称
		                        </div>
		                        <div field="vcAssetName" headerAlign="center" allowSort="true" align="left" width="100px">
		                            资产单元
		                        </div>
		
		                       
		                    </div>
		                </div>
					</div>
				</div>
			</div>
	
<script type="text/javascript">
	nui.parse();
	var grid1 = nui.get("datagrid1");
	
	//var detailForm1 = new nui.Form("#dataform1");
	
	//var formData = (new nui.Form("#form1")).getData(false,false);
	//grid1.load(formData);
	
	
	var node = null;//当前选中的节点
	
	(function(){
		if(window.parent.getCurrentNode){
			node = window.parent.getCurrentNode();
			
			if(node.isLeaf==false){
				nui.get("groupButton").hide();
			}
			window['parentNode'] = node;
			
			if(node.nodeType!="Root"){
				nui.get("lParentId").setValue(node.nodeId);
			}
			loadData(node);
		}
	})();
	
	function loadData(node){
		 search();
		
		 /*nui.ajax({
            url: "com.cjhxfund.jy.momReport.reportManager.queryProductInfoById.biz.ext",
            type: 'POST',
            data: {lProductId:node.lProductId},
            cache: false,
            contentType:'text/json',
            cache: false,
            success: function (mydata) {
                var o = nui.decode(mydata);
                
            }
        });*/
	}
	//查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}
	
	function addProd(){
		 
		 nui.open({
            url: "<%=request.getContextPath() %>/ProductProcess/zhxxcx/o32tcjc1_new/productAssetList.jsp",
            title: "产品列表",
            width: 450,
            height: 380,
            ondestroy: function (action) {
                if (action == "ok") {
                    var iframe = this.getIFrameEl();
                    var data = iframe.contentWindow.GetData();
                    data = nui.clone(data);
                    /*buttonEditObj.setValue(data.fundCode);
                    buttonEditObj.setText(data.fundName);*/
                   if(data==null || data==""){
                    	nui.alert("请选择产品或者资产单元数据~");
                    	return;
                    }
                    
                    nui.ajax({
			            url: "com.cjhxfund.jy.ProductProcess.o32tcjc.addAssetGroup.biz.ext",
			            type: 'POST',
			            data: {
			            	adds:data,
			            	nodeId:node.nodeId
			            },
			            cache: false,
			            contentType:'text/json',
			            cache: false,
			            success: function (mydata) {
			            	if(mydata.ret!=-1){
			                	nui.alert("添加成功~","系统提示",function(){
			                	
			                });
			                }else{
			                	nui.alert("添加失败，请联系管理员","系统提示");
			                }
			                window.parent.refreshNode(node);
			                search();
			            }
			        });
                    
                }
            }
        });
		
	}
	function deleteProd(){
		var rows = grid1.getSelecteds();
		if(rows==null || rows=="" || rows<1){
			nui.alert("请选择数据~");
			return;
		}
		nui.confirm("删除后不可恢复，是否确认删除？","系统提醒",function(action){
			if(action=="ok"){
				
				var lAssetGroupIds="";
				for(var i=0;i<rows.length;i++){
					lAssetGroupIds=lAssetGroupIds+rows[i].lAssetGroupId+(i==rows.length-1?"":",");
				}
				if(rows.length>0){
					nui.ajax({
			            url: "com.cjhxfund.jy.ProductProcess.o32tcjc.deleteAssetGroup.biz.ext",
			            type: 'POST',
			            data: {lAssetGroupIds:lAssetGroupIds},
			            cache: false,
			            contentType:'text/json',
			            cache: false,
			            success: function (mydata) {
			            	if(mydata.ret==1){
			            		nui.alert("删除成功~","系统提醒");
			                	window.parent.refreshNode(node);
			                	search();
			            	}else{
			            		nui.alert("删除失败。请联系管理员~","系统提醒");
			            	}
		                
			            }
			        });
			
				}else{
					nui.alert("请选择要删除的数据~","系统提醒");
				}
			}
		});
		
		
	}
	//重新刷新页面
	function refresh(){
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}

	//重置查询条件
	function reset(){
		var form = new nui.Form("#form1");//将普通form转为nui的form
		form.reset();
	}
	
	//enter键触发查询
	function onKeyEnter(e) {
		search();
	}
	function renderDataTemp(e){
			if(e.value == "0" || e.value == null){
				return "";
			}
			return dataTemp(e.value);
	}
	
	function format(){
		siformat=false;
	}
	
	function dataTemp(oldData){
		oldData = oldData+"";
		if(oldData=="0" || oldData=="" || oldData=="null" || oldData==null || oldData=="1"){
			return "";
		}
		var yy = oldData.substr(0,4);
		var mm = oldData.substr(4,2);
		var dd = oldData.substr(6,2);
		return yy+"-"+mm+"-"+dd;
	}
	
	/*
	 *	业务字典转换
	 */
	//投顾复核
    function renderInvestAdvise(e) {
		return nui.getDictText("investAdviseCheck",e.row.cInvestAdviseCheck);
	}
	//委托人复核
	function renderInvestClientCheck(e){
		return nui.getDictText("investClientCheck",e.row.cInvestClientCheck);
	}
	
	//产品类型
	function renderProductType(e){
		return nui.getDictText("productType",e.row.cProductType);
	}
	
	//产品状态
	function renderProductStatus(e){
		return nui.getDictText("productStatus",e.row.cProductStatus);
	}
	
	//资产单元：可否透支（透支状态）
	function renderOverdraft(e){
		return nui.getDictText("overdraftStatus",e.row.cOverdraft);
	}
	
	//资产单元：是否托管
	function renderTrust(e){
		return nui.getDictText("trustStatus",e.row.cTrust);
	}
	//投资类型
	function renderCInvestType(e){
		return nui.getDictText("investType",e.row.cInvestType);
	}
	//资产单元：是否三方存管
	function renderThirdPartyCustody(e){
		return nui.getDictText("thirdPartyCustody",e.row.cThirdPartyCustody);
	}
	//资产单元：资产单元状态
	function renderAssetStatus(e){
		return nui.getDictText("assetStatus",e.row.cAssetStatus);
	}
	
	//组合：组合类型
	function renderCombiClass(e){
		return nui.getDictText("combiClass",e.row.cCombiClass);
	}
	
	//组合：组合状态
	function renderCombiStatus(e){
		return nui.getDictText("combiStatus",e.row.cCombiStatus);
	}
	
	//组合：组合状态
	function renderInvestType(e){
		return nui.getDictText("investType",e.row.cInvestType);
	}
</script>
</body>
</html>