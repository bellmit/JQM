<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): huangmizhi
  - Date: 2017-11-25 14:48:56
  - Description: 产品权限配置帮助
-->
<head>
<title>产品权限配置帮助</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
</head>
<body>
<div style="font-weight:bold;font-size:14px;padding:0px 0 5px 0;">一、权限配置步骤</div>
　　1、设置投顾/委托人等外部客户权限，一般为“01”、“07”、“A1”等；<br/>
　　2、设置投资/基金经理权限，为“02”等；<br/>
　　3、设置交易员权限，为“03”、“04”、“05”、“06”、“08”等；<br/>
　　4、设置IT运维/监察稽核同事权限，为“00”等；<br/>

<div style="font-weight:bold;font-size:14px;padding:10px 0 5px 0;">二、设置说明</div>
　　1、不能同时设置“非创金员工”与“创金员工”权限类型；<br/>
　　2、不能同时设置“投资/基金经理岗”与“交易员岗”权限类型；<br/>
　　3、不能同时设置“00-组合查询”与其他权限类型；<br/>
　　4、不能同时设置“99-交易确认”与其他权限类型；<br/>
　　5、不能同时设置“98-后台成交确认”与其他权限类型；<br/>
　　6、若不是配置“99-交易确认阶段权限”或“98-后台已成交确认阶段权限”，则产品&组合名称必输；<br/>
　　7、若不是配置“A1-投资录入确认可为同一人员”、“A2-需要委托人确认”、“A4-需要投顾风控确认”，则关联用户必输；<br/>
　　8、新增产品权限时根据不同的权限类型做特殊处理：<br/>
　　　　（1）当类型为“A1”或“A2”或“A4”时，设置如下：<br/>
　　　　　　vcUserId=All Users；<br/>
　　　　　　vcUserName=全部用户；<br/>
　　　　（2）当类型为“98”或“99”时，设置如下：<br/>
　　　　　　lProductId=-1；<br/>
　　　　　　vcProductCode=All Products；<br/>
　　　　　　vcProductName=全部产品；<br/>
　　　　　　lCombiId=-1；<br/>
　　　　　　vcCombiNo=All Combis；<br/>
　　　　　　vcCombiName=全部组合；<br/>
　　　　　　lAssetId=-1；<br/>
　　　　　　vcAssetNo=All Assets；<br/>
　　　　　　vcAssetName=全部资产单元；<br/>


<div style="font-weight:bold;font-size:14px;padding:10px 0 5px 0;">三、权限类型</div>

　　1、创金员工、非创金员工公共权限类型：<br/>
　　　　00-组合查询权限；<br/>

　　2、投顾、委托人等非创金员工权限类型：<br/>
　　　　01-组合与投资录入权限；<br/>
　　　　07-组合与投资确认权限；<br/>
　　　　A4-需要投顾风控确认；<br/>
　　　　A5-组合与投顾风控确认权限；<br/>
　　　　A2-需要委托人确认；<br/>
　　　　A3-组合与委托人确认权限；<br/>
　　　　A1-投资录入确认可为同一人员；<br/>

　　3、投资经理、交易员等创金员工权限类型：<br/>
　　　　02-组合与投资/基金经理权限；<br/>
　　　　03-组合与询价结果录入权限；<br/>
　　　　04-组合与交易录单确认权限；<br/>
　　　　05-组合与交易录单复核权限；<br/>
　　　　06-组合与资金手工交收权限；<br/>
　　　　08-组合与资金交收设置权限；<br/>
　　　　09-组合与中标确认交易员审批权限；<br/>
　　　　99-交易确认阶段权限；<br/>
　　　　98-后台成交确认阶段权限；<br/><br/>


<script type="text/javascript">
	nui.parse();
</script>
</body>
</html>