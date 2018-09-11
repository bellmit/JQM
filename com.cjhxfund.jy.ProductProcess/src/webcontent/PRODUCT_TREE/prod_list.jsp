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
			<div title="产品详情" style="height:18%;">
          		<div id="dataform1">
        			<table style="width:100%; table-layout:fixed;margin: 0xp;padding: 20px;" id="table" border="0" class="">	
        				<tr>
		                    <td style="width:80px; " align="right">产品代码：</td>
		                    <td style="width:25%" align="left" colspan="1">
		                    	<input id="prodInfo.vcProductCode" name="prodInfo.vcProductCode" class="mini-textbox" style="width:80%" readonly="true" />
		                    </td>
		                    <td style="width:80px;" align="right">产品名称：</td>
		                    <td style="width:25%" align="left" colspan="1">
		                    	<input name="prodInfo.vcProductCaption" class="mini-textbox" style="width:80%" readonly="true" />
		                    </td>
							  <td style="width:80px;" align="right">产品类型：</td>
		                    <td style="width:25%" align="left" colspan="1">
		                    	<input name="prodInfo.cProductType" class="nui-dictcombobox" style="width:80%" dictTypeId="productType" readonly="true"/>
		                    </td>
			        	</tr>
			         	<tr>
		                  <td style="" align="right">产品类别：</td>
		                    <td>
		                    	<input name="prodInfo.llevel" id="hllevel" class="nui-hidden" style="width:80%" />
		                    	<input id="llevel" class="mini-textbox" style="width:80%" readonly="true"/>
		                    </td>
		                   
		                    <td style="width:80px;" align="right">成立日期：</td>
		                    <td style="width:25%" align="left" colspan="1">
		                    	<input id="lOpenDate" name="prodInfo.lOpenDate" class="mini-textbox" style="width:80%" readonly="true"  format="yyyy-MM-dd"  />
		                    </td>
		                    <td style="width:80px;" align="right">结束日期：</td>
		                    <td style="width:25%" align="left" colspan="1">
		                    	<input id="lEndDate" name="prodInfo.lEndDate" class="mini-textbox" style="width:80%" readonly="true"  format="yyyy-MM-dd"  />
				            </td>
				        </tr>
				        <tr>
				        	 
		                    <td style="" align="right">托管人名称：</td>
		                    <td>
		                    	<input name="prodInfo.vcCustodianName" class="mini-textbox" style="width:80%"  readonly="true"/>
		                    </td>
		                    
		                    <td style="" align="right">管理人名称：</td>
		                    <td>
		                    	<input name="prodInfo.vcAdminName" class="mini-textbox" style="width:80%"  readonly="true"/>
		                    </td>
		                    <td style="" align="right">投资顾问：</td>
		                    <td>
		                    	<input name="prodInfo.vcInvestmentAdvisor" class="mini-textbox" style="width:80%"  readonly="true"/>
		                    </td>
				        </tr>
				        <!-- <tr>
				        	<td style="" align="right">运营联系人：</td>
		                    <td>
		                    	<input name="prodInfo.vcOperationName" class="mini-textbox" style="width:80%" readonly="true"/>
		                    </td>
		                    <td style="" align="right">运营联系电话：</td>
		                    <td>
		                    	<input  name="prodInfo.vcOperationTel" class="mini-textbox" style="width:80%" readonly="true"/>
				            </td>
		                    <td style="" align="right">运营联系手机：</td>
		                    <td>
		                    	<input name="prodInfo.vcOperationPhone" class="mini-textbox" style="width:80%"  readonly="true"/>
		                    </td>
				        </tr>
				        <tr>
				        	<td style="" align="right">运营联系邮箱：</td>
		                    <td>
		                    	<input name="prodInfo.vcOperationEmail" class="mini-textbox" style="width:80%"  readonly="true"/>
		                    </td>
				        </tr> -->
					</table>
		  		</div>	
			</div>	
			<div id="tabs" class="nui-tabs" height="80%"  style="margin-top: 10px">
				<div title="子产品列表">
					<!-- 列表数据  -->	
					<div id="form1" class="nui-form" style="padding:2px;" align="center" >
				        <input id="lParentId" type="hidden" class="nui-hidden"style="width:95%" name="productInfo/lParentId"/>
				    </div>	
				   
				   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
		                <table style="width:100%;">
		                    <tr>
		                        <td style="width:100%;">
		                            <privilege:operation sourceId="ATS_MOM_CPSXZJD" sid="addProd" clazz="nui-button" onClick="addProd()" lableName="添加子产品"  iconCls="icon-add" ></privilege:operation>
		                            <privilege:operation sourceId="ATS_MOM_CPSSCJD" sid="deleteProd" clazz="nui-button" onClick="deleteProd()" lableName="删除子产品"  iconCls="icon-remove" ></privilege:operation>
		                        </td>
		                    </tr>
		                </table>
		            </div>

		            <div class="nui-fit">
				   		<div id="datagrid1" dataField="productInfos"
				   			class="nui-datagrid" style="width:100%;height:100%;"
				        	url="com.cjhxfund.jy.momReport.reportManager.queryProductInfoWithPage.biz.ext"
				           	pageSize="20" showPageInfo="true"
				           	allowSortColumn="true" sortMode="client"
				         	enableHotTrack="true" allowHeaderWrap="true"
				           	sizeList="[10,20,50,100]"
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
		                        <div field="vcProductCaption" headerAlign="center" allowSort="true" align="left" width="180px">
		                            产品名称
		                        </div>
		                        <div field="cProductType" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderProductType">
		                            产品类型
		                        </div>
		                       <!--  <div field="cInvestType" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderCInvestType">
		                            投资类型
		                        </div> -->
		                        <div field="vcCustodianName" headerAlign="center" allowSort="true" align="left" width="150px">
		                            托管人
		                        </div>
		                        <div field="vcAdminName" headerAlign="center" allowSort="true" align="left" width="150px">
		                            管理人
		                        </div>
		                        <div field="lOpenDate" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderDataTemp">
		                            成立日期
		                        </div>                        
		                        <div field="lEndDate" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderDataTemp">
		                           结束日期
		                        </div>
		                    </div>
		                </div>
					</div>
				</div>
			</div>
	</div>	
</div>
<script type="text/javascript">
	nui.parse();
	var grid1 = nui.get("datagrid1");
	grid1.load();
	//var detailForm1 = new nui.Form("#dataform1");
	
	//var formData = (new nui.Form("#form1")).getData(false,false);
	//grid1.load(formData);
	
	
	var node = null;//当前选中的节点
	
	(function(){
		if(window.parent.getCurrentNode){
			node = window.parent.getCurrentNode();
			window['parentNode'] = node;
			
			if(node.nodeType!="Root"){
				nui.get("lParentId").setValue(node.lProductId);
			}
			loadData(node);
		}
	})();
	
	function loadData(node){
		 search();
		
		 nui.ajax({
            url: "com.cjhxfund.jy.momReport.reportManager.queryProductInfoById.biz.ext",
            type: 'POST',
            data: {lProductId:node.lProductId},
            cache: false,
            contentType:'text/json',
            cache: false,
            success: function (mydata) {
                var o = nui.decode(mydata);
                var form = new nui.Form("#dataform1");
                form.setData(o);
                nui.get("lOpenDate").setValue(dataTemp(nui.get("lOpenDate").getValue()));
                nui.get("lEndDate").setValue(dataTemp(nui.get("lEndDate").getValue()));
                var hllevel = nui.get("hllevel").getValue();
                if((hllevel != "") && (hllevel != null)){
	                if(hllevel == "1"){
	                	nui.get("llevel").setValue("母基金");
	                }else{
	                	nui.get("llevel").setValue("子基金");
	                }
                }
            }
        });
	}
	//查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}
	
	function addProd(){
		 nui.open({
            url: "<%=request.getContextPath() %>/fm/comm/productInfoList.jsp?queryUserType=All",
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
                    var adds = (data.fundCode).split(",");
                    
                    nui.ajax({
			            url: "com.cjhxfund.jy.momReport.reportManager.addProductManger.biz.ext",
			            type: 'POST',
			            data: {
			            	adds:adds,
			            	lProductId:node.lProductId
			            },
			            cache: false,
			            contentType:'text/json',
			            cache: false,
			            success: function (mydata) {
			            	if(mydata.msg!="" && mydata.msg!=null){
			            	    nui.alert(""+mydata.msg+"已经存在，不能添加！","系统提醒");
			            	}else{
			            		nui.alert("添加成功！","系统提醒");
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
	
		nui.confirm("删除后不可恢复，是否确认删除？","系统提醒",function(action){
			if(action=="ok"){
				var rows = grid1.getSelecteds();
		
				if(rows.length>0){
					nui.ajax({
		            url: "com.cjhxfund.jy.momReport.reportManager.deleteProductManger.biz.ext",
		            type: 'POST',
		            data: {deletes:rows},
		            cache: false,
		            contentType:'text/json',
		            cache: false,
		            success: function (mydata) {
		                nui.alert("删除成功！","系统提醒");
		                window.parent.refreshNode(node);
		                search();
			            }
			        });
			
				}else{
					nui.alert("请选择要删除的数据！","系统提醒");
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