<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): 胥思明
  - Date: 2016-11-18 13:16:29
  - Description:
-->
<%@include file="/common/js/commscripts.jsp" %>
<head>
<title>历史评级</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
</head>
<body style="width:100%;height:100%; overflow: hidden;">
			<div class="search-condition">
			<div class="list">
				<div id="form1" class="nui-form" style="height:5%" align="center" >
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsBondAppraise">
					<!-- 排序字段 -->
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
						<tr>
							<td style="width:60px" align="right" >数据来源</td>
							<td colspan="1" width="20%" align="left">
                        			<input class="nui-textbox" id="cSource" name="criteria/_expr[1]/cSource"  width="100%"/>
							</td>
							<td style="width:100px" align="right">债券内码</td>
							<td colspan="1" width="20%" align="left">
                        			<input  class="nui-textbox"  name="criteria/_expr[2]/vcInterCode"
                             id="vcField" width="100%"/>
							</td>
							<td align="left">
								<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
							    <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
						                             重置
						        </a>
							</td>
						</tr>
					</table>
				</div>
			</div>   
        </div>
            <div class="nui-fit">
                <div 
                        id="datagrid1" 
                        dataField="bondAppraise"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.queryBondAppraise.biz.ext"
                        pageSize="20"
                        sortField="cSource"
                        showPageInfo="true"
                        multiSelect="true">

			<div property="columns">
                <div id="lDate" field="lAppraiseDate" headerAlign="center" allowSort="true" renderer="renderDataTemp">评价日期</div>
                <div field="vcBondAppraise" headerAlign="center" width="50" allowSort="true" renderer="vcLogTypeRenderer">债券评级</div>
                <div field="vcBondAppraiseOrgan" headerAlign="center" width="120" allowSort="true" >债券评级机构</div>
			</div>
		</div>
	</div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);
			

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
	            var json = form.getData(false,false);
	            grid.load(json);//grid查询
	        }

            //enter键触发查询
            function onKeyEnter(e) {
                search();
            }
            function cstatusname(e){
            	if(e.row.cStatus=='0'){
            		return "启用";
            	}else{
            		return "未启用";
            	}
            }
            
            //更改日期格式
			function renderDataTemp(e){
				if(e.value == "0" || e.value == null){
					return "";
				}
				return dataTemp(e.value);
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
          </script>
        </body>
</html>