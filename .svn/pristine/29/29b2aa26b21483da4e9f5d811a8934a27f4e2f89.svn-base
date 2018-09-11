<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%@ taglib uri="http://eos.primeton.com/tags/workflow" prefix="wf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>
<!-- 
  - Author(s): 黄燕
  - Date: 2016-12-06 15:31:16
  - Description:
-->
<head>
<title>去重明细信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
<%
   String processinstid = request.getParameter("processInstID");
 %>
</head>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
			     <div class="nui-fit" > 
			         <div id="datagrid1" class="nui-datagrid"
					style="width: 100%;height: 100%;  "  allowResize="false"
					url="com.cjhxfund.ats.fm.baseinfo.approveInfoManager.queryMergeDetail.biz.ext"
					sortField="lBizId" dataField="merges" sortOrder="desc" multiSelect="true" pageSize="20" showPager="false" showPageInfo="false">
			                    <div property="columns">
			                        <div field="lProcessInstId" width="100px" headerAlign="center" allowSort="true" visible=false>流程ID</div>
			                        <div field="lStockIssueId" headerAlign="center" allowSort="true" visible=false>业务序号</div>
			                        <div field="lBizId" headerAlign="center" allowSort="true" visible=false>流程序号</div>
			                        <div field="lStockInvestNo" headerAlign="center" allowSort="true" visible=false>债券投资编号</div>
			                       <div field="vcPaymentPlace" headerAlign="center" width="100px" allowSort="true" renderer="vcPaymentPlaceRenderer">登记托管机构</div>
			                         
			                        <div field="vcStockCode" headerAlign="center" width="100px" allowSort="true" >债券代码</div>
			                        
			                        <div field="vcStockName" headerAlign="center" width="100px" allowSort="true" >债券简称</div>
			                        
			                        <div field="vcStockNameFull" headerAlign="center" width="100px" allowSort="true" >债券全称</div>
			                        
			                        <div field="vcStockType" headerAlign="center" width="100px" allowSort="true" >债券类别</div>
			                           
			                        <div field="enExistLimite" headerAlign="center" allowSort="true" width="80px" align="right">发行期限(年)</div>
			                        
			                        <div field="enIssueBalance" headerAlign="center" allowSort="true"  align="right" width="80px" >发行规模(亿)</div>
			                        
			                         <div field="cStatus" headerAlign="center" allowSort="true" width="100px" renderer="cStatusRenderer" visible="false">流程状态</div>
			                        
			                        <div field="cBondAppraise" headerAlign="center" align="center" width="100px"  renderer="onBondAppraiseRenderer" width="60px">债券评级</div>
			                        
			                        <div field="vcBondAppraiseOrgan" headerAlign="center" width="150px" allowSort="true"  renderer="onBondAppraiseOrganRenderer">债券评级机构</div>
			                         
									<div field="vcIssueProperty" headerAlign="center" align="center" allowSort="true" width="80"  renderer="issuePropertyRenderer">
			                            	主体类型
			                        </div>
			                        
			                        <div field="vcIssuerNameFull" headerAlign="center" width="150px" allowSort="true" >
			                            	发行主体
			                        </div>
			                        
			                        <div field="cIssueAppraise" headerAlign="center" allowSort="true" align="center" width="100px"  renderer="creditRatingRenderer">
			                            	主体评级
			                        </div>
			                        <div field="vcIssueAppraiseOrgan" headerAlign="center" allowSort="true" width="100px" renderer="outRatingOrganRenderer">
			                            	主体评级机构
			                        </div>
			                        
			                        <div field="vcIndustry" headerAlign="center" width="100px" allowSort="true">所属行业</div>
				
				                    <div field="vcProvince" headerAlign="center" width="100px" allowSort="true">所属省份</div>
				                    
				                    <div field="vcGuarantorName" headerAlign="center" width="100px" allowSort="true" >
			                            	担保人名称
			                        </div>
				                    
				                    <div field="vcGuarantorSummary" headerAlign="center" width="100px" allowSort="true">担保人简介</div>
				                     
			                        <div field="lIssuePostDate" headerAlign="center" align="right" width="100px" allowSort="true" >
			                            	公告日期
			                        </div>
			                        <div field="lIssueBeginDate" headerAlign="center" align="right" width="100px" allowSort="true" >
			                            	发行日期
			                        </div>
			
			                        <div field="lPayDate" headerAlign="center" align="right" width="100px"  allowSort="true" >
			                            	缴款日期
			                        </div>
			                        <div field="lPublishDate" headerAlign="center" align="right" width="100px"  allowSort="true" >
			                            	上市日期
			                        </div>
			                        <div field="lBegincalDate" headerAlign="center" align="right" width="100px"  allowSort="true" >
			                            	起息日期
			                        </div>
			                        
			                        <div field="lEndincalDate" headerAlign="center" align="right" width="100px"  allowSort="true" visible="false">
			                            	到期日期
			                        </div>
			                        
			                        <div field="cInterestType" renderer="rendererRateType" headerAlign="center" width="100px" allowSort="true" >利率类型</div>
				
									<div field="cPayInterestType" renderer="rendererPayInterstType" width="100px" headerAlign="center"allowSort="true" >息票品种</div>
									
									<div field="enPayInteval" headerAlign="center" renderer="rendererEnPayInteval" width="100px" allowSort="true" >付息频率</div>
									
									<div field="enFaceRate" headerAlign="center" align="right" allowSort="true" >票面利率(%)</div>
									
									<div field="cBidType" headerAlign="center" renderer="renderercBidType" width="100px" allowSort="true" >招标方式</div>
									
									<div field="cPayType" headerAlign="center"allowSort="true" width="100px" renderer="rendererPaymentType" >缴款方式</div>
									
									<div field="vcSpecialText" headerAlign="center" width="100px" allowSort="true" >特殊条款</div>
				
			                        <div field="vcMainUnderwriter" headerAlign="center" width="100px"  allowSort="true"  >
			                            	主承销商
			                        </div>
			                        <div field="vcDeputyUnderwriter" headerAlign="center" width="100px"  allowSort="true"  >
			                            	副主承销商
			                        </div>
			                        
			                        <div field="cUnderwriteType" headerAlign="center" width="100px" allowSort="true"  renderer="underwriteTypeRenderer">
			                            	承销方式
			                        </div>
			                        
			                        <div field="vcGroupUnderwriter" headerAlign="center" width="100px"allowSort="true" >承销团</div>
			                        
			                         <div field="cIsHaveSaleback" headerAlign="center" width="100px" align="center" allowSort="true" renderer="isRenderer">
			                           	             是否具有回售权
			                        </div> 

			                        <div field="cIsHaveBuyback" headerAlign="center" width="100px" align="center" allowSort="true" renderer="isRenderer">
			                           	            是否具有赎回权
			                        </div>
			                         
			                        <div field="lNextExerciseDate" headerAlign="center" width="100px" align="right" allowSort="true">
			                           	            下一行权日
			                        </div>
			                        
			                         <div field="lCreditAnalyzeNo" headerAlign="center" width="100px" align="center" allowSort="true" visible="false">
			                           	            信用分析人员
			                        </div>
			                        
			                        <div field="vcCreditAnalyze" headerAlign="center" align="center" allowSort="true" visible="false">
			                           	           信用分析
			                        </div>
			                        			                        				                        			     			                        
			                        <div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
			                        
			                        <div field="vcStockType" headerAlign="center" allowSort="true" visible=false>债券类别编码</div>			                        			                        
			                        
			                        <div field="cSource" headerAlign="center" allowSort="true"   visible=false>数据来源</div>
			                        
			                        <div field="vcInterCode" headerAlign="center" allowSort="true"  visible=false>债券内码</div>
			                        
			                        <div field="vcStockCodeWind" headerAlign="center" allowSort="true" visible=false>债券代码_wind</div>
			                        
			                        <div field="cMarketNo" headerAlign="center" allowSort="true" visible=false>交易市场</div>
			                        
			                        <div field="vcStockType" headerAlign="center" allowSort="true" visible=false>债券类别编码</div>

			                    </div>
			          </div>
</div>
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var processinstid = '<%=processinstid %>';
    	var data = {"lBizId":processinstid}; 
    	grid.load(data);
    	//利率类型
    	function rendererRateType(e){
    		return nui.getDictText("rateType", e.row.cInterestType);
    	}
    	
    	//息票品种
    	function rendererPayInterstType(e){
    		return nui.getDictText("payInterestType", e.row.cPayInterestType);
    	}
    	
    	//付息频率
    	function rendererEnPayInteval(e){
    		return nui.getDictText("ATS_CF_JY_FREQUENCY", e.row.enPayInteval);
    	}
    	//招标方式
    	function renderercBidType(e){
    		return nui.getDictText("tenderType", e.row.cBidType);
    	}
    	
    	//缴款方式
    	function rendererPaymentType(e){
    		return nui.getDictText("ATS_FM_PAYMENT", e.row.cPayType);
    	}
        
        //债券评级机构
        function onBondAppraiseRenderer(e){
        	return nui.getDictText("creditRating",e.row.cBondAppraise);
        }
        
         //债券评级机构
        function onBondAppraiseOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcBondAppraiseOrgan);
        }
        
        function issuePropertyRenderer(e){
        	return nui.getDictText("ATS_FM_ISSUE_PROPERTY",e.row.vcIssueProperty);
        }
        
        
        function creditRatingRenderer(e){
        	return nui.getDictText("issuerRating",e.row.cIssueAppraise);
        }
        
        function outRatingOrganRenderer(e){
        	return nui.getDictText("outRatingOrgan",e.row.vcIssueAppraiseOrgan);
        }
        function lNextExerciseDateRenderer(e){
        	if(e.row.lNextExerciseDate!="" && e.row.lNextExerciseDate!=null){
        		return e.value.substr(0,4);
        	}
        }
        function underwriteTypeRenderer(e){
        	return nui.getDictText("underwriteType",e.row.cUnderwriteType);
        }
        var renders = [{ id: "1", text: '是' }, { id: "0", text: '否'}];
        function isRenderer(e) {
            for (var i = 0, l = renders.length; i < l; i++) {
                var g = renders[i];
                if (g.id == e.value) {
                  return g.text;
                }else{
                  return "否";
                }
            }
        }
        function vcPaymentPlaceRenderer(e){
        		return nui.getDictText("CF_JY_DJTGCS",e.row.vcPaymentPlace);
        }
    </script>
</body>
</html>