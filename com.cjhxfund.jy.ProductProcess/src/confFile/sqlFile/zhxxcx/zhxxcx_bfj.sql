 ----备付金保证金预估查询SQL-备付金
select a.L_DATE, --日期
       a.L_FUND_ID, --基金代码
       a.VC_FUND_CODE, --产品代码
       a.VC_FUND_NAME, --基金名称
       a.L_ASSET_ID, --资产单元
       a.VC_ASSET_NAME, --资产单元名称
       a.VC_BUSIN_FLAG, --业务类型名称
       a.EN_DEAL_BALANCE, --成交金额
       a.EN_BFJ_LASTDAY, --预测备付金
       a.EN_BFJ_LASTMON, --月初存出备付金
       a.EN_BFJ_GAP, --预测调整金额
       a.EN_BFJ_PREDICT, --月初需冻结金额
       a.C_GROUP_FLAG, --是否分组估值
       a.ASSET_FLAG --是否分资产单元
  from O32_CJ.to32_bfj_predict a
  where 1 = 1
   --and a.l_date >= '20170228'
   --and a.l_date <= '20170302'
   --and b.vc_fund_code in ('CJ0075', 'CJ0069')
   --and a.vc_busin_flag like '%汇总%'
 --order by a.l_date desc, b.vc_fund_code asc;