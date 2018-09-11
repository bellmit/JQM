<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): chenpeng
- Date: 2016-05-31 15:16:12
- Description:
    --%>
<head>
	<title>传真信息查询</title>
	<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
	<link id="css_icon" rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/coframe/org/css/org.css"/>
	<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
	<script src="<%= request.getContextPath() %>/process/util/common.js" type="text/javascript"></script>
</head>
<body style="width:100%;height:100%;overflow: hidden;">
	<div class="search-condition">
		<div class="list">
			<div id="form1" class="nui-form" style="padding:2px;" align="center" style="height:10%" >
				<!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.commonUtil.dataBase.CfJyEastFax">
                <!-- 排序字段 -->
                <table id="table1" border="0" class="table" style="height:100%;width: 100%;">
					<tr>
						<td class="form_label" align="right">
                            发送时间:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-datepicker" name="faxParam/sendTime" id="sendTime" format="yyyy-MM-dd"/>
                        </td>
                        <td class="form_label" align="right">
                            传真主题:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" name="faxParam/faxTheme"/>
                        </td>              
                        <td class="form_label" align="right">
                            接收人姓名:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" name="faxParam/recvName"/>
                        </td>
                        <td width="20%" align="left">
					            <a class='nui-button' plain='false' onclick="search()">
					                查询
					            </a>
					            &nbsp;
					            <a class='nui-button' plain='false' onclick="reset()">
					                重置
					            </a>
                        </td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<div class="nui-fit">
		<div id="datagrid1" 
			 dataField="cfjyeastfaxs" 
			 class="nui-datagrid" 
			 style="width:100%;height:100%;" 
			 url="com.cjhxfund.commonUtil.cfjyeastfaxbiz.queryCfJyEastFaxs.biz.ext" 
			 pageSize="50" 
			 showPageInfo="true" 
			 multiSelect="true" 
			 allowSortColumn="false">
			<div property="columns">
				<div type="indexcolumn"></div>
				<div type="checkcolumn"></div>
                <div field="faxId" headerAlign="center" allowSort="true" visible="false">
                            传真ID
                </div>
                <div field="FAX_ACCOUNT" headerAlign="center" allowSort="true" >
                            发送人传真号
                </div>
                <div field="FAX_THEME" headerAlign="center" allowSort="true" >
                            传真主题
                </div>
                <div field="SERIALNO" headerAlign="center" allowSort="true" >
                            传真流水号
                </div>
                <div field="FAX_COMMENTS" headerAlign="center" allowSort="true" >
                            传真备注
                </div>
                <div field="SEND_TIME" headerAlign="center" allowSort="true" >
                            发送时间
                </div>
                <div field="RECV_NUMBER" headerAlign="center" allowSort="true" >
                            接收人传真号
                </div>
                <div field="RECV_NAME" headerAlign="center" allowSort="true" >
                            接收人姓名
                </div>
                <div field="RECV_COMPANY" headerAlign="center" allowSort="true" >
                            接收人公司名称
                </div>
                <div field="VSLID_STATUS" headerAlign="center" allowSort="true" renderer="renderValidStatus">
                            状态
                </div>
			</div>
		</div>
	</div>
	<script type="text/javascript">
		nui.parse();
		var grid = nui.get("datagrid1");
		
		nui.get("sendTime").setValue(new Date());
			
		var formData = new nui.Form("#form1").getData(false,false);
		grid.load(formData);
	
		//重新刷新页面
		function refresh(){
			var form = new  nui.Form("#form1");
			var json = form.getData(false,false);
			grid.load(json);//grid查询
			nui.get("update").enable();
		}
		//查询
		function search() {
			var form = new nui.Form("#form1");
			var json = form.getData(false,false);
			grid.load(json);//grid查询
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
	
		//传真状态
		function renderValidStatus(e){
		  return nui.getDictText("CF_JY_CZZT",e.row.VSLID_STATUS);
		}
	</script>
  </body>
</html>
