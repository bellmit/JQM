	//页面间传输json数据
	function setFormData(data){
	   //跨页面传递的数据对象，克隆后才可以安全使用
	   var infos = nui.clone(data);
	
	   //保存list页面传递过来的页面类型：add表示新增、edit表示编辑
	   nui.getbyName("pageType").setValue(infos.pageType);
	   if(infos.pageType == "add"){
		   //初始化附加列表
		   inIt();
	   }
	   if (infos.pageType == "edit") {
           var json = infos.record;

           var form = new nui.Form("#dataform1");//将普通form转为nui的form
           form.setData(json);
           form.setChanged(false);
           
           //设置产品名称与产品代码
           nui.get("combProductCode").setValue(json.cfjybusinessbonetable.combProductCode);
           nui.get("combProductCode").setText(json.cfjybusinessbonetable.combProductName);
           
           //设置债券代码
           nui.get("investProductCode").setValue(json.cfjybusinessbonetable.investProductCode);
           nui.get("investProductCode").setText(json.cfjybusinessbonetable.investProductCode);
           
           //设置附件上传列表参数
           var prodIfm = document.getElementById("prodIfm");
    	   var bizId =  json.cfjybusinessbonetable.bizId;
    	   var processinstid = json.cfjybusinessbonetable.processinstid;
    	   
		   prodIfm.src = contextPath + "/process/fileupload/any_upload.jsp?bizId="+bizId+"&processinstid="+processinstid+"&attachType=0&attachBusType=0&type=1"; 
	   
		   var resaleRight = json.cfjybusinessbonetable.resaleRight;
		   var redemptionRight = json.cfjybusinessbonetable.redemptionRight;
		   var isInquiry = json.cfjybusinessbonetable.associationBetween;
		   
		   if(resaleRight == 1){
			      document.getElementById("lable1").style.display = "block";
		   }
		   if(redemptionRight == 1){
			    document.getElementById("lable2").style.display = "block";
		   }

		   if(isInquiry == 1){
			    document.getElementById("associationRemark").style.display = "block";
		   }
		   
		 //调用方法重新加载组合
		 setCombProductName();
	     //重新设置选择的组合
		 var vcCombiNo = json.cfjybusinessbonetable.vcCombiNo;
		 var vcCombiName = json.cfjybusinessbonetable.vcCombiName;
		 
		 nui.get("vcCombiNo").setValue(vcCombiNo);
		 nui.get("vcCombiNo").setText(vcCombiName);
	        
		 //重新设置隐藏组合名称
		 nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());   
	   }    
	}
	

	//关闭窗口
	function CloseWindow(action) {
	     if (action == "close" && form.isChanged()) {
	         if(confirm("数据被修改了，是否先保存？")) {
	              saveData();
	        }
	     }
	    if (window.CloseOwnerWindow)
	     return window.CloseOwnerWindow(action);
	     else window.close();
	}
	
	//确定保存或更新
	function onOk() {
	     saveData();
	}
	
	//取消
	function onCancel() {
	    CloseWindow("cancel");
	}
	                    
	function setCombProductName(e){
	  nui.get("combProductName").setValue(nui.get("combProductCode").getText());
	  //动态加载tab页
	  DynamicLoadingTabs();
	  
	  var vcCombiNo = nui.get("vcCombiNo");
	  vcCombiNo.setValue("");
	  
	  var combProductCode = nui.get("combProductCode").getValue();
      var url = "com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getCombiNosByKeyUserId.biz.ext?productCodes=" + combProductCode;
      vcCombiNo.setUrl(url);
      
      vcCombiNo.select(0);
	}
	
	//选择组合时触发
	function setVcCombiName(e){
		nui.get("vcCombiName").setValue(nui.get("vcCombiNo").getText());
	}
	                    
	                  
	//债券代码下拉项点击时触发函数
	function investProductCodeOnItemClick(){
		var investProductCode = nui.get("investProductCode").getValue();//投资产品信息

		if(investProductCode!=null && investProductCode!=""){
	                	
			//通过交易市场编号、证券申报代码到O32系统查找投资的债券、股票等产品信息（包含债券评级等债券属性）
			var paramArr = investProductCode.split(",");
			$.ajax({
				url:"com.cjhxfund.jy.ProductProcess.CFJYProductProcessBiz.getInvestProductInfoByMarketNoAndReportCode.biz.ext",
				type:'POST',
				data:nui.encode({marketNo:paramArr[2], reportCode:paramArr[0]}),
				cache:false,
				contentType:'text/json',
				success:function(text){
					var returnJson = nui.decode(text);
					if(returnJson.exception == null){
						 var investProductInfo = returnJson.investProductInfo;//投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
						                	
						 //投资产品信息（债券代码,债券名称,债券类别代码,债券评级代码,主体评级代码,评级机构代码）
						 var investProductCodeArr = investProductInfo.split(",");
						 var investProductCodeVal = investProductCodeArr[0];//债券代码
						 var investProductNameVal = investProductCodeArr[1];//债券名称
						 var investCategoryVal = investProductCodeArr[2];//债券类别代码
						 var bondRatingVal = investProductCodeArr[3];//债券评级代码
						 var subjectRatingVal = investProductCodeArr[4];//主体评级代码
						 var ratingAgenciesVal = investProductCodeArr[5];//评级机构代码
						                	
						 nui.get("investProductCode").setText(investProductCodeVal);
						nui.get("investProductCode").setValue(investProductCodeVal);
						nui.get("investProductName").setValue(investProductNameVal);
						
						//债券评级
						if(bondRatingVal!=null && bondRatingVal!="" && bondRatingVal!="★"){
							 nui.get("bondrating").setValue(bondRatingVal);
						}else{
							 nui.get("bondrating").setValue(null);
						}
						//主体评级
						if(subjectRatingVal!=null && subjectRatingVal!="" && subjectRatingVal!="★"){
							 nui.get("subjectrating").setValue(subjectRatingVal);
						}else{
							 nui.get("subjectrating").setValue(null);
						}
						//评级机构
						if(ratingAgenciesVal!=null && ratingAgenciesVal!="" && ratingAgenciesVal!="★"){
							 nui.get("ratingAgencies").setValue(ratingAgenciesVal);
						}else{
							 nui.get("ratingAgencies").setValue(null);
						}
						
						//债券类别
						if(investCategoryVal !=null && investCategoryVal!= "" && investCategoryVal!="★"){
							nui.get("investcategory").setValue(investCategoryVal);
						}else{
							nui.get("investcategory").setValue(null);
						}
						                	
					}else{
						 nui.alert("债券详细信息获取失败", "系统提示");
					}
				}
			});
		}else{
			nui.get("investProductCode").setText(null);
			nui.get("investProductCode").setValue(null);
		}
	}
	
	//是否关联交易，选择是时显示文本框输入那种关联交易，选择否时不用输入
	function isInquiryOnvaluechanged(e){
	   var isInquiry = nui.get("isInquiry").getValue();
	   if(isInquiry==1){
	     document .getElementById("associationRemark").style.display="block";
	   }else{
	     document .getElementById("associationRemark").style.display="none"; 
	   }
	}
	//是否具有回售权，选择是时显示文本框输入行权年，否时不用输入
	function resaleRightOnvaluechanged(e){
	   if(e.value==1){
	     //document .getElementById("resaleYear").style.display="block";
	     document.getElementById("lable1").style.display="block";
	   }else{
	    // document .getElementById("resaleYear").style.display="none"; 
	     document.getElementById("lable1").style.display="none";
	   }
	}
	//是否具有赎回权，选择是时显示文本框输入行权年，否时不用输入
	function redemptionRightOnvaluechanged(e){
	   if(e.value==1){
	    // document.getElementById("redemptionYear").style.display="block";
	     document.getElementById("lable2").style.display="block";
	   }else{
	    // document .getElementById("redemptionYear").style.display="none"; 
	     document.getElementById("lable2").style.display="none";
	   }
	}
	
	//初始化数据
	function inIt(){
	    var data = {entityName:'com.cjhxfund.jy.process.FirstGradeBond.CfCyBusinessMainTable'};
	    var json = nui.encode(data);
	       $.ajax({
	        url:"com.cjhxfund.jy.process.cfjybusinessbonetablebiz.generatePrimaryKey.biz.ext",
	        type:'POST',
	        data:json,
	        cache:false,
	        contentType:'text/json',
	        success:function(text){
	            var returnJson = nui.decode(text);
	            //var form = new nui.Form("#dataform1");//将普通form转为nui的form
	            //    form.setData(returnJson);
	            //    form.setChanged(false);
	            nui.get("bizId").setValue(returnJson.maintable.bizId);
	             var prodIfm = document.getElementById("prodIfm");   
	             prodIfm.src = "<%= request.getContextPath() %>/process/fileupload/any_upload.jsp?bizId="+returnJson.maintable.bizId+"&attachType=0&attachBusType=0";
	          }
	      });	
	}
	
	/** 
	 * 将数值四舍五入后自动增加千分位. ----所有业务通用
	 * @param cmpId 控件ID
	 * @param cent 要保留的小数位(Number) 
	 * @param isThousand 是否需要千分位 0:不需要,1:需要(数值类型); 
	 * @return 格式的字符串,如'1,234,567.45' 
	 * @type String 
	 */
	 function formatNumberCommon(cmpId, cent, isThousand){
	 	cent = cent==null||cent==""?4:cent;//默认保留4位小数
	 	isThousand = isThousand==null||cent==""?1:isThousand;//默认需要千分位
	 	var oldVal = nui.get(cmpId).getValue();
	 	if(oldVal!=null && oldVal!=""){
	 		var newVal = formatNumber(oldVal,cent,isThousand);
	 		nui.get(cmpId).setValue(newVal);
	 	}
	 }
	 
	//发行规模(万元)
	    function issueSizeFun(){
	        formatNumberCommon("issueSize",4);
	     }
	            	
	     //已投资该发行主体证券存量(万元)
	     function categoryMoneyFun(){
	          formatNumberCommon("categorymoney",4);
	     }
	            	
	     // 产品净值规模(万元)
	     function netWorthScaleFun(){
	         formatNumberCommon("netWorthScale",4);
	     }
	     
	     function commonLoading(msg,title){
	     	return nui.loading(msg,title);
	 	 }
	 	
	 	 function commonHideMessageBox(messageid){
	 	    nui.hideMessageBox(messageid);
	 	 }
			            