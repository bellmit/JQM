----综合信息查询SQL-交易所回购：信息查询-综合信息查询-交易所回购[8]
--需要字段：基金名称，组合名称，回购代码，委托方向，数量，净资金额，平均利率，利润，回购日期，实际购回日期，购回交割日期，实际占款天数
select L_HG_DATE, --回购日期
       L_FUND_ID, --基金ID
       VC_FUND_CODE, --基金代码
       VC_FUND_NAME, --基金名称
       VC_COMBI_NO, --组合代码
       VC_COMBI_NAME, --组合名称
       VC_REPORT_CODE, --回购代码
       VC_ENTRUSTDIR_NAME, --委托方向
       L_DEAL_AMOUNT, --数量
       EN_NET_ZJ, --净资金额
       EN_INTEREST_RATE, --平均利率
       EN_PROFIT, --利润
       L_REDEEM_LIQUIDATE, --实际购回日期
       L_SETTLE_DATE, --购回交割日期
       L_USE_DAYS --实际占款天数
 from stage.fm_0003 tt 
 where 1=1 
  and tt.L_HG_DATE>=PARAM_BUSI_DATE_BEGIN 
  and tt.L_HG_DATE<=PARAM_BUSI_DATE_END