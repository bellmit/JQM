--当日T+1头寸差额：交易所可提交质押债券明细
select t1.l_fund_id, --基金ID
       t1.vc_fund_code, --基金代码
       t1.vc_fund_name, --基金名称
       t1.vc_report_code, --债券代码
       t1.vc_stock_name, --债券名称
       t1.vc_market_no, --交易市场
       0 l_pledge_amount_count, --总数量
       t1.l_pledge_amount, --数量
       0 l_standard_amount_count, --折算标准券总数
       t1.l_converted_standard_amount --折算标准券数量
  from (select a.l_fund_id,
               f.vc_fund_code,
               f.vc_fund_name,
               b.vc_report_code,
               b.vc_stock_name,
               (select t.vc_market_name
                  from trade.tmarketinfo t
                 where t.c_market_no = b.c_market_no) vc_market_no,
               sum(nvl(a.l_current_amount - a.l_frozen_amount +
                       a.l_unfrozen_amount,
                       0)) l_pledge_amount,
               round(sum(nvl(a.l_current_amount - a.l_frozen_amount +
                             a.l_unfrozen_amount,
                             0) * (e.en_sys_ratio / 100) *
                         (nvl(d.en_curr_face_price, 100) / 100)),
                     4) l_converted_standard_amount
          from trade.tunitstock    a,
               trade.tstockinfo    b,
               trade.tstocktype    c,
               trade.tbondproperty d,
               trade.thgratio      e,
               trade.tfundinfo     f
         where c.c_asset_class = '3'
           and a.l_fund_id = f.l_fund_id
           and a.c_position_flag = '1'
           and e.c_parameter_type = '4'
           and a.c_market_no in ('1', '2')
           and b.c_market_no = c.c_market_no
           and b.c_stock_type = c.c_stock_type
           and a.vc_inter_code = b.vc_inter_code
           and a.vc_inter_code = d.vc_inter_code
           and a.vc_inter_code = e.vc_inter_code
           and b.vc_inter_code <> b.vc_frozen_code
           and instr(',' || c.vc_entrust_right || ',', ',T,') > 0
           and ((a.c_market_no = '1' and b.vc_frozen_code = '888880SS') or
               (a.c_market_no = '2' and b.vc_frozen_code = '131990SZ'))
           and abs(a.l_current_amount - a.l_frozen_amount +
                   a.l_unfrozen_amount) > 0
         group by a.l_fund_id,
                  f.vc_fund_code,
                  f.vc_fund_name,
                  b.c_market_no,
                  b.vc_report_code,
                  b.vc_stock_name
         order by a.l_fund_id, b.c_market_no, b.vc_report_code) t1
 where 1 = 1