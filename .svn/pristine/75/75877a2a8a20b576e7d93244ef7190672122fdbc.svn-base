您好！指令下达时候出现了审批类风控。
        指令详细信息如下：
    <#if (data.vcProductName)??>
       产品名称：${data.vcProductName}
    </#if> 
    <#if (data.vcCombiName)??>
                组合名称：${data.vcCombiName}
    </#if>
    <#if data.vcEntrustDirection=="3"||data.vcEntrustDirection=="4">
                证券代码：${data.vcStockCode}
                证券名称：${data.vcStockName}
    <#elseif data.vcEntrustDirection=="5"||data.vcEntrustDirection=="6"||data.vcEntrustDirection=="15"||data.vcEntrustDirection=="16"
    	||data.vcEntrustDirection=="17"||data.vcEntrustDirection=="18"||data.vcEntrustDirection=="26"||data.vcEntrustDirection=="27"||data.vcEntrustDirection=="30">
                证券申报代码：${data.vcSymbol}
    <#else>            
    </#if>
    <#if (data.lTradeDate)??>           
                交易日期：${data.lTradeDate}
    </#if>
    <#if (data.vcSettleSpeed)??>
                清算速度：${data.vcSettleSpeed}
    </#if>
    <#if (data.lResultNo)??>
                ATS指令序号：${data.lResultNo}
    </#if>
    <#if (data.lDailyInstructionNo)??>
                O32指令序号：${data.lDailyInstructionNo}
    </#if>
    <#if data.vcBizType=="1">
                业务类别：银行间二级交易
    <#elseif data.vcBizType=="2">
                业务类别：上海大宗交易
    <#elseif data.vcBizType=="3">
                业务类别：上海固收平台
    <#elseif data.vcBizType=="4">
                业务类别：深圳综合协议平台
    <#else>
                 业务类别：无法获取该属性值            
    </#if>
    <#if data.vcEntrustDirection=="3">
                委托方向：债券买入
    <#elseif data.vcEntrustDirection=="4">
                委托方向：债券卖出
    <#elseif data.vcEntrustDirection=="5">
                委托方向：正回购
    <#elseif data.vcEntrustDirection=="6">
                委托方向：逆回购
    <#elseif data.vcEntrustDirection=="15">
                委托方向：协议式正回购
    <#elseif data.vcEntrustDirection=="16">
                委托方向：协议式逆回购
    <#elseif data.vcEntrustDirection=="17">
                委托方向：正回购到期
    <#elseif data.vcEntrustDirection=="18">
                委托方向：逆回购到期
    <#elseif data.vcEntrustDirection=="26">
                委托方向：正回购换券
    <#elseif data.vcEntrustDirection=="27">
                委托方向：逆回购换券
    <#elseif data.vcEntrustDirection=="30">
                委托方向：正回购续作
    <#elseif data.vcEntrustDirection=="31">
                委托方向：逆回购续作
    <#else>
                委托方向：无法获取该属性值            
    </#if>
    <#if data.vcEntrustDirection=="3"||data.vcEntrustDirection=="4">
                结算日期：${data.lFirstSettleDate}            
                指令净价/全价：${data.enNetPrice}/${data.enFullPrice}           
                券面金额：${data.enFaceAmount}（万元）
    <#elseif data.vcEntrustDirection=="5"||data.vcEntrustDirection=="6"||data.vcEntrustDirection=="15"||data.vcEntrustDirection=="16"
    	||data.vcEntrustDirection=="17"||data.vcEntrustDirection=="18"||data.vcEntrustDirection=="26"||data.vcEntrustDirection=="27"||data.vcEntrustDirection=="30">
    <#if (data.lRepoDays)??>            
                回购天数：${data.lRepoDays}天
    </#if>
    <#if (data.enFaceAmount)??>
                回购金额：${data.enFaceAmount}（万元）
    </#if>
    <#if (data.enRepoRate)??>
                回购利率：${data.enRepoRate}
    </#if>
    <#if (data.lFirstSettleDate)??>
                首期结算日：${data.lFirstSettleDate}
    </#if>
    <#if (data.lMaturitySettleDate)??>
                到期结算日：${data.lMaturitySettleDate}
    </#if>
    <#list data.bonds as bond>
     <#if bond_index=0>
                质押券信息如下：
     </#if>
                        证券名称|质押比例|券面金额：${bond.vcStockName}|${bond.enMortagageRatio}|${bond.enFaceAmount}
    </#list>
    <#else>            
    </#if>            
请留意或关注相关审批信息，谢谢！