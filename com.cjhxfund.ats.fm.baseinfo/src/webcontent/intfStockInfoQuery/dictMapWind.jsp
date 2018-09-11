<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@include file="/common/js/commscripts.jsp" %>

<html>
<!-- 
  - Author(s): 吴念国
  - Date: 2016-11-24 13:26:57
  - Description:用于将windshuj
-->

<head>
<title>新债信息 _Wind数据_转换规则</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
 <body style="width:100%;height:100%; overflow: hidden;">
			<div class="search-condition">
			<div class="list">
				<div id="form1" class="nui-form" style="height:5%" align="center" >
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsDictWindMap">
					<!-- 排序字段 -->
					<table id="table1" border="0" cellpad   ding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
						<tr>
							<td style="width:90px" align="right">
			                            	字典名称:
			                        </td>
							<td colspan="1" width="15%" align="left">
                        			<input  class="nui-textbox"  name="criteria/_expr[1]/vcMapFieldName"
                             id="vcFirstDicName" width="100%"/>
							</td>
							<td style="width:80px" align=right>
			                            	字典值:
			                        </td>
							<td colspan="1" width="15%" align="left">
                        			<input  class="nui-textbox"  name="criteria/_expr[2]/vcMapFieldValue"
                             id="vcDicName" width="100%"/>
							</td>
							<td align="left">
								<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
							    <a id="query" class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">
						                             重置
						        </a>
							</td>
						</tr>
					</table>
							<input class="nui-hidden" type="hidden" name="criteria/_expr[3]/vcMapSource" value="Wind"/>
				</div>
			</div>   
        </div>
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                                增加
                            </a>
                            <span>&nbsp;</span>
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                修改
                            </a>
                           </td>
                    </tr>
                </table>
            </div>
            
            <div class="nui-fit">
                <div 
                        id="datagrid1" 
                        dataField="dictWindMap"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.queryDictWindMap.biz.ext"
                        pageSize="20"
                        sortField="lMapId"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged">

                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        <div field="lMapId" headerAlign="center" allowSort="true" visible="false">
                                                                                          序号
                        </div>
                
                        <div field="vcMapSource" headerAlign="center" allowSort="false" visible="false">
							数据来源
                        </div>
                        <div field="vcMapFieldName" headerAlign="center" width="80" allowSort="true" >
                           	字典名称
                        </div>
                        <div field="vcMapFieldId" headerAlign="center" width="60" allowSort="true" visible="false">
                          	字典键
                        </div>
                        <div field="vcMapFieldValue" headerAlign="center" width="80" allowSort="true" >
                                                                                             字典值
                        </div>
                        
                          
                        
                <div header="ATS" headerAlign="center">
                 <div property="columns">
                        <div field="vcDicId" headerAlign="center"  width="80" allowSort="true"  visible="false">
                            字典英文名称
                        </div>
                        <div field="vcDicName" headerAlign="center" width="80" allowSort="true" >
                            	字典名称
                        </div>
                        <div field="vcDicKey" headerAlign="center" width="60" allowSort="true" >
                            	字典键
                        </div>
                        <div field="vcDicKeyValue" headerAlign="center" width="80" allowSort="true" >
                            	字典值
                        </div>                        
                        
                       </div>
                        </div>   
                                  <div header="ATS辅助" headerAlign="center">
                 <div property="columns">
                 
                        <div field="vcFirstDicId" headerAlign="center"  width="80" allowSort="true" visible="false">
                            字典英文名称
                        </div>
                        <div field="vcFirstDicName" headerAlign="center" width="80" allowSort="true" >
                            	字典名称
                        </div>
                        <div field="vcFirstDicKey" headerAlign="center" width="60" allowSort="true" >
                            	字典键
                        </div>
                        <div field="vcFirstDicKeyValue" headerAlign="center" width="80" allowSort="true" >
                            	字典值
                        </div>                        
                        
                       </div>
                        </div>      
                        
                        
                        <div field="vcRemark" headerAlign="center" width="150"  allowSort="true" >
                            说明
                        </div>
                        <div field="cStatus" headerAlign="center" width="50" allowSort="true" renderer="cstatusname">
                            状态
                        </div>
                    </div>
                </div>
            </div>
        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");

            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);

            //新增
            function add() {
                nui.open({
                    url: "<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/addDictMapWind.jsp",
                    title: "新增_Wind转换规则", width: 647, height: 376,
                    onload: function () {//弹出页面加载完成
                    var iframe = this.getIFrameEl();
                    var data = {pageType:"add"};//传入页面的json数据
                    iframe.contentWindow.setFormData(data);
                    },
                    ondestroy: function (action) {//弹出页面关闭前
                    grid.reload();
                }
                });
            }

            //修改
            function edit() {
                var row = grid.getSelected();
                if (row) {
                    nui.open({
                        url: "<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/addDictMapWind.jsp",
                        title: "修改_Wind转换规则",
                        width: 647,
                        height: 376,
                        onload: function () {
                            var iframe = this.getIFrameEl();
                            var data = {pageType:"edit",record:{dictWindMap:row}};
                            //console.log(data);
                            //直接从页面获取，不用去后台获取
                            iframe.contentWindow.setFormData(data);
                            },
                            ondestroy: function (action) {
                                grid.reload();
                            }
                            });
                        } else {
                            nui.alert("请选中一条记录","提示");
                        }
                    }
                   
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

                                //当选择列时
                                function selectionChanged(){
                                    var rows = grid.getSelecteds();
                                    if(rows.length>1){
                                        nui.get("update").disable();
                                    }else{
                                        nui.get("update").enable();
                                    }
                                }
                            </script>
                        </body>
</html>