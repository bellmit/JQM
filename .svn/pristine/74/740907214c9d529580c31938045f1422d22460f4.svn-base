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
<title>交易对手查询</title>
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
							交易对手简称:
			                </td>
			                <td align="left">
								<input id="vcName" class="nui-textbox"  name="criteria/_or[1]/_expr[3]/vcName"
	                              width="100%"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[3]/_op" value="like">
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[3]/_likeRule" value="all">
	                            
	                           
	                            <input id="vcPinyin" class="nui-hidden"  name="criteria/_or[1]/_expr[4]/vcPinyin"
	                              width="100%"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[4]/_op" value="like">
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[4]/_likeRule" value="all">
	                        </td>
	                        
	                    	<td align="right">
							交易对手全称:
			                </td>
			                <td align="left">
								 <input id="vcAllName" class="nui-textbox"  name="criteria/_or[1]/_expr[2]/vcAllName"
	                              width="100%"/>
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[2]/_op" value="like">
	                            <input class="nui-hidden" type="hidden" name="criteria/_or[1]/_expr[2]/_likeRule" value="all">
	                            
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
                            <!-- <a class='nui-button' plain='false' id="edit" iconCls='icon-edit' onclick='edit()'>修改</a>
                            <a class='nui-button' plain='false' id="addAlisa" iconCls='icon-add' onclick='addAlias()'>增加别名</a> -->
                        </td>
                    </tr>
                </table>
            </div>
	         <div class="nui-fit" >  
	         	<div  id="datagrid1"
	                        class="nui-datagrid"
	                        style="width:100%;height:100%;"
	                        url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.LoadCounterpartyInfo.biz.ext?type=1"
	                        pageSize="20"
	                        onselectionchanged="selectionChanged"
	                        showPageInfo="true"
	                        multiSelect="true"
	                        sortField="lRivalId" sortOrder="desc">
	                        
	                    <div property="columns">
	                        <div type="indexcolumn"></div>
	                        <div type="checkcolumn"></div>
	                        <div field="lRivalId" headerAlign="center" allowSort="true" visible=false>交易对手ID</div>
	                        
	                        <div field="vcName" headerAlign="center" allowSort="true" >交易对手简称</div>
	                        
	                        <div field="vcAllName" headerAlign="center" allowSort="true" >交易对手全称</div>
	                        
	                        <div field="vcIssuerName" headerAlign="center" allowSort="true" >发行主体简称</div>
	                        
	                        <div field="vcIssuerFullname" headerAlign="center" allowSort="true" >发行主体全称</div>
	                        
	                        <div field="vcPinyin" headerAlign="center" allowSort="true" >交易对手缩写</div>
	                        
	                    </div>
	                 </div>
	               </div>
	               
	                <div id="tabs" class="nui-tabs" activeIndex="0" height="30%"> 
	               	<div title="银行账户信息">
	               	  <div class="nui-toolbar" style="border-bottom:0;padding:0px;">
            		  </div>
              			<div id="aliasGrid" class="nui-datagrid" style="width:100%;height:98%;"
							url="com.cjhxfund.ats.fm.instr.StockIssueInfoBiz.LoadCounterpartyAccount.biz.ext" 
							dataField="data"  multiSelect="true" pageSize="20"
	                        showPageInfo="true"  sortField="vcId" sortOrder="desc">
							
							<div property="columns">
							    <div type="checkcolumn"  ></div>
							    <div field="vcId" width="50" headerAlign="center" align="right"  allowSort="true"  >
							                    序号
							    </div>
						        <div field="vcAccountName"  headerAlign="center"  width="200" allowSort="true">
									 账户名称
						        </div>
								<div field="vcBankName"  headerAlign="center" width="200"  align="right"  allowSort="true">
									 开户行名称
						        </div>
						        <div field="cStatus"  headerAlign="center" width="160" allowSort="true" >
									 银行账户
						        </div>
						        <div field="vcPayNo"  headerAlign="center"  width="120" allowSort="true">
									 大额支付号
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
    	var form = new nui.Form("#form1");
    	var formData = form.getData(false,false);
		grid.load(formData);
		
		function reset(){
			form.reset();
		}
        //查询
        function search(){
        	var vcIssueName = nui.get("vcName").value;
             nui.get("vcPinyin").setValue(vcIssueName.toLowerCase());
        	var data = form.getData(false,false);      //获取表单多个控件的数据
            grid.load(data);
        }
        
		 
		//当选择列时
        function selectionChanged(){
            var rows = grid.getSelecteds();
			if(rows.length == 1){
				var record = grid.getSelected();
				var hlrivalid = record.lRivalId;
				if(hlrivalid){
				   aliasGrid.load({hlrivalid:hlrivalid});
				}else{
				   aliasGrid.clearRows();
				}
			}else{
				aliasGrid.clearRows();
			}
        }
        function add() {
			var url = "<%= request.getContextPath() %>/fm/baseinfo/issuerInfo/addTraderivalInfo.jsp";
			var title = "新增交易对手";
			var width = "450";
			var height = "330";
			nui.open({
				url: url,
				title: title, width: width, height: height,
				onload: function () {//弹出页面加载完成
					
				},
				ondestroy: function (action) {//弹出页面关闭前
					nui.get("vcName").setValue(action);
					search();
				}
			});
		}
    </script>
</html>