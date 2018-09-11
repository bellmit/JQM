<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>
<html>
<!-- 
  - Author(s): 邓小龙
  - Date: 2016-11-08 13:38:57
  - Description:
-->
<head>
<title>报量方式说明</title>
<body style="width: 100%;height: 100%;overflow: hidden;">
<div id="reportMarkId" style="height: 180px; width:590px;margin-left: 20px;"></div>
<div id="proportion" style="width: 590px;margin-left: 20px; margin-bottom: 5px;">
债券占比说明.<br/>
申购流程计算方式<br/>
	中标确认节点前计算方式：<br/>
		<span style="padding-left: 20px;">该笔债券投资占发行规模比例(%):【投标金额/发行规模】,否则为0；</span><br/>
		<span style="padding-left: 20px;">同一发行主体占产品净值规模比例(%):【(本次投标金额+主体发行债券存量)/净值规模】,否则为0；</span><br/>
		<span style="padding-left: 20px;">该笔债券投资占产品净值规模比例(%):【投标金额/净值规模】,否则为0；</span><br/>
		<span style="padding-left: 20px;">弱流动性资产规模占产品净值规模比例(%):暂无计算；</span><br/>
	中标确认节点后计算方式：<br/>
		<span style="padding-left: 20px;">该笔债券投资占发行规模比例(%):【缴款面值/发行规模】,否则为0；</span><br/>
		<span style="padding-left: 20px;">同一发行主体占产品净值规模比例(%):【(本次投标金额+主体发行债券存量)/净值规模】,否则为0；</span><br/>
		<span style="padding-left: 20px;">该笔债券投资占产品净值规模比例(%):【缴款面值/净值规模】,否则为0；</span><br/>
		<span style="padding-left: 20px;">弱流动性资产规模占产品净值规模比例(%):暂无计算；</span><br/>
缴款流程计算方式：<br/>
	<span style="padding-left: 20px;">该笔债券投资占发行规模比例(%):【缴款面值/发行规模】,否则为0；</span><br/>
	<span style="padding-left: 20px;">同一发行主体占产品净值规模比例(%):【(缴款面值+主体发行债券存量)/净值规模】,否则为0；</span><br/>
	<span style="padding-left: 20px;">该笔债券投资占产品净值规模比例(%):【缴款面值/净值规模】,否则为0；</span><br/>
	<span style="padding-left: 20px;">弱流动性资产规模占产品净值规模比例(%):暂无计算；</span><br/>
</div>
<div class="nui-toolbar" style="padding:0px;" borderStyle="border:0;">
                <table width="100%">
                    <tr>
                        <td style="text-align:center;" colspan="4">
                            <a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel('close')">关闭</a>
                        </td>
                    </tr>
                </table>
            </div>

<script type="text/javascript">
	function SetData(reportMark){
	    $("#reportMarkId").html(reportMark);
	}
	
	//关闭窗口
    function onCancel(action) {
		if (action == "close") {
			window.CloseOwnerWindow(action);
		}
	}
</script>
</body>
</html>