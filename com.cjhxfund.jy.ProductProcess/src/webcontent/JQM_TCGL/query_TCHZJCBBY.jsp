<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-04-22 14:35:39
- Description: 综合信息查询-包含调整功能（数据取自O32）
--%>
<head>
<title>综合信息查询</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
		   <%-- O32头寸检查表1查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_O32TCJC1" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="O32TCJC1">
				 	<%--基金ID --%>
				 	<input id="lFundId_O32TCJC1" class="nui-hidden" name="paramObject/lFundIds" value="">
				 	<%-- 资产单元ID --%>
				 	<input id="lAssetId_O32TCJC1" class="nui-hidden" name="paramObject/lAssetIds" value="">
				 	<%-- 手工调整金额(1-追加提取) --%>
				 	<input id="eNBalance1_O32TCJC1" class="nui-hidden" name="paramObject/eNBalance1s" value="">
				 	<%-- 备注信息(1-追加提取) --%>
				 	<input id="BZ1_O32TCJC1" class="nui-hidden" name="paramObject/BZ1s" value="">
				 	<%-- 手工调整金额(2-一级新债) --%>
				 	<input id="eNBalance2_O32TCJC1" class="nui-hidden" name="paramObject/eNBalance2s" value="">
				 	<%-- 备注信息(2-一级新债) --%>
				 	<input id="BZ2_O32TCJC1" class="nui-hidden" name="paramObject/BZ2s" value="">
				 	<%-- 手工调整金额(3-协议回购) --%>
				 	<input id="eNBalance3_O32TCJC1" class="nui-hidden" name="paramObject/eNBalance3s" value="">
				 	<%-- 备注信息(3-协议回购) --%>
				 	<input id="BZ3_O32TCJC1" class="nui-hidden" name="paramObject/BZ3s" value="">
				 	
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td class="form_label" width="7%">
								基金名称:
	                        </td>
	                        <td colspan="1" width="13%">
	                            <input id="vCFundCode_O32TCJC1" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_O32TCJC1"/>
	                        </td>
	                        <td class="form_label" width="7%">
								资产单元:
	                        </td>
	                        <td colspan="1" width="13%">
	                            <input id="vCAssetName_O32TCJC1" class="nui-textbox" name="paramObject/vCAssetName"/>
	                        </td>
	                        <td class="form_lable" width="5%">
								排序:
	                        </td>
	                        <td colspan="1" width="13%">
	                        	<input id="vCSort_O32TCJC1" class="nui-combobox" name="paramObject/vCSort" data="[{id: 'T0_BALANCE_ASC', text: 'T+0头寸升序'}, {id: 'T0_BALANCE_DESC', text: 'T+0头寸降序'},{id: 'T1_BALANCE_ASC', text: 'T+1头寸升序'},{id : 'T1_BALANCE_DESC', text: 'T+1头寸降序'}]"
	                        	emptyText="---请选择---" nullItemText="---请选择---" showNullItem="true" width="100px"/>
	                        </td>
	                        <td colspan="1" width="100px">
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_O32TCJC1()"/>
	                            &nbsp;
	                            <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_O32TCJC1()"/>
	                        </td>
	                        <td align="right" width="150px">
			                    <a class='nui-button' plain='false' iconCls="icon-reload" onclick="autoRefreshFun()">刷新</a>
			                    <input id="autoRefresh" class="nui-combobox" style="width:90px;" 
				                    value="180" showNullItem="false" allowInput="false"
				                    data="[
								    { id: 0, text: '不自动刷新' },
								    { id: 15, text: '每15秒刷新' },
								    { id: 30, text: '每30秒刷新' },
									{ id: 60, text: '每1分刷新' },
									{ id: 120, text: '每2分刷新' },
									{ id: 180, text: '每3分刷新' },
									{ id: 300, text: '每5分刷新' },
									{ id: 600, text: '每10分刷新' },
									{ id: 1200, text: '每20分刷新' },
									{ id: 1800, text: '每30分刷新' }]"/>&nbsp;&nbsp;
			            	</td>
		                    <td style="width:50px;" align="right">
		                    	<a href="javascript:fullScreen()"><span class="warn_red_bold" style="border-bottom:1px solid;font-size:13px;">全屏显示</span></a>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- O32头寸检查表1查询条件结束!!! --%>
		   
		   <%-- O32头寸检查表1列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_O32TCJC1"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="50"
                        frozenStartColumn="0"
                        frozenEndColumn="2"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        allowHeaderWrap="true"
                        sizeList="[10,20,50,100,200,300,500]"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        <div field="VC_FUNDNAME" headerAlign="center" allowSort="true" align="left" width="180px">
                            基金名称
                        </div>
                        <div field="VC_ASSETNAME" headerAlign="center" allowSort="true" align="left" width="120px">
                            资产单元名称
                        </div>
                        
                        <div header="头寸情况" headerAlign="center">
			                <div property="columns">
			                    <div field="JYSTC_SH" headerAlign="center" allowSort="true"  align="right" width="140px">
					  交易所头寸情况(上交所)
		                        </div>
		                        <div field="JYSTC_SZ" headerAlign="center" allowSort="true" align="right" width="140px">
					  交易所头寸情况(深交所)
		                        </div>
		                        <div field="T0_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
					  T+0头寸情况 F
		                        </div>
		                        <div field="T1_BALANCE" headerAlign="center" allowSort="true" align="right" width="120px">
					  T+1头寸情况 G
		                        </div>
			                </div>
			            </div>
                        
                        <div header="银行间交易" headerAlign="center">
			                <div property="columns">
			                    <div field="EN_YHJ_ZQ" headerAlign="center" allowSort="true" align="right" width="120px">
					  当日T+0交易意向 H
		                        </div>
		                        <div field="EN_YHJ_ZQ_T0CJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  当日T+0前台成交 I
		                        </div>
		                        <div field="EN_YHJ_ZQ_T1CJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  昨日T+1资金流入 J
		                        </div>
		                        <div field="EN_YHJ_RQGH" headerAlign="center" allowSort="true" align="right" width="120px">
					  当日逆回购到期  K
		                        </div>
		                        <div field="EN_YHJ_DXDF" headerAlign="center" allowSort="true" align="right" width="120px">
					  当日债券兑付兑息 L
		                        </div>
		                        <div field="EN_YHJ_TQDJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  次日正回购到期提前冻结 M
		                        </div>
			                </div>
			            </div>
                        
                        <div header="交易所交易" headerAlign="center">
			                <div property="columns">
			                    <div field="EN_JYS_ZLZY1" headerAlign="center" allowSort="true" align="right" width="120px">
					  指令/建议占用(上海) O
		                        </div>
		                        <div field="EN_JYS_ZLZY2" headerAlign="center" allowSort="true" align="right" width="120px">
					  指令/建议占用(深圳) O
		                        </div>
		                        <div field="EN_JYS_QZMM1" headerAlign="center" allowSort="true" align="right" width="120px">
					  股票权证买卖(上海) P
		                        </div>
		                        <div field="EN_JYS_QZMM2" headerAlign="center" allowSort="true" align="right" width="120px">
					  股票权证买卖(深圳) P
		                        </div>
		                        <div field="EN_JYS_ZQMM1" headerAlign="center" allowSort="true" align="right" width="120px">
					  债券买卖(上海) Q
		                        </div>
		                        <div field="EN_JYS_ZQMM2" headerAlign="center" allowSort="true" align="right" width="120px">
					  债券买卖(深圳) Q
		                        </div>
		                        <div field="EN_JYS_RZHG1" headerAlign="center" allowSort="true" align="right" width="120px">
					  正回购首期(上海) R
		                        </div>
		                        <div field="EN_JYS_RZHG2" headerAlign="center" allowSort="true" align="right" width="120px">
					  正回购首期(深圳) R
		                        </div>
		                        <div field="EN_JYS_RZGH1" headerAlign="center" allowSort="true" align="right" width="120px">
					  正回购到期(上海) S
		                        </div>
		                        <div field="EN_JYS_RZGH2" headerAlign="center" allowSort="true" align="right" width="120px">
					  正回购到期(深圳) S
		                        </div>
		                        <div field="EN_JYS_RQHG1" headerAlign="center" allowSort="true" align="right" width="120px">
					  逆回购首期(上海) T
		                        </div>
		                        <div field="EN_JYS_RQHG2" headerAlign="center" allowSort="true" align="right" width="120px">
					  逆回购首期(深圳) T
		                        </div>
		                        <div field="EN_JYS_RQGH1" headerAlign="center" allowSort="true" align="right" width="120px">
					  逆回购到期(上海) U
		                        </div>
		                        <div field="EN_JYS_RQGH2" headerAlign="center" allowSort="true" align="right" width="120px">
					  逆回购到期(深圳) U
		                        </div>
		                        <div field="EN_JYS_FDBJS1" headerAlign="center" allowSort="true" align="right" width="120px">
					  非担保交收(上海) V
		                        </div>
		                        <div field="EN_JYS_FDBJS2" headerAlign="center" allowSort="true" align="right" width="120px">
					  非担保交收(深圳) V
		                        </div>
			                </div>
			            </div>
                        
                        <div header="线下交易" headerAlign="center">
			                <div property="columns">
			                    <div field="EN_XX_CKZQK" headerAlign="center" allowSort="true" align="right" width="120px">
					  存款支取款 W
		                        </div>
		                        <div field="EN_WJS_JJSH" headerAlign="center" allowSort="true" align="right" width="120px">
					  基金赎回款 X
		                        </div>
		                        <div field="EN_WJS_WXSG" headerAlign="center" allowSort="true" align="right" width="120px">
					  网下申购退款 Y
		                        </div>
			                </div>
			            </div>
                        
                        <div header="其他" headerAlign="center">
			                <div property="columns">
			                    <div field="EN_BFJ_TQDJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  备付金保证金提前冻结 Z
		                        </div>
		                        <div field="EN_SH_TQDJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  赎回分红款提前冻结 AA
		                        </div>
		                        <div field="EN_FYTQDJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  费用提前冻结 AB
		                        </div>
		                        <div field="EN_ZJSGDJ" headerAlign="center" allowSort="true" align="right" width="120px">
					  资金手工冻结 AC
		                        </div>
		                        <div field="EN_ZJJD" headerAlign="center" allowSort="true" align="right" width="120px">
					  资金手工解冻 AD
		                        </div>
			                </div>
			            </div>
			            
			            <div header="或有事项" headerAlign="center">
			                <div property="columns">
			                    <div field="EN_ZJTQ" headerAlign="center" allowSort="true" align="right" width="120px">
					  追加提取 AE
					  				<input property="editor" class="nui-textbox" vtype="float" style="width:100%;"/>
		                        </div>
		                        <div field="EN_BALANCE2" headerAlign="center" allowSort="true" align="right" width="120px">
					  一级新债 AF
					  				<input property="editor" class="nui-textbox" vtype="float" style="width:100%;"/>
		                        </div>
		                        <div field="EN_XYHG" headerAlign="center" allowSort="true" align="right" width="120px">
					  协议回购 AG
					  				<input property="editor" class="nui-textbox" vtype="float" style="width:100%;"/>
		                        </div>
			                </div>
			            </div>
			            
			            <div header="O32系统头寸" headerAlign="center">
			                <div property="columns">
			                    <div field="T0_POS" headerAlign="center" allowSort="true" align="right" width="120px">
					  T+0交易头寸 AH
		                        </div>
		                        <div field="T0_POS2" headerAlign="center" allowSort="true" align="right" width="120px">
					  不包含T+1变化的T+0可用 AI
		                        </div>
		                        <div field="T1_POS" headerAlign="center" allowSort="true" align="right" width="120px">
					  T+1交易可用 AJ
		                        </div>
			                </div>
			            </div>
			            
                        <div field="L_FUND_ID" headerAlign="center" allowSort="true" align="center" width="45px">
                            基金序号
                        </div>
                        <div field="VC_FUNDCODE" headerAlign="center" allowSort="true" align="center" width="60px">
                            基金代码
                        </div>
                        <div field="L_ASSET_ID" headerAlign="center" allowSort="true" align="right" width="50px">
                            资产单元序号
                        </div>
                        
                      </div>
                   </div>
	</div>
</div>

<script type="text/javascript">
    nui.parse();
    var grid_O32TCJC1 = nui.get("datagrid_O32TCJC1");//O32头寸检查表1
    
    var refreshInt = true;//刚刚打开页面时，投顾默认刷新，交易员默认不刷新
    var queryUserTypeTemp = "<%=request.getParameter("queryUserType")%>";
	if(queryUserTypeTemp!=null && queryUserTypeTemp!="" && queryUserTypeTemp!="null"){
		refreshInt = false;
	}
    
    //tab标签切换时重新加载查询激活的tab标签的记录--所有业务通用
	function activechangedFun(){
		if(refreshInt==false){
			return;
		}
			search_O32TCJC1();
	}
	
	//自动刷新功能处理
	var autoRefreshValOld = nui.get("autoRefresh").getValue();//获取默认自动刷新时间
    var autoRefreshReturnVal= self.setInterval("autoRefreshFun()",eval(autoRefreshValOld)*1000);//设置自动刷新时间默认3分钟
    //系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	var autoRefreshVal = nui.get("autoRefresh").getValue();//获取最新自动刷新时间
    	//若最新获取的自动刷新时间与历史自动刷新时间不等，则关闭之前的定时器，以新的自动刷新时间新建定时器，并将新值赋予历史自动刷新时间变量
    	if(autoRefreshVal!=autoRefreshValOld){
    		autoRefreshValOld = autoRefreshVal;//将新值赋予历史自动刷新时间变量
    		clearInterval(autoRefreshReturnVal);//关闭之前的定时器
    		if(autoRefreshValOld!="0"){
    			autoRefreshReturnVal = setInterval("autoRefreshFun()", eval(autoRefreshValOld)*1000);//以新的自动刷新时间新建定时器
    		}
    	}
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
	
	
    
    
    <%-- O32头寸检查表1查询开始... --%>
	//查询
	function search_O32TCJC1() {
		search(grid_O32TCJC1, "#form_O32TCJC1");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_O32TCJC1(e){
        ButtonClickGetFundName(this, null);
	}
	//表格行增加样式
	grid_O32TCJC1.on("drawcell", function (e) {
    	var record = e.record;
    	var field  = e.field;
    	
    	var T0_BALANCE = changeNull(record.T0_BALANCE).replaceAll(",", "");  //获取 T+0头寸情况 F
    	var T1_BALANCE = changeNull(record.T1_BALANCE).replaceAll(",", "");  //获取 T+1头寸情况 G
    	var JYSTC_SH = changeNull(record.JYSTC_SH).replaceAll(",", "");		 //交易所头寸情况(上交所)
    	var JYSTC_SZ = changeNull(record.JYSTC_SZ).replaceAll(",", "");		 //交易所头寸情况(深交所)
    	
    	//将参数转换成int类型，并判断是否小于0.
    	if(Number(T0_BALANCE) < 0){
    	   e.rowCls = "warn_red";
    	}
    	
    	//将参数转换成int类型，并判断是否小于0.
    	if(Number(T1_BALANCE) < 0){
    	   e.rowCls = "warn_red";
    	}
    	//将参数转换成int类型，并判断是否小于0与是否等于交易所头寸情况(上交所)
    	if(Number(JYSTC_SH) < 0 && field == "JYSTC_SH"){
    	  e.cellCls = "warn_red";
    	}
    	//将参数转换成int类型，并判断是否小于0与是否等于交易所头寸情况(深交所)
    	if(Number(JYSTC_SZ) < 0 && field == "JYSTC_SZ"){
    	  e.cellCls = "warn_red";
    	}
	});
	
	//保存
	function save_O32TCJC1(){
		var errorStr1 = "";//错误提示信息(1-追加提取)
		var errorStr2 = "";//错误提示信息(2-一级新债)
		var errorStr3 = "";//错误提示信息(3-协议回购)
		var lFundIds = "";//基金ID
		var lAssetIds = "";//资产单元ID
		var eNBalance1s = "";//手工调整金额(1-追加提取)
		var BZ1s = "";//备注信息(1-追加提取)
		var eNBalance2s = "";//手工调整金额(2-一级新债)
		var BZ2s = "";//备注信息(2-一级新债)
		var eNBalance3s = "";//手工调整金额(3-协议回购)
		var BZ3s = "";//备注信息(3-协议回购)
		
		var changeDatas = grid_O32TCJC1.getChanges();
		for(var i=0; i<changeDatas.length; i++){
			var lFundId = changeNull(changeDatas[i].L_FUND_ID);//基金ID
			var lAssetId = changeNull(changeDatas[i].L_ASSET_ID);//资产单元ID
			var eNBalance1 = changeNull(changeDatas[i].EN_BALANCE1);//手工调整金额(1-追加提取)
			eNBalance1 = eNBalance1==""?"0":eNBalance1.toString().replace(/\$|\,/g,'');
			var BZ1 = changeNull(changeDatas[i].BZ1);//备注(1-追加提取)
			BZ1 = BZ1==null||BZ1==""?"★":BZ1;//若备注为空，传入特殊字符后台处理
			var eNBalance2 = changeNull(changeDatas[i].EN_BALANCE2);//手工调整金额(2-一级新债)
			eNBalance2 = eNBalance2==""?"0":eNBalance2.toString().replace(/\$|\,/g,'');
			var BZ2 = changeNull(changeDatas[i].BZ2);//备注(2-一级新债)
			BZ2 = BZ2==null||BZ2==""?"★":BZ2;//若备注为空，传入特殊字符后台处理
			var eNBalance3 = changeNull(changeDatas[i].EN_BALANCE3);//手工调整金额(3-协议回购)
			eNBalance3 = eNBalance3==""?"0":eNBalance3.toString().replace(/\$|\,/g,'');
			var BZ3 = changeNull(changeDatas[i].BZ3);//备注(3-协议回购)
			BZ3 = BZ3==null||BZ3==""?"★":BZ3;//若备注为空，传入特殊字符后台处理
			if(isNaN(eNBalance1)){
				errorStr1 += "、" + changeDatas[i].VC_ASSETNAME + "-" + lAssetId + "-" + lFundId;
			}
			if(isNaN(eNBalance2)){
				errorStr2 += "、" + changeDatas[i].VC_ASSETNAME + "-" + lAssetId + "-" + lFundId;
			}
			if(isNaN(eNBalance3)){
				errorStr3 += "、" + changeDatas[i].VC_ASSETNAME + "-" + lAssetId + "-" + lFundId;
			}
			lFundIds += lFundId;
			lAssetIds += lAssetId;
			eNBalance1s += eNBalance1;
			BZ1s += BZ1;
			eNBalance2s += eNBalance2;
			BZ2s += BZ2;
			eNBalance3s += eNBalance3;
			BZ3s += BZ3;
			if(i<changeDatas.length-1){
				lFundIds += "@";
				lAssetIds += "@";
				eNBalance1s += "@";
				BZ1s += "@";
				eNBalance2s += "@";
				BZ2s += "@";
				eNBalance3s += "@";
				BZ3s += "@";
			}
		}
		if(errorStr1!=""){
			errorStr1 = errorStr1.substring(1, errorStr1.length);
			nui.alert("【"+errorStr1+"】</br>追加提取 AE 手工调整值输入错误，请重新输入！", "系统提示");
			return;
		}
		if(errorStr2!=""){
			errorStr2 = errorStr2.substring(1, errorStr2.length);
			nui.alert("【"+errorStr2+"】</br>一级新债 AF 手工调整值输入错误，请重新输入！", "系统提示");
			return;
		}
		if(errorStr3!=""){
			errorStr3 = errorStr3.substring(1, errorStr3.length);
			nui.alert("【"+errorStr3+"】</br>协议回购 AG 手工调整值输入错误，请重新输入！", "系统提示");
			return;
		}
		nui.get("lFundId_O32TCJC1").setValue(lFundIds);
		nui.get("lAssetId_O32TCJC1").setValue(lAssetIds);
		nui.get("eNBalance1_O32TCJC1").setValue(eNBalance1s);
		nui.get("BZ1_O32TCJC1").setValue(BZ1s);
		nui.get("eNBalance2_O32TCJC1").setValue(eNBalance2s);
		nui.get("BZ2_O32TCJC1").setValue(BZ2s);
		nui.get("eNBalance3_O32TCJC1").setValue(eNBalance3s);
		nui.get("BZ3_O32TCJC1").setValue(BZ3s);
		saveData(grid_O32TCJC1, "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.updateO32TCJC1.biz.ext", "#form_O32TCJC1");
	}
	<%-- O32头寸检查表1查询结束!!! --%>
	
	
	
	//全屏显示
	function fullScreen(){
		window.open('<%=request.getContextPath()%>/ProductProcess/zhxxcx/CFJY_zhxxcx_tz.jsp?queryUserType=<%=request.getParameter("queryUserType")%>','newwindow','height=100,width=400,top=0,left=0,toolbar=no,menubar=no,scrollbars=no, resizable=no,location=no, status=no');
	}
</script>
</body>
</html>

