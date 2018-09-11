----综合信息查询SQL-标准券：信息查询-综合信息查询-标准券[B]
--需要字段：基金名称，交易市场，证券代码，证券名称，库存数量，可用数量
select tt.L_FUND_ID, --基金序号
      tt.VC_FUND_CODE, --基金代码
       tt.VC_FUND_NAME, --基金名称
       ttt.vc_combi_name as VC_SSET_NAME,--组合名称
       tt.C_MARKET_NO, --交易市场：1-上交所A；2-深交所A；
       tt.VC_REPORT_CODE, --证券代码
       tt.VC_STOCK_NAME, --证券名称
       tt.L_AMOUNT, --库存数量
       tt.L_AVL_AMOUNT --可用数量
  from (select a.l_fund_id l_fund_id,
               max(VC_FUND_CODE) VC_FUND_CODE,
               max(d.Vc_Fund_Name) Vc_Fund_Name,
               a.l_basecombi_id,
               '多股东' vc_stockholder,
               '多席位' vc_seat,
               -1 l_basecombiid,
               '多组合' vc_combino,
               '多组合' vc_combiname,
               --a.c_market_no,
               (select t.vc_market_name
                  from trade.tmarketinfo t
                 where t.c_market_no = a.c_market_no) c_market_no,
               c.vc_report_code,
               c.vc_stock_name,
               sum(l_current_amount) l_amount,
               sum(nvl((a.l_frozen_amount), 0)) l_RQ_amount,
               sum(l_current_amount - l_frozen_amount + l_unfrozen_amount) l_avl_amount,
               sum(nvl(e.en_szstd_amount, 0)) en_szstd_amount,
               sum(nvl(mx.l_settle_amount, 0)) l_dzzh_amount
          from trade.TUNITSTOCK a,
               trade.TCOMBI b,
               trade.TSTOCKINFO c,
               trade.tfundinfo d,
               (select tu.l_fund_id,
                       tu.l_basecombi_id,
                       tu.vc_stockholder_id,
                       tu.vc_bind_seat,
                       ts.vc_frozen_code,
                       sum(tu.en_impawn_amount * th.l_ratio / 100) en_szstd_amount
                  from trade.tunitstock tu,
                       trade.tstockinfo ts,
                       trade.thgratio   th
                 where tu.vc_inter_code = ts.vc_inter_code
                   and tu.vc_inter_code = th.vc_inter_code(+)
                   and th.c_parameter_type = '4'
                   and ts.vc_frozen_code in ('131990SZ', '131991SZ')
                   and tu.C_POSITION_FLAG not in ('7', 'c', 'd')
                 group by tu.l_fund_id,
                          tu.l_basecombi_id,
                          tu.vc_stockholder_id,
                          tu.vc_bind_seat,
                          ts.vc_frozen_code) e,
               (select a.l_fund_id,
                       a.l_basecombi_id,
                       a.vc_stockholder_id,
                       c.VC_MAIN_SEAT vc_bind_seat,
                       b.vc_relative_frozen_code,
                       sum(case
                             when a.c_entrust_direction = '7' then
                              a.l_settle_amount
                             else
                              -1 * a.l_settle_amount
                           end) l_settle_amount
                  from trade.tstockinfo b, trade.tpendsettle a, trade.tseat c
                 where a.c_status = '1'
                   and a.c_entrust_direction in ('7', '5')
                   and a.c_market_no = '2'
                   and a.vc_inter_code = b.vc_inter_code
                   and a.vc_inter_code <> b.vc_relative_frozen_code
                   and a.C_MARKET_NO = c.C_MARKET_NO
                   and a.vc_bind_seat = c.VC_SEAT_ID
                   and ((a.l_stock_enable_change_date = a.l_date and
                       a.c_entrust_direction = '7' and
                       a.c_stock_enable_change_flag = '1') or
                       (a.c_entrust_direction = '5' and
                       a.l_trade_date = a.l_date))
                 group by a.l_fund_id,
                          a.l_basecombi_id,
                          a.vc_stockholder_id,
                          c.VC_MAIN_SEAT,
                          b.vc_relative_frozen_code) mx
         where a.l_basecombi_id = b.l_combi_id
           and a.vc_inter_code = c.vc_inter_code
           and a.l_fund_id = d.l_fund_id
           and c.c_stock_type in ('A', 'x')
           and a.l_fund_id = e.l_fund_id(+)
           and a.l_basecombi_id = e.l_basecombi_id(+)
           and a.vc_stockholder_id = e.vc_stockholder_id(+)
           and a.vc_bind_seat = e.vc_bind_seat(+)
           and a.vc_inter_code = e.vc_frozen_code(+)
           and a.C_POSITION_FLAG not in ('7', 'c', 'd')
           and a.l_fund_id = mx.l_fund_id(+)
           and a.l_basecombi_id = mx.l_basecombi_id(+)
           and a.vc_stockholder_id = mx.vc_stockholder_id(+)
           and a.vc_bind_seat = mx.vc_bind_seat(+)
           and a.vc_inter_code = mx.vc_relative_frozen_code(+)
           and a.c_market_no in ('1', '2')
           and b.c_combi_status not in ('2', '3')
         Group by a.c_market_no,
                  c.vc_report_code,
                  c.vc_stock_name,
                  a.l_fund_id,a.l_basecombi_id) tt left join trade.TCOMBI ttt on tt.l_basecombi_id=ttt.l_combi_id
 where 1 = 1
   --and tt.VC_FUND_CODE in ('3M5034') --基金代码
   --and tt.C_MARKET_NO like '%%' --交易市场：1-上交所A；2-深交所A；
   --and tt.VC_REPORT_CODE like '%%' --证券代码
   --and tt.VC_STOCK_NAME like '%%' --证券名称
 --order by tt.VC_FUND_CODE asc, tt.C_MARKET_NO asc