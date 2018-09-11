----综合信息查询SQL-银行间回购：信息查询-综合信息查询-银行间回购[9]
--需要字段：回购日期，基金名称，组合名称，回购代码，委托方向，数量，净资金额，交易对手，平均利率，利润，实际回购日期【实际购回日期】，回购叫个日期【购回交割日期】，实际占款天数【无】，证券类别，实际回购代码
--(select t.vc_item_name from trade.tdictionary t where t.l_dictionary_no=10075 and t.c_lemma_item=a.c_trustee) c_trustee,
--(select t.vc_stocktype_name from trade.tstocktype t where t.c_market_no='5' and t.c_stock_type=c.c_stock_type) c_stock_type,
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
  from (select rownum l_id, x.*
  from (
	With Tbankrealdeal_Tmp As (Select Tb.l_Date,
                                          Tb.l_Daily_Instruction_No,
                                          Min(Nvl(Tb.l_Settle_Speed, 0)) l_Settle_Speed,
                                          Decode(Tb.c_Entrust_Direction,
                                                 '4',
                                                 '1',
                                                 '2') c_Entrust_Direction,
                                          Sum(Tb.En_Balance) En_Balance,
                                          Sum(Tb.En_Fee) En_Fee,
                                          Min(tb.c_first_settle_type) c_first_settle_type,
                                          min(tb.c_second_settle_type) c_second_settle_type
                                     From trade.Tbankrealdeal Tb
                                    Where Tb.c_Cancel_Flag = '0'
                                      And tb.c_busin_class = 'f'
                                    Group By Tb.l_Date,
                                             Tb.l_Daily_Instruction_No,
                                             Tb.c_Entrust_Direction
                                   union all
                                   Select Tb.l_Date,
                                          Tb.l_Daily_Instruction_No,
                                          Min(Nvl(Tb.l_Settle_Speed, 0)) l_Settle_Speed,
                                          Decode(Tb.c_Entrust_Direction,
                                                 '4',
                                                 '1',
                                                 '2') c_Entrust_Direction,
                                          Sum(Tb.En_Balance) En_Balance,
                                          Sum(Tb.En_Fee) En_Fee,
                                          Min(tb.c_first_settle_type) c_first_settle_type,
                                          min(tb.c_second_settle_type) c_second_settle_type
                                     From trade.Thisbankrealdeal Tb
                                    Where Tb.c_Cancel_Flag = '0'
                                      And tb.c_busin_class = 'f'
                                    Group By Tb.l_Date,
                                             Tb.l_Daily_Instruction_No,
                                             Tb.c_Entrust_Direction)
         select /*+ #HINT#23# */
          '0' flag,
          (select t.vc_item_name from trade.tdictionary t where t.l_dictionary_no=10075 and t.c_lemma_item=a.c_trustee) c_trustee,
          to_char(a.l_hg_date) l_hg_date,
          a.l_serial_no,
          a.l_settle_speed,
          to_char(nvl(a.l_redeem_lawdate, 0)) l_redeem_lawdate,
          to_char(nvl(a.l_redeem_liquidate, 0)) l_redeem_liquidate,
          to_char(nvl(a.l_settle_date, 0)) l_settle_date,
          a.l_fund_id,
					(select tinfo.vc_fund_code from trade.tfundinfo tinfo where tinfo.l_fund_id=a.l_fund_id) vc_fund_code,
          e.vc_combi_no,
          d.vc_fund_name,
          to_char(nvl(a.l_redeal_date, 0)) l_redeal_date,
          h.l_asset_id,
          h.vc_asset_name,
          min(h.vc_asset_no) vc_asset_no,
          e.vc_combi_name,
          c.vc_report_code,
          min(to_number(substr(c.vc_report_code, -3, 3))) part,
          sum(decode(b.c_fund_direction, '1', -1, 1) * a.l_deal_amount) l_deal_amount,
          decode(sum(a.l_deal_amount),
                 0,
                 0,
                 sum(a.en_deal_price * a.l_deal_amount) /
                 sum(a.l_deal_amount)) en_interest_rate,
          sum(decode(b.c_fund_direction, '1', 1, -1) * a.en_deal_balance -
              a.en_fee) en_net_zj,
          sum(decode(b.c_fund_direction, '1', -1, 1) *
              (a.en_deal_balance + a.en_redeem_interest -
               nvl((select max(cu.en_occur_balance)
                     from trade.TCURRENTS cu
                    where k.vc_deal_no = cu.vc_deal_no
                      and k.l_fund_id = cu.l_fund_id
                      and k.l_basecombi_id = cu.l_basecombi_id
                      and k.c_entrust_direction = cu.c_entrust_direction
                      and k.vc_inter_code = cu.vc_inter_code
                      and cu.l_busin_flag = 41708),
                   0))) en_ret_zj,
          sum(decode(b.c_fund_direction, '1', -1, 1) * a.en_redeem_interest -
              a.en_fee) en_profit,
          Sum(Decode(b.c_Entrust_Direction, '5', -1, 1) * a.En_Now_Interest) En_Now_Interest,
          sum(a.en_redeem_interest - a.en_fee -
              (a.en_deal_balance + a.en_fee) *
              nvl(nvl((select en_year_rate / l_days
                        from trade.TINTERESTRATE
                       where vc_currency_no = 'CNY'
                         and l_rate_type = '1'
                         and l_fund_id = a.l_fund_id),
                      (select en_year_rate / l_days
                         from trade.TINTERESTRATE
                        where vc_currency_no = 'CNY'
                          and l_rate_type = '1'
                          and l_fund_id = -1)),
                  0) * decode(a.l_redeem_days,
                              3,
                              decode(to_number(to_char(to_date(to_char(a.l_date,
                                                                       99999999),
                                                               'yyyymmdd'),
                                                       'd')),
                                     2,
                                     3,
                                     3,
                                     5,
                                     4,
                                     5,
                                     5,
                                     4,
                                     6,
                                     1,
                                     a.l_redeem_days),
                              a.l_redeem_days)) en_extra_profit,
          b.vc_entrustdir_name,
          a.l_operator_no,
          a.vc_inter_code,
          (select t.vc_stocktype_name from trade.tstocktype t where t.c_market_no='5' and t.c_stock_type=c.c_stock_type) c_stock_type,
          a.c_redeal_flag,
          c.c_asset_class,
          e.l_combi_id l_basecombi_id,
          max(m.vc_name) vc_rival_name,
          min(b.c_stock_direction) c_stock_direction,
          trade.sf_get_hgrealcode(To_Number(Substr(c.Vc_Report_Code, -3, 3)),
                            c.c_stock_type,
                            '5') vc_real_code,
          round(sum(Decode(b.c_Entrust_Direction, '5', -1, 1) *
                    nvl((case
                          when a.c_stock_type = 'I' then
                           a.l_busin_amount * (a.en_mature_price - a.en_first_price)
                          else
                           a.en_deal_balance * a.en_deal_price
                        end) * (Case
                          When a.c_stock_type = 'I' then
                           trade.sf_date_diff(a.l_hg_date, a.l_redeem_liquidate)
                          Else
                           trade.sf_date_diff(a.l_hg_date, a.l_redeem_lawdate)
                        end) / (case
                          when a.c_stock_type = 'I' then
                           case
                             when trade.sf_date_diff(to_number(to_char(to_date(a.l_hg_date,
                                                                         'yyyymmdd') +
                                                                 nvl(a.l_settle_speed, 0),
                                                                 'yyyymmdd')),
                                               a.l_redeem_liquidate) = 0 then
                              1
                             else
                              trade.sf_date_diff(to_number(to_char(to_date(a.l_hg_date, 'yyyymmdd') +
                                                             nvl(a.l_settle_speed, 0),
                                                             'yyyymmdd')),
                                           a.l_redeem_liquidate)
                           end
                          when a.c_market_no in ('1', '2') then
                           36000
                          else
                           36500
                        end),
                        0)),
                2) En_Total_Interest,
          min(k.c_first_settle_type) c_first_settle_type,
          min(k.c_second_settle_type) c_second_settle_type
           from trade.THGREGISTER a,
                trade.TENTRUSTDIRECTION b,
                trade.TSTOCKINFO c,
                trade.TFUNDINFO d,
                trade.TCOMBI e,
                trade.tasset h,
                (select a.l_date,
                        a.l_entrust_serial_no,
                        a.l_trade_rival_no,
                        a.c_first_settle_type,
                        a.c_second_settle_type,
                        a.vc_deal_no,
                        a.l_fund_id,
                        a.l_basecombi_id,
                        a.c_entrust_direction,
                        a.vc_inter_code
                   from trade.tbankrealdeal a
                 union all
                 select a.l_date,
                        a.l_entrust_serial_no,
                        a.l_trade_rival_no,
                        a.c_first_settle_type,
                        a.c_second_settle_type,
                        a.vc_deal_no,
                        a.l_fund_id,
                        a.l_basecombi_id,
                        a.c_entrust_direction,
                        a.vc_inter_code
                   from trade.thisbankrealdeal a) k,
                trade.ttraderival m
          where a.c_entrust_direction = b.c_entrust_direction
            and a.c_market_no = b.c_market_no
            and a.vc_inter_code = c.vc_inter_code
            and a.l_fund_id = d.l_fund_id
            and a.l_basecombi_id = e.l_combi_id
            and a.c_market_no = '5'
            and e.l_asset_id = h.l_asset_id
            and a.l_hg_date = k.l_date(+)
            and a.l_entrust_serial_no = k.l_entrust_serial_no(+)
            and k.l_trade_rival_no = m.l_rival_id(+)
            and e.c_combi_status not in ('2', '3')
            and c.c_stock_type not in ('x', 'A', 'z')
            and c.c_asset_class <> '6'
            and (a.c_redeal_flag = '0' or
                (a.c_redeal_flag = '1' and a.L_REDEEM_LIQUIDATE = PARAM_BUSI_DATE_TODAY))
          group by a.l_hg_date,
                   a.l_serial_no,
                   a.l_settle_speed,
                   a.l_redeem_lawdate,
                   a.l_redeem_liquidate,
                   a.l_settle_date,
                   a.l_redeal_date,
                   a.l_fund_id,
                   e.vc_combi_no,
                   d.vc_fund_name,
                   e.vc_combi_name,
                   c.vc_report_code,
                   b.vc_entrustdir_name,
                   a.l_operator_no,
                   a.vc_inter_code,
                   c.c_stock_type,
                   a.c_redeal_flag,
                   c.c_asset_class,
                   e.l_combi_id,
                   h.l_asset_id,
                   h.vc_asset_name,
                   a.c_trustee
         union all
         select '0' flag,
                (select t.vc_item_name from trade.tdictionary t where t.l_dictionary_no=10075 and t.c_lemma_item=a.c_trustee) c_trustee,
                to_char(a.l_hg_date) l_hg_date,
                a.l_serial_no,
                a.l_settle_speed,
                to_char(nvl(a.l_redeem_lawdate, 0)) l_redeem_lawdate,
                to_char(nvl(a.l_redeem_liquidate, 0)) l_redeem_liquidate,
                to_char(nvl(a.l_settle_date, 0)) l_settle_date,
                a.l_fund_id,
                (select tinfo.vc_fund_code from trade.tfundinfo tinfo where tinfo.l_fund_id=a.l_fund_id) vc_fund_code,
                e.vc_combi_no,
                d.vc_fund_name,
                to_char(nvl(a.l_redeal_date, 0)) l_redeal_date,
                h.l_asset_id,
                h.vc_asset_name,
                min(h.vc_asset_no) vc_asset_no,
                e.vc_combi_name,
                c.vc_report_code,
                min(to_number(substr(c.vc_report_code, -3, 3))) part,
                sum(decode(b.c_fund_direction, '1', -1, 1) * a.l_deal_amount) l_deal_amount,
                decode(sum(a.l_deal_amount),
                       0,
                       0,
                       sum(a.en_deal_price * a.l_deal_amount) /
                       sum(a.l_deal_amount)) en_interest_rate,
                sum(decode(b.c_fund_direction, '1', 1, -1) *
                    a.en_deal_balance - a.en_fee) en_net_zj,
                sum(decode(b.c_fund_direction, '1', -1, 1) *
                    (a.en_deal_balance + a.en_redeem_interest -
                     nvl((select max(cu.en_occur_balance)
                           from trade.THISCURRENTS cu
                          where k.l_date = cu.l_date
                            and k.vc_deal_no = cu.vc_deal_no
                            and k.l_fund_id = cu.l_fund_id
                            and k.l_basecombi_id = cu.l_basecombi_id
                            and k.c_entrust_direction =
                                cu.c_entrust_direction
                            and k.vc_inter_code = cu.vc_inter_code
                            and cu.l_busin_flag = 41708),
                         0))) en_ret_zj,
                sum(decode(b.c_fund_direction, '1', -1, 1) *
                    a.en_redeem_interest - a.en_fee) en_profit,
                Sum(Decode(b.c_Entrust_Direction, '5', -1, 1) *
                    a.En_Now_Interest) En_Now_Interest,
                sum(a.en_redeem_interest - a.en_fee -
                    (a.en_deal_balance + a.en_fee) *
                    nvl(nvl((select en_year_rate / l_days
                              from trade.TINTERESTRATE
                             where vc_currency_no = 'CNY'
                               and l_rate_type = '1'
                               and l_fund_id = a.l_fund_id),
                            (select en_year_rate / l_days
                               from trade.TINTERESTRATE
                              where vc_currency_no = 'CNY'
                                and l_rate_type = '1'
                                and l_fund_id = -1)),
                        0) * decode(a.l_redeem_days,
                                    3,
                                    decode(to_number(to_char(to_date(to_char(a.l_date,
                                                                             99999999),
                                                                     'yyyymmdd'),
                                                             'd')),
                                           2,
                                           3,
                                           3,
                                           5,
                                           4,
                                           5,
                                           5,
                                           4,
                                           6,
                                           1,
                                           a.l_redeem_days),
                                    a.l_redeem_days)) en_extra_profit,
                b.vc_entrustdir_name,
                a.l_operator_no,
                a.vc_inter_code,
                (select t.vc_stocktype_name from trade.tstocktype t where t.c_market_no='5' and t.c_stock_type=c.c_stock_type) c_stock_type,
                a.c_redeal_flag,
                c.c_asset_class,
                e.l_combi_id l_basecombi_id,
                max(m.vc_name) vc_rival_name,
                min(b.c_stock_direction) c_stock_direction,
                trade.sf_get_hgrealcode(To_Number(Substr(c.Vc_Report_Code, -3, 3)),
                                  c.c_stock_type,
                                  '5') vc_real_code,
                Sum(Decode(b.c_Entrust_Direction, '5', -1, 1) *
                    a.En_Now_Interest) En_Total_Interest,
                min(k.c_first_settle_type) c_first_settle_type,
                min(k.c_second_settle_type) c_second_settle_type
           from trade.ThisHGREGISTER    a,
                trade.TENTRUSTDIRECTION b,
                trade.ThisSTOCKINFO     c,
                trade.TFUNDINFO         d,
                trade.TCOMBI            e,
                trade.tasset            h,
                trade.thisbankrealdeal  k,
                trade.ttraderival       m
          where a.c_entrust_direction = b.c_entrust_direction
            and a.c_market_no = b.c_market_no
            and a.l_hg_date = c.l_date
            and a.vc_inter_code = c.vc_inter_code
            and a.l_fund_id = d.l_fund_id
            and a.l_basecombi_id = e.l_combi_id
            and a.c_market_no = '5'
            and e.l_asset_id = h.l_asset_id
            and a.l_hg_date = k.l_date(+)
            and a.l_entrust_serial_no = k.l_entrust_serial_no(+)
            and k.l_trade_rival_no = m.l_rival_id(+)
            and e.c_combi_status not in ('2', '3')
            and c.c_stock_type not in ('x', 'A', 'z')
            and c.c_asset_class <> '6'
            and a.c_redeal_flag <> '1'
          group by a.l_hg_date,
                   a.l_serial_no,
                   a.l_settle_speed,
                   a.l_redeem_lawdate,
                   a.l_redeem_liquidate,
                   a.l_settle_date,
                   a.l_redeal_date,
                   a.l_fund_id,
                   e.vc_combi_no,
                   d.vc_fund_name,
                   e.vc_combi_name,
                   c.vc_report_code,
                   b.vc_entrustdir_name,
                   a.l_operator_no,
                   a.vc_inter_code,
                   c.c_stock_type,
                   a.c_redeal_flag,
                   c.c_asset_class,
                   e.l_combi_id,
                   h.l_asset_id,
                   h.vc_asset_name,
                   a.c_trustee
         union all
         Select '1' flag,
                (select t.vc_item_name from trade.tdictionary t where t.l_dictionary_no=10075 and t.c_lemma_item=a.c_trustee) c_trustee,
                To_Char(a.l_Date) l_Hg_Date,
                a.l_Daily_Instruction_No,
                k.l_Settle_Speed,
                To_Char(Nvl(a.l_Redeem_Liquidate, 0)) l_Redeem_Lawdate,
                To_Char(Nvl(a.l_Redeem_Liquidate, 0)) l_Redeem_Liquidate,
                To_Char(Nvl(a.l_End_Date, 0)) l_Settle_Date,
                a.l_Fund_Id,
                (select tinfo.vc_fund_code from trade.tfundinfo tinfo where tinfo.l_fund_id=a.l_fund_id) vc_fund_code,
                e.Vc_Combi_No,
                d.Vc_Fund_Name,
                decode(a.c_Redeal_Flag,
                       '1',
                       To_Char(Nvl(a.l_End_Date, 0)),
                       '0') l_Redeal_Date,
                h.l_Asset_Id,
                h.Vc_Asset_Name,
                h.Vc_Asset_No,
                e.Vc_Combi_Name,
                c.Vc_Report_Code,
                (a.l_Hg_Days) part,
                Decode(a.c_Entrust_Direction, '1', -1, 1) * k.En_Balance / 100 l_Deal_Amount,
                a.En_Hg_Ratio * 100 En_Interest_Rate,
                Decode(a.c_Entrust_Direction, '1', 1, -1) * a.En_Hg_Balance -
                k.En_Fee En_Net_Jz,
                Decode(a.c_Entrust_Direction, '1', -1, 1) *
                decode(a.c_Redeal_Flag,
                       '1',
                       a.en_redeem_balance,
                       a.en_instr_redeem_balance) En_Ret_Zj,
                Decode(a.c_Entrust_Direction, '1', -1, 1) *
                decode(a.c_Redeal_Flag,
                       '1',
                       Nvl(a.en_redeem_balance - a.en_hg_balance, 0),
                       Nvl(en_instr_redeem_balance - a.en_hg_balance, 0)) -
                k.En_Fee En_Profit,
                Decode(a.c_Entrust_Direction, '1', -1, 1) * a.En_Interest En_Now_Interest,
                0 En_Extra_Profit,
                f.Vc_Item_Name Vc_Entrustbir_Name,
                a.l_Operator_No l_Operator_No,
                c.Vc_Inter_Code,
                (select t.vc_stocktype_name from trade.tstocktype t where t.c_market_no='5' and t.c_stock_type=c.c_stock_type) c_stock_type,
                a.c_Redeal_Flag,
                c.c_Asset_Class,
                a.l_Basecombi_Id l_Basecombi_Id,
                m.Vc_Name Vc_Rival_Name,
                Decode(a.c_Entrust_Direction, '1', '2', '1') c_Stock_Direction,
                c.vc_report_code vc_real_code,
                Decode(a.c_Entrust_Direction, '1', -1, 1) *
                (a.En_Hg_Balance * a.En_Hg_Ratio / 365 * a.l_Hg_Days) En_Total_Interest,
                k.c_first_settle_type c_first_settle_type,
                k.c_second_settle_type c_second_settle_type
           From trade.Ttreatyhgdetail a,
                (select l_Direct_Date,
                        l_Daily_Instruction_No,
                        l_Index_Daily_Modify
                   from trade.tinstruction
                  where c_Instruction_Status = '1'
                    and c_Busin_Class = 'f') ti,
                trade.Tstockinfo c,
                trade.Tfundinfo d,
                trade.Tcombi e,
                trade.Tasset h,
                trade.Tbankrealdeal_Tmp k,
                trade.Ttraderival m,
                trade.Tdictionary f
          Where a.Vc_Inter_Code = c.Vc_Inter_Code
            and a.l_date = ti.l_Direct_Date
            and a.l_Daily_Instruction_No = ti.l_Daily_Instruction_No
            and a.l_Index_Daily_Modify = ti.l_Index_Daily_Modify
            And a.l_Fund_Id = d.l_Fund_Id
            And a.l_Basecombi_Id = e.l_Combi_Id
            And e.l_Asset_Id = h.l_Asset_Id
            And a.l_Date = k.l_Date
            And a.l_Daily_Instruction_No = k.l_Daily_Instruction_No
            And a.c_Entrust_Direction = k.c_Entrust_Direction
            And a.l_Trade_Rival_No = m.l_Rival_Id
            And a.c_Entrust_Direction = f.c_Lemma_Item
            And f.l_Dictionary_No = 60086
            and e.c_combi_status not in ('2', '3')
            and c.c_stock_type not in ('x', 'A', 'z')
            and c.c_asset_class <> '6'
            and (a.c_redeal_flag = '0' or
                (a.c_redeal_flag = '1' and a.L_REDEEM_LIQUIDATE = PARAM_BUSI_DATE_TODAY))
         union all
         Select '1' flag,
                (select t.vc_item_name from trade.tdictionary t where t.l_dictionary_no=10075 and t.c_lemma_item=a.c_trustee) c_trustee,
                To_Char(a.l_Date) l_Hg_Date,
                a.l_Daily_Instruction_No,
                k.l_Settle_Speed,
                To_Char(Nvl(a.l_Redeem_Liquidate, 0)) l_Redeem_Lawdate,
                To_Char(Nvl(a.l_Redeem_Liquidate, 0)) l_Redeem_Liquidate,
                To_Char(Nvl(a.l_End_Date, 0)) l_Settle_Date,
                a.l_Fund_Id,
                (select tinfo.vc_fund_code from trade.tfundinfo tinfo where tinfo.l_fund_id=a.l_fund_id) vc_fund_code,
                e.Vc_Combi_No,
                d.Vc_Fund_Name,
                decode(a.c_Redeal_Flag,
                       '1',
                       To_Char(Nvl(a.l_End_Date, 0)),
                       '0') l_Redeal_Date,
                h.l_Asset_Id,
                h.Vc_Asset_Name,
                h.Vc_Asset_No,
                e.Vc_Combi_Name,
                c.Vc_Report_Code,
                (a.l_Hg_Days) part,
                Decode(a.c_Entrust_Direction, '1', -1, 1) * k.En_Balance / 100 l_Deal_Amount,
                a.En_Hg_Ratio * 100 En_Interest_Rate,
                Decode(a.c_Entrust_Direction, '1', 1, -1) * a.En_Hg_Balance -
                k.En_Fee En_Net_Jz,
                Decode(a.c_Entrust_Direction, '1', -1, 1) *
                decode(a.c_Redeal_Flag,
                       '1',
                       a.en_redeem_balance,
                       a.en_instr_redeem_balance) En_Ret_Zj,
                Decode(a.c_Entrust_Direction, '1', -1, 1) *
                decode(a.c_Redeal_Flag,
                       '1',
                       Nvl(a.en_redeem_balance - a.en_hg_balance, 0),
                       Nvl(en_instr_redeem_balance - a.en_hg_balance, 0)) -
                k.En_Fee En_Profit,
                Decode(a.c_Entrust_Direction, '1', -1, 1) * a.En_Interest En_Now_Interest,
                0 En_Extra_Profit,
                f.Vc_Item_Name Vc_Entrustbir_Name,
                a.l_Operator_No l_Operator_No,
                c.Vc_Inter_Code,
                (select t.vc_stocktype_name from trade.tstocktype t where t.c_market_no='5' and t.c_stock_type=c.c_stock_type) c_stock_type,
                a.c_Redeal_Flag,
                c.c_Asset_Class,
                a.l_Basecombi_Id l_Basecombi_Id,
                m.Vc_Name Vc_Rival_Name,
                Decode(a.c_Entrust_Direction, '1', '2', '1') c_Stock_Direction,
                c.vc_report_code vc_real_code,
                Decode(a.c_Entrust_Direction, '1', -1, 1) *
                (a.En_Hg_Balance * a.En_Hg_Ratio / 365 * a.l_Hg_Days) En_Total_Interest,
                k.c_first_settle_type c_first_settle_type,
                k.c_second_settle_type c_second_settle_type
           From (select *
                   from trade.Ttreatyhgdetail
                 union
                 select * from trade.Thistreatyhgdetail) a,
                (select l_Direct_Date,
                        l_Daily_Instruction_No,
                        l_Index_Daily_Modify
                   from trade.thisinstruction
                  where c_Instruction_Status = '1'
                    and c_Busin_Class = 'f'
                    and c_Deal_Execute_Status In ('3')) ti,
                trade.Thisstockinfo c,
                trade.Tfundinfo d,
                trade.Tcombi e,
                trade.Tasset h,
                trade.Tbankrealdeal_Tmp k,
                trade.Ttraderival m,
                trade.Tdictionary f
          Where a.l_date = c.l_date
            and a.Vc_Inter_Code = c.Vc_Inter_Code
            and a.l_date = ti.l_Direct_Date
            and a.l_Daily_Instruction_No = ti.l_Daily_Instruction_No
            and a.l_Index_Daily_Modify = ti.l_Index_Daily_Modify
            And a.l_Fund_Id = d.l_Fund_Id
            And a.l_Basecombi_Id = e.l_Combi_Id
            And e.l_Asset_Id = h.l_Asset_Id
            And a.l_Date = k.l_Date
            And a.l_Daily_Instruction_No = k.l_Daily_Instruction_No
            And a.c_Entrust_Direction = k.c_Entrust_Direction
            And a.l_Trade_Rival_No = m.l_Rival_Id
            And a.c_Entrust_Direction = f.c_Lemma_Item
            And f.l_Dictionary_No = 60086
            and e.c_combi_status not in ('2', '3')
            and c.c_stock_type not in ('x', 'A', 'z')
            and c.c_asset_class <> '6'
            and a.c_redeal_flag <> '1'
  ) x
          where 1 = 1
        ) tt
 where 1 = 1
   --and tt.VC_FUND_CODE in ('001199') --基金代码
   --and tt.VC_COMBI_NO in ('') --组合代码
   --and tt.VC_COMBI_NAME like '%%' --组合名称
   --and tt.VC_REPORT_CODE like '%%' --回购代码
   --and tt.VC_ENTRUSTDIR_NAME like '%%' --委托方向
   --and tt.L_REDEEM_LIQUIDATE >= '' --实际购回日期
   --and tt.L_REDEEM_LIQUIDATE <= ''
 --order by tt.L_HG_DATE desc, tt.L_FUND_ID asc, tt.L_REDEEM_LIQUIDATE asc