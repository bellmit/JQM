<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<!-- 
  - Author(s): ouyangsiheng
  - Date: 2017-04-12 17:23:05
  - Description:
-->
<head>
<title>自定义常用处理意见</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script src="<%= request.getContextPath() %>/common/nui/nui.js" type="text/javascript"></script>
    
</head>
<body>
	<div class="" id="form1">
		<div class="mini-panel-title"
			style="text-align: center; font-size: 20px;">常用审批语</div>
		<table  border="1" cellpadding="0">
			<tr>
				<td class="mini-panel-title" style="width:100px; text-align:center;">常用审批语</td>
				<td ><input class="nui-textarea " 
					style="height: 290px; width: 540px;  font:#5eb0fa;" id="ownId" name="ownId" /></td>
			</tr>
			<tr>
				<td class="mini-panel-title" style="width:100px; text-align:center;">说明</td>
				<td class="mini-panel-title">将默认的审批用语(如“已阅”，“同意”，“转送”等)配置好后，在执行审批操作时，可以直接下拉选择，多个默认审批语请以回车分隔。</td>
			</tr>
		</table>
		<table style="width: 100%; height:65px; table-layout: fixed;">
			<tbody>
				<tr>

					<td id="excute" style="text-align: center;" colspan="6"><a
						class="nui-button" iconCls="icon-save" onclick="saveOwn">保存</a> <span
						style="display: inline-block; width: 25px;"></span> <a
						class="nui-button" iconCls="icon-cancel" onclick="onCancel">取消</a>
					</td>
				</tr>
			</tbody>
		</table>

	</div>



	<script type="text/javascript">
    	nui.parse();    	
    		/*--------------------------------发送请求获得自定义常用处理意见---------------------------------*/
    	$.ajax({  
			     url:"com.cjhxfund.fpm.bpsExpend.comment.queryCommComments.biz.ext",
			     data:"",
			     type:'POST',
			     contentType:'text/json',
	             cache:false,
			     success:function(data){			              			             
			     var str = "";
			     for(var i=0;i<data.result.length;i++){		             
			     str = str==""? data.result[i].dictName : str +"\n"+ data.result[i].dictName;			                 
			        }     	           			                
			       nui.get("ownId").setValue(str);			                			               
		           }
		         });
		                
		                
		                
		       	/*--------------------------------保存常用审批语---------------------------------*/         		     
		     function saveOwn(){		
                 var dictName=nui.get("ownId").getValue();
                 if(dictName==null || dictName.length==0){
                 	nui.alert("请至少保留一条常用处理意见！");
                 }else{
                 
                 	dictName=dictName.replace(/\n/g,"|");        
	                var data={commcomment:{commentText:dictName}};   
	                var json = nui.encode(data);           	       	       
					$.ajax({						
						url: "com.cjhxfund.fpm.bpsExpend.comment.updateCommComment.biz.ext",
						type: "POST",
						data: json,
						cache: false,
		           		contentType: 'text/json',
						success: function(text){				
								nui.alert("保存成功！");
								
								window.CloseOwnerWindow("ok");		
								
				           		                	
						}
					});	
                 }             
		}
		
								
		            //自定义取消
	    	function onCancel() {
	           window.CloseOwnerWindow("cancel");
	        }
	    
	    
    </script>  
</body>
</html>
  