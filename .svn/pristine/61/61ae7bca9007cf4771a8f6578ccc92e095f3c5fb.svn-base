<%@page import="com.eos.data.datacontext.UserObject"%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<!-- 
  - Author(s): luwenxing
  - Date: 2017-03-21 09:37:36
  - Description:
-->
<head>
<title>免责条款</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<table>
		<tr><td >您好：</td></tr>
		<tr><td style="text-indent:2em;">本系统为创金合信基金管理有限公司（以下简称“本公司”）提供数据分析服务之系统，系统的原始数据来源包括但不限于本公司管理的基金公司特定客户资产管理计划的基本信息、估值数据、外部系统数据（如wind数据库）等。</td></tr>
		<tr><td style="text-indent:2em;">凡进入、访问或使用本系统，请仔细阅读以下免责声明：</td></tr>
		<tr><td style="text-indent:2em;">1、本系统所载信息和资料仅供一般性参考，本公司对所载信息和数据的真实性、准确性、完整性、时效性不作任何承诺和保证。任何人不得对本系统所载信息和数据的真实性、准确性、完整性、时效性产生任何依赖。</td></tr>
		<tr><td style="text-indent:2em;">2、本系统所载信息不应被视为参与/退出特定客户资产管理计划等金融产品的要约，亦不构成投资、法律、税收、会计等方面的正式建议。依据本系统所载的信息和数据行事所造成的一切后果由行事者自负，与本公司无关。</td></tr>
		<tr><td style="text-indent:2em;"> 3、本系统内容将定期或不定期更新，但本公司对本系统所载或所涉及的信息的及时性不作任何承诺和保证。本公司有权无需事先通知而删除或修改本系统信息。  </td></tr>
		<tr><td style="text-indent:2em;"> 4、本公司就本系统各项服务的安全、不中断不作任何承诺和保证。对于因技术故障（如传输错误、技术缺陷、第三者侵入等）而导致的任何数据缺失，无法进入、访问或使用本系统而可能导致的任何直接或间接损失，本公司不承担任何法律责任。</td></tr>
		<tr><td style="text-indent:2em;">  5、除非另做说明，本系统中所含全部内容的版权归本公司所有或许可使用，未经本公司事先书面许可，任何人不得以任何方式或方法分发、复制、转载、修改、发表、翻版、许可或仿制本系统中的本公司拥有版权或经许可使用的任何内容。 </td></tr>
		<tr><td style="text-indent:2em;"> 6、本公司具有法律法规规定的其它有关免责规定项下所享有的一切权利，本公司没有主张或迟延主张该等权利并不视为本公司放弃该等权利。  </td></tr>
	</table>
	
	<form> <br />
	    <div style="text-align: left;margin-left:130px;">
			<label><input name="Accept"  type="radio" value="1"/>本人已仔细阅读上述免责声明，同意接受以上免责声明的约束 </label> 
			<br /> 
			<label><input name="Accept"  type="radio" value="0" />本人不同意接受以上免责声明的约束 </label> 
		</div>
	</form> 
	
	<div style="text-align: center;margin-top:30px;margin-bottom:30px" colspan="4"  >
			<a class='nui-button' plain='false' iconCls="icon-ok" onclick="onOk()"> 确定 </a> 
			<span style="display: inline-block; width: 50px;"></span> 
			<a class='nui-button' plain='false' iconCls="icon-cancel" onclick="onCancel()">取消 </a>
	</div>
	
	<script type="text/javascript">
    	nui.parse();
    	// 确定
    	function onOk(){
    		var accept = $("input[name='Accept']:checked").val();
    		if (accept == null) {
    			alert("请选择是否接受声明约束！");
    			return;
    		}
    		CloseWindow();
    	}
    	
    	// 取消
    	 function onCancel(){
    	 	CloseWindow();
    	 }
    	 
    	 //关闭窗口
		function CloseWindow() {
			if (window.CloseOwnerWindow)
				return window.CloseOwnerWindow();
			else
				return window.close();
		}
		
		function getFormData(){
			var data = {};
			data['accept'] = $("input[name='Accept']:checked").val();
			return data;
		}
    	
    </script>
</body>
</html>