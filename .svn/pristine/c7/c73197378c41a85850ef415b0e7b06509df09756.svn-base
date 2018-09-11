<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" session="false" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/common.jsp" %>
<!-- 
  - Author(s): luojuehuai
  - Date: 2016-09-07 14:51:04
  - Description:
-->

<head>
    <title>询价录入</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    
    <style type="text/css">
        .flag{
            width:120px;
            float:left;
            margin-right: 10px;
        }
        .flag > div{
            border:2px solid #E4E5E9;
            border-radius: 5px;
        }
        .red{
            width:25px;
            height:15px;
            background:red;
            float:left;
            margin-top: 5px;
        }
        .black{
            width:25px;
            height:15px;
            background:black;
            float:left;
            margin-top: 5px;
        }
        .yellow{
            width:25px;
            height:15px;
            background:yellow;
            float:left;
            margin-top: 5px;
        }
        .blue{
            width:25px;
            height:15px;
            background:blue;
            float:left;
            margin-top: 5px;
        }
        .green{
            width:25px;
            height:15px;
            background:green;
            float:left;
            margin-top: 5px;
        }
        .infoLabel{
            width:250px;
            float:left;
            height:26px;

        }
        .infoLabel > label:first-of-type{
            float:left;
            text-align: right;
            width:112px;
            display:block;
        }
        .infoLabel2{
            width:300px;
            float:left;
            height:26px;

        }
        .infoLabel2 >label:first-of-type{
            float:left;
            text-align: right;
            width:150px;
            display:block;
        }
        .arrow{
            background: url("image/arrow_gray.png");
            background-color:white;
            width:64px;
            height:64px;
            margin:0 auto;
            display:block;
        }
        .arrow:hover{
            background: url("image/arrow_blue.png");
            width:64px;
            height:64px;
            margin:0 auto;
            display:block;
        }
        body{
           height:97%;
        }
    </style>
</head>
<body>
<!-- 查询表单 start -->
	<div class="search-condition">
   		<div class="list">
   			<div id="" class="nui-form" align="center">
   				<table border="0" cellpadding="1" cellspacing="1" style="width:100%;table-layout:fixed;">
                	<tr>
                		<td style="width:60px">产品代码:</td>
                        <td style="width:20%" align="left" colspan="1">
                        	<input name="" class="nui-combobox" style="width:95%;"/>
						</td>
						<td width="60px" align="right"></td>
						<td colspan="1" width="18%" align="left">
						</td>
						<td width="60px" align="right"></td>
						<td colspan="1" width="18%" align="left">
						</td>
						<td width="60px" align="right"></td>
						<td colspan="1" width="18%" align="left">
						</td>
                        <td width="60px" align="right"></td>
						<td colspan="1" width="18%" align="left">
						</td>
                    </tr>
                    <tr>
                    	<td align="right" colspan="1">
					       <a class='nui-button' plain='false' iconCls="icon-reset" onclick="reset()">重置</a>   
					   	</td>
                    	<td colspan="1">
                            <input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search()"/>
                        </td>
                    </tr>
				</table>
   			</div>
   		</div>
   	</div>
   	
	<div class="nui-toolbar" style="border-bottom:0;padding:0px;">
        <table style="width:100%;">
            <tr>
                <td style="width:100%;">
                	<a class='nui-button' plain='false' iconCls="icon-collapse" onclick="">录入询价结果</a>
                	<a class='nui-button' plain='false' iconCls="icon-collapse" onclick="">录入线下指令/建议询价</a>
                	<a class='nui-button' plain='false' iconCls="icon-download" onclick="">导出</a>
                </td>
            </tr>
        </table>
    </div>
<!-- 查询表单 end -->

<!-- 第一个table start -->
<div id="datagrid1" class="nui-datagrid" 
    	url="" 
    	dataField="" style="width:100%;height:250px;" idField="id"
    	pageSize="10"
        onselectionchanged="selectionChanged"
        allowResize="true"
        sizeList="[10,20,50,100]"
        pagerButtons="#prompt_todays">
    <div property="columns">
        <div type="indexcolumn" ></div>
        <div field="loginname" width="120" headerAlign="center" allowSort="true">日期</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">询价指令/建议序号</div>
        <div field="gender" width="100" renderer="onGenderRenderer" align="center" headerAlign="center">指令/建议状态</div>
        <div field="salary" numberFormat="¥#,0.00" align="right" width="100" allowSort="true">询价状态</div>
        <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">确认状态</div>
        <div field="createtime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">产品代码</div>
        <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">产品名称</div>
        <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">组合名称</div>
        <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">业务类别</div>
        <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">委托方向</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">回购天数</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">指令/建议下达日期</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">交易日</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">首次结算日</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">到期结算日</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">回购金额</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">指令/建议修改人</div>
        <div field="name" width="120" headerAlign="center" allowSort="true">指令/建议修改时间</div>
    </div>
</div>
<!-- 第一个table end -->

<div id="prompt_todays">	
    <div class="flag">
        <div class="black"></div>
        <label>后台已成交</label>
    </div>
    <div class="flag">
        <div class="green"></div>
        <label>后台已成交</label>
    </div>
    <div class="flag" style="width:60px;">
        <div class="red"></div>
        <label>无效</label>
    </div>
    <div class="flag"  style="width:90px;">
        <div class="blue"></div>
        <label>前台已成交</label>
    </div>
</div>
<div  class="nui-tabs" style="width:100%;height:auto;" activeIndex="0">
    <div title="询价指令/建议详情">
        <div style="clear:left;padding-top:5px;height:auto;width:100%;">

            <div class="infoLabel2"><label>	产品名称	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	组合名称	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	业务类别	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	委托方向	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	回购金额	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	清算速度	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	回购天数	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	交易日期	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	交易对手	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	首次结算日	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	到期结算日	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	占款天数	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	报价方式	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	回购利率	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	指令/建议下达日期	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	下达人	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	下达时间	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	修改人	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	修改时间	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	撤销人	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	撤销时间	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	备注	</label><input class="nui-textbox"/></div>
            <div class="infoLabel2"><label>	附件	</label><input class="nui-textbox"/></div>


        </div>
    </div>
    <div title="锁定券详情">
        <div class="infoLabel2"><label>	组合名称	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	债券代码	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	债券名称	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	当前锁定数量	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	锁定类型	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	锁定状态	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	锁定原因	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	锁定时间	</label><input class="nui-textbox"/></div>
        <div class="infoLabel2"><label>	锁定人	</label><input class="nui-textbox"/></div>
    </div>
    <div title="询价结果">
        <input type="button" value="删除"  onclick="search()"/>
        <input type="button" value="修改"  onclick="search()"/>
        <input type="button" value="取消"  onclick="search()"/>
        <div id="datagrid2" class="mini-datagrid" style="width:100%;height:250px;"
             url=""  idField="id" allowResize="true" sizeList="[20,30,50,100]" pageSize="20">
            <div property="columns">
                <div type="indexcolumn" ></div>
                <div field="loginname" width="120" headerAlign="center" allowSort="true">清算速度</div>
                <div field="name" width="120" headerAlign="center" allowSort="true">回购天数</div>
                <div field="gender" width="100" renderer="onGenderRenderer" align="center" headerAlign="center">交易日期</div>
                <div field="salary" numberFormat="¥#,0.00" align="right" width="100" allowSort="true">交易对手</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">回购利率</div>
                <div field="createtime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">回购金额</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">首次结算日</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">到期结算日</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">备注</div>
            </div>
        </div>
        <h3>
            抵押券信息
        </h3>
         <div id="datagrid2" class="mini-datagrid" style="width:100%;height:250px;"
             url=""  idField="id" allowResize="true" sizeList="[20,30,50,100]" pageSize="20">
            <div property="columns">
                <div type="indexcolumn" ></div>
                <div field="loginname" width="120" headerAlign="center" allowSort="true">债券代码</div>
                <div field="name" width="120" headerAlign="center" allowSort="true">债券名称</div>
                <div field="gender" width="100" renderer="onGenderRenderer" align="center" headerAlign="center">交易市场</div>
                <div field="salary" numberFormat="¥#,0.00" align="right" width="100" allowSort="true">托管机构</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">券面金额（万元)</div>
                <div field="createtime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">折算比率（%）</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">面值</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">净价(T-1)</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">全价(T-1)</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">债项评级</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">主体评级</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">评级机构</div>
            </div>
        </div>
    </div>
    <div title="触犯风控">
        <div id="datagrid4" class="mini-datagrid" style="width:100%;height:250px;"
             url=""  idField="id" allowResize="true" sizeList="[20,30,50,100]" pageSize="20">
            <div property="columns">
                <div type="indexcolumn" ></div>
                <div field="loginname" width="120" headerAlign="center" allowSort="true">触警来源</div>
                <div field="name" width="120" headerAlign="center" allowSort="true">触警操作</div>
                <div field="gender" width="100" renderer="onGenderRenderer" align="center" headerAlign="center">触警级别</div>
                <div field="salary" numberFormat="¥#,0.00" align="right" width="100" allowSort="true">风控序号</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">风控说明</div>
                <div field="createtime" width="100" headerAlign="center" dateFormat="yyyy-MM-dd" allowSort="true">设置值</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">实际值</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">备注</div>
                <div field="age" width="100" allowSort="true" decimalPlaces="2" dataType="float">触警时间</div>
            </div>
        </div>
    </div>
</div>

<!-- 详细标签 end -->
<script type="text/javascript">
    nui.parse();
    var operation = function(){
        mini.open({
            url: "<%= request.getContextPath() %>/repurchase/repurchaseOpra.jsp",
            title: "编辑员工", width: 600, height: 400,
            onload: function () {
                var iframe = this.getIFrameEl();
                var data = { action: "edit", id: row.id };
                iframe.contentWindow.SetData(data);

            },
            ondestroy: function (action) {
//                         grid.reload(); 
            }
        });
    };
    var showDetail = function(){
    
    };
</script>
</body>
</html>