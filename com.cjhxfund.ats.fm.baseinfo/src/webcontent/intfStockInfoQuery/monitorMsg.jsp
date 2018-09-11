<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<!-- 
  - Author(s): 章璐
  - Date: 2016-11-07 15:38:57
  - Description:
-->
<%@include file="/common/js/commscripts.jsp" %>
<head>
<title>监控日志</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    
</head>
 <body style="width:100%;height:100%; overflow: hidden;">
			<div class="search-condition">
			<div class="list">
				<div id="form1" class="nui-form" style="height:5%" align="center" >
					<!-- 数据实体的名称 -->
					<input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.ats.fm.baseinfo.baseInfoDataSet.TAtsMessageLog">
					<!-- 排序字段 -->
					<table id="table1" border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
						<tr>
							<td style="width:65px" align="right" >
			                            	日期:
			                        </td>
							<td colspan="1" width="15%" align="left">
                        			<input class="nui-datepicker" format="yyyy-MM-dd"showClose="true" 
			                             id="date"  width="100%" oncloseclick="onCloseClickValueEmpty"/>
									<input class="nui-hidden" name="criteria/_expr[1]/lDate"  id="lDate" />
							</td>
							
							<td style="width:65px" align="right">
			                            	流程名称:
			                        </td>
							<td colspan="1" width="15%" align="left">
                        			<input  class="nui-textbox"  name="criteria/_expr[2]/vcProcessName"
                             id="vcProcessMsg" width="100%"/>
							</td>
							<td style="width:65px" align="right">日志类型:</td>
						    <td style="width:15%" align="left">
			                            <input class="nui-dictcombobox" 
			                             dictTypeId="ATS_FM_LOG_STATUS" 
					                        name="criteria/_expr[3]/cLogType" textField="dictName" valueField="dictID" showClose="true"
					                         id="cLogType"  width="100%" oncloseclick="onCloseClickValueEmpty"/>
			                </td>
			                <td style="width:65px	" align="right">
			                            	日志信息:
			                        </td>
							<td colspan="1" width="15%" align="left">
                        			<input  class="nui-textbox"  name="criteria/_expr[4]/vcMessage"
                             id="vcProcessMsg" width="100%"/>
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
        			<div class="nui-toolbar" style="border-bottom:0;padding:0px">
			                <table style="width:100%;height:20px;">
			                    <tr>
			                        <td style="width:100%;">
			                             <privilege:operation sourceId="ATS_XZCX_TBO32WINDSJ" sid="synOpen" clazz="nui-button" onClick="synStock_open()" lableName="开启手工新债归集"  iconCls="icon-find" ></privilege:operation>
			                             <privilege:operation sourceId="ATS_XZCX_TBO32WINDSJ" sid="synClose" clazz="nui-button" onClick="synStock_close()" lableName="关闭手工新债归集"  iconCls="icon-find" ></privilege:operation>
			                             <privilege:operation sourceId="ATS_XZCX_TBO32WINDSJ" sid="allsyn" clazz="nui-button" onClick="synStock_all()" lableName="一键归集"  iconCls="icon-find" ></privilege:operation>
			                        </td>
			                    </tr>
			                </table>
			         </div>
                    
            <div class="nui-fit">
                <div 
                        id="datagrid1" 
                        dataField="msgs"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.ats.fm.baseinfo.intfStockInfoQueryManager.queryMonitorMsg.biz.ext"
                        pageSize="20"
                        sortField="lTime"
                        sortOrder="desc"
                        showPageInfo="true"
                        multiSelect="true"
                        onRowdblclick="cellclick">

                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        <div id="lDate" field="lDate" headerAlign="center" width="60px" align="right" allowSort="true" renderer="renderDataTemp">
                            日期
                        </div>
                        <div field="lTime" headerAlign="center" align="right" width="60px" allowSort="true" renderer="renderTimeTemp">
							时间
                        </div>
                         <div field="cLogType" headerAlign="center" width="50" allowSort="true" renderer="vcLogTypeRenderer">
                            	日志类型
                        </div>
                        <div field="lCount" headerAlign="center"  width="60" allowSort="true" >
                            数据量
                        </div>
                        <div field="vcProcessName" headerAlign="center" width="120" allowSort="true" >
                          	流程名称
                        </div>
                        <div field="vcProcessMsg" headerAlign="center" width="200" allowSort="true" >
                            流程信息
                        </div>
                         <div field="vcMessage" headerAlign="center" width="300" allowSort="true" >
                           	日志信息
                        </div>
                    </div>
                </div>
            </div>

        <script type="text/javascript">
            nui.parse();
            var grid = nui.get("datagrid1");
            nui.get("date").setValue((new Date()));
			synControl();
			search();
			
            var formData = new nui.Form("#form1").getData(false,false);
            grid.load(formData);
			
			function synStock_open(){
				var parmKey = "ATS_SYN_STOCK_ISSUE";
				var parmVal = "0";
	        	var json = nui.encode({paramKey:parmKey,paramValue:parmVal});
	        	nui.ajax({
	            url: "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.updateParamValue.biz.ext",
	            type: "post",
	            contentType:'text/json',
	            data: json ,
	            success: function (text) {
	              var returnJson = nui.decode(text);
	              if (returnJson.exception == null) {
	              		nui.alert("手动新债归集开启 : 成功 ！", "提示", function(){});
	              		nui.get("synOpen").disable();
	              		nui.get("synClose").enable();
	              		nui.get("allsyn").enable();
	              }
	            }
	          });
			}
			
			function synStock_close(){
				var parmKey = "ATS_SYN_STOCK_ISSUE";
				var parmVal = "1";
	        	var json = nui.encode({paramKey:parmKey,paramValue:parmVal});
	        	nui.ajax({
	            url: "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.updateParamValue.biz.ext",
	            type: "post",
	            contentType:'text/json',
	            data: json ,
	            success: function (text) {
	              var returnJson = nui.decode(text);
	              if (returnJson.exception == null) {
	              		nui.alert("手动新债归集关闭 : 成功 ！", "提示", function(){});
	              		nui.get("synOpen").enable();
	              		nui.get("synClose").disable();
	              		nui.get("allsyn").disable();
	              }
	            }
	          });
			}
			
			function commonLoading(msg,title){
				return nui.loading(msg,title);
			}
			
			function synStock_all(){
				var msg = commonLoading("正在归集,时间较长请稍后...","系统提示");
				$.ajax({
                    url:"com.cjhxfund.ats.fm.baseinfo.synBondInfoData.synAutomatic.biz.ext",
                    type:'POST',
                    timeout:0,
                    cache:false,
                    contentType:'text/json',
                    success:function(text){
                    	nui.hideMessageBox(msg);
                        var returnJson = nui.decode(text);
                        	if(returnJson.returnValue == true && returnJson.step == "0"){
                            	nui.alert("归集成功！", "系统提示", function(action){
  									window.close();
                                });
                        	}else if(returnJson.returnValue == false && returnJson.step == "1"){
                            	nui.alert("获取O32新债数据失败！ ", "系统提示", function(action){
  									window.close();
                                });
                            }else if(returnJson.returnValue == false && returnJson.step == "2"){
                            	nui.alert("获取O32属性数据失败！", "系统提示", function(action){
  									window.close();
                                });
                            }else if(returnJson.returnValue == false && returnJson.step == "3"){
                            	nui.alert("获取Wind数据失败！", "系统提示", function(action){
  									window.close();
                                });
                            }else if(returnJson.returnValue == false && returnJson.step == "4"){
                            	nui.alert("Wind数据转ATS格式失败！", "系统提示", function(action){
  									window.close();
                                });
                            }else if(returnJson.returnValue == false && returnJson.step == "5"){
                            	nui.alert("O32债券类型转换失败！", "系统提示", function(action){
  									window.close();
                                });
                            }else if(returnJson.returnValue == false && returnJson.step == "6"){
                            	nui.alert("归集O32数据失败！", "系统提示", function(action){
  									window.close();
                                });
                            }else if(returnJson.returnValue == false && returnJson.step == "7"){
                            	nui.alert("归集Wind数据失败！", "系统提示", function(action){
  									window.close();
                                });
                            }else{
                            	nui.alert("归集失败", "系统提示", function(action){
                                	if(action == "ok" || action == "close"){
                                    window.close();
                                	}
                                });
                            }
                        }
                 });
			}
			
			function synControl(){
	        	var parmKey = "ATS_SYN_STOCK_ISSUE";
	        	var json = nui.encode({paramKey:parmKey});
	        	nui.ajax({
	            url: "com.cjhxfund.ats.fm.comm.zhfwptparamconfbiz.getParamValue.biz.ext",
	            type: "post",
	            contentType:'text/json',
	            data: json ,
	            success: function (text) {
	              var returnJson = nui.decode(text);
	              if (returnJson.paramValue != null && returnJson.paramValue !="") {
	              	if(returnJson.paramValue == "0"){
	              		nui.get("synOpen").disable();
	              		nui.get("synClose").show();
	              		nui.get("allsyn").show();
	              	}else{
	              		nui.get("synOpen").show();
	              		nui.get("synClose").disable();
	              		nui.get("allsyn").disable();
	              	}
	              }
	            }
	          });
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
    			var lDate = nui.get("date").getValue();
            	var str = "";
            	if(lDate != ""){
            		var arr = [];
            		arr = lDate.split("-");
            		str = arr.join("");
            		str = str.substr(0,8);
            	} /* else{
            		 var myDate = new Date();    
					 var year = myDate.getFullYear().toString();
					 var month = (myDate.getMonth() + 1).toString();  
					 var day = myDate.getDate().toString();  
					 str = year+month+day;
            	} */
    			nui.get("lDate").setValue(str);
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
			
			//更改时间格式
			function renderTimeTemp(e){
				if(e.value == "0" || e.value == null){
					return "";
				}
				return timeTemp(e.value);
			}
			function timeTemp(oldTime){
				oldTime = oldTime+"";
				if(oldTime=="0" || oldTime=="" || oldTime=="null" || oldTime==null || oldTime=="1"){
					return "";
				}
				if(oldTime.length == 5){
					oldTime = "0"+oldTime;
				}
				var hh = oldTime.substr(0,2);
				var mi = oldTime.substr(2,4);
				var ss = oldTime.substr(4,6);
				return hh+":"+mi.substr(0,2)+":"+ss;
			}
			function cellclick(e){
				if(e.record.vcMessage){
					nui.open({
						  url: "<%=request.getContextPath() %>/fm/baseinfo/intfStockInfoQuery/messageDetail.jsp",
						                title: "详细信息 ", width: 500, height: 360,
						  onload: function () {
						    var  iframe = this.getIFrameEl();
						    iframe.contentWindow.SetData(e.record);
						  },
						  ondestroy: function (action) {
						    grid.reload();
						  }
						});
				}
			}
			
			function vcLogTypeRenderer(e){
        		return nui.getDictText("ATS_FM_LOG_STATUS",e.row.cLogType);
        }
          </script>
        </body>
</html>