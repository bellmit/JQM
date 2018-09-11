您好！到期结算日为明天的指令下达时候以下组合可用数量不足！
        指令详细信息如下：
  	<#if (data.vcCombiCode)??>
        组合代码：${data.vcCombiCode}
  	</#if> 
    <#if (data.vcCombiName)??>
                组合名称：${data.vcCombiName}
    </#if>
    <#if (data.vcProductCode)??>
                产品代码：${data.vcProductCode}
    </#if>
    <#if (data.vcProductName)??>
                产品名称：${data.vcProductName}
    </#if>
    <#if data.bonds?has_content>
	    <#list data.bonds as bond>
	    	<#if bond.vcStockCode??>
		     <#if bond_index=0>
        质押券信息如下：
		     </#if>
                证券代码|证券名称|质押数量|可用数量：${bond.vcStockCode}|${bond.vcStockName}|${bond.vcMortagageQty}|${bond.vcAvailQtyT1}
		    </#if>
		   </#list>
		<#else>
		此组合中找不到对应的质押券信息,请了解！
    </#if>           
请留意邮件中相关信息，谢谢！