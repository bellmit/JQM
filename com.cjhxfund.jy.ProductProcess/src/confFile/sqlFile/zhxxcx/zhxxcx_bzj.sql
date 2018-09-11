select a.L_DATE, --日期
       a.L_FUND_ID, --基金代码
       a.vc_fund_code, --产品代码
       a.VC_FUND_NAME, --基金名称
       a.L_DEFAULT_ASSET, --资产单元序号
       a.vc_asset_name, --资产单元名称
       a.VC_SEQUARE_CODE, --结算参与人代码
       a.CURRENT_BZJ, --预测保证金
       a.MONTH_BEGIN_BZJ, --月初存出保证金
       a.MARGIN_BZJ, --预测需调整金额
       a.PREDICT_BZJ --下月需冻结保证金
  from O32_CJ.to32_bzj_clear_predict a
 where 1=1
   --and a.l_date >= '20170116'
   --and a.l_date <= '20170117'
   --and b.vc_fund_code in ('3M5068', '001662')
 --order by a.l_date desc, b.vc_fund_code asc
