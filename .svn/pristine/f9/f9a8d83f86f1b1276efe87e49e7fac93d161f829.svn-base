<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): chendi
  - Date: 2017-05-16 14:37:20
  - Description:
-->
<head>
<title>产品头寸风险测算表</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<link id="css_icon" rel="stylesheetet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
<link	rel="stylesheet" type="text/css" href="<%=contextPath%>/common/css/GridDetailBlock.css" />
<script	type="text/javascript" src="<%=contextPath%>/common/js/GridDetailBlock.js"></script>

</head>
<body style="width:99.6%;height:99.6%;">
<div style="margin:0px 2px 0px 2px;width:100%;height:100%;" >
	<div id="tab" activeIndex="0" onactivechanged="activechangedFun" style="width:100%;height:100%;">
		   <%-- 产品头寸风险测算表查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_CPTCFXCSB" method="post">
				 	<%-- 查询用户类型，若是投顾，则过滤产品权限 --%>
				 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
				 	<%-- 查询类型 --%>
				 	<input class="nui-hidden" name="paramObject/queryType" value="CPTCFXCSB">
				 	<%-- 筛选查询类型 --%>
				 	<input id="exclusivelyShowSection" class="nui-hidden"  name="paramObject/exclusivelyShowSection" value="N">
				 	<%--基金ID --%>
				 	<input id="lFundId_CPTCFXCSB" class="nui-hidden" name="paramObject/lFundIds" value="">
				 	<%-- 序号 --%>
				 	<input id="XH_CPTCFXCSB" class="nui-hidden" name="paramObject/XHs" value="">
				 	<%-- 委托人 --%>
				 	<input id="WTR_CPTCFXCSB" class="nui-hidden" name="paramObject/WTRs" value="">
				 	<%-- 上层资金来源 --%>
				 	<input id="SCZJLY_CPTCFXCSB" class="nui-hidden" name="paramObject/SCZJLYs" value="">
				 	<%-- 上层追加资金概率 --%>
				 	<input id="SCZJZJGL_CPTCFXCSB" class="nui-hidden" name="paramObject/SCZJZJGLs" value="">
				 	<%-- 上层追加资金额度 --%>
				 	<input id="SCZJZJED_CPTCFXCSB" class="nui-hidden" name="paramObject/SCZJZJEDs" value="">
				 	<%-- 备注信息 --%>
				 	<input id="BZ_CPTCFXCSB" class="nui-hidden" name="paramObject/BZs" value="">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                	<tr>
	                		<td class="form_label" width="60px" align="right">
								基金名称:
	                        </td>
	                        <td colspan="1" width="60%" align="left">
	                            <input id="vCFundCode_CPTCFXCSB" class="nui-buttonedit" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_CPTCFXCSB"/>
	                        	<input id="vCFundName_CPTCFXCSB" class="nui-hidden" name="paramObject/vCFundName" value=""/>
	                        </td>
	                        <td colspan="10">
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_CPTCFXCSB()"/>
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_CPTCFXCSB()"/>
	                            <input class='nui-button' plain='false' text="保存" iconCls="icon-save" onclick="save_CPTCFXCSB()"/>
	                            <input class='nui-button' plain='false' id="export_CPTCFXCSB" text="导出" iconCls="icon-download" onclick="export_CPTCFXCSB()"/>
	                        </td>
	                        <!-- <td style="width:150px;" align="right">
	                        	<span class="warn_red_bold">数据每 3分钟自动刷新</span>
	                        </td> -->
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 自动化头寸表查询条件结束!!! --%>
		   
		   <%-- 自动化头寸表列表开始... --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_CPTCFXCSB"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.QueryTCXX.biz.ext"
                        pageSize="100"
                       	showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        allowHeaderWrap="true"
                        allowSortColumn="true"
                        sizeList="[50,100,500,1000]"
                        allowCellEdit="true"
						allowCellSelect="true"
						enterNextCell="true"
						allowMoveColumn="true"
						editNextOnEnterKey="true"
						sortField="VC_FUND_NAME" sortOrder="desc"
						multiSelect="true"   showfooter="false" >
                    <div property="columns">
                        <div type="indexcolumn" width="40px">序号</div>
		                <div field="VC_FUND_NAME" name="VC_FUND_NAME"  headerAlign="center" allowSort="true" align="left" width="180px">
            	  基金名称
		                </div>
		                <div field="AK_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
                AK 基金净资产
                        </div>
                        <div field="AL_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
                AL 基金总资产
                        </div>
                        <div field="D_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType"  width="120px">
                D 融资回购占净资产比例(%)
                        </div>
                        <div field="E_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="120px">
                E 融资回购占净资产比例_未到期(%)
                        </div>
                        <div field="F_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="120px">
                F 财务杠杆率(%)
                        </div>
                        <div field="G_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="120px">
                G 交易所担保交收头寸覆盖率(%)
                        </div>
                        <div field="H_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="120px">
                H 交易所担保交收头寸覆盖率_全部(%)
                        </div>
                        <div field="I_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="120px">
                I 交易所非担保交收头寸覆盖率(%)
                        </div>
                        <div field="J_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="130px">
			 	J 银行间头寸覆盖率(%)
                        </div>
                        <div field="K_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="130px">
			  	K 银行间头寸覆盖率_质押券
                        </div>
                        <div field="L_COL" headerAlign="center" allowSort="true" dataType="currency"  align="right" renderer="rendererRateType" width="140px">
            	L 银行间T+0可变现覆盖率
                        </div>
                        <div field="TL_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" renderer="rendererRateType" width="140px">
            	TL T+0可变现覆盖率
                        </div>
                        <div field="M_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="140px">
               	M 交易所正回购到期余额
                        </div>
                        <div field="N_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			N 交易所逆回购到期余额
			  			</div>
			  			<div field="AM_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			AM 交易所正回购未到期余额
			  			</div>
                        <div field="O_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			O 交易所协议正回购到期余额
                        </div>
                        <div field="P_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
  				P 交易所协议逆回购到期余额
                        </div>
                        <div field="AN_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
  				AN 交易所协议正回购未到期余额
                        </div>
                        <div field="Q_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			Q 银行间正回购到期余额
                        </div>
                        <div field="R_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="130px">
	  			R 银行间逆回购到期余额
                        </div>
                        <div field="AO_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="130px">
	  			AO 银行间正回购未到期余额
                        </div>
                        <div field="S_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="130px">
	 			S 存款到期兑付金额
                        </div>
                        <div field="T_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			T 基金赎回款
                        </div>
                        <div field="U_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			U 昨日T+1银行间卖券金额
                        </div>
                <div header="当日T+0可变现" headerAlign="center">
	                <div property="columns">
                        <div field="V_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			V T+0可变现金额
                        </div>
                        <div field="W_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			W T+0可变现金额_上海固收平台
                        </div>
                        <div field="X_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			X T+0可变现金额_深圳协议平台
                        </div>
                        <div field="Y_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			Y T+0可变现金额_银行间市场
                        </div>
                        <div field="Z_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			Z T+0可变现金额_银行间市场_中债
                        </div>
                        <div field="AA_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
                AA T+0可变现金额_银行间市场_上清
                		</div>
                    </div>
	            </div>
	            <div header="当日T+1可变现" headerAlign="center">
	                <div property="columns">
                        <div field="AB_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			AB T+1可变现金额
                        </div>
                        <div field="AC_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="120px">
	  			AC T+1可变现金额_标准券可用金额
                        </div>
                         <div field="AD_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="130px">
	  			AD T+1可变现金额_可质押入库数量
                        </div>
                        <div field="AE_COL" headerAlign="center" allowSort="true" dataType="currency" align="right" width="130px">
	  			AE T+1可变现金额_可质押入库金额
                        </div>
                    </div>
	            </div>
	            <div header="上层资金追加(需手工录入)" headerAlign="center">
	                <div property="columns">
                        <div field="AF_COL" headerAlign="center" align="left" width="130px">
	  			AF 委托人
	  						<input property="editor" class="nui-textbox" style="width:100%;"/>
                        </div>
                        <div field="AG_COL" headerAlign="center" align="left" width="130px">
	  			AG 上层资金来源
	  						<input property="editor" class="nui-textbox" style="width:100%;"/>
                        </div>
                        <div field="AH_COL" headerAlign="center" align="right" width="130px">
	  			AH 上层资金概率
	  						<input property="editor" class="nui-textbox" vtype="float" style="width:100%;"/>
                        </div>
                        <div field="AI_COL" headerAlign="center" align="right" width="130px">
	  			AI 上层资金额度
	  						<input property="editor" class="nui-textbox" vtype="float" style="width:100%;"/>
                        </div>
                        <div field="AJ_COL" headerAlign="center" align="left" width="130px">
	  			AJ 手工调整备注
	  					<input property="editor" class="nui-textarea" style="width:100%;"/>
                        </div>
                    </div>
	            </div>
                        <div field="L_FUND_ID"  name="L_FUND_ID"  headeralign="center" allowsort="true" align="left" width="50px">
		                         基金ID
		                </div>
		                <div field="VC_FUND_CODE" name="VC_FUND_CODE" headerAlign="center" allowSort="true" align="left" width="60px">
            	 基金代码
		                </div>
                    </div>
                </div>
            </div>
            <%-- 自动化头寸表列表结束!!! --%>
	</div>
</div>	

<script type="text/javascript">
	nui.parse();
	var grid_CPTCFXCSB = nui.get("datagrid_CPTCFXCSB");//产品头寸风险预测表
	
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
		    search_CPTCFXCSB();
	}
	
	//系统自动刷新页面--所有业务通用
    function autoRefreshFun(){
    	refreshInt = true;//打开页面之后设置值为true
    	activechangedFun();//同时刷新查询列表数据
    }
    
	<%-- 自动化头寸表开始... --%>
	//查询
	function search_CPTCFXCSB(){
		nui.get("exclusivelyShowSection").setValue("1");
		search(grid_CPTCFXCSB, "#form_CPTCFXCSB");
	}
	//获取查询条件的基金名称
	function ButtonClickGetFundName_CPTCFXCSB(e){
        ButtonClickGetFundName(this, null);
	}
    //行双击时弹出页面展示该指令详细信息
/* 	grid_CPTCFXCSB.on("rowdblclick", function (e) {
		rowdblclickFun("CFJY_zhxxcx_CPTCFXCSB_detail.jsp", "头寸风险预算表明细", 710, 400, e, grid_CPTCFXCSB);
	}); */

	//保存
	function save_CPTCFXCSB(){
		var errorStr = "";//错误提示信息
		var lFundIds = "";//基金ID
		var XHs = "";//序号
		var WTRs = "";//委托人
		var SCZJLYs = "";//上层资金来源
		var SCZJZJGLs = "";//上层追加资金概率
		var SCZJZJEDs = "";//上层追加资金额度
		var BZs = "";//备注
		var changeDatas = grid_CPTCFXCSB.getChanges();
		for(var i=0; i<changeDatas.length; i++){
			var lFundId = changeNull(changeDatas[i].L_FUND_ID);//基金ID
			var XH = changeNull(changeDatas[i].XH);//序号
			var WTR = changeNull(changeDatas[i].Z_COL);//委托人
			var SCZJLY = changeNull(changeDatas[i].AA_COL);//上层资金来源
			var SCZJZJGL = changeNull(changeDatas[i].AB_COL);//上层追加资金概率
			var SCZJZJED = changeNull(changeDatas[i].AC_COL);//上层追加资金额度
			SCZJZJED = SCZJZJED==""?"0":SCZJZJED.toString().replace(/\$|\,/g,'');
			var BZ = changeNull(changeDatas[i].AD_COL);//备注
			BZ = BZ==null||BZ==""?"★":BZ;//若备注为空，传入特殊字符后台处理
			if(isNaN(SCZJZJED)){
				errorStr += "、" + changeDatas[i].VC_FUND_NAME + "-" + changeDatas[i].BZ;
			}
			lFundIds += lFundId;
			XHs += XH;
			WTRs += WTR;
			SCZJLYs += SCZJLY;
			SCZJZJGLs += SCZJZJGL;
			SCZJZJEDs += SCZJZJED;
			BZs += BZ;
			if(i<changeDatas.length-1){
				lFundIds += "@";
				XHs += "@";
				WTRs += "@";
				SCZJLYs += "@";
				SCZJZJGLs += "@";
				SCZJZJEDs += "@";
				BZs += "@";
			}
		}
		if(errorStr!=""){
			errorStr = errorStr.substring(1, errorStr.length);
			nui.alert("【"+errorStr+"】</br>手工调整值输入错误，请重新输入！", "系统提示");
			return;
		}
		
		nui.get("lFundId_CPTCFXCSB").setValue(lFundIds);//基金ID
		nui.get("XH_CPTCFXCSB").setValue(XHs);//序号
		nui.get("WTR_CPTCFXCSB").setValue(WTRs);//委托人
		nui.get("SCZJLY_CPTCFXCSB").setValue(SCZJLYs);//上层资金来源
		nui.get("SCZJZJGL_CPTCFXCSB").setValue(SCZJZJGLs);//上层追加资金概率
		nui.get("SCZJZJED_CPTCFXCSB").setValue(SCZJZJEDs);//上层追加资金额度
		nui.get("BZ_CPTCFXCSB").setValue(BZs);//备注
		saveData(grid_CPTCFXCSB, "com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.updateCPTCFXCSB.biz.ext", "#form_CPTCFXCSB");
	}
	//重置指令信息
	function resetDire_CPTCFXCSB(){
		var form = new nui.Form("form_CPTCFXCSB");
		form.reset();
	}
	//导出
	function export_CPTCFXCSB(){
	    exportSubmit("export_CPTCFXCSB", "form_CPTCFXCSB", "产品头寸风险测算表","TCXXCX");
	}
	<%-- 自动化头寸表结束!!! --%>
	self.setInterval("autoRefreshFun()",60000*3);//设置自动刷新时间默认5分钟
	
	function rendererRateType(e){
		if(e.value == null){
			return "";
		}else{
			return e.value;
		}
    }
	
	var detailData = new Array();
	$(function(){
		detailData[5] = "融资回购余额（含当天到期）/净资产";
		detailData[6] = "未到期融资回购余额/净资产";
		detailData[7] = "总资产/净资产";
		detailData[8] = "T+1可变现金额/交易所正回购到期金额";
		detailData[9] = "（T+1可变现金额+融资占用标准券金额）/（交易所当日正回购到期金额+交易所未到期正回购余额）";
		detailData[10] = "交易所T+0可变现金额/交易所协议正回购到期余额";
		detailData[11] = "(银行间T+0可变现金额+银行间逆回购到期金额+存款到期金额+基金赎回款+昨日银行间T+1卖券金额)/银行间正回购到期金额";
		detailData[12] = "银行间T+0可变现金额/银行间正回购到期金额";
		detailData[13] = "银行间T+0可变现金额/（银行间正回购到期金额+协议正回购到期金额）";
		detailData[14] = "银行间和交易所T+0可变现金额/（银行间正回购到期金额+协议正回购到期金额）";
		
		//合并单元格
		grid_CPTCFXCSB.on("update", function () {
		// Grid加载方法
			onHeaderShowDetail('datagrid_CPTCFXCSB',detailData); 
	    });
	});
</script>
</body>
</html>