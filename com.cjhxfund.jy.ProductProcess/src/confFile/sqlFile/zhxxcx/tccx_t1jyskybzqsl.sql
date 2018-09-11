--当日T+1头寸差额：交易所可用标准券数量
select t1.l_fund_id, --基金ID
       t1.vc_fund_code, --基金代码
       t1.vc_fund_name, --基金名称
       t1.vc_market_no, --交易市场
       0 l_enable_amount_count, --总数量
       t1.l_enable_amount --数量
  from (select a.l_fund_id, --基金ID
               b.vc_fund_code, --基金代码
               b.vc_fund_name, --基金名称
               (select t.vc_market_name
                  from trade.tmarketinfo t
                 where t.c_market_no = a.c_market_no) vc_market_no,
               sum(nvl(a.l_current_amount - a.l_frozen_amount +
                       a.l_unfrozen_amount,
                       0)) l_enable_amount
          from trade.tunitstock a, trade.tfundinfo b
         where a.l_fund_id = b.l_fund_id
           and a.vc_inter_code in ('888880SS', '131990SZ')
           and abs(a.l_current_amount - a.l_frozen_amount +
                   a.l_unfrozen_amount) > 0
         group by a.l_fund_id, b.vc_fund_code, b.vc_fund_name, a.c_market_no
         order by a.l_fund_id, a.c_market_no) t1
 where 1 = 1