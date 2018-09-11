<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"
session="false" %>
    <!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
    <%@include file="/common/js/commscripts.jsp" %>
        <html>
         <head>
                <title>
                    mom附件信息
                </title>
                <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
            </head>
            
            <body style="width:100%;height:100%;overflow: hidden; margin: 0px;">
                <div class="search-condition">
                    <div class="list">
                        <div id="form1" class="nui-form" align="center" style="height: 10%">
                            <!-- 排序字段 -->
                            <form id="queryForm">
                                <!-- 数据实体的名称 -->
				                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.ProductProcess.singleDataset.TAtsMomAttach">
				                <!-- 排序字段 -->
				                <input class="nui-hidden" name="criteria/_orderby[1]/_property" value="lAttachId">
				                <input class="nui-hidden" name="criteria/_orderby[1]/_sort" value="desc">
                                <table id="table1" class="table" style="width:100%;table-layout:fixed;">
                                    <tr>
			                        	<td style="width: 60px" align="right">
				                            日期:
				                        </td>
				                        <td style="width:20%" align="left">
				                            <input class="nui-datepicker" id="busdate" width="100%" name="criteria/_expr[1]/dBusidateend"/>
				                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
				                        </td>
                                        <td style="width: 60px" align="right">
				                            产品代码:
				                        </td>
				                        <td style="width:20%" align="left">
				                            <input class="nui-textbox" width="100%" name="criteria/_expr[2]/vcProductCode"/>
				                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
				                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
				                        </td>
				                        <td style="width: 70px" align="right">
				                            产品名称:
				                        </td>
				                        <td style="width:20%" align="left">
				                            <input class="nui-textbox" width="100%" name="criteria/_expr[3]/vcProductName"/>
				                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="like">
				                            <input class="nui-hidden" name="criteria/_expr[3]/_likeRule" value="all">
				                        </td>                                        
                                    <td align="left">
			                        <a class='nui-button' plain='false' iconCls="icon-search"  onclick="search()">
								                	查询
								            </a>

								            <a class='nui-button' plain='false' iconCls="icon-reload"  onclick="reset()">
								                	重置
								            </a>
								     </td> 
								    <!-- <td align="left">
								            <a class='nui-button' plain='false' iconCls="icon-download" onclick="fileDownload()">
								                下载
								            </a>
								    </td>
								    <td align="left">
								            <a class='nui-button' plain='false' iconCls="icon-upload" onclick="fileupload()">
								               上传
								            </a>
								    </td> -->
                                    </tr>                                    
                                </table>
                            </form>
                        </div>
                    </div>
                </div>
					<div class="nui-toolbar" style="border-bottom:0;padding:0px">
			                <table style="width:100%;height:20px;">
			                    <tr>
			                        <td style="width:100%;">
			                            <a class='nui-button' plain='false' iconCls="icon-upload" onclick="fileupload()">
								               上传
								            </a> 
								         <a class='nui-button' plain='false' iconCls="icon-download" onclick="fileDownload()">
								                下载
								            </a>     
			                        </td>
			                    </tr>
			                </table>
			         </div> 
                <div class="nui-fit">
                <div 
                        id="datagrid1"
                        dataField="tatsmomattachs"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.FileUploadUtil.queryMomAttachs.biz.ext"
                        pageSize="10"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged"
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        <div field="lAttachId" headerAlign="center" allowSort="true" visible="false">
                            附件id
                        </div>
                        <div field="dBusidateend" headerAlign="center" allowSort="true">
                            业务日期
                        </div>
                        <div field="vcProductCode" headerAlign="center" allowSort="true" >
                            产品代码
                        </div>
                        <div field="vcProductName" headerAlign="center" allowSort="true" >
                            产品名称
                        </div>
                        <div field="vcAttachName" headerAlign="center" allowSort="true" >
                            附件名称
                        </div>
                        <div field="vcAttachAdd" headerAlign="center" allowSort="true" >
                            附件地址
                        </div>
                        <div field="vcAttachState" headerAlign="center" allowSort="true" visible="false">
                            附件状态
                        </div>
                        <div field="dCreateTime" headerAlign="center" allowSort="true" dateFormat="yyyy-MM-dd HH:mm:ss">
                            创建时间
                        </div>
                        <div field="vcUserId" headerAlign="center" allowSort="true" visible="false">
                            用户id
                        </div>
                        <div field="vcFileId" headerAlign="center" allowSort="true" visible="false">
                            上传附件id
                        </div>
                        <div field="vcAttachSize" headerAlign="center" allowSort="true" >
                            附件大小
                        </div>
                        <div field="vcAttachType" headerAlign="center" allowSort="true" >
                            附件类型
                        </div>
                        <div field="lProductId" headerAlign="center" allowSort="true" visible="false">
                            产品id
                        </div>
                        
                        
                    </div>
                </div>
            </div>
			<form id="file_download" method="post">
                    <!-- 数据实体的名称 -->
                    <input class="nui-hidden" name="sysid" id="sysid" />
            </form>
<script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
			//默认查询当天
			//nui.get("busdate").setValue(new Date());
			
            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);
            
            //重新刷新页面
            function refresh(){
                var form = new  nui.Form("#form1");
                var json = form.getData(false,false);
                grid.load(json);//grid查询
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

            //当选择列时
            function selectionChanged(){
                var rows = grid.getSelecteds();
            }
            
            //附件下载
            function fileDownload() {
                var datas = nui.get("datagrid1").getSelecteds();
                var sysId = "";
                for (var i = 0; i < datas.length; i++) {
                    if (sysId == "") {
                        sysId = datas[i].lAttachId;
                    } else {
                        sysId = sysId + "," + datas[i].lAttachId;
                    }
                }
                nui.get("sysid").setValue(sysId);
                if (datas != null && datas != "") {
                    //给出提示并调用下载逻辑
                    nui.confirm("确认要下载吗？", "系统提示",
                    function(action) {
                        if (action == "ok") {
                         var json = nui.encode({attachs:datas});
                           	nui.ajax({
								url:"com.cjhxfund.jy.excelUploadAdd.excelUpload.attachManage.biz.ext",
								type:'POST',
								data:json,
								cache:false,
    							contentType:'text/json',		
								success:function(text){
				                    if(text.flag==false){
				                       nui.alert("下载失败，文件不存在！", "系统提示");
				                    }else{
				                         var form = document.getElementById("file_download");
	                                     form.action = "com.cjhxfund.jy.excelUploadAdd.FileDownLoad.flow";
	                                     form.submit();
                            		}
								}
						});	
                        }
                    });
                } else {
                    nui.alert("请先选要下载的附件.", "系统提示");
                }
                
            }
            
            //附件上传
             function fileupload() {
				mini.open({
				    url:"<%=request.getContextPath() %>/ProductProcess/fileupload/importMOMFile.jsp",
				    title: "用印文件导入", width: 500, height: 200,
				    overflow:"hidden",
				    onload: function () {
				        
				    },
				    ondestroy: function (action) {
				        grid.reload();
				    }
				});
             }
</script>
</body>
        
</html>