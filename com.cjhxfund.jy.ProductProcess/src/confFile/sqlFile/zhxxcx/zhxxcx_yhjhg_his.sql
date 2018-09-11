----综合信息查询SQL-银行间回购：信息查询-综合信息查询-银行间回购[9]
--需要字段：回购日期，基金名称，组合名称，回购代码，委托方向，数量，净资金额，交易对手，平均利率，利润，实际回购日期【实际购回日期】，回购叫个日期【购回交割日期】，实际占款天数【无】，证券类别，实际回购代码
select L_HG_DATE, --回购日期
       L_SERIAL_NO, --流水号
       L_FUND_ID, --基金序号
       VC_FUND_CODE, --基金代码
       VC_FUND_NAME, --基金名称
       VC_COMBI_NO, --组合代码
       VC_COMBI_NAME, --组合名称
       VC_REPORT_CODE, --回购代码
       VC_ENTRUSTDIR_NAME, --委托方向
       L_DEAL_AMOUNT, --数量
       EN_NET_ZJ, --净资金额
       EN_RET_ZJ, --返回金额
       VC_RIVAL_NAME, --交易对手
       EN_INTEREST_RATE, --平均利率
       EN_PROFIT, --利润
       L_REDEEM_LAWDATE, --法定购回日期
       L_REDEEM_LIQUIDATE, --实际购回日期
       L_SETTLE_DATE, --购回交割日期
       C_STOCK_TYPE, --证券类别
       VC_REAL_CODE, --实际回购代码
       C_TRUSTEE --托管机构
  from stage.fm_0002 tt 
  where 1=1 
  and tt.L_HG_DATE>=PARAM_BUSI_DATE_BEGIN 
  and tt.L_HG_DATE<=PARAM_BUSI_DATE_END