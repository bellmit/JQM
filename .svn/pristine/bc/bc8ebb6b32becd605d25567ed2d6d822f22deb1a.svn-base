<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common/js/commscripts.jsp" %>

<!-- 
  - Author(s): 黄燕
  - Date: 2016-11-07 15:06:40
  - Description:
-->
<head>
<title>发行主体_导出到O32</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
<body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
			<div class="search-condition">
			  <div class="list">
	            <div id="form1" class="nui-form"  align="center" style="height:10%" >
	                <!-- 排序字段 -->
	                <form id="queryForm" action="">
	                <table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
	                   <tr>
	                        <td align="right">
							发行主体:
			                </td>
			                <td align="left">
								<input id="vcIssueName" class="nui-textbox"  name="map/vcIssueName"
	                             id="IssuerName" width="100%"/>
	                             <input id="vcIssueNameFull" class="nui-hidden"  name="map/vcIssueNameFull"
	                              width="100%"/>
	                        </td>
	                        
	                    	<td align="right">
							主体评级:
			                </td>
			                <td align="left">
								<input class="nui-dictcombobox" name="map/cIssueAppraise"  valueField="dictID" textField="dictName" dictTypeId="issuerRating"  
										emptyText="全部" nullItemText="全部" multiSelect="true" showClose="true" valueFromSelect="true" width="100%" oncloseclick="onCloseClickValueEmpty"/>
	                        </td>
	                        
	                        <td align="right">
							主体类型:
			                </td>
			                <td align="left">
								<input class="nui-dictcombobox" name="map/vcIssueProperty"   valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ISSUE_PROPERTY"  
										emptyText="全部" nullItemText="全部"  multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" width="100%"/>
	                        </td>
	                        <td align="right">
		                       
						            <a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">
						                	查询
						            </a>
						     </td> 
						     <td align="left">
						            <a class='nui-button' plain='false' iconCls="icon-reload"  onclick="reset()">
						                	重置
						            </a>
	                        </td>
	                    </tr>
	                </table>
	               </form>
	            </div>
	          </div>  
	        </div>
	         <div class="nui-fit" >  
	         	<div  id="datagrid1"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.queryIssuerInfoTemp.biz.ext"
	                        pageSize="20"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        sortField="lIssuerId" sortOrder="desc">
	                        
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div field="lIssuerId" headerAlign="center" allowSort="true" visible=false>发行人序号</div>
	                        
	                        <div field="vcIssueName" headerAlign="center" allowSort="true" >主体简称</div>
	                        
	                        <div field="vcIssueNameFull" headerAlign="center" allowSort="true" >主体全称</div>
	                        
	                        <div field="vcIssueProperty" headerAlign="center" allowSort="true" renderer="issuePropertyRenderer">主体类型</div>
	                        
	                        <div field="cIssueAppraise" headerAlign="center" allowSort="true" renderer="creditRatingRenderer">主体评级</div>
	                        
	                        
	                        <div field="vcIssueAppraiseOrgan" headerAlign="center" allowSort="true" renderer="outRatingOrganRenderer">主体评级机构</div>
	                        
	                        <div field="vcIndustry" headerAlign="center" allowSort="true" visible=false>所属行业编号</div>
	                        <div field="vcIndustryName" headerAlign="center" allowSort="true">所属行业</div>
	                        
	                         <div field="vcProvince" headerAlign="center" allowSort="true">所属省份</div>
	                         <div field="vcIssueAppraiseCsrc" headerAlign="center" allowSort="true" visible=false>所属行业(证监会二级)编号</div>
	                         <div field="vcIssueAppraiseCsrcName" headerAlign="center" allowSort="true">所属行业(证监会二级)</div>
	                         <div field="enIssuerNetValue" headerAlign="center" allowSort="true">公司净资产</div>
	                         <div field="vcCityLevel" headerAlign="center" allowSort="true" renderer="vcCityLevelRenderer">城投行政级别</div>
	                        
	                        <div field="vcIssuerCode" headerAlign="center" allowSort="true"  align="right">主体编号</div>
	                        
	                        <div field="vcIssueNameChar" headerAlign="center" allowSort="true" width="150px" >主体名称缩写</div>
	                        
	                    </div>
	                 </div>
	               </div>
</body>
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var form = new nui.Form("#form1");
    	var formData = form.getData(false,false);
		grid.load(formData);
		function reset(){
			form.reset();
		}
    	  //债券评级机构
        function onBondAppraiseRenderer(e){
        	return nui.getDictText("creditRating",e.row.cBondAppraise);
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
        function vcCityLevelRenderer(e){
        	return nui.getDictText("cityLevel",e.row.vcCityLevel);
        }
        //查询
        function search(){
        	var vcIssueName = nui.get("vcIssueName").value;
        	nui.get("vcIssueName").setValue(vcIssueName.toUpperCase());
        	nui.get("vcIssueNameFull").setValue(vcIssueName);
        	var data = form.getData(false,false);      //获取表单多个控件的数据
            grid.load(data);
        }
        
        function clearStockType(e){
        	if(e.source.value==null || e.source.value==""){
		   			//清空债券类型
		   			var vcStockType = nui.get("vcStockType");
			        vcStockType.setValue("");
		            var url = "com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadStockType.biz.ext?type=1";
		            vcStockType.setUrl(url);
		   		}
        }
        function add() {
			var url = "<%= request.getContextPath() %>/fm/baseinfo/issuerInfo/addIssuerInfo.jsp";
			var title = "新增发行主体";
			var width = "400";
			var height = "300";
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					
				},
				ondestroy: function (action) {//弹出页面关闭前
					grid.reload();
				}
			});
		}
		function edit(){
		    var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/issuerInfo/editIssuerInfo.jsp",
                    title: "发行主体修改", 
                    width: 400, 
           			height: 300,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data);
                    },
                    ondestroy: function (action) {
                        if(action=="saveSuccess"){
	                        grid.reload();
                   	 	}
                    }
                });
                
            } else {
                nui.alert("请选中一条记录");
            }
		}
		
		
    </script>
</html>