<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 刘玉龙
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
		<div class="search-condition">
			<div class="list">
				   <div id="form1" class="nui-form" style="padding:2px;" align="center" >		            
		            <table id="table1" class="table" style="width:100%;table-layout:fixed;">
		                <tr>
		                   	<td class="form_label" width="8%" align="right">产品代码:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="productInfo/vcProductCode"/>
		                    </td>
		                    
		                    <td class="form_label" width="8%" align="right">产品简称:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-textbox" style="width:95%" name="productInfo/vcProductName"/>
		                    </td>	
		                    
 							<td class="form_label" width="8%" align="right">产品类型:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-dictcombobox" name="productInfo/cProductType"  valueField="dictID" textField="dictName" dictTypeId="productType"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
		                    </td> 
		                    
		                    <td class="form_label" width="8%" align="right">产品状态:</td>
		                    <td colspan="1" width="15%" align="left">
		                        <input class="nui-dictcombobox" name="productInfo/cProductStatus"  valueField="dictID" textField="dictName" dictTypeId="productStatus"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
		                    </td> 
		              </tr>
		              <tr>
							<td class="form_label" width="8%" align="right">投资类型:</td>
							<td colspan="1" width="15%" align="left">
							    <input class="nui-dictcombobox" name="productInfo/cInvestType"  valueField="dictID" textField="dictName" dictTypeId="investType"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
							</td> 
							<td class="form_label" width="8%" align="right">产品管理类型:</td>
							<td colspan="1" width="15%" align="left">
							    <input class="nui-dictcombobox" name="productInfo/cManageType"  valueField="dictID" textField="dictName" dictTypeId="productmanagetype"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
							</td>  
							<td class="form_label" width="8%" align="right">产品归属公司:</td>
							<td colspan="1" width="15%" align="left">
							    <input class="nui-dictcombobox" name="productInfo/vcCorporBelongTo"  valueField="dictID" textField="dictName" dictTypeId="corporBelongTo"  
									emptyText="全部" nullItemText="全部" style="width:95%" showClose="true" oncloseclick="onCloseClickValueEmpty" />
							</td>
							<td class="form_label" width="8%" align="right">
							</td>   
		                    <td colspan="1" width="15%" align="left">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
	                        </td>
			              </tr>
		            </table>
		         </div>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
		   
		   <%-- 产品复核权限配置列表开始... --%>
		   <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <!-- <a class='nui-button' plain='false' iconCls="icon-add" onclick="setCheck()">复核设置</a> -->
                            <privilege:operation sourceId="ATS_XZCX_TBO32PI" sid="synProdInfo" clazz="nui-button" onClick="synProdInfo()" lableName="同步产品信息"  iconCls="icon-find" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZCX_TBO32PI" sid="addProdInfo" clazz="nui-button" onClick="addProdInfo()" lableName="新增"  iconCls="icon-add" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZCX_TBO32PI" sid="updateProdInfo" clazz="nui-button" onClick="updateProdInfo()" lableName="修改"  iconCls="icon-edit" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZCX_TBO32PI" sid="delteProdInfo" clazz="nui-button" onClick="delteProdInfo()" lableName="删除"  iconCls="icon-remove" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZCX_SZCPGLLX" sid="updateProductManageType" clazz="nui-button" onClick="updateProductManageType()" lableName="设置产品管理类型"  iconCls="icon-edit" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZCX_SZYQ" sid="updateSealInfo" clazz="nui-button" onClick="updateSealInfo()" lableName="设置印鉴"  iconCls="icon-edit" ></privilege:operation>
                            <privilege:operation sourceId="ATS_XZCX_SZGSGS" sid="updateCorporBelongTo" clazz="nui-button" onClick="updateCorporBelongTo()" lableName="设置产品归属公司"  iconCls="icon-edit" ></privilege:operation>
                        </td>
                    </tr>
                </table>
            </div>

            <div class="nui-fit">
		   		<div id="datagrid1" dataField="productInfos"
		   			class="nui-datagrid" style="width:100%;height:60%;"
		        	url="com.cjhxfund.ats.fm.baseinfo.ProductManager.queryProductInfoWithPage.biz.ext"
		           	pageSize="20" showPageInfo="true"
		           	allowSortColumn="true" sortMode="client"
		         	enableHotTrack="true" allowHeaderWrap="true"
		           	sizeList="[10,20,50,100]"
		           	allowCellEdit="true"
					allowCellSelect="true"
					enterNextCell="true"
					allowMoveColumn="true"
					onselectionchanged="selectionChanged"
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
                            产品简称
                        </div>
                        <div field="vcProductCaption" headerAlign="center" allowSort="true" align="left" width="100px">
                            产品全称
                        </div>
                         <div field="cInvestAdviseCheck" headerAlign="center" allowSort="true" align="left" width="130px" renderer="renderInvestAdvise">
                            投顾复核
                        </div>
                        <div field="cInvestClientCheck" headerAlign="center" allowSort="true" align="left" width="130px" renderer="renderInvestClientCheck">
                            委托人复核
                        </div>
                        <div field="cProductType" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderProductType">
                            产品类型
                        </div>
                        <div field="cProductStatus" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderProductStatus">
                            产品状态
                        </div>
                        
                        <div field="cInvestType" headerAlign="center" allowSort="true" align="left" width="100px" renderer="renderInvestType">
                            投资类型
                        </div>
                        
                        <div field="enProductShare" headerAlign="center" allowSort="true" align="left" width="130px">
                            产品总份额
                        </div>						
                        <div field="lOpenDate" headerAlign="center" allowSort="true" align="left" width="130px" renderer="renderDataTemp">
                            成立日期
                        </div>                        
                        <div field="lEndDate" headerAlign="center" allowSort="true" align="left" width="130px" renderer="renderDataTemp">
                           结束日期
                        </div>
                        <div field="cManageType" headerAlign="center" allowSort="true" align="left" width="130px" renderer="renderManageType">
                           产品管理类型
                        </div>
                        <div field="vcCorporBelongTo" headerAlign="center" allowSort="true" align="left" width="130px" renderer="renderCorporBelongTo">
                           产品归属公司
                        </div>
                        <div field="cSource" headerAlign="center" allowSort="true" visible="false">
                          数据来源
                        </div>
                        <div field="vcCustodianName" headerAlign="center" allowSort="true" visible="false">
                          托管人名称
                        </div>
                        <div field="vcAdminName" headerAlign="center" allowSort="true" visible="false">
                          管理人名称
                        </div>
                        <div field="vcOperationName" headerAlign="center" allowSort="true" visible="false">
                          运营联系人
                        </div>
                        <div field="vcOperationTel" headerAlign="center" allowSort="true" visible="false">
                          运营联系电话
                        </div>
                        <div field="vcOperationPhone" headerAlign="center" allowSort="true" visible="false">
                         运营联系手机
                        </div>
                        <div field="vcOperationEmail" headerAlign="center" allowSort="true" visible="false">
                         运营联系邮箱
                        </div>
                        <div field="lProductId" headerAlign="center" allowSort="true" visible="false">
                         主键ID
                        </div>
                    </div>
                </div>

				<div id="tabs" class="nui-tabs" activeIndex="0" height="40%">
	            	<div title="产品详情">
	              		<div id="dataform1">
	            			<table style="width:100%; table-layout:fixed;margin: 0xp;padding: 0px;" id="table" border="0" class="">	
	            				<tr>
				                    <td style="width:80px;" align="right">产品序号：</td>
				                    <td>
				                    	<input id="detailData.lProductId" name="detailData.lProductId" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
				                    <td style="width:120px; " align="right">产品代码：</td>
				                    <td >
				                    	<input id="detailData.vcProductCode" name="detailData.vcProductCode" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
				                    <td style="width:120px;" align="right">产品简称：</td>
				                    <td>
				                    	<input name="detailData.vcProductName" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
				                    <td style="width:120px;" align="right">产品全称：</td>
				                    <td>
				                    	<input name="detailData.vcProductCaption" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
					        	</tr>
					         	<tr>
				                    <td style="" align="right">产品状态：</td>
				                    <td>
				                    	<input name="detailData.cProductStatus" class="nui-dictcombobox" style="width:100%" dictTypeId="productStatus" readonly="true"/>
				                    </td>
				                    <td style="" align="right">缺省资产单元：</td>
				                    <td>
				                    	<input id="detailData.lDefaultAsset" name="detailData.lDefaultAsset" class="nui-dictcombobox" textField="TEXT1" valueField="ID1" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">成立日期：</td>
				                    <td>
				                    	<input name="detailData.lOpenDate" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">结束日期：</td>
				                    <td>
				                    	<input  name="detailData.lEndDate" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                </tr>

								<tr>
				                   	<td style="" align="right">产品类型：</td>
				                    <td>
				                    	<input name="detailData.cProductType" class="nui-dictcombobox" style="width:100%" dictTypeId="productType" readonly="true"/>
				                    </td>
				                    <td style="" align="right">缺省组合单元：</td>
				                    <td>
				                    	<input id="detailData.lDefaultCombi" name="detailData.lDefaultCombi" class="nui-dictcombobox" textField="TEXT2" valueField="ID2" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">投资类型：</td>
				                    <td>
				                    	<input name="detailData.cInvestType" class="nui-dictcombobox" style="width:100%" dictTypeId="investType" readonly="true"/>
				                    </td>
				                    <td style="" align="right">产品总份额：</td>
				                    <td>
				                    	<input  name="detailData.enProductShare" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                </tr>
					                
				                <tr>
				                   	<td style="" align="right">本币币种：</td>
				                    <td>
				                    	<input name="detailData.vcCurrencyNo" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">允许投资市场：</td>
				                    <td>
				                    	<input name="detailData.vcPermitMarket" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">多币种标志：</td>
				                    <td>
				                    	<input name="detailData.cMultiCurrency" class="nui-dictcombobox" style="width:100%" dictTypeId="multiCurrency" readonly="true"/>
				                    </td>
				                    <td style="" align="right">资金合用标志：</td>
				                    <td>
				                    	<input  name="detailData.cCashAddup" class="nui-dictcombobox" style="width:100%" dictTypeId="cashAddup" readonly="true"/>
				                    </td>
				                </tr>

								<tr>
				                    <td style="" align="right">投顾复核：</td>
				                    <td>
				                    	<input name="detailData.cInvestAdviseCheck" class="nui-dictcombobox" style="width:100%" dictTypeId="investAdviseCheck" readonly="true"/>
				                    </td>
				                    <td style="" align="right">委托人复核：</td>
				                    <td>
				                    	<input name="detailData.cInvestClientCheck" class="nui-dictcombobox" style="width:100%" dictTypeId="investClientCheck" readonly="true"/>
				                    </td>
				                    <td style="" align="right">头寸控制点：</td>
				                    <td>
				                    	<input name="detailData.vcCashControlPoint" class="nui-dictcombobox" style="width:100%" dictTypeId="cashControlPoint" readonly="true"/>
				                    </td>
				                    <td style="" align="right">证券控制点：</td>
				                    <td>
				                    	<input name="detailData.vcStockControlPoint" class="nui-dictcombobox" style="width:100%" dictTypeId="stockControlPoint" readonly="true"/>
				                    </td>
				                </tr>
				                <tr>
				                    <td style="" align="right">托管人名称：</td>
				                    <td>
				                    	<input name="detailData.vcCustodianName" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">管理人名称：</td>
				                    <td>
				                    	<input name="detailData.vcAdminName" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">运营联系人：</td>
				                    <td>
				                    	<input name="detailData.vcOperationName" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">运营联系电话：</td>
				                    <td>
				                    	<input name="detailData.vcOperationTel" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                </tr>
				                <tr>
				                    <td style="" align="right">业务日期：</td>
				                    <td>
				                    	<input name="detailData.lBusinessDate" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                    <td style="" align="right">运营联系手机：</td>
				                    <td>
				                    	<input name="detailData.vcOperationPhone" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                     <td style="" align="right">运营联系邮箱：</td>
				                    <td rowspan="5">
				                    	<input name="detailData.vcOperationEmail" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                     <td style="" align="right">备注：</td>
				                    <td rowspan="5">
				                    	<input name="detailData.vcRemarks" class="mini-textbox" style="width:100%" readonly="true"/>
				                    </td>
				                </tr>
							</table>
				  		</div>	
					</div>	
					
					<div title="产品投资范围">
              			<div id="dataform2">
            				<table style="width:800px; table-layout:fixed; margin:0xp; padding:0px;" id="table" border="0" class="">	
	            				<tr>
	            				  	<td style="width:160px; " align="right">产品占发行规模比例：</td>
				                    <td style="width:200px;">
				                    	<input id="ioccupyScaleProportion" name="ioccupyScaleProportion" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
				                    <td style="width:180px; " align="right">同一发行主体占净值规模上限：</td>
				                    <td style="width:200px;">
				                    	<input name="subjectOccupyNetSize" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
					        	</tr>
					        	<tr>
					        		<td style="" align="right">弱流动性资产规模比例：</td>
				                    <td>
				                    	<input name="weakLiquidityRatio" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
				                    <td style="" align="right">该笔债投资占净值规模比例上限：</td>
				                    <td>
				                    	<input name="netSizeProportion" class="mini-textbox" style="width:100%" readonly="true" />
				                    </td>
					        	</tr>
					        	<tr>
					        		<td style="" align="right">投资范围：</td>
				                    <td colspan="3">
				                    	
				                    	<input  name="scopeInvestment" class="mini-textarea"  style="width: 100%" readonly="true" />
				                    </td>                   
					        	</tr>
					        	
					        	<tr>
					        		<td style="" align="right">可投范围：</td>
				                    <td colspan="3">
				                    	
				                    	<input  name="voteRange" class="mini-textarea"  style="width: 100%" readonly="true" />
				                    </td>
					        	</tr>
					        	
					        	<tr>
					        		<td style="" align="right">投资限制：</td>
				                    <td colspan="3">
				                    	
				                    	<input  name="investmentLimit" class="mini-textarea"  style="width: 100%" readonly="true" />
				                    </td>
					        	</tr>
					        	<tr>
					        		<td style="" align="right">禁投范围：</td>
				                    <td colspan="3">
				                    	
				                    	<input  name="noCastRange" class="mini-textarea"  style="width: 100%" readonly="true" />
				                    </td>
					        	</tr>
					        	<tr>
				                   	<td style="" align="right">备注：</td>
				                    <td colspan="3">
				                    	
				                    	<input  name="remarks" class="mini-textarea" style="width: 100%" readonly="true" />
				                    </td>
					        	</tr>
					        	
					        	
							</table>
						</div>	
		        	</div>
					
					<div title="资产单元">
              			<div id="datagrid2" class="nui-datagrid" style="width:100%;height:100%;"
							url="com.cjhxfund.ats.fm.baseinfo.ProductManager.getContainAssetWithPage.biz.ext" 
							dataField="assetInfos" 
							idField="id" allowResize="true">
							<div property="columns">
								<!--<div type="indexcolumn" ></div>-->
								<div field="vcAssetNo" width="100" allowSort="true">资产单元编号</div>
								<div field="vcAssetName" width="120" headerAlign="center" allowSort="true">资产单元名称</div>
								<div field="cOverdraft" width="120" headerAlign="center" allowSort="true" renderer="renderOverdraft">可否透支</div>
								<div field="vcRemarks" width="100" align="center" headerAlign="center">备注</div>
								<div field="cTrust" width="100" allowSort="true" renderer="renderTrust">是否托管</div>
								<div field="vcInvestOverdraft" width="100" allowSort="true">透支时允许透支的业务</div>
								<div field="cAssetStatus" width="100" allowSort="true" renderer="renderAssetStatus">资产单元状态</div>
								<div field="cCreditAsset" width="100" allowSort="true">资产单元属性</div>
								<div field="cThirdPartyCustody" width="100" allowSort="true" renderer="renderThirdPartyCustody">是否三方存管</div>
							</div>
						</div>
		        	</div>
        			<div title="组合信息">
              			<div id="datagrid3" class="nui-datagrid" style="width:100%;height:100%;"
							url="com.cjhxfund.ats.fm.baseinfo.ProductManager.getContainCombiWithPage.biz.ext" 
							dataField="combiInfos"
							idField="id" allowResize="true">
							<div property="columns">
								<!--<div type="indexcolumn" ></div>-->
								<div field="vcCombiNo" width="120" headerAlign="center" allowSort="true">投资组合编号</div>
								<div field="vcCombiName" width="120" headerAlign="center" allowSort="true">投资组合名称</div>
								<div field="cCombiClass" width="100" align="center" headerAlign="center" renderer="renderCombiClass">组合类型</div>
								<div field="vcAssetName" width="100" allowSort="true">所属资产单元</div>
								<div field="lSetupDate" width="100" allowSort="true" renderer="renderDataTemp">创建日期</div>
								<div field="lEndDate" width="100" headerAlign="center" allowSort="true" renderer="renderDataTemp">结束日期</div>
								<div field="cCombiStatus" width="100" headerAlign="center" allowSort="true" renderer="renderCombiStatus">组合状态</div>
								<div field="cInvestType" width="100" headerAlign="center" allowSort="true" renderer="renderInvestType">投资类型</div>
								<div field="vcStocktypeRight" width="100" headerAlign="center" allowSort="true">证券类别权限</div>
								<div field="vcEntrdireRight" width="100" headerAlign="center" allowSort="true">委托方向权限</div>
								<div field="vcPermitMarket" width="100" headerAlign="center" allowSort="true">允许投资的交易市场</div>
								<div field="vcPermitBusinClass" width="100" headerAlign="center" allowSort="true">允许投资的业务分类</div>
								<div field="vcRemark" width="100" headerAlign="center" allowSort="true">备注</div>
							</div>
						</div>
		        	</div>
		        	<div title="账户信息">
              			<div id="datagrid4" class="nui-datagrid" style="width:100%;height:100%;"
							url="com.cjhxfund.ats.fm.baseinfo.ProductManager.getContainAccountWithPage.biz.ext" 
							dataField="accountInfo"
							idField="id" allowResize="true">
							<div property="columns">
								<div field="lAccountId" width="70" headerAlign="center" allowSort="true">序号</div>
								<div field="vcProductCode" width="80" headerAlign="center" allowSort="true">产品代码</div>
								<div field="vcProductName" width="160" align="center" headerAlign="center">产品名称</div>
								<div field="vcPaymentPlace" width="90" allowSort="true" renderer="vcPaymentPlaceRenderer">登记托管机构</div>
								<div field="vcAccountType" width="70" allowSort="true" renderer="renderAccountType">账户类型</div>
								<div field="vcAccountName" width="100" headerAlign="center" allowSort="true">账户名称</div>
								<div field="vcAccountNo" width="100" headerAlign="center" allowSort="true">账户号码</div>
								<!-- <div header="托管劵商席位号" align="right">
				                <div property="columns">
				                    <div field="vcTrusteeSeatNoSh" width="50" headerAlign="center" allowSort="true">上海</div>
									<div field="vcTrusteeSeatNoSz" width="50" headerAlign="center" allowSort="true">深圳</div>
				                </div>
				            	</div>  -->
				            	<div field="vcTrusteeSeatNo" width="100" headerAlign="center">托管劵商席位号</div>
								<div field="vcTrusteePlace" width="100" headerAlign="center">托管所</div>
								<div field="vcLargePaymentNo" width="100" headerAlign="center" allowSort="true">大额支付号</div>
								<div field="vcRemarks" width="100" headerAlign="center" allowSort="true">备注</div>
							</div>
						</div>
	        		</div>
					<div title="印鉴信息">
						<div id="sealInfoForm" width="100%">
							<table border="0" cellpadding="1" cellspacing="2" style="border-collapse:separate;border-spacing:10px;">
								<tr style="height: 50px">
	            				  	<td style="width:160px;" align="right">传递形式：</td>
				                    <td style="width:300px;" align="right">
				                    	<input name="sealAttachInfo.cInstructionTransferModus" class="nui-dictcombobox" valueField="dictID" textField="dictName" dictTypeId="instructionTransferModus" style="width: 100%" readonly="true" />
				                    </td>
				                    <td  align="right">预留印鉴：</td>
				                    <td style="border: 1px solid #a5acb5;" rowspan="3">
										<img src="./timg.jpg"  id="sealAttachPath" width="300px" height="180px" >
									</td>
					        	</tr>
					        	<tr align="left" style="height: 50px;">
				                   	<td style="" align="right">授权人签字：</td>
				                    <td style="width:300px;">
				                    	<input name="sealAttachInfo.vcAuthorizedSignature" class="nui-textarea" style="width: 100%" readonly="true" />
				                    </td>
					        	</tr>
					        	<tr align="left" style="height: 50px">
					        	</tr>
							</table>
						</div>
					</div>
            	</div>
		    <%-- 产品权限配置列表结束!!! --%>
			</div>
	</div>	
</div>
<script type="text/javascript">
	nui.parse();
	var grid1 = nui.get("datagrid1");
	var grid2 = nui.get("datagrid2");
	var grid3 = nui.get("datagrid3");
	var grid4 = nui.get("datagrid4");
	
	var detailForm1 = new nui.Form("#dataform1");
	var detailForm2 = new nui.Form("#dataform2");
	var sealInfoForm = new nui.Form("#sealInfoForm");
	
	var formData = new nui.Form("#form1").getData(false,false);
	grid1.load(formData);
	 $("#dataform1 .mini-buttonedit-buttons").remove();
	 $("#sealInfoForm .mini-buttonedit-buttons").remove();
	 $("#dataform2 .mini-buttonedit-buttons").remove();
	var detalForm1 = new nui.Form("#dataform1");
	
	//查询
	function search() {
		var form = new nui.Form("#form1");
		var json = form.getData(false,false);
		grid1.load(json);//grid查询
	}
	
	//设置复核条件
	function setCheck() {
		var rows = grid1.getSelecteds();
		if (rows.length > 1){
			nui.open({
				url: "<%=request.getContextPath()%>/fm/baseinfo/productManager/productCheckSelectForm.jsp",
				title: "批量复核设置", width: 600, height: 200,
				onload: function () {//弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {pageType:"multiSet",records:rows};//传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {//弹出页面关闭前
					grid1.reload();
				}
			});
		}else if(rows.length == 1){
			var row = grid1.getSelected();
			var cInvestAdviseCheck = false;
			var cInvestClientCheck = false;
			if(row.cInvestAdviseCheck=="1"){
				cInvestAdviseCheck = true;
			}
			if(row.cInvestClientCheck=="1"){
				cInvestClientCheck = true;
			}
			nui.open({
				url: "<%=request.getContextPath()%>/fm/baseinfo/productManager/productCheckSelectForm.jsp",
				title: "复核设置", width: 600, height: 200,
				onload: function () {//弹出页面加载完成
					var iframe = this.getIFrameEl();
					var data = {pageType:"singleSet",record:{ProductInfo:row,cInvestAdviseCheck:cInvestAdviseCheck,cInvestClientCheck:cInvestClientCheck},records:rows};//传入页面的json数据
					iframe.contentWindow.setFormData(data);
				},
				ondestroy: function (action) {//弹出页面关闭前
					grid1.reload();
				}
			});
		}else{
			nui.alert("请选中要设置的记录！");
		}
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
	
	//当选择列时
	function selectionChanged(){
		var rows = grid1.getSelecteds();
		if(rows.length == 1){
			var record = grid1.getSelected();
			var newRow = jQuery.extend(true, {}, record);
		 	newRow.lBusinessDate = dataTemp(newRow.lBusinessDate);
			newRow.lOpenDate = dataTemp(newRow.lOpenDate);
			newRow.lEndDate = dataTemp(newRow.lEndDate);
			detailForm1.setData({detailData: newRow});
			sealInfoForm.setData({sealAttachInfo: newRow});
			if(newRow.sealAttachPath != "" && newRow.sealAttachPath != null){
				var imgPath = newRow.sealAttachPath;
				imgPath = "<%= request.getContextPath() %>"+imgPath.match(/ats.war(\S*)/)[1];
				document.getElementById("sealAttachPath").src = imgPath;
			}else{
				document.getElementById("sealAttachPath").src = "./timg.jpg";
			}
			grid2.load({lProductId:record.lProductId});
			grid3.load({lProductId:record.lProductId});
			grid4.load({vcProductCode:record.vcProductCode});
			var json = nui.encode({vcProductCode:record.vcProductCode});
			
			$.ajax({
				url:"com.cjhxfund.ats.fm.baseinfo.ProductManager.getInvestRange.biz.ext",
				type:'POST',
				data:json,
				cache: false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						(new nui.Form("#dataform2")).setData(returnJson.investRange);
						var lDefaultAsset = nui.get("detailData.lDefaultAsset");
                        var url = "com.cjhxfund.ats.fm.baseinfo.ProductManager.queryAssetAndCombi.biz.ext";
                        lDefaultAsset.setUrl(url); 
                        var lDefaultCombi = nui.get("detailData.lDefaultCombi");
                        var url1 = "com.cjhxfund.ats.fm.baseinfo.ProductManager.queryAssetAndCombi.biz.ext?type=1";
                        lDefaultCombi.setUrl(url1); 
					}
				}
			});
			nui.get("updateProdInfo").enable();
		}else{
			detailForm1.clear();
			//detailForm2.clear();
			grid2.clearRows();
			grid3.clearRows();
			grid4.clearRows();
			sealInfoForm.clear();
			if(rows.length > 1){
			   nui.get("updateProdInfo").disable();
			}
		}
	}
	
	
	function renderDataTemp(e){
			if(e.value == "0" || e.value == null){
				return "";
			}
			return dataTemp(e.value);
	}
	
	// 管理类型翻译
	function renderManageType(e){
		return nui.getDictText("productmanagetype",e.row.cManageType);
	}
	
	// 产品归属公司翻译
	function renderCorporBelongTo(e){
		return nui.getDictText("corporBelongTo",e.row.vcCorporBelongTo);
	}
	
	
	function format(){
		siformat=false;
	}
	
	function dataTemp(oldData){
		oldData = oldData+"";
		if(oldData=="0" || oldData=="" || oldData=="null" || oldData==null || oldData=="1" || oldData==undefined || oldData=="undefined"){
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
	
	 //获取O32产品信息
    function synProdInfo() {
	          var type = 12;
	          var json = nui.encode({buttonType:type});
	          nui.ajax({
	            url: "com.cjhxfund.ats.fm.baseinfo.synBondInfoData.getBondInfoData.biz.ext",
	            type: "post",
	            contentType:'text/json',
	            data: json ,
	            success: function (text) {
	              var returnJson = nui.decode(text);
	              if (returnJson.returnValue == true) {
	                 nui.alert("同步O32产品信息结果：成功", "", function(){});
	              }
	              else {
	              	 nui.alert("同步O32产品信息结果：失败", "", function(){});
	              }
	            }
	          });  
        }
        	 //渲染行对象
			 grid4.on("drawcell", function (e) {
		        row=e.row;
		        field = e.field;
		         	//action列，超连接操作按钮
			        if (field == "vcTrusteeSeatNo") {
			            e.cellStyle = "text-align:center";
			            var vcTrusteeSeatNoSh = row.vcTrusteeSeatNoSh;
			            var vcTrusteeSeatNoSz = row.vcTrusteeSeatNoSz;
			            if((vcTrusteeSeatNoSh==null || vcTrusteeSeatNoSh=="undefined") && (vcTrusteeSeatNoSz==null || vcTrusteeSeatNoSz=="undefined")){
					   		   e.cellHtml="";
				   		}else{
				   		   if(vcTrusteeSeatNoSz!=null && vcTrusteeSeatNoSh!=null){
				   		   e.cellHtml=vcTrusteeSeatNoSz+"(深圳)/"+vcTrusteeSeatNoSh+"(上海)";
					   		}
					   		if(vcTrusteeSeatNoSh==null || vcTrusteeSeatNoSh=="undefined"){
					   			e.cellHtml=vcTrusteeSeatNoSz+"(深圳)";
					   		}else{
					   			e.cellHtml=vcTrusteeSeatNoSh+"(上海)";
					   		}
				   		}
				   		
			        }
			        	
        	}); 
        
	function addProdInfo(){
		nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/productManager/openProductInfo.jsp",
                    title: "产品信息维护", width: 850, height: 575,
                    onload: function () {//弹出页面加载完成
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"add"};//传入页面的json数据
                       iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {//弹出页面关闭前
                       grid1.reload();
                    }
             });
	}
	//修改
    function updateProdInfo() {
        var row = grid1.getSelected();
        if (row) {
            if(row.cSource!=1){
	              nui.alert("不能修改O32过来的数据！", "系统提示");
	              return;
	           }
            nui.open({
                url: "<%=request.getContextPath() %>/fm/baseinfo/productManager/openProductInfo.jsp",
                title: "产品信息维护",
                width: 850,
                height: 575,
                onload: function () {
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"edit",record:{productinfo:row}};
	                    //直接从页面获取，不用去后台获取
	                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {
                        
                        grid1.reload();
                    }
                    });
                } else {
                    nui.alert("请选中一条记录","提示");
                }
            }
		//删除
		   function delteProdInfo(){
				var rows = grid1.getSelecteds();
				if(rows.length > 0){
			        for(var k=0;k<rows.length;k++){
			           if(rows[k].cSource!=1){
			              nui.alert("不能删除O32过来的数据！", "系统提示");
			              return;
			           }
			        }
					nui.confirm("确定删除选中记录？","系统提示",
					function(action){
						if(action=="ok"){
							var json = nui.encode({productinfo:rows});
							grid1.loading("正在删除中,请稍等...");
							$.ajax({
								url:"com.cjhxfund.ats.fm.baseinfo.ProductManager.deleteProdcutInfo.biz.ext",
								type:'POST',
								data:json,
								cache: false,
								contentType:'text/json',
								success:function(text){
									var returnJson = nui.decode(text);
									if(returnJson.returnCode == "yes"){
										grid1.reload();
										nui.alert("删除成功", "系统提示", function(action){
										});
									}else if(returnJson.returnCode == "no"){
									    grid1.unmask();
										nui.alert("产品已被引用，无法删除！", "系统提示");
									}else{
										grid1.unmask();
										nui.alert("删除失败!", "系统提示");
									}
								}
							});
						}
					});
				}else{
					nui.alert("请选中一条记录！");
				}
		}    
		
		// 设置产品管理类型
		function updateProductManageType(){
			var rows = grid1.getSelecteds();
			if(rows.length<1){
				nui.alert("请至少选择一条产品设置管理类型","提示");
				return;
			}
			nui.open({
				url : nui.context + "/fm/baseinfo/productManager/updateProductManageType.jsp",
				title : "设置产品管理类型",
				width : 400,
				height : 189,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setData(rows);
				},
				ondestroy : function(action) {
					var iframe = this.getIFrameEl();
		            //获取选中、编辑的结果
		            var returnJson = iframe.contentWindow.getData();
		            if(returnJson!= null){
			            returnJson = mini.clone(returnJson);    //必须。克隆数据。
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
	                			nui.alert(returnJson.rtnMsg,"系统提示",function(action){
					    			if(action == "ok"){
										search();
					    			}
				    			});
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								nui.alert(returnJson.rtnMsg,"系统提示");
							}
						}else{
							nui.alert("系统异常","系统提示");
						}
		            }else{
		            	if(action == "ok"){
							search();
		            	}
		            }
				}
			});
		}     
		
		// 设置印鉴信息
		function updateSealInfo(){
			var rows = grid1.getSelecteds();
			var row = grid1.getSelected();
			if(rows.length>1){
				nui.alert("只能进行单条修改","提示");
				return
			}else if(rows.length==0){
				nui.alert("请至少选择一条产品设置印鉴信息","提示");
				return;
			}
			nui.open({
				url : nui.context + "/fm/baseinfo/productManager/updateProductSealInfo.jsp",
				title : "设置印鉴信息",
				width : 500,
				height : 400,
				onload : function() {
					var iframe = this.getIFrameEl();
					if(row.cInstructionTransferModus == undefined){
						row['cInstructionTransferModus'] = "";
					}
					if(row.vcAuthorizedSignature == undefined){
						row['vcAuthorizedSignature'] = "";
					}
					if(row.vcPrintAttachId == undefined){
						row['vcPrintAttachId'] = "";
					}
					iframe.contentWindow.setData(row);
				},
				ondestroy : function(action) {
					var iframe = this.getIFrameEl();
		            //获取选中、编辑的结果
		            var returnJson = iframe.contentWindow.getData();
		            if(returnJson!= null){
			            returnJson = mini.clone(returnJson);    //必须。克隆数据。
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
	                			nui.alert(returnJson.rtnMsg,"系统提示",function(action){
					    			if(action == "ok"){
										search();
					    			}
				    			});
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								nui.alert(returnJson.rtnMsg,"系统提示");
							}
						}else{
							nui.alert("系统异常","系统提示");
						}
		            }else{
		            	if(action == "ok"){
							search();
		            	}
		            }
				}
			});
		}     
		
		// 设置产品归属公司
		function updateCorporBelongTo(){
			var rows = grid1.getSelecteds();
			if(rows.length<1){
				nui.alert("请至少选择一条产品设置归属公司","提示");
				return;
			}
			nui.open({
				url : nui.context + "/fm/baseinfo/productManager/updateProductBelongCompany.jsp",
				title : "设置产品归属公司",
				width : 400,
				height : 183,
				onload : function() {
					var iframe = this.getIFrameEl();
					iframe.contentWindow.setData(rows);
				},
				ondestroy : function(action) {
					var iframe = this.getIFrameEl();
		            //获取选中、编辑的结果
		            var returnJson = iframe.contentWindow.getData();
		            if(returnJson!= null){
			            returnJson = mini.clone(returnJson);    //必须。克隆数据。
						if(returnJson.exception == null){
							if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_SUCCESS%>"){
	                			nui.alert(returnJson.rtnMsg,"系统提示",function(action){
					    			if(action == "ok"){
										search();
					    			}
				    			});
							}else if(returnJson.rtnCode == "<%=com.cjhxfund.commonUtil.Constants.ATS_ERROR%>"){
								nui.alert(returnJson.rtnMsg,"系统提示");
							}
						}else{
							nui.alert("系统异常","系统提示");
						}
		            }else{
		            	if(action == "ok"){
							search();
		            	}
		            }
				}
			});
		}     
	
</script>
</body>
</html>