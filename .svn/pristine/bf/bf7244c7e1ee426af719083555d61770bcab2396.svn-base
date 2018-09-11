--O32系统-->综合信息查询-->交易所成交回报[6]-->当天查询SQL
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
       (select td.vc_item_name from trade.tdictionary td where td.l_dictionary_no = '40396' and td.c_lemma_item = ttt.c_busin_class) c_busin_class_name --业务类型名称
  from (select to_char(t.l_date) l_date,
              (select tinfo.vc_fund_code from trade.tfundinfo tinfo where tinfo.l_fund_id=t.l_fund_id) vc_fund_code,
               min(t.vc_fund_name) vc_fund_name,          
               t.vc_report_code,
               min(t.vc_stock_name) vc_stock_name,
                min(t.vc_entrustdir_name) vc_entrustdir_name,
               Nvl(sum(t.l_deal_amount), 0) l_deal_amount,
               Nvl(sum(t.en_deal_balance), 0) en_deal_balance,
               DECODE(SUM(t.l_deal_amount),
                      0,
                      0,
                      SUM(t.l_deal_amount * t.en_avg_dealprice) /
                      SUM(t.l_deal_amount)) en_avg_dealprice,
               DECODE(SUM(t.l_deal_amount),
                      0,
                      0,
                      SUM(t.l_deal_amount * t.en_avg_dealprice_full) /
                      SUM(t.l_deal_amount)) en_avg_dealprice_full,
               max(t.en_avg_price) en_avg_price,
              max(t.vc_market_name) vc_market_name,
               Case
                 when Count(Distinct Nvl(t.c_busin_class, -1)) = 1 Then
                  Max(t.c_busin_class)
                 else
                  '-1'
               end c_busin_class 
          from (select a.*,
                       j.vc_report_seat,
                       f.l_amount,
                       f.l_begin_amount,
                       c.vc_fund_name,
                       g.l_asset_id,
                       g.vc_asset_no,
                       g.vc_asset_name vc_asset_name2,
                       b.vc_report_direction,
                       b.vc_entrustdir_name,
                       b.c_fund_direction,
                       h.vc_combi_no,
                       h.vc_combi_name,
                       J.l_entrust_count l_entrust_count,
                       J.l_entrust_amount l_entrust_amount,
                       decode(a.l_operator_no,
                              -1,
                              '混合',
                              nvl(op.vc_operator_name, '')) vc_operator_name,
                       tm.vc_market_name vc_market_name,
                       d2.vc_item_name vc_asset_name,
                       k.l_total_insamount,
                       k.c_instruction_level,
                       b.c_stock_direction,
                       c.vc_currency_no vc_currency_no_bb,
                       decode(a.L_RIVAL_ID, -1, '混合', nvl(m.vc_name, '')) vc_rival_name
                  from trade.tfundinfo c,
                       trade.tentrustdirection b,
                       trade.tcombi h,
                       trade.tasset g,
                       trade.toperator op,
                       trade.ttraderival m,
                       trade.tmarketinfo tm,
                       trade.tdictionary d2,
                       (select nt.l_date,
                               nk.l_fund_id,
                               nk.l_basecombi_id,
                               nk.vc_inter_code,
                               nk.c_entrust_direction,
                               nk.c_invest_type,
                               sum(case
                                     when nt.c_instruction_status = '3' then
                                      nk.l_today_deal_amount
                                     else
                                      nk.l_amount
                                   end) l_total_insamount,
                               (case
                                 when count(distinct nt.c_instruction_level) = 1 then
                                  max(nt.c_instruction_level)
                                 else
                                  '-1'
                               end) c_instruction_level
                          from trade.tinstructionstock nk, trade.tinstruction nt
                         where nt.l_date = nk.l_date
                           and nk.l_daily_instruction_no =
                               nt.l_daily_instruction_no
                           and nk.l_index_daily_modify =
                               nt.l_index_daily_modify
                           and instr('1346', nt.c_instruction_status) > 0
                           and nk.c_amount_balance_flag in ('0', '1', '2')
                           and nk.l_begin_date <= PARAM_BUSI_DATE_TODAY
                           and nk.l_end_date >= PARAM_BUSI_DATE_TODAY
                           and nt.l_date >= PARAM_BUSI_DATE_TODAY
                           AND nt.l_date <= PARAM_BUSI_DATE_TODAY
                         group by nt.l_date,
                                  nk.l_fund_id,
                                  nk.l_basecombi_id,
                                  nk.vc_inter_code,
                                  nk.c_entrust_direction,
                                  nk.c_invest_type) k,
                       (SELECT a1.l_date,
                               a1.l_fund_id,
                               a1.l_basecombi_id,
                               a1.c_invest_type,
                               a1.vc_stockholder_id,
                               a1.vc_inter_code,
                               sum(Nvl(a1.l_begin_amount, 0) +
                                   Nvl(b1.l_today_dividend_right_amount, 0)) l_begin_amount,
                               sum(a1.l_current_amount) l_amount
                          FROM trade.tunitstock a1, trade.tspecstock b1
                         where 1 = 1
                           and a1.l_Unit_Id = b1.l_Unit_Id(+)
                           and a1.l_date = b1.l_date(+)
                           and a1.l_date >= PARAM_BUSI_DATE_TODAY
                           AND a1.l_date <= PARAM_BUSI_DATE_TODAY
                           and a1.C_POSITION_FLAG not in ('7', 'c', 'd')
                         GROUP BY a1.l_date,
                                  a1.l_fund_id,
                                  a1.l_basecombi_id,
                                  a1.vc_stockholder_id,
                                  a1.vc_inter_code,
                                  a1.c_invest_type) f,
                       (select l_date,
                               l_fund_id,
                               l_basecombi_id,
                               c_entrust_direction,
                               c_market_no,
                               vc_report_code,
                               vc_stockholder_id,
                               count(*) l_entrust_count,
                               Case
                                 when Count(Distinct
                                            Nvl(et1.vc_report_seat, -1)) = 1 Then
                                  Max(et1.vc_report_seat)
                                 else
                                  '混合'
                               end vc_report_seat,
                               sum(et1.l_entrust_amount - et1.l_cancel_amount) l_entrust_amount,
                               et1.c_invest_type
                          from trade.tentrusts et1
                         where et1.c_cancel_flag = '0'
                           and et1.l_date >= PARAM_BUSI_DATE_TODAY
                           AND et1.l_date <= PARAM_BUSI_DATE_TODAY
                         group by l_date,
                                  l_fund_id,
                                  l_basecombi_id,
                                  c_entrust_direction,
                                  c_market_no,
                                  vc_report_code,
                                  vc_stockholder_id,
                                  et1.c_invest_type) J,
                       (select a.*,
                               d.vc_stock_name,
                               d.c_asset_class,
                               d.c_stock_type,
                               d.l_market_deal_amount,
                               (d.en_last_price) en_last_price,
                               d.vc_currency_no,
                               (d.en_avg_price) en_avg_price,
                               (d.en_market_deal_balance) en_market_deal_balance,
                               (d.en_max_price) en_marketmax_price,
                               (d.en_min_price) en_marketmin_price,
                               (d.en_yesterday_close_price) en_yesterday_close_price,
                               d.vc_international_code,
                               d.vc_ric_code,
                               d.en_open_price,
                               d.vc_sedol_code,
                               d.vc_cusip_code,
                               d.vc_bloomberg_code,
                               (select a.vc_currency_name
                                  from trade.tcurrencyinfo a
                                 where a.vc_currency_no =
                                       d.VC_TRADE_CURRENCY_NO) vc_currency_name
                          from (SELECT a.l_date,
                                       a.l_fund_id,
                                       a.l_basecombi_id,
                                       a.vc_report_code,
                                       a.vc_inter_code,
                                       a.c_market_no,
                                       a.c_entrust_direction,
                                       a.vc_stockholder_id,
                                       case
                                         when count(distinct
                                                    nvl(et.vc_third_reff, -1)) = 1 then
                                          max(nvl(et.vc_third_reff, '0'))
                                         else
                                          '-1'
                                       end vc_third_reff,
                                       SUM(a.l_deal_amount) l_deal_amount,
                                       sum(a.EN_FUT_CLOSE_PROFIT) EN_FUT_CLOSE_PROFIT,
                                       SUM(CASE
                                             WHEN a.c_entrust_direction IN
                                                  ('5', '6', '7', '8') THEN
                                              a.l_deal_amount * 100
                                             WHEN (d.c_stock_type = '-') or
                                                  (a.c_entrust_direction in
                                                  ('26', '27')) then
                                              a.EN_BALANCE
                                             ELSE
                                              a.l_deal_amount * a.en_deal_price
                                           END) *
                                       decode(max(d.c_asset_class),
                                              'a',
                                              max(o.l_multiplier_unit),
                                              trade.sf_future_multiple(a.vc_inter_code)) en_deal_balance,
                                       SUM((CASE
                                             WHEN a.c_entrust_direction IN
                                                  ('5', '6', '7', '8') THEN
                                              a.l_deal_amount * 100
                                             WHEN (d.c_stock_type = '-') or
                                                  (a.c_entrust_direction in
                                                  ('26', '27')) then
                                              a.EN_BALANCE
                                             ELSE
                                              a.l_deal_amount * a.en_deal_price
                                           END) *
                                           trade.sf_currency_rate(a.l_date,
                                                            d.vc_trade_currency_no,
                                                            c.vc_currency_no,
                                                            c.l_fund_id,
                                                            c.l_set_no)) *
                                       decode(max(d.c_asset_class),
                                              'a',
                                              max(o.l_multiplier_unit),
                                              trade.sf_future_multiple(a.vc_inter_code)) en_deal_balance_bb,
                                       DECODE(SUM(a.l_deal_amount),
                                              0,
                                              0,
                                              SUM(a.l_deal_amount *
                                                  a.en_deal_price) /
                                              SUM(a.l_deal_amount)) en_avg_dealprice,
                                       Decode(Sum(a.l_Deal_Amount),
                                              0,
                                              0,
                                              Sum(a.l_Deal_Amount *
                                                  (a.En_Deal_Price +
                                                  decode(h.c_net_price,
                                                          0,
                                                          0,
                                                          Nvl(h.en_real_interest,
                                                              0)))) /
                                              Sum(a.l_Deal_Amount)) En_Avg_Dealprice_full,
                                       Sum(CASE
                                             WHEN a.c_entrust_direction IN
                                                  ('5', '6', '7', '8') THEN
                                              a.l_Deal_Amount *
                                              (100 +
                                              decode(h.c_net_price,
                                                      0,
                                                      0,
                                                      Nvl(h.en_real_interest, 0)))
                                             WHEN (d.c_stock_type = '-') or
                                                  (a.c_entrust_direction in
                                                  ('26', '27')) THEN
                                              a.EN_BALANCE +
                                              a.l_Deal_Amount *
                                              decode(h.c_net_price,
                                                     0,
                                                     0,
                                                     Nvl(h.en_real_interest, 0))
                                             ELSE
                                              a.l_Deal_Amount *
                                              (a.en_deal_price +
                                              decode(h.c_net_price,
                                                      0,
                                                      0,
                                                      Nvl(h.en_real_interest, 0)))
                                           END) *
                                       decode(max(d.c_asset_class),
                                              'a',
                                              max(o.l_multiplier_unit),
                                              trade.sf_future_multiple(a.vc_inter_code)) en_full_balance,
                                       COUNT(*) l_deal_times,
                                       MIN(a.en_deal_price) en_min_price,
                                       MAX(a.en_deal_price) en_max_price,
                                       (case
                                         when count(distinct nvl(decode(nvl(et.l_operator_no,
                                                                   0),
                                                               0,
                                                               a.l_operator_no,
                                                               et.l_operator_no),
                                                        -1)) = 1 then
                                          min(decode(nvl(et.l_operator_no, 0),
                                                     0,
                                                     a.l_operator_no,
                                                     et.l_operator_no))
                                         else
                                          -1
                                       end) l_operator_no,
                                       (case
                                         when count(distinct nvl(e.l_Direct_Instead_Operator,
                                                        -1)) = 1 then
                                          min(e.l_Direct_Instead_Operator)
                                         else
                                          -1
                                       end) l_Direct_Instead_Operator,
                                       Case
                                         when min(a.c_busin_class) in ('I', 'E') THEN
                                          min(e.c_invest_type)
                                         else
                                          min(et.c_invest_type)
                                       end c_invest_type,
                                       Case
                                         when Count(Distinct
                                                    Nvl(a.c_busin_class, -1)) = 1 Then
                                          Max(a.c_busin_class)
                                         else
                                          '-1'
                                       end c_busin_class,
                                       Case
                                         when Count(Distinct
                                                    Nvl(a.Vc_Broker_No, -1)) = 1 Then
                                          Max(a.Vc_Broker_No)
                                         else
                                          '-1'
                                       end Vc_Broker_No,
                                       Case
                                         when Count(Distinct
                                                    Nvl(a.Vc_Broker_No, '0')) = 1 Then
                                          case
                                            when MAX(Nvl(a.Vc_Broker_No, '0')) = '0' then
                                             max(tbs.vc_broker_name)
                                            else
                                             Max(tb.Vc_Broker_Name)
                                          END
                                         else
                                          '-1'
                                       end Vc_Broker_Name,
                                       (case
                                         when count(distinct
                                                    nvl(e.l_direct_operator, -1)) = 1 then
                                          min(e.l_direct_operator)
                                         else
                                          '-1'
                                       end) l_direct_operator,
                                       Case
                                         when Count(Distinct
                                                    Nvl(a.vc_report_seat, -1)) = 1 Then
                                          Max(a.vc_report_seat)
                                         else
                                          '混合'
                                       end vc_report_seat_cj,
                                       (case
                                         when count(distinct
                                                    nvl(e.c_etf_auto, -1)) = 1 then
                                          min(e.c_etf_auto)
                                         else
                                          '-1'
                                       end) c_etf_auto,
                                       (case
                                         when count(distinct
                                                    nvl(a.c_margined_out, '')) <= 1 then
                                          decode(min(nvl(a.c_margined_out, '')),
                                                 '0',
                                                 '否',
                                                 '1',
                                                 '是',
                                                 '')
                                         else
                                          '混合'
                                       end) c_margined_out,
                                       (case
                                         when count(distinct
                                                    nvl(et.c_price_type, -1)) = 1 then
                                          min(wx.vc_price_name)
                                         else
                                          '-1'
                                       end) vc_price_name,
                                       (case
                                         when count(distinct
                                                    nvl(d.vc_mixed_type, -1)) = 1 then
                                          min(d.vc_mixed_type)
                                         else
                                          '-1'
                                       end) vc_mixed_type,
                                       (case
                                         when count(distinct nvl(decode(nvl(et.L_RIVAL_ID,
                                                                   0),
                                                               0,
                                                               a.L_TRADE_RIVAL_NO,
                                                               et.L_RIVAL_ID),
                                                        -1)) = 1 then
                                          min(decode(nvl(et.L_RIVAL_ID, 0),
                                                     0,
                                                     a.L_TRADE_RIVAL_NO,
                                                     et.L_RIVAL_ID))
                                         else
                                          -1
                                       end) L_RIVAL_ID
                                  FROM trade.tentrusts et,
                                       trade.tstockinfo d,
                                       trade.tbroker tb,
                                       trade.tbondproperty h,
                                       trade.toptionproperty o,
                                       trade.trealdeal a,
                                       trade.tfundinfo c,
                                       trade.tseat s,
                                       trade.tbroker tbs,
                                       trade.tentrustdirectiondetail wx,
                                       (select nt.l_date,
                                               nt.l_daily_instruction_no,
                                               max(to_char(nt.l_direct_operator)) l_direct_operator,
                                               max(nk.c_invest_type) c_invest_type,
                                               max(nt.l_Direct_Instead_Operator) l_Direct_Instead_Operator,
                                               max(nt.c_etf_auto) c_etf_auto,
                                               max(nt.l_index_daily_modify) l_index_daily_modify
                                          from trade.tinstructionstock nk,
                                               trade.tinstruction      nt
                                         where nt.l_date = nk.l_date
                                           and nk.l_daily_instruction_no =
                                               nt.l_daily_instruction_no
                                           and nk.l_index_daily_modify =
                                               nt.l_index_daily_modify
                                           and instr('1346',
                                                     nt.c_instruction_status) > 0
                                           and nk.c_amount_balance_flag in
                                               ('0', '1', '2')
                                         group by nt.l_date,
                                                  nt.l_daily_instruction_no) e
                                 WHERE a.l_date = et.l_date(+)
                                   and a.l_entrust_serial_no =
                                       et.l_entrust_serial_no(+)
                                   and a.l_fund_id = c.l_fund_id
                                   and a.c_valid <> '2'
                                   and a.vc_broker_no = tb.vc_broker_no(+)
                                   and a.vc_inter_code = d.vc_inter_code
                                   and a.l_daily_instruction_no =
                                       e.l_daily_instruction_no(+)
                                   and a.l_date = e.l_date(+)
                                   and a.Vc_Report_Seat = s.vc_seat_id(+)
                                   and a.C_MARKET_NO = s.c_market_no(+)
                                   and s.Vc_Company_No = tbs.vc_broker_no(+)
                                   and a.l_date = o.l_date(+)
                                   and a.vc_inter_code = o.vc_inter_code(+)
                                   and et.c_market_no = wx.c_market_no(+)
                                   and et.c_entrust_direction =
                                       wx.c_entrust_direction(+)
                                   and et.c_price_type = wx.c_price_type(+)
                                   and a.l_date = h.l_date(+)
                                   and a.vc_inter_code = h.vc_inter_code(+)
                                   --and a.c_market_no in ('1', '2')
                                   and a.l_date >= PARAM_BUSI_DATE_TODAY
                                   and a.l_date <= PARAM_BUSI_DATE_TODAY
                                   and nvl(et.c_cancel_flag, '0') = '0'
                                 GROUP BY a.l_date,
                                          a.l_fund_id,
                                          a.c_market_no,
                                          a.vc_report_code,
                                          a.vc_inter_code,
                                          a.c_entrust_direction,
                                          a.l_basecombi_id,
                                          a.vc_stockholder_id,
                                          nvl(et.c_invest_type, e.c_invest_type)) a,
                               trade.tstockinfo d
                         where a.l_date = d.l_date
                           and a.vc_inter_code = d.vc_inter_code) a
                 where a.l_fund_id = c.l_fund_id
                   and tm.c_market_no = a.c_market_no
                   and h.l_asset_id = g.l_asset_id
                   AND d2.l_dictionary_no = 10036
                   AND d2.c_lemma_item = a.c_asset_class
                   AND a.c_entrust_direction = b.c_entrust_direction
                   AND a.c_market_no = b.c_market_no
                   AND a.l_fund_id = h.l_fund_id
                   AND a.l_basecombi_id = h.l_combi_id
                   AND a.l_operator_no = op.l_operator_no(+)
                   and a.l_rival_id = m.l_rival_id(+)
                   AND a.l_date = f.l_date(+)
                   AND a.l_fund_id = f.l_fund_id(+)
                   and a.l_basecombi_id = f.l_basecombi_id(+)
                   and a.vc_stockholder_id = f.vc_stockholder_id(+)
                   AND a.vc_inter_code = f.vc_inter_code(+)
                   and a.vc_inter_code = k.vc_inter_code(+)
                   and a.l_date = k.l_date(+)
                   and a.l_fund_id = k.l_fund_id(+)
                   and a.l_basecombi_id = k.l_basecombi_id(+)
                   and a.c_entrust_direction = k.c_entrust_direction(+)
                   and a.c_invest_type = k.c_invest_type(+)
                   and a.c_invest_type = f.c_invest_type(+)
                   and a.c_invest_type = j.c_invest_type(+)
                   and a.vc_report_code = J.vc_report_code(+)
                   and a.l_fund_id = J.l_fund_id(+)
                   and a.c_entrust_direction = J.c_entrust_direction(+)
                   and a.l_basecombi_id = j.l_basecombi_id(+)
                   and a.c_market_no = J.c_market_no(+)
                   and a.l_date = j.l_date(+)
                   and a.vc_stockholder_id = j.vc_stockholder_id(+)
                   and h.c_combi_status not in ('2', '3')) t,
               trade.vfundasset v
         where t.l_date = v.l_date(+)
           and t.l_fund_id = v.l_fund_id(+)
         group by t.l_date,
                  t.l_fund_id,
                  t.l_asset_id,
                  t.l_basecombi_id,
                  t.vc_stockholder_id,
                  t.c_market_no,
                  t.vc_report_code,
                  t.c_entrust_direction) ttt
 where 1 = 1
   --and ttt.vc_fund_code in ('001909') --基金代码
   --and ttt.vc_report_code like '%6000%' --证券代码
   --and ttt.vc_stock_name like '%宁波%' --证券名称
   --and ttt.vc_entrustdir_name like '%买入%' --委托方向
   --and ttt.c_busin_class_name like '%%' --业务类型
 --order by ttt.l_date desc, ttt.vc_fund_code asc, ttt.vc_report_code asc;