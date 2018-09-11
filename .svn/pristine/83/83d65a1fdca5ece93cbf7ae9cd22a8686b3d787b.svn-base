<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<%--
- Author(s): huangmizhi
- Date: 2016-06-07 18:12:12
- Description: 自动化头寸表
--%>
<head>
<title>自动化头寸表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div class="nui-tabs" id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		<div title="自动化头寸表">
		   <%-- 自动化头寸表查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_ZDHTCB" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="ZDHTCB">
				 	<%-- 筛选查询类型 --%>
				 	<input class="nui-hidden" id="exclusivelyShowSection" name="paramObject/exclusivelyShowSection" value="N">
				 	<%--基金ID --%>
				 	<input id="lFundId_ZDHTCB" class="nui-hidden" name="paramObject/lFundIds" value="">
				 	<%-- 序号 --%>
				 	<input id="XH_ZDHTCB" class="nui-hidden" name="paramObject/XHs" value="">
				 	<%-- 手工调整金额 --%>
				 	<input id="TZJE_ZDHTCB" class="nui-hidden" name="paramObject/TZJEs" value="">
				 	<%-- 备注信息 --%>
				 	<input id="BZ_ZDHTCB" class="nui-hidden" name="paramObject/BZs" value="">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                        <td>
				                                基金名称:
                				<input id="vCFundCode_ZDHTCB" style="width:200px;" required="false" class="nui-textboxlist" name="paramObject/vCFundCode" searchField="searchKey" dataField="productCombis"
                        			valueField="fundCode" textField="fundCodeName" url="com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getProductCodeByKey.biz.ext" value="" text="" enterQuery="false"/>
	                            <input class='nui-button' plain='false' text="筛选" iconCls="icon-search" onclick="filterSearch_ZDHTCB()"/>
	                            <input class='nui-button' plain='false' text="AK负值筛选" iconCls="icon-search" onclick="searchByTGH_ZDHTCB()"/>
	                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_ZDHTCB()"/>
	                            <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_ZDHTCB()"/>
								<input class='nui-button' plain='false' id="export_ZDHTCB" text="导出" iconCls="icon-download" onclick="export_ZDHTCB()"/>
	                        </td>
	                        <td style="width:135px;" align="right">
	                        	<span class="warn_red_bold">数据每 5 分钟自动刷新</span>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 自动化头寸表查询条件结束!!! --%>
		   
		   <%-- 自动化头寸表列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_ZDHTCB"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryZHXX.biz.ext"
                        pageSize="100"
                       	showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        allowHeaderWrap="true"
                        sizeList="[10,20,50,100]"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true"
						multiSelect="true"   showfooter="false" >

                    <div property="columns">
                        <div type="indexcolumn"></div>
		                <div field="L_FUND_ID"  name="L_FUND_ID"  headeralign="center" allowsort="true" align="center" width="50px">
		                            基金ID
		                </div>
		                <div field="VC_FUND_CODE" name="VC_FUND_CODE" headerAlign="center" allowSort="true" align="center" width="60px">
		                            基金代码
		                </div>
		                <div field="VC_FUND_NAME" name="VC_FUND_NAME" headerAlign="center" allowSort="true" align="left" width="180px">
		                            基金名称
		                </div>
		                <div field="XH" headeralign="center" allowsort="true" align="center" visible="false">
		                            序号
		                </div>
                        <div field="BZ"  headerAlign="center"  align="left" width="180px">
                            备注
                        </div>
                        <div field="D_COL" headerAlign="center"  align="right" width="120px">
                        D 期初余额
                        </div>
                        <div field="AK_COL" headerAlign="center" align="right" width="130px">
			 			AK 余额
                        </div>
                        <div field="EN_BALANCE" headerAlign="center" allowSort="true" align="right" width="130px">
			  净追加等手工调整(流入为正,流出为负)
			  				<input property="editor" class="nui-textbox" vtype="float" style="width:100%;"/>
                        </div>
                        <div field="SGTZ_BZ" headerAlign="center" allowSort="true" align="left" width="130px">
			 手工调整备注
			  				<input property="editor" class="nui-textarea" style="width:100%;"/>
                        </div>
                        <div field="F_COL" headerAlign="center"  align="right" width="140px">
                        F 银行间正回购,首次结算日为当日,金额为正
                        </div>
                        <div field="G_COL" headerAlign="center"  align="right" width="140px">
                        G 银行间逆回购,首次结算日为当日,金额为负  
                        </div>
                        <div field="H_COL" headerAlign="center" align="right" width="120px">
			  			H T日成交的T+0银行间买券,结算日为当日,金额为负
			  			</div>
                        <div field="I_COL" headerAlign="center" align="right" width="120px">
			  			I T日成交的T+0银行间卖券,结算日为当日,金额为正
                        </div>
                        <div field="J_COL" headerAlign="center" align="right" width="120px">
			  			J 银行间正回购到期,到期结算日为当日,金额为负
                        </div>
                        <div field="K_COL" headerAlign="center" align="right" width="120px">
			  			K 银行间逆回购到期,到期结算日为当日,金额为正
                        </div>
                        <div field="L_COL" headerAlign="center" align="right" width="130px">
			  			L T-1日成交的T+1交收的银行间买券,结算日为当日,金额为负
                        </div>
                        <div field="M_COL" headerAlign="center" align="right" width="130px">
			 			M T-1日成交的T+1交收的银行间卖券,结算日为当日,金额为正
                        </div>
                        <div field="N_COL" headerAlign="center" align="right" width="120px">
			  			N 银行间分销,金额为负
                        </div>
                        <div field="O_COL" headerAlign="center" align="right" width="120px">
			  			O 交易所分销,金额为负
                        </div>
                        <div field="P_COL" headerAlign="center" align="right" width="120px">
			  			P 基金申购,金额为负
                        </div>
                        <div field="Q_COL" headerAlign="center" align="right" width="120px">
			  			Q 基金赎回,赎回到账日为当日,金额为正
                        </div>
                        <div field="R_COL" headerAlign="center" align="right" width="120px">
			  			R 红利到账,金额为正
                        </div>
                        <div field="S_COL" headerAlign="center" align="right" width="120px">
			  			S 期货户入金,期货保证金调整的期货保证金增加,金额为负
                        </div>
                        <div field="T_COL" headerAlign="center" align="right" width="120px">
			  			T 期货户出金,期货保证金调整的期货保证金减少,金额为正
                        </div>
                        <div field="U_COL" headerAlign="center" align="right" width="120px">
			  			U 同业存款,即定期存款,金额为负
                        </div>
                        <div field="V_COL" headerAlign="center" align="right" width="120px">
			  			V 同业存款到期,即定期存款到期,到期日为当日,金额为正
                        </div>
                        <div field="W_COL" headerAlign="center" align="right" width="130px">
			  			W 当日债券兑付/付息/部分兑付/部分提前兑付(沪深),金额为正
                        </div>
                        <div field="X_COL" headerAlign="center" align="right" width="130px">
			  			X 当日债券兑付/付息/部分兑付/部分提前兑付(非沪深),金额为正
                        </div>
                        <div field="Y_COL" headerAlign="center" align="right" width="120px">
			  			Y 追加,即当日资金管理手工增加资金,金额为正
                        </div>
                        <div field="Z_COL" headerAlign="center" align="right" width="120px">
			  			Z 提取,即当日资金管理手工减少资金,金额为负
                        </div>
                        <div field="AA_COL" headerAlign="center" align="right" width="120px">
			  			AA 当日TA申购,金额为正
                        </div>
                        <div field="AB_COL" headerAlign="center" align="right" width="140px">
			  			AB TA赎回,赎回款到账日为当日,金额为负
                        </div>
                        <div field="AC_COL" headerAlign="center" align="right" width="120px">
			  			AC 网下申购,金额为负
                        </div>
                        <div field="AD_COL" headerAlign="center" align="right" width="130px">
			 			AD 网下申购退款,金额为正
                        </div>
                        <div field="AL_COL" headerAlign="center" align="right" width="130px">
			 			AL 费用支付，金额为负
                        </div>
                        <div field="AM_COL" headerAlign="center" align="right" width="130px">
			 			AM 新股配售交收，金额为负
                        </div>
                        <div field="AE_COL" headerAlign="center" align="right" width="140px">
			 			AE RTGS非担保卖券,清算速度T+0,金额为正
                        </div>
                        <div field="AF_COL" headerAlign="center" align="right" width="140px">
			 			AF RTGS非担保买券,清算速度T+0,金额为负
                        </div>
                        <div field="AG_COL" headerAlign="center" align="right" width="100px">
			 			AG 调款
                        </div>
                        <div field="AN_COL" headerAlign="center" align="right" width="130px">
			 			AN 资金冻结，金额为正
                        </div>
                        <div field="AO_COL" headerAlign="center" align="right" width="130px">
			 			AO 资金冻结取消,金额为正
                        </div>
                        <div field="AP_COL" headerAlign="center" align="right" width="130px">
			 			AP 资金增加,金额为正
                        </div>
                    </div>
                </div>
            </div>
            <%-- 自动化头寸表列表结束!!! --%>
		</div>
	</div>
</div>	

<script type="text/javascript">
	nui.parse();
	var grid_ZDHTCB = nui.get("datagrid_ZDHTCB");//自动化头寸表
	
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
		//获取激活的tab标签的标题
		var activeTabTitle = nui.get("tab").getActiveTab().title;
		if(activeTabTitle=="自动化头寸表"){
		    search_ZDHTCB();
		}
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    self.setInterval("autoRefreshFun()",60000*5);//设置自动刷新时间默认5分钟
	
	
	
	
	<%-- 自动化头寸表开始... --%>
	//查询
	function search_ZDHTCB(){
		nui.get("exclusivelyShowSection").setValue("1");
		search(grid_ZDHTCB, "#form_ZDHTCB");
	}
	//筛选,AK金额中（1 托管户，6 上清DVP，7 中债DVP）任意一项为负数,值展示"托管户"/"上清DVP"/"中债DVP"
	function filterSearch_ZDHTCB(){
		nui.get("exclusivelyShowSection").setValue("2");
		search(grid_ZDHTCB, "#form_ZDHTCB");
	}
	//筛选,AK金额中托管户为负数,值展示"托管户"/"上清DVP"/"中债DVP"
	function searchByTGH_ZDHTCB(){
		nui.get("exclusivelyShowSection").setValue("3");
		search(grid_ZDHTCB, "#form_ZDHTCB");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_ZDHTCB(e){
        ButtonClickGetFundName(this, null);
	}
    //行双击时弹出页面展示该指令/建议详细信息
	grid_ZDHTCB.on("rowdblclick", function (e) {
		rowdblclickFun("CFJY_zhxxcx_zdhtcb_detail.jsp", "自动化头寸表明细", 710, 400, e, grid_ZDHTCB);
	});
	//合并单元格
	grid_ZDHTCB.on("load", function () {
    	grid_ZDHTCB.mergeColumns(["L_FUND_ID", "VC_FUND_CODE", "VC_FUND_NAME"]);
    	if(grid_ZDHTCB.data.length == 0 ){
    		nui.alert("没有符合筛选的数据！");
    	}
    });
	//保存
	function save_ZDHTCB(){
		var errorStr = "";//错误提示信息
		var lFundIds = "";//基金ID
		var XHs = "";//序号
		var eNBalances = "";//手工调整金额
		var BZs = "";//备注信息
		var changeDatas = grid_ZDHTCB.getChanges();
		for(var i=0; i<changeDatas.length; i++){
			var lFundId = changeNull(changeDatas[i].L_FUND_ID);//基金ID
			var XH = changeNull(changeDatas[i].XH);//序号
			var eNBalance = changeNull(changeDatas[i].EN_BALANCE);//手工调整金额
			eNBalance = eNBalance==""?"0":eNBalance.toString().replace(/\$|\,/g,'');
			var BZ = changeNull(changeDatas[i].SGTZ_BZ);//备注
			BZ = BZ==null||BZ==""?"★":BZ;//若备注为空，传入特殊字符后台处理
			if(isNaN(eNBalance)){
				errorStr += "、" + changeDatas[i].VC_FUND_NAME + "-" + changeDatas[i].BZ;
			}
			lFundIds += lFundId;
			XHs += XH;
			eNBalances += eNBalance;
			BZs += BZ;
			if(i<changeDatas.length-1){
				lFundIds += "@";
				XHs += "@";
				eNBalances += "@";
				BZs += "@";
			}
		}
		if(errorStr!=""){
			errorStr = errorStr.substring(1, errorStr.length);
			nui.alert("【"+errorStr+"】</br>手工调整值输入错误，请重新输入！", "系统提示");
			return;
		}
		nui.get("lFundId_ZDHTCB").setValue(lFundIds);
		nui.get("XH_ZDHTCB").setValue(XHs);
		nui.get("TZJE_ZDHTCB").setValue(eNBalances);
		nui.get("BZ_ZDHTCB").setValue(BZs);
		saveData(grid_ZDHTCB, "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.updateZDHTCB.biz.ext", "#form_ZDHTCB");
	}
	//导出
	function export_ZDHTCB(){
	    exportSubmit("export_ZDHTCB", "form_ZDHTCB", nui.get("tab").getActiveTab().title);
	}
	<%-- 自动化头寸表结束!!! --%>
	
</script>
</body>
</html>