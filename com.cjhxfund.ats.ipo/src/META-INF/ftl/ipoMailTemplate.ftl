<#if data.ipoStateCode=="0010">
您好！以下是wind新股数据:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
初步询价公告，请您登陆系统查询相关信息并进行相关操作。
<#elseif data.ipoStateCode=="0020">
您好！以下是wind新股数据、投顾所管理基金信息:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
请您登陆系统查询相关信息并于今日12:00前反馈新股询价意向。
<#elseif data.ipoStateCode=="0021">
您好！以下是wind新股数据、研究员人员信息:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
指派行业研究员，请您登陆系统查询相关信息并进行相关操作 。
<#elseif data.ipoStateCode=="0022">
您好！以下是wind新股数据、新股报价信息:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
提供新股价格建议与研究报告，请您登陆系统查询相关信息并进行相关操作 。
<#elseif data.ipoStateCode=="0030">
您好！以下是投顾意向反馈结果:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
确认主承备案结果，当天12点前截止反馈意向，请您登陆系统查询相关信息并进行相关操作 。
<#elseif data.ipoStateCode=="0031">
您好！以下是wind新股数据、新股报价信息:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
审批新股询价价格，请您登陆系统查询相关信息并进行相关操作 。
<#elseif data.ipoStateCode=="0032">
您好！以下是wind新股数据、新股报价信息:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
确认新股询价价格，请您登陆系统查询相关信息并进行相关操作 。
<#elseif data.ipoStateCode=="0040">
您好！以下是指令所有数据:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
新股询价指令单，请您登陆系统查询相关信息并进行相关操作 。
<#elseif data.ipoStateCode=="0050">
您好！以下是指令所有数据:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
审批询价指令，请您登陆系统审批新股询价指令 。
<#elseif data.ipoStateCode=="0060">
您好！以下是所辖基金指令相关数据:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
确认询价指令，请您登陆系统确认最终的新股询价指令 。
<#elseif data.ipoStateCode=="0061">
您好！以下是指令所有数据:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
审批询价指令，请您登陆系统审批最终的新股询价指令。
<#elseif data.ipoStateCode=="0070">
您好！以下是指令所有数据:
	  日期：${data.vcdate}
              股票简称：${data.vcCombiName}
              股票代码：${data.vcProductCode}
执行询价指令，请您登陆系统执行最终的新股询价指令
</#if>      
对应网址:www.baidu.com