<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/repurchase/investNew/CFJYProductProcessForm_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2015-10-09 11:42:39
- Description: 指令/建议录入指令/建议单_正逆回购业务
--%>
<head>
<title>指令/建议录入指令/建议单_正逆回购业务</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body>
        <!-- 标识页面是查看(query)、修改(edit)、新增(add) -->
        <input name="pageType" class="nui-hidden"/>
        <div id="dataform1" style="padding-top:5px;">
            <!-- hidden域 -->
            <input class="nui-hidden" name="zhfwptjyznhg.processType4InvestProductNum" value="03,04,05,06,16,17,21,22"/>
            <input class="nui-hidden" name="zhfwptjyznhg.processId"/>
            <input class="nui-hidden" name="zhfwptjyznhg.processStatus" id="processStatus"/>
            <input class="nui-hidden" name="zhfwptjyznhg.roleType" id="roleType"/>
            <input class="nui-hidden" name="zhfwptjyznhg.bonds" id="zhfwptjyznhg.bonds"/>
            <input class="nui-hidden" name="zhfwptjyznhg.dataSource" id="zhfwptjyznhg.dataSource"/>
            <!-- 业务类别 2-银行间二级市场业务-->
            <input class="nui-hidden" name="zhfwptjyznhg.businclass" id="businclass" value="2"/>
            <!-- 指令/建议操作级别：0无；1快速；2一般；3慢速；数据字典40345项  -->
            <input class="nui-hidden" name="zhfwptjyznhg.instructionlevel" id="instructionlevel" value="0"/>
            <!-- 结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户； -->
            <input class="nui-hidden" name="zhfwptjyznhg.bondsettletype" id="bondsettletype" value="3"/>
            <!-- 【只用于银行间回购】到期结算方式：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户； -->
            <input class="nui-hidden" name="zhfwptjyznhg.bondsettletype2" id="bondsettletype2" value="3"/>
            <!-- 投资类型：交易所，1-可交易；2-持有到期；3-可供出售；回购业务投资类型为1-可交易，不传投资类型会根据系统数决定取组合的投资类型或缺省为1-可交易，具体取值和O3保持一致。 -->
            <input class="nui-hidden" name="zhfwptjyznhg.investtype" id="investtype" value="1"/>
            <!-- 价格模式：1 - 市价（表示不限制委托价格，在涨跌停范围内即可）；2 - 限价（表示限制委托价格，买入不高于，卖出不低于）； -->
            <input class="nui-hidden" name="zhfwptjyznhg.ordtype" id="ordtype" value="2"/>
            <!-- 交易市场：OTC-场外； -->
            <input class="nui-hidden" name="zhfwptjyznhg.exdestination" id="exdestination" value="OTC"/>
            <!-- 回购用途类别：1：等期限套利；2：不等期限套利；3：短期资金运用；4：超配；5：放大； -->
            <input class="nui-hidden" name="zhfwptjyznhg.purposetype" id="purposetype" value=""/>
            <!-- 判断可用（风控）：0-不判；1-判； -->
            <input class="nui-hidden" name="zhfwptjyznhg.judgeavailable" id="judgeavailable" value="1"/>
            <!-- 判断风控：0-不判；1-判； -->
            <input class="nui-hidden" name="zhfwptjyznhg.judgerisk" id="judgerisk" value="1"/>
            <!--指令/建议有效结束日期：当Tag59=6GTD时，指定该指令/建议的有效日期，其他无需指定。 -->
            <input class="nui-hidden" name="zhfwptjyznhg.expiredate" id="expiredate" value=""/>
            
            <table style="width:100%;height:100%;table-layout:fixed;" class="nui-form-table">
                
                <tr>
                    <td class="form_label" align="right" width="23%">
                        业务日期:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="processDate" class="nui-datepicker" name="zhfwptjyznhg.processDate" required="true" value=""/>
                    </td>
                    <td class="form_label" align="right" width="23%">
                        业务类别:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="processType" class="nui-dictcombobox" dictTypeId="CF_JY_PRODUCT_PROCESS_TYPE_ZNHG_SHORT" name="zhfwptjyznhg.processType" emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" required="true" onvaluechanged="changedProcessType(e)"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right" width="23%">
                        产品名称:
                    </td>
                    <td colspan="1" width="27%">
                        <input id="combProductCode" required="true" class="nui-autocomplete" style="width:150px;" name="zhfwptjyznhg.combProductCode" searchField="searchKey" dataField="combProducts"
                        	valueField="fundCode" textField="fundName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductsByKeyAndUserId.biz.ext" value="" text="" enterQuery="false" onvaluechanged="changedCombProductCode"/>
                        <input id="combProductName" class="nui-hidden" name="zhfwptjyznhg.combProductName"/>
                    </td>
                    <td class="form_label" align="right" width="23%">
                        组合名称:
                    </td>
                    <td colspan="1" width="27%">
                       <input class="nui-combobox" id="vcCombiNo"  required="true" dataField="productCombis"  name="zhfwptjyznhg.vcCombiNo" 
	                        valueField="vcCombiNo" textField="vcCombiName" onvaluechanged="setVcCombiName" searchField="searchKey" value="" text="" enterQuery="false"/>
	                      <input class="nui-hidden" id="vcCombiName" name="zhfwptjyznhg.vcCombiName"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        券面总额合计（万元）:
                    </td>
                    <td colspan="1">
                        <input id="investCount" class="nui-textbox" name="zhfwptjyznhg.investCount" required="true" onblur="investCountFun()"/>
                    </td>
                    <td class="form_label" align="right">
                        交易金额（万元）:
                    </td>
                    <td colspan="1">
                        <input id="tranAmount" class="nui-textbox" name="zhfwptjyznhg.tranAmount" required="false" onblur="tranAmountFun()"/>
                    </td>
                </tr>
                <tr>
                	<td class="form_label" align="right">
                        回购期限（天）:
                    </td>
                    <td colspan="1">
                        <input id="actualDays" class="nui-textbox" name="zhfwptjyznhg.actualDays" required="true" onblur="actualDaysFun()"/>
                        <%-- 证券申报代码 --%>
                        <input class="nui-hidden" name="zhfwptjyznhg.symbol" id="symbol" value=""/>
                    </td>
                    <td class="form_label" align="right">
                        交易对手:
                    </td>
                    <td colspan="1">
                        <input id="tradingOpponent" class="nui-textbox" name="zhfwptjyznhg.tradingOpponent" required="false"/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        回购利率（%）:
                    </td>
                    <td colspan="1">
                        <input id="tradingRate" class="nui-textbox" name="zhfwptjyznhg.tradingRate" required="true"/>
                    </td>
                    <td class="form_label" align="right">
                        清算速度:
                    </td>
    				<td colspan="1" class="radio-border-top-none">
            			<input id="clearingSpeed" class="nui-dictradiogroup" dictTypeId="CF_JY_PRODUCT_PROCESS_CLEARING_SPEED" name="zhfwptjyznhg.clearingSpeed" value="T+0" repeatItems="1" repeatLayout="none" repeatDirection="horizontal" onvaluechanged="clearingSpeedOnvaluechanged(e)"/>
            		</td>
                </tr>
                <tr>
                	<td class="form_label" align="right">
                        首次结算日:
                    </td>
                    <td colspan="1">
                        <input id="firstSettlementDate" class="nui-datepicker" name="zhfwptjyznhg.firstSettlementDate" required="true" value=""/>
                    </td>
                    <td class="form_label" align="right">
                        到期结算日:
                    </td>
                    <td colspan="1">
                        <input id="expiryDate" class="nui-datepicker" name="zhfwptjyznhg.expiryDate" required="true" value=""/>
                    </td>
                </tr>
                <tr>
                    <td class="form_label" align="right">
                        备注:
                    </td>
                    <td colspan="3">
                        <input class="nui-textarea"name="zhfwptjyznhg.remark" width="100%"/>
                    </td>
                </tr>
            </table>
            
            
            <div title="回购债券信息">
			  <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
			    <table style="width:100%;">
			      <tr>
			        <td style="width:100%;">
			          	回购债券信息
			        </td>
			        <td >
			          <a class="nui-button " plain="false" iconCls="icon-add" onclick="gridAddRow('grid_0')"  plain="false" tooltip="增加">
			            &nbsp;
			          </a>
			        </td>
			        <td >
			          <a class="nui-button " plain="false" iconCls="icon-remove" onclick="gridRemoveRow('grid_0')"  plain="false" tooltip="删除">
			            &nbsp;
			          </a>
			        </td>
			        <td >
	                  <a class="nui-button " plain="false" iconCls="icon-reload" onclick="gridReload('grid_0')"  plain="false" tooltip="刷新">
	                    &nbsp;
	                  </a>
	                </td>
			      </tr>
			    </table>
			  </div>
			  
			  <div 
		              id="grid_0"
		              class="nui-datagrid"
		              style="width:100%;height:145px;"
		              showPager="false"
		              sortMode="client"
		              url="com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_queryBondsByProcessId.biz.ext"
		              dataField="bonds"
		              allowCellEdit="true"
		              allowCellSelect="true"
		              multiSelect="true"
		              editNextOnEnterKey="true"
		              oncellendedit="autoCalc"
		              ondrawcell="onDrawCell"
		              >
			    <div property="columns">
			      <div type="indexcolumn"></div>
			      <div type="checkcolumn"></div>
			      <div field="bondCode" allowSort="true" align="center" headerAlign="center" width="100px" >
			        债券代码
			        <input id="bondCode" required="true" class="nui-autocomplete" popupWidth="300" popupHeight="200" style="width:100px;" name="bondCode" property="editor" searchField="searchKey" dataField="investProducts"
                        	valueField="investProduct" textField="investProduct" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductsByKey.biz.ext" value="" text="" enterQuery="false"/>
			      </div>
			      <div field="bondName" allowSort="true" align="center" headerAlign="center" width="150px" >
			        债券名称
			        <input id="bondName" class="nui-textbox" name="bondName" property="editor" required="true"/>
			      </div>
			      <div field="bondAmount" allowSort="true" align="right" headerAlign="center" width="">
			        券面总额（万元）
			        <input id="bondAmount" class="nui-textbox" name="bondAmount" property="editor" required="true" onblur="bondAmountFun()"/>
			      </div>
			      <div field="conversionRatio" allowSort="true" align="right" headerAlign="center" width="">
			        折算比例（%）
			        <input id="conversionRatio" class="nui-textbox" name="conversionRatio" property="editor" required="true"/>
			      </div>
			      <div field="firstNetValue" allowSort="true" align="right" headerAlign="center" width="">
			        首次净价（元）
			        <input id="firstNetValue" class="nui-textbox" name="firstNetValue" property="editor" required="true" onblur="firstNetValueFun()"/>
			      </div>
			    </div>
			  </div>
			</div>
            
            
            <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                        	<!-- <a class='nui-button' plain='false' iconCls="icon-tip" onclick="saveData(0)">
                                风控试算
                            </a>
                            <span style="display:inline-block;width:25px;"></span> -->
                            <a class='nui-button' plain='false' iconCls="icon-save" onclick="saveData(1)">
                                保存
                            </a>
                            <span style="display:inline-block;width:25px;">
                            </span>
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
                                取消
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
        <script type="text/javascript">
            nui.parse();
            var date = new Date();
            nui.get("processDate").setValue(date);//业务日期
            nui.get("firstSettlementDate").setValue(date);//首次结算日
            nui.get("expiryDate").setValue(date);//到期结算日
            
            
            //新增债券记录
            function gridAddRow(datagrid){
				var grid = nui.get(datagrid);
		        var totalCount = grid.getData().length;
		        if(totalCount>=10){
		        	nui.alert("最多只能输入10支债券信息","提示");
				    return;
		        }else{
		        	grid.addRow({});
		        }
		        //自动计算券面总额合计（万元）与交易金额（万元）字段值
                autoCalc();
			}
			//删除债券记录
			function gridRemoveRow(datagrid) {
		        var grid = nui.get(datagrid);
		        var rows = grid.getSelecteds();
		        if (rows.length > 0) {
					grid.removeRows(rows, true);
		        }
		        //自动计算券面总额合计（万元）与交易金额（万元）字段值
                autoCalc();
			}
			//重新加载债券信息
			function gridReload(datagrid){
				var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
				if(pageType=="edit"){
					var grid = nui.get(datagrid);
        			grid.reload();
				}
				//自动计算券面总额合计（万元）与交易金额（万元）字段值
                autoCalc();
			}
			//设置债券记录
			function setGridData(datagrid,dataid){
		        var grid = nui.get(datagrid);
		        var grid_data = grid.getData();
		        var grid_data_new = new Array();
		        for(var i=0; i<grid_data.length; i++){
		        	var bond = grid_data[i];
                	var bondCode = bond.bondCode;//债券代码
                	var bondName = bond.bondName;//债券名称
                	var bondAmount = bond.bondAmount;//券面总额（万元）
                	var conversionRatio = bond.conversionRatio;//折算比例（%）
                	var firstNetValue = bond.firstNetValue;//首次净价（元）
                	var bondCodeTemp = bondCode;
                	var bondNameTemp = bondName;
                	if(bondCode!=null && bondCode!="" && bondCode.indexOf("-")!=-1){//若是选择债券，则将债券代码、债券名称拆分保存
                		bondCodeTemp = bondCode.substr(0, bondCode.indexOf("-"));
                		if(bondCode.length >= bondCode.indexOf("-")+1){
                			bondNameTemp = bondCode.substr(bondCode.indexOf("-")+1, bondCode.length);
                		}
                	}
                	var bondTemp = {bondCode:bondCodeTemp,bondName:bondNameTemp,bondAmount:bondAmount,conversionRatio:conversionRatio,firstNetValue:firstNetValue};
                	grid_data_new.push(bondTemp);
		        }
		        nui.get(dataid).setValue(grid_data_new);
			}
               

            function saveData(type){//type==0:风控试算   type==1:保存
				
                var form = new nui.Form("#dataform1");
                form.setChanged(false);
                //风控试算路径
                var riskControlUrl = "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.repurchaseRiskControl.biz.ext";
                //保存
                var urlStr = "com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_add.biz.ext";
                var pageType = nui.getbyName("pageType").getValue();//获取当前页面是编辑还是新增状态
                var roleType = nui.get("roleType").getValue();//获取当前页面是投顾打开还是交易员填单打开
                //编辑
                if(pageType=="edit"){
                    urlStr = "com.cjhxfund.jy.ProductProcess.JY_ZNHG.JY_ZNHG_update.biz.ext";
                }
                
                //获取到期结算日
                var expiryDate = form.getData().zhfwptjyznhg.expiryDate;
                //设置债券信息
                setGridData("grid_0","zhfwptjyznhg.bonds");
                var gridData = nui.get("zhfwptjyznhg.bonds").getValue();
                //拼接债券代码,用于sql查询
                var bondCodeStr = "";
                for(var i=0;i<gridData.length;i++){
                	bondCodeStr += "'"+gridData[i].bondCode+"'";
                	if(i<gridData.length-1){
                		bondCodeStr += ",";
                	}
                }
                
                //若债券信息为空，则不做查询判断
                if(bondCodeStr!=null && bondCodeStr!=""){
                	var delistingDate = "";
					var stockName = "";
					var stockCode = "";
					nui.ajax({
						url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG_Bond.getDelistingDate.biz.ext",
						type:"POST",
						data:{dataObject:bondCodeStr},
						cache: false, 
						async: false,
						contentType:"text/json",
						success:function(text){
							//摘牌日期
							delistingDate = text.info[0].delistingDate;
							//债券代码
							stockCode = text.info[0].stockCode;
							//债券名字
							stockName = text.info[0].stockName;
							
						},
						error:function(){
						}
					});
					
					if(delistingDate){
						//到期结算日 转换为数字以便比较
						var expiryDateNumber = expiryDate.replaceAll("-","");
						expiryDateNumber = expiryDateNumber.substr("0","8");
						//投顾确认指令/建议时机器猫未控制回购所压债券的摘牌日期不得早于回购交割日
						if(expiryDateNumber>delistingDate){
							nui.alert("【到期结算日["+expiryDateNumber+"]】不得大于【"+stockCode+"-"+stockName+"】的【摘牌日期["+delistingDate+"]】","系统提示",function(){
		                		nui.get("expiryDate").focus();
		                	});
	                		return;
						}
					}
	                
	                
	                var trusteeshipAlertInfo = "";
	                var trusteeshipAlertFlag = false;
	                nui.ajax({
						url:"com.cjhxfund.jy.ProductProcess.JY_ZNHG_Bond.getTrusteeship.biz.ext",
						type:"POST",
						data:{dataObject:bondCodeStr},
						cache: false, 
						async: false,
						contentType:"text/json",
						success:function(text){
							//托管所名称
							itemName = text.info[0].itemName;
							var info = text.info;
							for(var i=0;i<info.length;i++){
								trusteeshipAlertInfo += "【"+info[i].reportCode+"-"+info[i].stockName+"】 是【"+info[i].itemName+"】 的债券<br/>";
								if(itemName!=info[i].itemName){
									trusteeshipAlertFlag = true;
								}
								if(i==info.length-1){
									trusteeshipAlertInfo += "质押券必须属于同一个托管所";
								}
								
							}
							
						},
						error:function(){
						}
					});
	                
	                if(trusteeshipAlertFlag){
						nui.alert(trusteeshipAlertInfo,"系统提示",function(){
	                	});
	            		return;
					}
                }
                
                form.validate();
                if(form.isValid()==false) return;
                
                //特殊验证，业务类别：03-质押式正回购;04-质押式逆回购;(如果是质押式回购需要根据回购天数查询O32是否存在证券代码)
            	if(nui.get("processType").getValue() == "03" || nui.get("processType").getValue() == "04"){
                	if(nui.get("symbol").getValue()==null || nui.get("symbol").getValue()==""){
	                	nui.alert("O32系统无该回购期限(天)对应的证券代码，请联系交易员先新增该回购期限对应的证券代码","系统提示",function(){
	                		nui.get("actualDays").focus();
	                	});
	                	return; 
	                }
            	}
                
                
                //获取产品名称值
                var combProductCodeVal = nui.get("combProductCode").getValue();//获取产品代码值
                var combProductNameVal = nui.get("combProductCode").getText();//获取产品名称值（从表单显示值取）
                nui.get("combProductName").setValue(combProductNameVal);
                if(combProductCodeVal==combProductNameVal){
                	nui.alert("请输入选择正确的产品名称","提示");
            		nui.get("combProductCode").focus();
			        return; 
                }
                
                //设置指令/建议有效结束日期
                nui.get("expiredate").setValue(nui.get("processDate").getValue());
                
                
                    //若是完整指令/建议，则需要特殊验证
                	//特殊验证，业务类别：03-质押式正回购;04-质押式逆回购;05-买断式正回购;06-买断式逆回购；21-交易所正回购；22-交易所逆回购；
	                var processTypeVal = nui.get("processType").getValue();//业务类别
	                if(processTypeVal!="04" && processTypeVal!="21" && processTypeVal!="22"){//质押券设置为非必填项目：04-质押式逆回购;;21-交易所正回购；22-交易所逆回购；
	                	//债券（质押式可以最多10行）
		                var bondsVal = nui.get("zhfwptjyznhg.bonds").getValue();//债券记录信息
		                if(bondsVal.length==0){
		                	nui.alert("债券信息不能为空","提示");
						    return;
		                }else if(bondsVal.length>10){
		                	nui.alert("最多只能输入10支债券信息","提示");
						    return;
		                }
		                
		                for(var i=0; i<bondsVal.length; i++){
		                	var bond = bondsVal[i];
		                	var bondCode = bond.bondCode;//债券代码
		                	var bondName = bond.bondName;//债券名称
		                	var bondAmount = bond.bondAmount;//券面总额（万元）
		                	var conversionRatio = bond.conversionRatio;//折算比例（%）
		                	var firstNetValue = bond.firstNetValue;//首次净价（元）
		                	
		                	if(bondCode==undefined || bondCode==null || bondCode==""){
		                		nui.alert("第 "+(i+1)+" 行债券信息 [债券代码] 不能为空","提示");
						    	return;
		                	}
		                	if(bondName==undefined || bondName==null || bondName==""){
		                		nui.alert("第 "+(i+1)+" 行债券信息 [债券名称] 不能为空","提示");
						    	return;
		                	}
		                	if(bondAmount==undefined || bondAmount==null || bondAmount==""){
		                		nui.alert("第 "+(i+1)+" 行债券信息 [券面总额（万元）] 不能为空","提示");
						    	return;
		                	}
		                	if(conversionRatio==undefined || conversionRatio==null || conversionRatio==""){
		                		nui.alert("第 "+(i+1)+" 行债券信息 [折算比例（%）] 不能为空","提示");
						    	return;
		                	}
		                	if(processTypeVal=="05" || processTypeVal=="06"){
		                		if(firstNetValue==undefined || firstNetValue==null || firstNetValue==""){
			                		nui.alert("第 "+(i+1)+" 行债券信息 [首次净价（元）] 不能为空","提示");
							    	return;
			                	}
		                	}
		                }
	                }
                
	
                //保存数据
                var processStatusUrl = "com.cjhxfund.jy.ProductProcess.JY_ZNHG.getProcessStatus_ZNHG.biz.ext";
                var validStatusUrl = "com.cjhxfund.jy.ProductProcess.JY_ZNHG.getValidStatus_ZNHG.biz.ext";
                //对于完整指令/建议先进行风控试算，根据结果进行处理，对于询价指令/建议直接保存数据
                if(type=="0"){
	                var data = form.getData(false,true);
	                var json = nui.encode(data);
	                $.ajax({
			            url:riskControlUrl,
			            type:'POST',
			            data:json,
			            cache:false,
			            contentType:'text/json',
			            success:function(text){
			            	var result = nui.decode(text);
			            	if(result.rtnCode=="0"){
			            		nui.open({
			            			url: "<%=request.getContextPath()%>/fix/riskControlDetailList.jsp",
					                title: "指令/建议风险提示",
					                width: 650,
					                height: 380,
					                allowResize: false,
					                onload: function () {
				                        var iframe = this.getIFrameEl();
				                        var data = result.riskMsg;
				                        iframe.contentWindow.SetData(data);
					           		},
								    ondestroy: function (action) {  //弹出页面关闭前
								        if (action == "ok") {       //如果点击“继续”
								        }                        
								    }
			            		});
			            	}
			            	if(result.rtnCode=="1"){
			            		nui.alert("风险试算通过，您可以下达该指令/建议");
			            	}
			            	if(result.rtnCode=="2"){
			            		nui.alert("执行异常");
			            	}
			            }
			      	});
                }else{
                	saveDataCommon(form, pageType, urlStr, roleType, processStatusUrl, validStatusUrl);
                }
			}

                    //页面间传输json数据
                    function setFormData(data){
                        //跨页面传递的数据对象，克隆后才可以安全使用
                        var infos = nui.clone(data);

                        //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
                        nui.getbyName("pageType").setValue(infos.pageType);

                        //如果是点击编辑类型页面
                        if (infos.pageType == "edit") {
                        	
                            var json = infos.record;
                            var form = new nui.Form("#dataform1");//将普通form转为nui的form
                            var dataSource = json.zhfwptjyznhg.dataSource;
							nui.get("zhfwptjyznhg.dataSource").setValue(dataSource);
                            //加载债券信息
                        	nui.get("grid_0").load({processId:json.zhfwptjyznhg.processId});
                            
                            
                            //设置产品名称值
                            var combProductNameVal = json.zhfwptjyznhg.combProductName;
                            nui.get("combProductCode").setText(combProductNameVal);
                			nui.get("combProductName").setValue(combProductNameVal);
                			
                            form.setData(json);
                            form.setChanged(false);
                            
                            //调用方法重新加载组合
					        changedCombProductCode();
					        //重新设置选择的组合
							var vcCombiNo = json.zhfwptjyznhg.vcCombiNo;
							var vcCombiName = json.zhfwptjyznhg.vcCombiName;
		
					        nui.get("vcCombiNo").setValue(vcCombiNo);
					        nui.get("vcCombiNo").setText(vcCombiName);
					        
					        //重新设置隐藏组合名称
					        nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
                        }
                        
                        //若当前页面是交易员填单打开，则设置“是否询价指令/建议”标识为只读，且值为“0-否（完整指令/建议）”
		                
		                nui.get("roleType").setValue(infos.roleType);//设置角色类型值传输到后台处理
		            	isInquiryOnvaluechanged();//初始化设置必输项，是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
                    }
                    //自动增加千分位-券面总额合计（万元）
		            function investCountFun(){
		                //若是完整指令/建议，则需要转换为千分位格式
		                	formatNumberCommon("investCount");
		            }
                    //自动增加千分位-交易金额（万元）
                    function tranAmountFun(){
		                //若是完整指令/建议，则需要转换为千分位格式
		                	formatNumberCommon("tranAmount");
                    }
                    //自动增加千分位-券面总额（万元）
                    function bondAmountFun(){
                    	var oldVal = nui.get("bondAmount").getValue();
                    	if(oldVal!=null && oldVal!=""){
                    		oldVal = oldVal.toString().replace(/\$|\,/g,'');
                    		//if(eval(oldVal)%10 != 0){
                    		//	nui.alert("券面总额最小变动单位为10万，请重新设置","提示");
                    		//	nui.get("bondAmount").setValue(null);
                    		//}else{
                    			var newVal = formatNumber(oldVal,0,1);
	                    		nui.get("bondAmount").setValue(newVal);
                    		//}
	                    	//自动计算券面总额合计（万元）与交易金额（万元）字段值
                    		autoCalc();
                    	}
                    }
                    //自动增加千分位-首次净价（元）
                    function firstNetValueFun(){
                    	formatNumberCommon("firstNetValue");
                    }
                    
                    
                    //自动计算券面总额合计（万元）与交易金额（万元）字段值
                    function autoCalc(){
                    	var grid = nui.get("grid_0");
				        var gridData = grid.getData();
				        if(gridData.length>0){
				        	var investCountVal = 0;//券面总额合计（万元）
				        	var tranAmountVal = 0;//交易金额（万元）
				        
				        	for(var i=0; i<gridData.length; i++){
				        		var bondAmount = gridData[i].bondAmount;//券面总额（万元）
				        		var bondAmountVal = bondAmount==null||bondAmount==""?"0":bondAmount.replace(/(^\s*)|(\s*$)|(,)/g, "");
				        		var conversionRatio = gridData[i].conversionRatio;//折算比例（%）
				        		var conversionRatioVal = conversionRatio==null||conversionRatio==""?"0":conversionRatio.replace(/(^\s*)|(\s*$)|(,)/g, "");
				        		
				        		//券面总额合计（万元）=所有债券券面总额（万元）之和
				        		investCountVal += eval(bondAmountVal);
				        		//交易金额（万元）=所有债券券面总额（万元）*折算比例（%）之和
				        		tranAmountVal += eval(bondAmountVal)*eval(conversionRatioVal)/100;
				        	}
				        	
				        	//设置券面总额合计（万元）值
				        	if(investCountVal!=null && investCountVal!=""){
				        		nui.get("investCount").setValue(formatNumber(investCountVal,2,1));
				        	}
				        	//设置交易金额（万元）值
				        	if(tranAmountVal!=null && tranAmountVal!=""){
				        		nui.get("tranAmount").setValue(formatNumber(tranAmountVal,2,1));
				        	}
				        }
                    }
                    
                    
                    //债券代码选中后自动填充债券名称
                    var bondNameVal = "";//获取投资产品（债券）名称值
                    function onDrawCell(e) {
			            if(e.field == "bondCode"){
			            	var record = e.record;//获取行记录值
			            	var bondCodeText = record.bondCode;//投资产品（债券）代码值
			            	if(bondCodeText!=null && bondCodeText!=""){
			            		if(bondCodeText.indexOf("-")!=-1){
			            			var bondCodeVal = bondCodeText.substr(0, bondCodeText.indexOf("-"));
					            	e.cellHtml = bondCodeVal;//给债券代码赋值
					            	//将债券名称保存起来
					            	bondNameVal = bondCodeText.substr(bondCodeText.indexOf("-")+1, bondCodeText.length);
			            		}
				            }
			            }else if (e.field == "bondName") {
			                if(bondNameVal!=null && bondNameVal!=""){
			                	e.cellHtml = bondNameVal;
			                	bondNameVal = "";//赋值后将原变量设置为空
			                }
			            }
			        }
			        
			        //是否询价指令/建议：0-否（完整指令/建议）;1-是（询价指令/建议）;
		            function isInquiryOnvaluechanged(){
		            		nui.get("investCount").setRequired(true);//券面总额合计（万元）
		            		nui.get("actualDays").setRequired(true);//回购期限（天）
		            		nui.get("tradingRate").setRequired(true);//回购利率（%）
		            		nui.get("firstSettlementDate").setRequired(true);//首次结算日
		            		nui.get("expiryDate").setRequired(true);//到期结算日
		            }
		            
		            //若业务类型为：21-交易所正回购；22-交易所逆回购；则交易对手和质押券为非必填项，清算速度默认为T+1。
		            function changedProcessType(e){
		            	var val = e.value;
		            	if(val=="21" || val=="22"){//“交易所竞价正回购、“交易所竞价逆回购”
		            		nui.get("tradingOpponent").setRequired(false);//交易对手
		            		nui.get("clearingSpeed").setValue("T+1");//清算速度
		            	}else{
		            		nui.get("tradingOpponent").setRequired(true);//交易对手
		            		nui.get("clearingSpeed").setValue("T+0");//清算速度
		            	}
		            	actualDaysFun();
		            }
		            
		            //回购期限（天）
		            function actualDaysFun(){
		            	var actualDays = nui.get("actualDays").value;//回购期限（天）
		            	//若输入区间值，如2-7，则设置到期结算日为空并返回
		            	if(isNaN(actualDays/1)){
		            		nui.get("expiryDate").setValue(null);//到期结算日
		            		return;
		            	}
		            	var processDate = nui.formatDate(nui.get("processDate").value, "yyyyMMdd");//业务日期
		            	var bizType=nui.get("processType").getValue();//业务类型
		            	var clearingSpeedTemp = nui.get("clearingSpeed").value;//清算速度：T+0、T+1
		            	var clearingSpeed = 0;//清算速度：T+0为0天，T+1为1天，这里是指交易日
		            	if(clearingSpeedTemp=="T+1"){
		            		clearingSpeed = 1;
		            	}
		            	
		            	var jsonParam = nui.encode({currentDate:processDate, clearingSpeed:clearingSpeed, actualDays:actualDays});
		            	var url="com.cjhxfund.jy.ProductProcess.ProductProcessUtilBiz.getSettlementDate.biz.ext";
		            	if(null!=bizType&&(bizType=="21"|| bizType=="22")){//“交易所竞价正回购、“交易所竞价逆回购”
		            		url="com.cjhxfund.jy.ProductProcess.ProductProcessUtilBiz.getNewSettlementDate.biz.ext";
		            	}
		            	$.ajax({
				            url:url,
				            type:'POST',
				            data:jsonParam,
				            cache:false,
				            contentType:'text/json',
				            success:function(text){
				                var returnJson = nui.decode(text);
				                if(returnJson.exception == null){
				                	var settlementDate = returnJson.settlementDate;//“首次结算日期”、“到期结算日期”
				                	var settlementDateArr = settlementDate.split(",");
				                	nui.get("firstSettlementDate").setValue(settlementDateArr[0]);//首次结算日
            						nui.get("expiryDate").setValue(settlementDateArr[1]);//到期结算日
				                }else{
				                    nui.alert("首次结算日、到期结算日数据获取失败", "系统提示");
				                }
				            }
				        });
				        
				        //设置symbol值
				        if(actualDays==null || actualDays==""){
				        	return;
				        }
				        var processType = nui.get("processType").getValue();
	                	//特殊验证，业务类别：03-质押式正回购;04-质押式逆回购;(如果是质押式回购需要根据回购天数查询O32是否存在证券代码)
	                	if(processType != null && processType != ""){
		                	if(nui.get("processType").getValue() == "03" || nui.get("processType").getValue() == "04"){
			                	var jsonParam2 = nui.encode({actualDays:actualDays});
						        //console.log(jsonParam2);
						        $.ajax({
						            url:"com.cjhxfund.jy.ProductProcess.ProductProcessUtilBiz.getSymbol.biz.ext",
						            type:'POST',
						            data:jsonParam2,
						            cache:false,
						            contentType:'text/json',
						            success:function(text){
						                var returnJson = nui.decode(text);
						                if(returnJson.exception == null){
						                	if(returnJson.symbol=="回购期限(天)对应的申报代码为空"){
						                		nui.get("symbol").setValue(null);
						                		nui.alert("O32系统无该回购期限(天)对应的证券代码，请联系交易员先新增该回购期限对应的证券代码");
						                	}else{
						                		nui.get("symbol").setValue(returnJson.symbol);//申报代码
						                	}
						                }else{
						                    nui.alert("回购期限(天)对应的证券代码数据获取失败", "系统提示");
						                }
						            }
						        });
		                	}
	                	}
		            }
		            
		            //清算速度：T+0、T+1
		            function clearingSpeedOnvaluechanged(e){
		            	actualDaysFun();
		            }
        </script>
    </body>
</html>
