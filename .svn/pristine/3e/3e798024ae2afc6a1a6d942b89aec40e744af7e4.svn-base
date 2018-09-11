<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%--
- Author(s): CJ-WB-DT13
- Date: 2016-03-09 11:38:26
- Description:
    --%>
    <head>
        <title>
            产品投资范围查询
        </title>
        <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    </head>
    <body style="width:99.6%;height:99.6%;overflow: hidden;">
        <div class="search-condition" style="margin-left: 5px;">
		  <div class="list">
            <div id="form1" class="nui-form" align="center" >
                <!-- 数据实体的名称 -->
                <input class="nui-hidden" name="criteria/_entity" value="com.cjhxfund.jy.process.FirstGradeBond.CfJyProductInvestmentRange">
                <!-- 排序字段 -->
                <table id="table1" class="table" style="width: 100%">
                    <tr>
                        <td class="form_label" align="right">
                            产品代码:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" name="criteria/_expr[1]/combProductCode"/>
                            <input class="nui-hidden" name="criteria/_expr[1]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[1]/_likeRule" value="all">
                        </td>
                        <td class="form_label" align="right">
                            产品名称:
                        </td>
                        <td colspan="1" align="left">
                            <input class="nui-textbox" name="criteria/_expr[2]/combProductName"/>
                            <input class="nui-hidden" name="criteria/_expr[2]/_op" value="like">
                            <input class="nui-hidden" name="criteria/_expr[2]/_likeRule" value="all">
                        </td>
                        <td>
                         <!--footer-->
				        <div property="footer" align="left">
				            <a class='nui-button' plain='false' onclick="search()">
				            	查询
				            </a>
				            &nbsp;
				            <a class='nui-button' plain='false' onclick="reset()">
				           	             重置
				            </a>
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
                                增加
                            </a>
                            &nbsp;
                            <a id="update" class='nui-button' plain='false' iconCls="icon-edit" onclick="edit()">
                                编辑
                            </a>
                            &nbsp;
                            <a class='nui-button' plain='false' iconCls="icon-remove" onclick="remove()">
                                删除
                            </a>
                        </td>
                    </tr>
                </table>
            </div>
            <div class="nui-fit" style="margin-left: 5px;">
                <div 
                        id="datagrid1"
                        dataField="cfjyproductinvestmentranges"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.process.cfjyproductinvestmentrangebiz.queryCfJyProductInvestmentRanges.biz.ext"
                        pageSize="20"
                        showPageInfo="true"
                        multiSelect="true"
                        onselectionchanged="selectionChanged"
                        allowSortColumn="false">

                    <div property="columns">
                        <div type="indexcolumn">
                        </div>
                        <div type="checkcolumn">
                        </div>
                        
                        <div field="productid" headerAlign="center" allowSort="true" visible="false">
                            产品编号
                        </div>
                        <div field="combProductCode" headerAlign="center" allowSort="true" visible="false">
                            产品代码
                        </div>
                        <div field="combProductName" headerAlign="center" allowSort="true" >
                            产品名称
                        </div>
                        <div field="voteRange" headerAlign="center" allowSort="true" >
                            可投范围
                        </div>
                        <div field="noCastRange" headerAlign="center" allowSort="true" >
                            禁投范围
                        </div>
                        <div field="investmentLimit" headerAlign="center" allowSort="true" >
                            投资限制
                        </div>
                        <div field="remarks" headerAlign="center" allowSort="true" >
                            备注
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
         url: "<%=request.getContextPath() %>/process/CfJyProductInvestmentRangeForm.jsp",
         title: "投资范围录入", width: 1000, height: 650,
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

    //编辑
    function edit() {
      var row = grid.getSelected();
      if (row) {
        nui.open({
           url: "<%=request.getContextPath() %>/process/CfJyProductInvestmentRangeForm.jsp",
           title: "投资范围修改",
           width: 1000,
           height: 670,
           onload: function () {
              var iframe = this.getIFrameEl();
              var data = {pageType:"edit",record:{cfjyproductinvestmentrange:row}};
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

     //删除
    function remove(){
        var rows = grid.getSelecteds();
        if(rows.length > 0){
           nui.confirm("确定删除选中记录？","系统提示",function(action){
               if(action=="ok"){
                  var json = nui.encode({cfjyproductinvestmentranges:rows});
                  grid.loading("正在删除中,请稍等...");
                  $.ajax({
                     url:"com.cjhxfund.jy.process.cfjyproductinvestmentrangebiz.deleteCfJyProductInvestmentRanges.biz.ext",
                     type:'POST',
                     data:json,
                     cache: false,
                     contentType:'text/json',
                     success:function(text){
                        var returnJson = nui.decode(text);
                        if(returnJson.exception == null){
                            grid.reload();
                            nui.alert("删除成功", "系统提示", function(action){});
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
          nui.get("update").disable();
       }else{
          nui.get("update").enable();
       }
    }
                                
    //行双击时弹出页面展示该指令/建议详细信息
	grid.on("rowdblclick", function (e) {
		edit();
	});
   </script>
  </body>
</html>
