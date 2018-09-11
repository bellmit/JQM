<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): CJ-WB-DT13
  - Date: 2016-07-19 14:12:51
  - Description:
-->
<head>
<title>债券详细信息</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
	    
	    
	    <script src="<%= request.getContextPath() %>/process/util/FirstGradeBond.js" type="text/javascript"></script>
	    <style type="text/css">
			th{
				border-right: 1px solid #D3D3D3;
				font-weight: inherit;
			}
			td{
				border-right: 1px solid #D3D3D3;
			}
			.td_bottom{
			    border-bottom: 1px solid #D3D3D3;
			}
	      
	        .asLabel .mini-textbox-border,
		    .asLabel .mini-textbox-input,
		    .asLabel .mini-buttonedit-border,
		    .asLabel .mini-buttonedit-input,
		    .asLabel .mini-textboxlist-border
		    {
		        border:0;background:none;cursor:default;
		    }
		    .asLabel .mini-buttonedit-button,
		    .asLabel .mini-textboxlist-close
		    {
		        display:none;
		    }
		    .asLabel .mini-textboxlist-item
		    {
		        padding-right:8px;
		    }    
	    </style>
</head>
<body>
	<div id="dataform1" style="padding-top:5px;height:93%;">
		<table style="width:100%;table-layout:fixed;" class="nui-form-table">
			<tr>
            	<th class="form_label" width="15%" align="right">
                        债券代码:
                </th>
                <td colspan="1" width="35%">
                	<input class="nui-textbox"  width="100%" name="stockissueinfo.vcStockCode"/>
                </td>
                <th class="form_label" width="15%" align="right">
                        债券简称:
                </th>
                <td colspan="1" width="35%">
                    <input class="nui-textbox" width="100%" name="stockissueinfo.vcStockName"/>
                </td>
            </tr>
            <tr>
                <th class="form_label" align="right">
                        债券全称:
                </th>
                <td colspan="1">
                    <input class="nui-textbox" width="100%" name="stockissueinfo.vcStockNameFull"/>
                </td>
                <th class="form_label" align="right">
                        债券类别:
                </th>
                <td colspan="1">
			        <input class="nui-textbox" width="100%" name="stockissueinfo.vcStocktypeName"/>
			        
                </td>
            </tr>
            <tr>
                <th class="form_label" align="right">
                        交易市场:
                </th>
                <td colspan="1">
                    <input class="nui-dictcombobox" width="100%" name="stockissueinfo.cMarketNo" allowInput="true"
			  	 url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryCMarket.biz.ext"   emptyText="请选择" textField="TEXT" valueField="ID" readonly="readonly" showNullItem="false"  />
                </td>
                <th class="form_label" align="right">
                        公告日期:
                </th>
                <td colspan="1">
                    <input class="nui-textbox" width="100%" name="stockissueinfo.lIssuePostDate"/>
                </td>
            </tr>
            <tr>
                <th class="form_label" align="right">
                        发行日期:
                </th>
                <td colspan="1">
                    <input class="nui-textbox" width="100%" name="stockissueinfo.lIssueBeginDate"/>
                </td>
                <th class="form_label" align="right">
                        投标截止日期:
                </th>
                <td colspan="1">
                    <input class="mini-datepicker" format="yyyy-MM-dd H:mm:ss" width="100%" name="stockissueinfo.dBidLimitTime"/>
                </td>
            </tr>
            <tr>
                <th class="form_label" align="right">
                        缴款日期:
                </th>
                <td colspan="1">
                    <input class="nui-textbox" width="100%" name="stockissueinfo.lPayDate"/>
                </td>
                <th class="form_label" align="right">
                        上市日期:
                </th>
                    <td colspan="1">
                        <input class="nui-textbox" width="100%" name="stockissueinfo.lPublishDate"/>
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        起息日期:
                    </th>
                    <td colspan="1">
                        <input class="nui-textbox" width="100%" name="stockissueinfo.lBegincalDate"/>
                    </td>
                    <th class="form_label" align="right">
                        到期日期:
                    </th>
                    <td colspan="1">
                        <input class="nui-textbox" width="100%" name="stockissueinfo.lEndincalDate"/>
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        发行规模(亿):
                    </th>
                    <td colspan="1">
                        <input class="nui-textbox" width="100%" name="stockissueinfo.enIssueBalance"/>
                    </td>
                    <th class="form_label" align="right">
                        发行期限(年):
                    </th>
                    <td colspan="1">
                        <input class="nui-textbox" width="100%" name="stockissueinfo.enExistLimite"/>
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        利率类型:
                    </th>
                    <td colspan="1">
                        <input class="nui-dictcombobox" width="100%" dictTypeId="rateType" name="stockissueinfo.cInterestType" readonly="readonly"/>
                    </td>
                    <th class="form_label" align="right">
                        息票品种:
                    </th>
                    <td colspan="1">
                        
                        <input class="nui-dictcombobox" width="100%" dictTypeId="payInterestType" name="stockissueinfo.cPayInterestType" readonly="readonly"/>
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        付息频率(次/年):
                    </th>
                    <td colspan="1">
                        
                        <input class="nui-dictcombobox" width="100%" readonly="readonly" id="enPayInteval"  name="stockissueinfo.enPayInteval" dictTypeId="ATS_CF_JY_FREQUENCY"/>
                    </td>
                    <th class="form_label" align="right">
                        票面利率(%):
                    </th>
                    <td colspan="1">
                        <input class="nui-textbox" width="100%" name="stockissueinfo.enFaceRate" readonly="readonly" />
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        债券评级:
                    </th>
                    <td colspan="1">
                        
                        <input class="nui-dictcombobox" width="100%" name="stockissueinfo.cBondAppraise" readonly="readonly"  dictTypeId="creditRating" />
                    </td>
                    <th class="form_label" align="right">
                        债券评级机构:
                    </th>
                    <td colspan="1">
                        <input class="nui-dictcombobox" width="100%" name="stockissueinfo.vcBondAppraiseOrgan" readonly="readonly" dictTypeId="outRatingOrgan" />
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        招标方式:
                    </th>
                    <td colspan="1">
                        <input class="nui-dictcombobox" width="100%" name="stockissueinfo.cBidType" readonly="readonly" dictTypeId="tenderType" />
                    </td>
                    <th class="form_label" align="right">
                        主体简称:
                    </th>
                    <td colspan="1">
                        <input class="nui-textbox"width="100%" name="stockissueinfo.vcIssuerName"/>
                    </td>
                </tr>
                <tr>
                    
                    <th class="form_label" align="right">
                        特殊条款:
                    </th>
                    <td colspan="3">
                        
                        <input class="nui-textarea" width="80%" name="stockissueinfo.vcSpecialText"/>
                    </td>
                </tr>
                <tr>
                    <th class="form_label" align="right">
                        主体评级:
                    </th>
                    <td colspan="1">
                        <input class="nui-dictcombobox" width="100%" name="stockissueinfo.cIssueAppraise" dictTypeId="issuerRating" />
                    </td>
                    <th class="form_label" align="right">
                        主体评级机构:
                    </th>
                    <td colspan="1">
                        
                        <input class="nui-dictcombobox" width="100%" name="stockissueinfo.vcIssueAppraiseOrgan" dictTypeId="outRatingOrgan" />
                        
                    </td>
                </tr>
                <tr>
                    <th class="form_label td_bottom" align="right">
                        主承销商:
                    </th>
                    <td colspan="1" class="td_bottom">
                        <input class="nui-textbox" name="stockissueinfo.vcMainUnderwriter" width="100%"/>
                    </td>
                    <th class="form_label td_bottom" align="right">
                        副主承销商:
                    </th>
                    <td colspan="1" class="td_bottom">
                        <input class="nui-textbox" name="stockissueinfo.vcDeputyUnderwriter" width="100%"/>
                    </td>
                </tr>
                <!-- <tr>
                    <td class="form_label">
                        承销方式:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="stockissueinfo.cUnderwriteType"/>
                    </td>
                    <td class="form_label">
                        承销团:
                    </td>
                    <td colspan="1">
                        <input class="nui-textbox" name="stockissueinfo.vcGroupUnderwriter"/>
                    </td>
                </tr> -->
            </table>
  </div>
  <div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
		<table width="100%">
			<tr>
				<td style="text-align:center;" colspan="4">
					<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">
					 关闭
					</a>
				</td>
			</tr>
		</table>
	</div>	
	<script type="text/javascript">
    	nui.parse();
    	var form = new nui.Form("#dataform1");//将普通form转为nui的form
    	
    	function setFormData(data){
    	
    	    //跨页面传递的数据对象，克隆后才可以安全使用
	   		var infos = nui.clone(data);
	   		var data = {stockissueinfo:{vcInterCode:infos.vcInterCode},rowData:{stockissueinfo:infos.rowData}};
	   		
	   		var form = new nui.Form("#dataform1");//将普通form转为nui的form
	   		//转换所以的时间
			data.rowData.stockissueinfo.lIssuePostDate=dateTemp(data.rowData.stockissueinfo.lIssuePostDate);
			data.rowData.stockissueinfo.lIssueBeginDate=dateTemp(data.rowData.stockissueinfo.lIssueBeginDate);
			//data.rowData.stockissueinfo.dBidLimitTime=dateTemp(data.rowData.stockissueinfo.dBidLimitTime);
			data.rowData.stockissueinfo.lPayDate=dateTemp(data.rowData.stockissueinfo.lPayDate);
			data.rowData.stockissueinfo.lPublishDate=dateTemp(data.rowData.stockissueinfo.lPublishDate);
			data.rowData.stockissueinfo.lBegincalDate=dateTemp(data.rowData.stockissueinfo.lBegincalDate);
			data.rowData.stockissueinfo.lPublishDate=dateTemp(data.rowData.stockissueinfo.lPublishDate);
			
			form.setData(data.rowData);
			form.setChanged(false);
			//处理付息频率，值满足数据字典则直接显示数据字典中对应值，否则直接显示值
			if(nui.get("enPayInteval").getText()=="" || nui.get("enPayInteval").getText()==null){
				nui.get("enPayInteval").setText(data.rowData.stockissueinfo.enPayInteval);
			}	
    	}
    	//时间转换
    	function dateTemp(oldData){
    		oldData=oldData+"";
    		if(oldData==0 || oldData=="" || oldData=="null"){
    			return "";
    		}
    		
    		var datas=oldData.indexOf("-");
    		if(datas>=0){
    			return oldData;
    		}
    		var yy=oldData.substr(0,4);//0开始，截取后面4位
    		var mm=oldData.substr(4,2);//4开始，截取后面2位
    		var dd=oldData.substr(6,2);
    		
    		return yy+"-"+mm+"-"+dd;
    	}
    	//关闭窗口
		function CloseWindow(action) {
			if (action == "close" && form.isChanged()) {
				if(confirm("数据被修改了，是否先保存？")) {
					saveData();
				}
			}
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow(action);
			else window.close();
		}
		
		var fields = form.getFields();                
        for (var i = 0, l = fields.length; i < l; i++) {
			var c = fields[i];
			if (c.setReadOnly) c.setReadOnly(true);     //只读
			if (c.setIsValid) c.setIsValid(true);      //去除错误提示
			if (c.addCls) c.addCls("asLabel");          //增加asLabel外观
		}
	
		//取消
		function onCancel() {
			CloseWindow("cancel");
		}
    </script>
</body>
</html>