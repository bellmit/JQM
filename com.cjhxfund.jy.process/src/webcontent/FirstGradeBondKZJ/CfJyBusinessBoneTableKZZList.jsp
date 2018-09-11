<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): chenpeng
- Date: 2016-03-30 10:19:16
- Description:
    --%>
    <head>
        <title>
            CfJyBusinessBoneTable查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body style="width:99.6%;height:99.6%;overflow: hidden;">
        <div class="search-condition" style="margin-left: 5px;">
		  <div class="list">
            <div id="form1" class="nui-form" align="center" style="height:100%">
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.process.FirstGradeBond.queryWorkItemList">
                <!-- 排序字段 -->
                <table id="table1" class="table" style="width: 100%;" border="0">
                    <tr>
                        <td class="form_label" align="right">
                            业务日期:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-datepicker" format="yyyy-MM-dd" name="criteria/_expr[1]/processDate" id="processDate" style="margin-left: 10px;"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="=">
                        </td>
                        <td class="form_label" align="right">
                            债券名称:
                        </td>
                        <td colspan="1" align="left">
                    
                            <input id="vCFundCode_ZJTC" class="nui-buttonedit" name="criteria/_expr[2]/combProductCode" id="combProductCode" onbuttonclick="ButtonClickGetFundName_ZJTC"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                            
                            <input class="nui-hidden" name="criteria/_expr[3]/businesstype" value="2"/>
                            <input class="nui-hidden" name="criteria/_expr[3]/_op" value="=">
                        </td>
                        <td class="form_label" width="7%">
						交易状态:
		                </td>
		                <td colspan="1" width="18%">
							<input class="nui-dictcombobox" name="criteria/_expr[4]/validStatus" data="data" valueField="dictID" textField="dictName" dictTypeId="CF_JY_PRODUCT_PROCESS_VALID_STATUS"  
									emptyText="全部" nullItemText="全部" showNullItem="true" style="width:95%" value="0"  multiSelect="true" showClose="true" valueFromSelect="true" oncloseclick="onCloseClickValueEmpty" />
							<input class="nui-hidden" name="criteria/_expr[4]/_op" value="in"/>
							
							<!-- <input class="nui-hidden" name="criteria/_expr[5]/currentstate" value="4,10"/>
                            <input class="nui-hidden" name="criteria/_expr[5]/_op" value="in"> -->
						</td>
                        <%--<td class="form_label" align="right">
                            业务类别:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-combobox" data="[{id: 1, text: '一级债券(非可转债)'}, {id: 2, text: '一级债券(可转债)'}]"
                             name="criteria/_expr[2]/businessType" style="margin-left: 10px;"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="=">
                            
                            
                        </td>--%>
                        <td>
	                       <!--footer-->
					        <div property="footer" align="center">
					            <a class='nui-button' plain='false' iconCls="icon-search" onclick="search()">
					                查询
					            </a>
					           <%-- &nbsp;
					            <a class='nui-button' plain='false' onclick="reset()">
					                重置
					            </a>--%>
					        </div>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
	  </div>
            <div class="nui-toolbar" style="border-bottom:0;padding:0px;margin-left: 5px;">
                <table style="width:100%;">
                    <tr>
                        <td style="width:100%;">
                            <a class='nui-button' plain='false' iconCls="icon-add" onclick="add()">
                                申请
                            </a>
                            &nbsp;
                            <a class='nui-button' plain='false' id="Abandoned" iconCls="icon-remove" onclick="Abandoned()">
                                废弃
                            </a>
                            <%--<a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                编辑
                            </a>
                            <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>--%>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit" style="margin-left: 5px;">
                <div 
                        id="datagrid1"
                        dataField="cfjybusinessbonetables"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.process.cfjybusinessbonetablebiz.queryCfJyBusinessBoneTables.biz.ext"
                        pageSize="20"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged"
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="checkcolumn">
                        </div>
                        <div type="indexcolumn">
                        </div>
                        <div field="btId" headerAlign="center" allowSort="true" visible="false">
                            编号
                        </div>
                        <div field="processinstid" headerAlign="center" allowSort="true" visible="false">
                            流程编号
                        </div>
                        <div field="workitemNames" headerAlign="center" allowSort="true" width="150px" renderer="rendererWorkitemName">
                            当前节点
                        </div>
                        <div field="processDate" headerAlign="center" align="center" allowSort="true" dateFormat="yyyy-MM-dd">
                            申购日期
                        </div>
                        <div field="combProductName" width="150px" headerAlign="center" allowSort="true" >
                            产品名称
                        </div>
                        <div field="investproductnum" headerAlign="center" align="center" allowSort="true" width="50">
                            编号
                        </div>
                        <div field="combProductCode" headerAlign="center" allowSort="true" visible="false">
                            产品代码
                        </div>
                        <div field="investProductCode" headerAlign="center" allowSort="true" >
                            债券代码
                        </div>
                        <div field="investProductName" headerAlign="center" allowSort="true" >
                            债券名称
                        </div>
                        <div field="purchaseAmount" headerAlign="center" align="right" allowSort="true" >
                            申购金额(万元)
                        </div>
                        <div field="depositRatio" headerAlign="center" align="right" allowSort="true" >
                            定金比例(%)
                        </div>
                        <div field="depositAmount" headerAlign="center" align="right" allowSort="true" >
                            定金金额(万元)
                        </div>
                        
                        <div field="ratingname" headerAlign="center" align="center" allowSort="true" >
                            发行主体
                        </div>
                        <div field="ratingType" headerAlign="center" align="center" allowSort="true" renderer="renderRatingType">
                            发行主体类型
                        </div>
                        <div field="subjectrating" headerAlign="center" align="center" allowSort="true" renderer="renderSubjectrating">
                            主体评级
                        </div>
                        <div field="bondrating" headerAlign="center" align="center" allowSort="true" renderer="renderBondrating">
                            债项评级
                        </div>
                        <div field="ratingagencies" headerAlign="center" align="center" allowSort="true" renderer="renderRatingagencies">
                            评级机构
                        </div>
                        <div field="issueSize" headerAlign="center" align="right" allowSort="true" >
                            发行规模(万元)
                        </div>
                        <div field="categorydate" headerAlign="center" align="right" allowSort="true" >
                            债券期限(年)
                        </div>
                        <div field="categorymoney" headerAlign="center" align="right" width="150px" allowSort="true" >
                          主体发行证券存量(万元)
                        </div>
                        <div field="mainBearingMechanism" headerAlign="center" align="center" allowSort="true" >
                            主承机构
                        </div>
                        <div field="validStatus" headerAlign="center" allowSort="true" renderer="renderValidStatus">
                            交易状态
                        </div>
						<div field="currentstate" headerAlign="center" allowSort="true" visible="false">
						                            流程状态
                        </div>
                    </div>
                </div>
            </div>
<script type="text/javascript">
    nui.parse();
    var grid = nui.get("datagrid1");
    //给业务日期查询条件赋值
	nui.get("processDate").setValue(new Date());
	
    var formData = new nui.Form("#form1").getData(false,false);
    grid.load(formData);

    //新增
    function add() {
        nui.open({
           url: "<%=request.getContextPath() %>/process/FirstGradeBondKZJ/CfJyBusinessBoneTableKZZForm.jsp",
           title: "申购缴款(可转债)录入", width: 750, height: 631,
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

    

    //删除
    function remove(){
       var rows = grid.getSelecteds();
       if(rows.length > 0){
          nui.confirm("确定删除选中记录？","系统提示",
          function(action){
             if(action=="ok"){
                var json = nui.encode({cfjybusinessbonetables:rows});
                grid.loading("正在删除中,请稍等...");
                $.ajax({
                    url:"com.cjhxfund.jy.process.cfjybusinessbonetableKZZ.deleteCfJyBusinessBoneTables.biz.ext",
                    type:'POST',
                    data:json,
                    cache: false,
                    contentType:'text/json',
                    success:function(text){
                    var returnJson = nui.decode(text);
                    if(returnJson.exception == null){
                       grid.reload();
                       nui.alert("删除成功", "系统提示", function(action){
                    });
                 }else{
                     grid.unmask();
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

    //当选择列时
     function selectionChanged(){
        var rows = grid.getSelecteds();
        if(rows.length>1){
               nui.get("Abandoned").disable();
        }else{
               nui.get("Abandoned").enable();
        }
    } 
             
    //主体评级
    function renderSubjectrating(e){
        return nui.getDictText("CF_JY_PRODUCT_PROCESS_SUBJECT_RATING",e.row.subjectrating);
    }   
             
    //主体类型
    function renderRatingType(e){
       return nui.getDictText("CF_JY_ZTLX",e.row.ratingType);
    }
             
    //债项评级
    function renderBondrating(e){
       return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_RATING",e.row.bondrating);
    }
             
    //债券种类
    function renderInvestcategory(e){
       return nui.getDictText("CF_JY_PRODUCT_PROCESS_BOND_CATEGORY",e.row.investcategory);
    }
             
    //评级机构
    function renderRatingagencies(e){
       return nui.getDictText("CF_JY_PRODUCT_PROCESS_RATING_AGENCIES",e.row.ratingagencies);
    }  
    
    //交易状态处理--所有业务通用
	function renderValidStatus(e) {
		return nui.getDictText("CF_JY_PRODUCT_PROCESS_VALID_STATUS",e.row.validStatus);
	}   
    
    function ButtonClickGetFundName_ZJTC(e){
	   	ButtonClickGetFundName(this,'<%=request.getParameter("jurisdiction")%>');
	} 
	
	//指令/建议废弃
	function Abandoned(){
	  var rows = grid.getSelected();
	  if(rows){
	    if(rows.currentstate == 7 || rows.currentstate == 8){
	       nui.alert("该指令/建议已经结束,不能再做任何操作!","系统提示");
	       return;
	    }
	    nui.confirm("确定要废弃选中的指令/建议吗？","系统提示",
          function(action){
             if(action=="ok"){
                var json = nui.encode({processinstid:rows.processinstid,btId:rows.btId});
                grid.loading("正在废弃中,请稍等...");
                $.ajax({
                    url:"com.cjhxfund.jy.process.cfjybusinessbonetablebiz.firstGradeBondeAbandoned.biz.ext",
                    type:'POST',
                    data:json,
                    cache: false,
                    contentType:'text/json',
                    success:function(text){
                    var returnJson = nui.decode(text);
                    if(returnJson.returnValue == "yes"){
                       grid.reload();
                       nui.alert("废弃成功", "系统提示", function(action){
                    	});
	                 }else if(returnJson.returnValue == "12"){
	                    grid.unmask();
	                    nui.alert("流程已结束，不能废弃", "系统提示");
	                 }else{
	                     grid.unmask();
	                     nui.alert("废弃失败", "系统提示");
	                 }
               }
             });
           }
        });
	  }else{
	    nui.alert("请选择一条指令/建议。","提示");
	  }
	}       

	function rendererWorkitemName(e){
		if(e.row.workitemNames == null){
		    return "流程已结束";
		}else{
		    return e.row.workitemNames;
		}
	}                  
   </script>
  </body>
</html>
