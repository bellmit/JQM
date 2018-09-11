--O32系统-->综合信息查询-->交易所成交回报[6]-->历史查询SQL
select ttt.l_date, --发生日期
       ttt.vc_fund_code, --基金代码
       ttt.vc_fund_name, --基金名称
       ttt.vc_report_code, --证券代码
       ttt.vc_stock_name, --证券名称
       ttt.vc_entrustdir_name, --委托方向
       ttt.en_avg_price, --市场成交均价
       ttt.l_deal_amount, --成交数量
       ttt.en_deal_balance, --成交金额
       ttt.en_avg_dealprice, --成交均价
       ttt.en_avg_dealprice_full, --成交均价（全价）
       ttt.vc_market_name, --交易市场
       ttt.c_busin_class, --业务类型代码
       ttt.c_busin_class_name --业务类型名称
  from stage.fm_0004 ttt
 where 1 = 1
   --and ttt.l_date >= '20170616'
   --and ttt.l_date <= '20170616'
   --and ttt.vc_fund_code in ('001909', '002101', '002310', '002210') --基金代码
   --and ttt.vc_report_code like '%6000%' --证券代码
   --and ttt.vc_stock_name like '%%' --证券名称
   --and ttt.vc_entrustdir_name like '%买入%' --委托方向
   --and ttt.c_busin_class_name like '%%' --业务类型
 --order by ttt.l_date desc, ttt.vc_fund_code asc, ttt.vc_report_code asc;