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
<title>发行主体查询</title>
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
								<input id="vcIssueName" class="nui-textbox"  name="criteria/_or[1]/_expr[3]/vcIssueName"
	                             id="IssuerName" width="100%"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[3]/_op" value="like">
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[3]/_likeRule" value="all">
	                            
	                            <input id="vcIssueNameFull" class="nui-hidden"  name="criteria/_or[1]/_expr[2]/vcIssueNameFull"
	                              width="100%"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[2]/_op" value="like">
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[2]/_likeRule" value="all">
	                            
	                            <input id="vcIssueNameChar" class="nui-hidden"  name="criteria/_or[1]/_expr[4]/vcIssueNameChar"
	                              width="100%"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[4]/_op" value="like">
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[4]/_likeRule" value="all">
	                        </td>
	                        
	                    	<td align="right">
							主体评级:
			                </td>
			                <td align="left">
								<input class="nui-dictcombobox" name="criteria/_expr[6]/cIssueAppraise"  valueField="dictID" textField="dictName" dictTypeId="issuerRating"  
										emptyText="全部" nullItemText="全部" multiSelect="true" showClose="true" valueFromSelect="true" width="100%" oncloseclick="onCloseClickValueEmpty"/>
	                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[6]/_op" value="in">
	                        </td>
	                        
	                        <td align="right">
							主体类型:
			                </td>
			                <td align="left">
								<input class="nui-dictcombobox" name="criteria/_expr[7]/vcIssueProperty"   valueField="dictID" textField="dictName" dictTypeId="ATS_FM_ISSUE_PROPERTY"  
										emptyText="全部" nullItemText="全部"  multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" width="100%"/>
	                        	<input class="nui-hidden" type="hidden" name="criteria/_expr[7]/_op" value="in">
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
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' id="add" iconCls='icon-add' onclick='add()'>新增</a>
                            <a class='nui-button' plain='false' id="edit" iconCls='icon-edit' onclick='edit()'>修改</a>
                            <a class='nui-button' plain='false' id="addAlisa" iconCls='icon-add' onclick='addAlias()'>增加别名</a>
                        </td>
                    </tr>
                </table>
            </div>
	         <div class="nui-fit" >  
	         	<div  id="datagrid1"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.loadIssueInfo.biz.ext?type=1"
	                        pageSize="20"
	                        onselectionchanged="selectionChanged"
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
	                        
	                        <div field="lIssuerIdO32" headerAlign="center" allowSort="true" width="150px" visible=false>主体名称缩写</div>
	                        
	                    </div>
	                 </div>
	               </div>
	               
	                <div id="tabs" class="nui-tabs" activeIndex="0" height="30%"> 
	               	<div title="别名明细信息">
	               	  <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' id="aditAlisa" iconCls='icon-edit' onclick='removeAlias()'>删除别名</a>
                        </td>
                    </tr>
                </table>
            </div>
              			<div id="aliasGrid" class="nui-datagrid" style="width:100%;height:82%;"
							url="com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.getIssueAliasInfoByName.biz.ext" 
							dataField="alias"  multiSelect="true" pageSize="20"
	                        showPageInfo="true"  sortField="lAliasId" sortOrder="desc">
							
							<div property="columns">
							    <div type="checkcolumn"  ></div>
							    <div field="lAliasId" width="50" headerAlign="center" align="right"  allowSort="true"  >
							                    序号
							    </div>
								<div field="lDate"  headerAlign="center" width="70" dateFormat="yyyy-MM-dd" align="right"  allowSort="true">
									 日期
						        </div>
						        <div field="vcIssuerNameFull"  headerAlign="center"  width="140" allowSort="true">
									 发行主体全称
						        </div>
						        <div field="vcIssuerNameFullWind"  headerAlign="center"  width="120" allowSort="true">
									 发行主体别名
						        </div>
						        <div field="cStatus"  headerAlign="center" width="100" allowSort="true" visible=false>
									 状态
						        </div>
						        <div field="lOperatorNo"  headerAlign="center" width="100" align="right" allowSort="true" visible=false>
									 操作人
						        </div>
							</div>
						</div>
		        	</div>
		        </div>
</body>
	<script type="text/javascript">
    	nui.parse();
    	var grid = nui.get("datagrid1");
    	var aliasGrid= nui.get("aliasGrid");
    	setAlisa();
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
             nui.get("vcIssueNameChar").setValue(vcIssueName.toUpperCase());
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
			var width = "450";
			var height = "390";
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					
				},
				ondestroy: function (action) {//弹出页面关闭前
					nui.get("vcIssueName").setValue(action);
					search();
				}
			});
		}
		function edit(){
		    var row = grid.getSelected();
            if (row) {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/issuerInfo/editIssuerInfo.jsp",
                    title: "发行主体修改", 
                    width: 450, 
           			height: 390,
                    //allowResize:false,
                    onload: function () {
                        var iframe = this.getIFrameEl();
                        var data = row;
                        iframe.contentWindow.SetData(data,allVcIssueAppraiseCsrc,allVcIndustry);
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
		
		 function addAlias() {
		  //取其列发行主体全称
            var row = grid.getSelected();
            var data = nui.encode(row.vcIssueNameFull);
            if(row.vcIssueNameFull != null){
			   nui.open({  
	                url: "<%=request.getContextPath()%>/fm/baseinfo/issuerInfo/addIssueAliasForm.jsp",
	            title: "新增别名", width: 320, height: 170,
	            onload: function () {//弹出页面加载完成
	            var iframe = this.getIFrameEl();
	            iframe.contentWindow.setFormData(data);
	            },
	            ondestroy: function (action) {//弹出页面关闭前
	            aliasGrid.reload();
	            }
	            });
            }else{
              nui.alert("发行主体为空，不能新增别名！", "系统提示");
            }
		 }
		 
		//当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
            if(rows.length>1){
                nui.get("edit").disable();
            }else{
                nui.get("edit").enable();
            }
            
			if(rows.length == 1){
				var record = grid.getSelected();
				var vcIssueNameFull = record.vcIssueNameFull;
				if(vcIssueNameFull){
				   aliasGrid.load({vcIssueNameFull:record.vcIssueNameFull});
				}else{
				   aliasGrid.clearRows();
				}
			}else{
				aliasGrid.clearRows();
			}
			setAlisa();
        }
        //设置别名按钮是否可用
        function setAlisa(){
         var rows = grid.getSelecteds();
	        if(rows.length == 0){
			  nui.get("addAlisa").disable();
			}else if(rows.length == 1){
	          nui.get("addAlisa").enable();
	        }else{
	          nui.get("addAlisa").disable();
	        }
        }
        
            
        //新增 发行人全称别名
		function gridAddRow(datagrid){
			var grid = nui.get(datagrid);
				grid.addRow({});
		}
		
		//删除
		function gridRemoveRow(datagrid){
			var grid = nui.get(datagrid);
			var rows = grid.getSelecteds();
            if (rows.length > 0) {
                grid.removeRows(rows, true);
            }
		}
		//刷新
		function gridReload(datagrid){
			var grid = nui.get(datagrid);
			grid.reload();
		}
	   //删除
	   function removeAlias(){
			var rows = aliasGrid.getSelecteds();
			if(rows.length > 0){
				nui.confirm("确定删除选中记录？","系统提示",
				function(action){
					if(action=="ok"){
						var json = nui.encode({alias:rows});
						aliasGrid.loading("正在删除中,请稍等...");
						$.ajax({
							url:"com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.deleteIssueAliasInfo.biz.ext",
							type:'POST',
							data:json,
							cache: false,
							contentType:'text/json',
							success:function(text){
								var returnJson = nui.decode(text);
								if(returnJson.exception == null){
									aliasGrid.reload();
									nui.alert("删除成功", "系统提示", function(action){
									});
								}else{
									aliasGrid.unmask();
									nui.alert("删除失败", "系统提示");
								}
							}
						});
					}
				});
			}else{
				nui.alert("请选中一条记录！");
			}
	}
	var allVcIssueAppraiseCsrc;
	var allVcIndustry;
	loadVcIssueAppraiseCsrcAll();
	loadVcIndustryAll();
	function loadVcIssueAppraiseCsrcAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"1"}),
			    contentType:'text/json',
			    success: function (text) {
			    	allVcIssueAppraiseCsrc=text.data;
			    }
			});
	     }
	     function loadVcIndustryAll(){
	     	nui.ajax({//com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc
			    url: "com.cjhxfund.ats.fm.baseinfo.IssueInfoManager.loadVcIssueAppraiseCsrc.biz.ext",
			    type: "post",
			    data:nui.encode({type:"2"}),
			    contentType:'text/json',
			    success: function (text) {
			    	allVcIndustry=text.data;
			    }
			});
	     }
    </script>
</html>