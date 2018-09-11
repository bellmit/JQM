select t.l_date, --日期
       t.VC_DEAL_NO, --成交编号
       t.L_FUND_ID, --基金编号
       t.VC_FUND_CODE, --基金代码
       t.VC_FUND_NAME, --基金名称
       VC_REPORT_CODE, --证券代码
       t.VC_STOCK_NAME, --证券名称
       t.VC_ENTRUSTDIR_NAME, --委托方向
       t.EN_RATE, --回购利率（%）
       t.L_DEAL_AMOUNT, --成交数量
       t.EN_FIRST_CLEAR_BALANCE, --成交金额
       t.EN_SECOND_CLEAR_BALANCE, --到期清算金额
       t.L_HG_DAYS, --回购天数
       t.L_USE_DAYS, --实际占款天数
       t.L_SETTLE_SPEED, --清算速度
       t.L_FIRST_SETTLE_DATE, --首次交割日
       t.L_SECOND_SETTLE_DATE, --到期交割日
       t.L_TRADE_RIVAL_NAME, --交易对手名称
       t.EN_FIRST_NET_PRICE, --净价价格
       t.EN_FIRST_FULL_PRICE, --全价价格
       t.EN_SECOND_MATURE_YIELD, --到期收益率（%）
       t.C_TRUSTEENAME, --托管机构名称
       t.L_TIME --成交时间
  from stage.fm_0001 t
 where 1=1