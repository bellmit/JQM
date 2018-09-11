----机器猫-综合报表-持仓查询-产品持仓明细-当天：O32-信息查询-综合信息查询-组合证券[1]
--需要字段：日期，基金名称，组合名称，证券代码，证券名称，交易市场，持仓，冻结数量，外部评级，发行人外部评级，成本价，全价成本，全价市值，全价浮盈
select tt1.L_DATE, --日期
       tt1.L_FUND_ID, --基金序号
       tt1.vc_fund_code, --基金代码
       tt1.VC_FUND_NAME, --基金名称
       tt1.l_basecombi_id, --投资组合序号
       tt1.VC_COMBI_NO, --组合代码
       tt1.VC_COMBI_NAME, --组合名称
       tt1.vc_inter_code, --证券内码
       tt1.VC_REPORT_CODE, --证券代码
       tt1.VC_STOCK_NAME, --证券名称
       tt1.C_MARKET_NO, --交易市场代码
       tt1.vc_market_name, --交易市场名称
       tt1.L_CURRENT_AMOUNT, --持仓
       tt1.l_usable_amount, --可用数量
       tt1.L_FROZEN_AMOUNT, --冻结数量
       tt1.C_OUTER_APPRAISE, --外部评级
       tt1.C_ISSUER_OUTER_APPRAISE, --发行人外部评级
       tt1.EN_BEGIN_COST_PRICE, --成本价
       tt1.EN_QJ, --全价
       tt1.EN_JJ, --净价
       tt1.d_dqcb, --当前成本
       tt1.d_lxcb, --利息成本
       tt1.d_qjcb, --全价成本
       tt1.d_jjsz, --净价市值
       tt1.d_qjsz, --全价市值
       tt1.d_jjfy, --净价浮盈
       tt1.d_qjfy, --全价浮盈 --全价浮盈 = 全价市值 - 净价成本 - 利息成本
       tt1.vc_stockholder_id, --股东代码
       decode(tt1.en_last_price,
              0,
              '0.0000',
              (to_char(round(tt1.en_last_price, 4),
                       'fm99,999,999,999,990.0000'))) en_last_price, --最新价
       decode(tt1.en_value_currency,
              0,
              '0.00',
              (to_char(round(tt1.en_value_currency, 2),
                       'fm99,999,999,999,990.00'))) en_value_currency, --市值/持仓净值
       decode(en_accumulate_profit_new + tt1.en_float_profit_now,
              0,
              '0.00',
              (to_char(round(en_accumulate_profit_new + tt1.en_float_profit_now, 2),
                       'fm99,999,999,999,990.00'))) en_total_profit, --总体盈亏
       case
         when en_fund_value = 0 then
          null
         else
          decode(en_value_currency / en_fund_value * 100,
                 0,
                 '0.0000',
                 (to_char(round(en_value_currency / en_fund_value * 100, 4),
                          'fm99,999,999,999,990.0000')))
       end en_currency_fund, --市值比净值
       case
         when en_current_cost_now = 0 then
          null
         else
          decode(en_float_profit / en_current_cost_now * 100,
                 0,
                 '0.00',
                 (to_char(round(en_float_profit / en_current_cost_now * 100,
                                2),
                          'fm99,999,999,999,990.00')))
       end en_float_rate, --盈亏率
       tt1.en_float_profit, --浮动盈亏
       tt1.en_accumulate_profit_new, --累计盈亏
       tt1.en_float_profit_now,  --当日浮动盈亏
       tt1.c_position_flag,   --持仓多空标志
       (select a.vc_item_name
                  from trade.tdictionary a
                 where a.l_dictionary_no = '40350'
                   and a.c_lemma_item <> '!'
                   and a.c_lemma_item = tt1.c_position_flag) c_position_flag_cn --持仓多空标志
  from (select nvl(g.en_fund_value, 0) en_fund_value,
               nvl(h.EN_VALUATE_DURATION, 0) EN_VALUATE_DURATION,
               h.c_trustee,
               Nvl(abs(a.l_current_amount) * j.en_face_values, 0) en_stock_values,
               Nvl(a.En_Real_Cost, 0) En_Real_Cost,
               nvl(f.L_TODAY_DIVIDEND_RIGHT_AMOUNT, 0) L_TODAY_DIVIDEND_RIGHT_AMOUNT,
               h.l_zqhs_begindate,
               h.l_zqhs_enddate,
               h.c_pay_capital_type,
               ft.EN_PRE_PRICE,
               case
                 when d.c_asset_class = '2' then
                  d.en_repay_year
               end en_repay_year,
               case
                 when h.c_pay_capital_type = '2' then
                  bpr.l_pay_date
               end l_pay_date,
               trade.sf_avg_price_new(a.l_fund_id,
                                      a.vc_inter_code,
                                      a.c_invest_type,
                                      a.l_date,
                                      b.c_value_class,
                                      '1',
                                      b.c_out_bond_type,
                                      0,
                                      a.l_basecombi_id,
                                      '1',
                                      b.l_business_date,
                                      b.c_invest_direction,
                                      b.c_long_stop_type,
                                      b.c_etf_value_type,
                                      b.c_accountant_type,
                                      b.c_bond_stop_type,
                                      b.c_calculate_type,
                                      b.c_class_bond_type,
                                      d.c_Market_No,
                                      d.c_Stock_Type,
                                      d.Vc_Busin_Classes,
                                      d.Vc_Mixed_Type,
                                      d.En_Avg_Price,
                                      d.En_Fair_Price2,
                                      d.En_Yesterday_Close_Price,
                                      d.En_Last_Price,
                                      d.c_Long_Stop_Flag,
                                      d.Vc_Asset_Relative_Code,
                                      d.c_Stop_Flag,
                                      d.l_total_lock_days,
                                      d.l_left_lock_days,
                                      d.c_Asset_Class,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      null,
                                      b.c_exchange_abs_type,
                                      b.c_bank_abs_type,
                                      b.c_exchange_net_type,
                                      0,
                                      d.vc_reference_fa_code,
                                      a.c_position_flag,
                                      b.c_inactive_type,
                                      d.c_trade_active,
                                      b.c_zq_gzms,
                                      b.c_yhjzq_price_source,
                                      b.c_jyszq_price_source) En_Avg_Jj_Price,
               decode(nvl(g.en_fund_value, 0),
                      0,
                      0,
                      a.en_buy_balance *
                      trade.sf_currency_rate(a.l_date,
                                             d.vc_currency_no,
                                             b.vc_currency_no,
                                             b.l_fund_id,
                                             b.l_set_no) / g.en_fund_value * 100) en_buy_ratio,
               decode(nvl(g.en_fund_value, 0),
                      0,
                      0,
                      a.en_sale_balance *
                      trade.sf_currency_rate(a.l_date,
                                             d.vc_currency_no,
                                             b.vc_currency_no,
                                             b.l_fund_id,
                                             b.l_set_no) / g.en_fund_value * 100) en_sale_ratio,
               nvl(k.en_asset_value, 0) en_asset_value,
               b.vc_fund_code,
               i.vc_asset_no,
               tc.vc_custom_class,
               h.c_other_appraise_one vc_other_appraise_one,
               h.c_other_appraise_two vc_other_appraise_two,
               nvl(d.l_total_amount, 0) l_total_amount,
               to_char(a.l_date) l_date,
               a.c_market_no,
               (select t.vc_market_name
                  from trade.tmarketinfo t
                 where t.c_market_no = a.c_market_no) vc_market_name, --交易市场名称
               c.l_fund_id,
               b.vc_fund_name,
               i.l_asset_id,
               i.vc_asset_name vc_asset_name2,
               nvl(d.l_turnover_amount, 0) l_turnover_amount,
               a.L_BASECOMBI_ID,
               c.vc_combi_no,
               c.vc_combi_name,
               a.vc_stockholder_id,
               d.vc_stock_name,
               d.vc_report_code,
               d.c_stock_type,
               j.vc_stocktype_name,
               a.l_frozen_amount,
               a.l_unfrozen_amount,
               a.en_untransfered_invest,
               a.l_current_amount l_current_amount,
               a.l_prebuy_amount l_prebuy_amount,
               a.l_presale_amount l_presale_amount,
               nvl(h.en_bond_interest *
                   (1 - (select nvl(k.en_interest_tax, 0.00)
                           from trade.TBONDDETAILPROPERTY k
                          where k.l_date = d.l_date
                            and k.c_stock_type = d.c_stock_type
                            and k.c_tax_type = b.c_tax_type)),
                   0.00) en_bond_interest,
               nvl(h.en_today_interest *
                   (1 - (select nvl(k.en_interest_tax, 0.00)
                           from trade.TBONDDETAILPROPERTY k
                          where k.l_date = d.l_date
                            and k.c_stock_type = d.c_stock_type
                            and k.c_tax_type = b.c_tax_type)),
                   0.00) en_today_interest,
               a.l_current_amount l_amount,
               f.en_bond_interest_invest,
               round((case
                       when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                        abs(a.l_current_amount)
                       else
                        a.l_current_amount
                     end) *
                     trade.sf_avg_price_new(a.l_fund_id,
                                            a.vc_inter_code,
                                            a.c_invest_type,
                                            0,
                                            b.c_value_class,
                                            '1',
                                            b.c_out_bond_type,
                                            0,
                                            a.l_basecombi_id,
                                            '1',
                                            b.l_business_date,
                                            b.c_invest_direction,
                                            b.c_long_stop_type,
                                            b.c_etf_value_type,
                                            b.c_accountant_type,
                                            b.c_bond_stop_type,
                                            b.c_calculate_type,
                                            b.c_class_bond_type,
                                            d.c_Market_No,
                                            d.c_Stock_Type,
                                            d.Vc_Busin_Classes,
                                            d.Vc_Mixed_Type,
                                            d.En_Avg_Price,
                                            d.En_Fair_Price2,
                                            d.En_Yesterday_Close_Price,
                                            d.En_Last_Price,
                                            d.c_Long_Stop_Flag,
                                            d.Vc_Asset_Relative_Code,
                                            d.c_Stop_Flag,
                                            d.l_total_lock_days,
                                            d.l_left_lock_days,
                                            d.c_Asset_Class,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            b.c_exchange_abs_type,
                                            b.c_bank_abs_type,
                                            b.c_exchange_net_type,
                                            0,
                                            d.vc_reference_fa_code,
                                            a.c_position_flag,
                                            b.c_inactive_type,
                                            d.c_trade_active,
                                            b.c_zq_gzms,
                                            b.c_yhjzq_price_source,
                                            b.c_jyszq_price_source),
                     2) en_value,
               Round(decode(Nvl(g.En_Fund_Value, 0),
                            0,
                            0,
                            (((case
                              when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                               abs(a.l_Current_Amount)
                              else
                               a.l_current_amount
                            end) *
                            trade.sf_currency_rate(a.l_date,
                                                     d.vc_currency_no,
                                                     b.vc_currency_no,
                                                     b.l_fund_id,
                                                     b.l_set_no) *
                            trade.sf_avg_price_new(a.l_fund_id,
                                                     a.vc_inter_code,
                                                     a.c_invest_type,
                                                     0,
                                                     b.c_value_class,
                                                     '1',
                                                     b.c_out_bond_type,
                                                     0,
                                                     a.l_basecombi_id,
                                                     '1',
                                                     b.l_business_date,
                                                     b.c_invest_direction,
                                                     b.c_long_stop_type,
                                                     b.c_etf_value_type,
                                                     b.c_accountant_type,
                                                     b.c_bond_stop_type,
                                                     b.c_calculate_type,
                                                     b.c_class_bond_type,
                                                     d.c_Market_No,
                                                     d.c_Stock_Type,
                                                     d.Vc_Busin_Classes,
                                                     d.Vc_Mixed_Type,
                                                     d.En_Avg_Price,
                                                     d.En_Fair_Price2,
                                                     d.En_Yesterday_Close_Price,
                                                     d.En_Last_Price,
                                                     d.c_Long_Stop_Flag,
                                                     d.Vc_Asset_Relative_Code,
                                                     d.c_Stop_Flag,
                                                     d.l_total_lock_days,
                                                     d.l_left_lock_days,
                                                     d.c_Asset_Class,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     b.c_exchange_abs_type,
                                                     b.c_bank_abs_type,
                                                     b.c_exchange_net_type,
                                                     0,
                                                     d.vc_reference_fa_code,
                                                     a.c_position_flag,
                                                     b.c_inactive_type,
                                                     d.c_trade_active,
                                                     b.c_zq_gzms,
                                                     b.c_yhjzq_price_source,
                                                     b.c_jyszq_price_source) -
                            (case
                              when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                               abs(a.l_begin_amount)
                              else
                               a.l_begin_amount
                            end) *
                            trade.sf_currency_rate(trade.sf_get_tradedate(a.l_date,
                                                                            -1,
                                                                            2,
                                                                            d.c_market_no,
                                                                            a.l_fund_id),
                                                     d.vc_currency_no,
                                                     b.vc_currency_no,
                                                     b.l_fund_id,
                                                     b.l_set_no) *
                            trade.sf_avg_price_new(a.l_Fund_Id,
                                                     a.Vc_Inter_Code,
                                                     a.c_Invest_Type,
                                                     (select trade.sf_get_tradedate(a.l_date,
                                                                                    -1,
                                                                                    2,
                                                                                    d.c_market_no,
                                                                                    a.l_fund_id)
                                                        from dual),
                                                     b.c_value_class,
                                                     '1',
                                                     b.c_out_bond_type) *
                            (case
                              when ((j.c_stock_type = '(' or j.c_stock_type = ')') and
                                   (a.c_position_flag = 'b' or a.c_position_flag = '2')) then
                               -1
                              else
                               1
                            end)) * (case
                              when d.c_asset_class = '9' and a.c_position_flag = '2' then
                               -1
                              else
                               1
                            end) +
                            (a.en_sale_balance - a.en_buy_balance +
                            Nvl(f.en_today_dividend, 0)) *
                            trade.sf_currency_rate(a.l_date,
                                                    d.vc_currency_no,
                                                    b.vc_currency_no,
                                                    b.l_fund_id,
                                                    b.l_set_no)) /
                            g.en_fund_value) * 100,
                     4) en_dwyx_ratio,
               round((case
                       when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                        abs(a.l_current_amount)
                       else
                        a.l_current_amount
                     end) *
                     trade.sf_avg_price_new(a.l_fund_id,
                                            a.vc_inter_code,
                                            a.c_invest_type,
                                            0,
                                            b.c_value_class,
                                            '1',
                                            b.c_out_bond_type,
                                            0,
                                            a.l_basecombi_id,
                                            '1',
                                            b.l_business_date,
                                            b.c_invest_direction,
                                            b.c_long_stop_type,
                                            b.c_etf_value_type,
                                            b.c_accountant_type,
                                            b.c_bond_stop_type,
                                            b.c_calculate_type,
                                            b.c_class_bond_type,
                                            d.c_Market_No,
                                            d.c_Stock_Type,
                                            d.Vc_Busin_Classes,
                                            d.Vc_Mixed_Type,
                                            d.En_Avg_Price,
                                            d.En_Fair_Price2,
                                            d.En_Yesterday_Close_Price,
                                            d.En_Last_Price,
                                            d.c_Long_Stop_Flag,
                                            d.Vc_Asset_Relative_Code,
                                            d.c_Stop_Flag,
                                            d.l_total_lock_days,
                                            d.l_left_lock_days,
                                            d.c_Asset_Class,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            b.c_exchange_abs_type,
                                            b.c_bank_abs_type,
                                            b.c_exchange_net_type,
                                            0,
                                            d.vc_reference_fa_code,
                                            a.c_position_flag,
                                            b.c_inactive_type,
                                            d.c_trade_active,
                                            b.c_zq_gzms,
                                            b.c_yhjzq_price_source,
                                            b.c_jyszq_price_source),
                     2) en_value_JJ,
               round(d.en_avg_price, 4) en_avg_price,
               round(d.en_last_price, 4) en_last_price,
               0,
               a.en_accumulate_profit,
               a.l_buy_amount l_buy_amount,
               a.l_sale_amount l_sale_amount,
               (a.l_buy_amount - a.l_sale_amount) l_absbuy_amount,
               decode(a.l_buy_amount,
                      0,
                      0,
                      a.en_buy_balance /
                      (a.l_buy_amount *
                      decode(d.c_asset_class,
                              'a',
                              decode(o.L_MULTIPLIER_UNIT,
                                     0,
                                     1,
                                     nvl(o.L_MULTIPLIER_UNIT, 1)),
                              trade.sf_future_multiple(a.vc_inter_code)))) en_buy_price,
               d.en_yesterday_close_price,
               decode(a.l_sale_amount,
                      0,
                      0,
                      a.en_sale_balance /
                      (a.l_sale_amount *
                      decode(d.c_asset_class,
                              'a',
                              decode(o.L_MULTIPLIER_UNIT,
                                     0,
                                     1,
                                     nvl(o.L_MULTIPLIER_UNIT, 1)),
                              trade.sf_future_multiple(a.vc_inter_code)))) en_sale_price,
               a.en_buy_balance,
               a.en_sale_balance,
               (a.en_buy_balance - a.en_sale_balance) en_absbuy_balance,
               a.en_buy_fee,
               a.en_sale_fee,
               a.en_real_buy_fee,
               a.en_real_sale_fee,
               (a.en_real_buy_fee + a.en_real_sale_fee) en_total_fee,
               a.vc_bind_seat,
               nvl(f.en_today_dividend, 0) en_today_dividend,
               (nvl(f.en_today_dividend, 0) + nvl(f.en_total_dividend, 0)) en_total_dividend,
               nvl(f.l_dividend_right_amount, 0) l_dividend_right_amount,
               nvl(f.l_shareout_right, 0) l_shareout_right,
               nvl(f.l_today_shareout, 0) l_today_shareout,
               nvl(f.l_new_right_amount, 0) l_new_right_amount,
               (nvl(f.l_today_shareout, 0) + nvl(f.l_total_shareout, 0)) l_total_shareout,
               nvl(f.l_uncirculated_amount, 0) l_uncirculated_amount,
               nvl(f.l_yjuncirculated_amount, 0) l_yjuncirculated_amount,
               nvl(f.l_dividend_right_amount + f.l_today_shareout +
                   f.l_total_shareout + f.l_uncirculated_amount +
                   f.l_yjuncirculated_amount,
                   0) l_all_uncirculated_amount,
               d.c_asset_class vc_asset_name,
               a.l_current_amount + a.l_unfrozen_amount - a.l_frozen_amount l_usable_amount,
               a.en_current_impawn_amount en_current_impawn,
               a.en_pre_impawn_amount en_pre_impawn_amount,
               a.en_impawn_amount en_impawn_amount,
               a.en_pre_return_amount en_pre_return_amount,
               a.en_return_amount en_return_amount,
               a.c_invest_type c_invest_type,
               a.l_temp_frozen_amount l_temp_frozen_amount,
               a.l_temp_unfrozen_amount l_temp_unfrozen_amount,
               a.l_t1_temp_frozen_amount l_t1_temp_frozen_amount,
               a.l_t1_frozen_amount l_t1_frozen_amount,
               a.en_interest_invest en_interest_invest,
               a.en_turn_invest en_turn_invest_qc,
               a.en_turn_interest_invest en_turn_interest_invest,
               a.en_turn_profit en_turn_profit_qc,
               a.l_buy_unsettle_amount l_buy_unsettle_amount,
               a.l_sale_unsettle_amount l_sale_unsettle_amount,
               a.en_buy_unsettle_balance en_buy_unsettle_balance,
               a.en_sale_unsettle_balance en_sale_unsettle_balance,
               a.c_position_flag c_position_flag,
               a.c_position_flag c_position_direction,
               nvl(a.en_today_profit, 0) en_today_profit,
               nvl(a.en_current_cost, 0) en_current_cost,
               nvl(h.en_face_price, 0) en_face_price,
               nvl(h.en_curr_face_price, 0) en_curr_face_price,
               nvl(h.en_publish_price, 0) en_publish_price,
               nvl(h.en_exist_limite, 0) en_exist_limite,
               to_char(nvl(h.l_market_date, 0)) l_market_date,
               to_char(nvl(h.l_publish_date, 0)) l_publish_date,
               nvl(h.en_year_rate * 100, 0) en_year_rate,
               to_char(nvl(h.l_begincal_date, 0)) l_begincal_date,
               to_char(nvl(h.l_end_date, 0)) l_end_date,
               h.c_investor_operation_type,
               (case
                 when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                  abs(a.l_current_amount)
                 else
                  a.l_current_amount
               end) * trade.sf_avg_price_new(a.l_fund_id,
                                             a.vc_inter_code,
                                             a.c_invest_type,
                                             0,
                                             b.c_value_class,
                                             '1',
                                             b.c_out_bond_type,
                                             0,
                                             a.l_basecombi_id,
                                             '1',
                                             b.l_business_date,
                                             b.c_invest_direction,
                                             b.c_long_stop_type,
                                             b.c_etf_value_type,
                                             b.c_accountant_type,
                                             b.c_bond_stop_type,
                                             b.c_calculate_type,
                                             b.c_class_bond_type,
                                             d.c_Market_No,
                                             d.c_Stock_Type,
                                             d.Vc_Busin_Classes,
                                             d.Vc_Mixed_Type,
                                             d.En_Avg_Price,
                                             d.En_Fair_Price2,
                                             d.En_Yesterday_Close_Price,
                                             d.En_Last_Price,
                                             d.c_Long_Stop_Flag,
                                             d.Vc_Asset_Relative_Code,
                                             d.c_Stop_Flag,
                                             d.l_total_lock_days,
                                             d.l_left_lock_days,
                                             d.c_Asset_Class,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             null,
                                             b.c_exchange_abs_type,
                                             b.c_bank_abs_type,
                                             b.c_exchange_net_type,
                                             0,
                                             d.vc_reference_fa_code,
                                             a.c_position_flag,
                                             b.c_inactive_type,
                                             d.c_trade_active,
                                             b.c_zq_gzms,
                                             b.c_yhjzq_price_source,
                                             b.c_jyszq_price_source) *
               trade.sf_currency_rate(a.l_date,
                                      d.vc_currency_no,
                                      b.vc_currency_no,
                                      b.l_fund_id,
                                      b.l_set_no) en_value_currency,
               trade.sf_currency_rate(a.l_date,
                                      d.vc_currency_no,
                                      b.vc_currency_no,
                                      b.l_fund_id,
                                      b.l_set_no) en_currency_rate,
               (select a.vc_currency_name
                  from trade.tcurrencyinfo a
                 where a.vc_currency_no = d.vc_currency_no) vc_currency_name,
               decode(d.c_asset_class,
                      'a',
                      o.l_multiplier_unit,
                      trade.sf_future_multiple(a.vc_inter_code)) l_multiple,
               (case
                 when h.c_interest_type = '1' then
                  decode(sign(h.l_end_date - h.l_date),
                         -1,
                         0,
                         trade.sf_date_diff(h.l_date, h.l_end_date))
                 else
                  decode(Sign(h.l_End_Date -
                              trade.Sf_Next_Interest_Date(h.l_Begincal_Date,
                                                          h.En_Pay_Inteval)),
                         -1,
                         trade.Sf_Date_Diff(h.l_Date, h.l_End_Date),
                         decode(sign(trade.sf_next_interest_date(h.l_begincal_date,
                                                                 h.en_pay_inteval) -
                                     h.l_date),
                                -1,
                                0,
                                trade.sf_date_diff(h.l_date,
                                                   trade.sf_next_interest_date(h.l_begincal_date,
                                                                               h.en_pay_inteval))))
               end) / 365 l_left_term_year,
               (case
                 when h.c_interest_type = '1' then
                  decode(sign(h.l_end_date - h.l_date),
                         -1,
                         0,
                         trade.sf_date_diff(h.l_date, h.l_end_date))
                 else
                  decode(Sign(h.l_End_Date -
                              trade.Sf_Next_Interest_Date(h.l_Begincal_Date,
                                                          h.En_Pay_Inteval)),
                         -1,
                         trade.Sf_Date_Diff(h.l_Date, h.l_End_Date),
                         decode(sign(trade.sf_next_interest_date(h.l_begincal_date,
                                                                 h.en_pay_inteval) -
                                     h.l_date),
                                -1,
                                0,
                                trade.sf_date_diff(h.l_date,
                                                   trade.sf_next_interest_date(h.l_begincal_date,
                                                                               h.en_pay_inteval))))
               end) l_left_term,
               nvl(decode(d.c_asset_class,
                          '3',
                          trade.sf_get_bond_convexity(a.vc_inter_code,
                                                      d.en_last_price,
                                                      trade.sf_get_bond_yield(a.l_date,
                                                                              a.vc_inter_code,
                                                                              d.en_last_price),
                                                      a.l_date,
                                                      h.c_pay_interest_type,
                                                      h.c_interest_type,
                                                      h.en_curr_face_price,
                                                      h.en_pay_inteval,
                                                      h.en_exist_limite,
                                                      h.en_year_rate,
                                                      h.l_begincal_date,
                                                      h.l_end_date,
                                                      h.c_net_price,
                                                      h.en_bond_interest),
                          0),
                   0) en_bond_convexity,
               nvl(decode(d.c_asset_class,
                          '3',
                          trade.sf_get_bond_maturity(a.l_fund_id,
                                                     d.c_market_no,
                                                     a.vc_inter_code,
                                                     d.en_last_price,
                                                     a.l_date,
                                                     h.c_pay_interest_type,
                                                     h.c_interest_type,
                                                     h.en_curr_face_price,
                                                     h.en_pay_inteval,
                                                     h.en_exist_limite,
                                                     h.en_year_rate,
                                                     h.l_begincal_date,
                                                     h.l_end_date,
                                                     h.c_net_price,
                                                     h.en_bond_interest),
                          0),
                   0) en_bond_maturity,
               nvl(case
                     when (d.c_asset_class = '3' and
                          h.c_investor_operation_type <> '0' and
                          h.c_investor_operation_type is not null) then
                      trade.sf_get_bond_maturity(a.l_fund_id,
                                                 d.c_market_no,
                                                 a.vc_inter_code,
                                                 d.en_last_price,
                                                 a.l_date,
                                                 h.c_pay_interest_type,
                                                 h.c_interest_type,
                                                 h.en_curr_face_price,
                                                 h.en_pay_inteval,
                                                 h.en_exist_limite,
                                                 h.en_year_rate,
                                                 h.l_begincal_date,
                                                 case
                                                   when (h.l_Investor_Operation_Date is null or
                                                        h.l_Investor_Operation_Date = 0) then
                                                    h.l_end_date
                                                   else
                                                    h.l_Investor_Operation_Date
                                                 end,
                                                 h.c_net_price,
                                                 h.en_bond_interest)
                     else
                      0
                   end,
                   0) en_bond_maturity_xq,
               d.vc_mixed_type,
               d.c_asset_class,
               Nvl(a.En_Interest_Gain, 0) En_Interest_Gain,
               0 en_interest_gain_ysx,
               nvl(f.en_shareout_price, 0) en_shareout_price,
               to_char(trade.sf_next_interest_date(h.l_begincal_date,
                                                   h.en_pay_inteval)) l_next_interest_date,
               decode(sign(h.l_end_date - h.l_date),
                      -1,
                      0,
                      trade.sf_date_diff(h.l_date, h.l_end_date)) l_left_days,
               decode(sign(h.l_end_date - h.l_date),
                      -1,
                      0,
                      trade.sf_date_diff(h.l_date, h.l_end_date) / 365) l_left_days_year,
               z.vc_issuer_name,
               h.c_pay_interest_type,
               decode(d.c_asset_class,
                      '3',
                      round(100 *
                            trade.sf_get_bond_yield(a.l_date,
                                                    a.vc_inter_code,
                                                    d.en_last_price),
                            6)) en_bond_yield,
               Decode(d.c_Asset_Class,
                      '3',
                      Round(100 *
                            trade.Sf_Get_Bond_Yield(a.l_Date,
                                                    a.Vc_Inter_Code,
                                                    Decode((a.l_Current_Amount +
                                                           a.l_Sale_Amount),
                                                           0,
                                                           0,
                                                           (a.En_Untransfered_Invest +
                                                           a.En_Buy_Balance +
                                                           a.En_Buy_Fee) /
                                                           (a.l_Current_Amount +
                                                           a.l_Sale_Amount))),
                            3)) En_Bond_Yield_Cbj,
               (case
                 when d.c_asset_class = '3' and
                      h.c_investor_operation_type <> '0' then
                  round(100 *
                        trade.sf_get_bond_yield(a.l_date,
                                                a.vc_inter_code,
                                                d.en_last_price,
                                                h.l_investor_operation_date),
                        6)
               end) en_bond_yield_xq,
               nvl(EN_TRADING_FEE, 0) EN_TRADING_FEE,
               nvl(en_uncarryover_trading_fee, 0) en_uncarryover_trading_fee,
               ' ' vc_grouptype_name,
               ' ' vc_group_name,
               (select (case
                         when count(distinct tm.vc_group_name) <= 1 then
                          max(tm.vc_group_name)
                         else
                          '混合'
                       end)
                  from trade.taccountgroup tm, trade.tgroupfundcombi tg
                 where tm.l_group_id = tg.l_group_id
                   and tg.l_fund_id = a.l_fund_id
                   and tm.c_group_type = '2') vc_qry_group_name,
               nvl(h.en_pay_inteval, 0) en_pay_inteval,
               a.EN_TRADE_BALANCE,
               a.vc_inter_code,
               a.c_invest_type c_invest_type_no,
               decode(d.en_yesterday_close_price,
                      0,
                      0,
                      (d.en_max_price - en_min_price) /
                      d.en_yesterday_close_price * 100) en_UpDown_ratio,
               b.vc_currency_no vc_currency_no_bb,
               d.vc_international_code,
               d.vc_ric_code,
               d.vc_sedol_code,
               d.vc_cusip_code,
               d.vc_bloomberg_code,
               h.c_inside_appraise,
               to_char(h.l_investor_operation_date) l_investor_operation_date,
               to_char(h.l_publisher_operation_date) l_publisher_operation_date,
               --h.c_outer_appraise,
               (select t.vc_item_name
                  from trade.tdictionary t
                 where t.l_dictionary_no = '110000'
                   and t.c_lemma_item <> '!'
                   and t.c_lemma_item = h.c_outer_appraise) c_outer_appraise, --外部评级
               z.c_inside_appraise c_issuer_inside_appraise,
               --z.c_outer_appraise c_issuer_outer_appraise,
               (select t.vc_item_name
                  from trade.tdictionary t
                 where t.l_dictionary_no = '110000'
                   and t.c_lemma_item <> '!'
                   and t.c_lemma_item = z.c_outer_appraise) c_issuer_outer_appraise, --发行人外部评级
               decode(d.c_asset_class,
                      '3',
                      decode(h.c_net_price,
                             0,
                             nvl(d.en_last_price, 0),
                             nvl(d.en_last_price, 0) +
                             nvl(h.en_today_interest, 0)),
                      d.en_last_price) en_qj,
               decode(d.c_asset_class,
                      '3',
                      decode(h.c_net_price,
                             0,
                             nvl(d.en_last_price, 0) -
                             nvl(h.en_today_interest, 0),
                             nvl(d.en_last_price, 0)),
                      d.en_last_price) en_jj,
               nvl(h.en_real_interest, 0) en_real_interest,
               h.c_basic_rate_type,
               h.en_basic_rate * 100 en_basic_rate,
               tb.c_bonus_type,
               h.en_fair_yield_ratio * 100 en_fair_yield_ratio,
               nvl(a.en_interest_profit, 0) en_interest_profit,
               nvl(a.en_turn_interest_profit, 0) en_turn_interest_profit,
               b.vc_remarks,
               (Nvl(a.l_begin_amount, 0) +
               Nvl(f.l_Today_Dividend_Right_Amount, 0)) l_begin_amount,
               (case
                      when (a.l_current_amount + a.l_sale_amount) = 0 then
                       0
                      else
                       (a.en_turn_invest + a.en_buy_balance + a.en_buy_fee) /
                       (a.l_current_amount + a.l_sale_amount)
                    end) en_begin_cost_price,
               a.l_current_amount + a.l_prebuy_amount - a.l_presale_amount en_change_amount,
               b.l_end_date l_fund_enddate,
               sum((case
                     when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                      abs(a.l_current_amount)
                     else
                      a.l_current_amount
                   end) *
                   trade.sf_avg_price_new(a.l_fund_id,
                                          a.vc_inter_code,
                                          a.c_invest_type,
                                          0,
                                          b.c_value_class,
                                          '1',
                                          b.c_out_bond_type,
                                          0,
                                          a.l_basecombi_id,
                                          '1',
                                          b.l_business_date,
                                          b.c_invest_direction,
                                          b.c_long_stop_type,
                                          b.c_etf_value_type,
                                          b.c_accountant_type,
                                          b.c_bond_stop_type,
                                          b.c_calculate_type,
                                          b.c_class_bond_type,
                                          d.c_Market_No,
                                          d.c_Stock_Type,
                                          d.Vc_Busin_Classes,
                                          d.Vc_Mixed_Type,
                                          d.En_Avg_Price,
                                          d.En_Fair_Price2,
                                          d.En_Yesterday_Close_Price,
                                          d.En_Last_Price,
                                          d.c_Long_Stop_Flag,
                                          d.Vc_Asset_Relative_Code,
                                          d.c_Stop_Flag,
                                          d.l_total_lock_days,
                                          d.l_left_lock_days,
                                          d.c_Asset_Class,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          null,
                                          b.c_exchange_abs_type,
                                          b.c_bank_abs_type,
                                          b.c_exchange_net_type,
                                          0,
                                          d.vc_reference_fa_code,
                                          a.c_position_flag,
                                          b.c_inactive_type,
                                          d.c_trade_active,
                                          b.c_zq_gzms,
                                          b.c_yhjzq_price_source,
                                          b.c_jyszq_price_source)) over(partition by a.l_fund_id) en_total_value,
               0 en_value_ratio1,
               0 en_refer_cost,
               0 en_refer_fdyk,
               0 en_refer_syl,
               (case
                 when (a.l_current_amount + a.l_sale_amount) = 0 then
                  0
                 else
                  (a.en_turn_invest + a.en_buy_balance + a.en_buy_fee) /
                  (a.l_current_amount + a.l_sale_amount)
               end) en_his_cost_price,
               nvl(f.l_shareout_right * f.en_shareout_price, 0) en_shareout_balance,
               0 en_his_zongtiyk_balance,
               g.en_current_cash,
               Nvl(a.EN_UNCARRYOVER_REAL_COST, 0) EN_UNCARRYOVER_REAL_COST,
               b.vc_fund_caption,
               decode(d.c_asset_class,
                      '3',
                      nvl(h.EN_VALUATE_POINT_VALUE, 0),
                      0) en_valuate_point_value,
               decode(d.c_asset_class,
                      '3',
                      nvl(h.EN_VALUATE_POINT_VALUE, 0) * a.l_current_amount,
                      0) en_positions_point_value,
               
               decode(d.c_asset_class,
                      '9',
                      a.en_current_cost,
                      case
                        when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                             l_multiple = 0 then
                         0
                        else
                         (a.EN_UNTRANSFERED_INVEST + a.EN_BUY_BALANCE + a.en_buy_fee) *
                         (1 -
                         a.L_SALE_AMOUNT / (a.l_current_amount + a.L_SALE_AMOUNT))
                      end) d_dqcb, --当前成本             
               
               decode(d.c_asset_class,
                      '9',
                      0,
                      case
                        when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                             l_multiple = 0 then
                         0
                        else
                         (a.en_interest_invest +
                         a.L_BUY_AMOUNT *
                         nvl(h.en_today_interest *
                              (1 - (select nvl(k.en_interest_tax, 0.00)
                                      from trade.TBONDDETAILPROPERTY k
                                     where k.l_date = d.l_date
                                       and k.c_stock_type = d.c_stock_type
                                       and k.c_tax_type = b.c_tax_type)),
                              0.00)) * (1 - a.L_SALE_AMOUNT /
                         (a.l_current_amount + a.L_SALE_AMOUNT))
                      end) d_lxcb, --利息成本
               
               case
                 when d.c_asset_class = '3' then
                  decode(d.c_asset_class,
                         '9',
                         a.en_current_cost,
                         case
                           when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                                l_multiple = 0 then
                            0
                           else
                            (a.EN_UNTRANSFERED_INVEST + a.EN_BUY_BALANCE + a.en_buy_fee) *
                            (1 -
                            a.L_SALE_AMOUNT / (a.l_current_amount + a.L_SALE_AMOUNT))
                         end) + decode(d.c_asset_class,
                                       '9',
                                       0,
                                       case
                                         when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                                              l_multiple = 0 then
                                          0
                                         else
                                          (a.en_interest_invest +
                                          a.L_BUY_AMOUNT *
                                          nvl(h.en_today_interest *
                                               (1 - (select nvl(k.en_interest_tax, 0.00)
                                                       from trade.TBONDDETAILPROPERTY k
                                                      where k.l_date = d.l_date
                                                        and k.c_stock_type = d.c_stock_type
                                                        and k.c_tax_type = b.c_tax_type)),
                                               0.00)) * (1 - a.L_SALE_AMOUNT /
                                          (a.l_current_amount + a.L_SALE_AMOUNT))
                                       end)
                 else
                  decode(d.c_asset_class,
                         '9',
                         a.en_current_cost,
                         case
                           when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                                l_multiple = 0 then
                            0
                           else
                            (a.EN_UNTRANSFERED_INVEST + a.EN_BUY_BALANCE + a.en_buy_fee) *
                            (1 -
                            a.L_SALE_AMOUNT / (a.l_current_amount + a.L_SALE_AMOUNT))
                         end)
               end d_qjcb, --全价成本
               
               round((case
                       when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                        abs(a.l_current_amount)
                       else
                        a.l_current_amount
                     end) *
                     trade.sf_avg_price_new(a.l_fund_id,
                                            a.vc_inter_code,
                                            a.c_invest_type,
                                            0,
                                            b.c_value_class,
                                            '1',
                                            b.c_out_bond_type,
                                            0,
                                            a.l_basecombi_id,
                                            '1',
                                            b.l_business_date,
                                            b.c_invest_direction,
                                            b.c_long_stop_type,
                                            b.c_etf_value_type,
                                            b.c_accountant_type,
                                            b.c_bond_stop_type,
                                            b.c_calculate_type,
                                            b.c_class_bond_type,
                                            d.c_Market_No,
                                            d.c_Stock_Type,
                                            d.Vc_Busin_Classes,
                                            d.Vc_Mixed_Type,
                                            d.En_Avg_Price,
                                            d.En_Fair_Price2,
                                            d.En_Yesterday_Close_Price,
                                            d.En_Last_Price,
                                            d.c_Long_Stop_Flag,
                                            d.Vc_Asset_Relative_Code,
                                            d.c_Stop_Flag,
                                            d.l_total_lock_days,
                                            d.l_left_lock_days,
                                            d.c_Asset_Class,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            null,
                                            b.c_exchange_abs_type,
                                            b.c_bank_abs_type,
                                            b.c_exchange_net_type,
                                            0,
                                            d.vc_reference_fa_code,
                                            a.c_position_flag,
                                            b.c_inactive_type,
                                            d.c_trade_active,
                                            b.c_zq_gzms,
                                            b.c_yhjzq_price_source,
                                            b.c_jyszq_price_source),
                     2) d_jjsz, --净价市值 
               
               decode(a.l_current_amount,
                      0,
                      0,
                      case
                        when d.c_asset_class = '3' then
                         round((case
                                 when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                                  abs(a.l_current_amount)
                                 else
                                  a.l_current_amount
                               end) *
                               trade.sf_avg_price_new(a.l_fund_id,
                                                      a.vc_inter_code,
                                                      a.c_invest_type,
                                                      0,
                                                      b.c_value_class,
                                                      '1',
                                                      b.c_out_bond_type,
                                                      0,
                                                      a.l_basecombi_id,
                                                      '1',
                                                      b.l_business_date,
                                                      b.c_invest_direction,
                                                      b.c_long_stop_type,
                                                      b.c_etf_value_type,
                                                      b.c_accountant_type,
                                                      b.c_bond_stop_type,
                                                      b.c_calculate_type,
                                                      b.c_class_bond_type,
                                                      d.c_Market_No,
                                                      d.c_Stock_Type,
                                                      d.Vc_Busin_Classes,
                                                      d.Vc_Mixed_Type,
                                                      d.En_Avg_Price,
                                                      d.En_Fair_Price2,
                                                      d.En_Yesterday_Close_Price,
                                                      d.En_Last_Price,
                                                      d.c_Long_Stop_Flag,
                                                      d.Vc_Asset_Relative_Code,
                                                      d.c_Stop_Flag,
                                                      d.l_total_lock_days,
                                                      d.l_left_lock_days,
                                                      d.c_Asset_Class,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      b.c_exchange_abs_type,
                                                      b.c_bank_abs_type,
                                                      b.c_exchange_net_type,
                                                      0,
                                                      d.vc_reference_fa_code,
                                                      a.c_position_flag,
                                                      b.c_inactive_type,
                                                      d.c_trade_active,
                                                      b.c_zq_gzms,
                                                      b.c_yhjzq_price_source,
                                                      b.c_jyszq_price_source),
                               2) +
                         nvl(h.en_today_interest *
                             (1 - (select nvl(k.en_interest_tax, 0.00)
                                     from trade.TBONDDETAILPROPERTY k
                                    where k.l_date = d.l_date
                                      and k.c_stock_type = d.c_stock_type
                                      and k.c_tax_type = b.c_tax_type)),
                             0.00) * a.l_current_amount
                        else
                         round((case
                                 when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                                  abs(a.l_current_amount)
                                 else
                                  a.l_current_amount
                               end) *
                               trade.sf_avg_price_new(a.l_fund_id,
                                                      a.vc_inter_code,
                                                      a.c_invest_type,
                                                      0,
                                                      b.c_value_class,
                                                      '1',
                                                      b.c_out_bond_type,
                                                      0,
                                                      a.l_basecombi_id,
                                                      '1',
                                                      b.l_business_date,
                                                      b.c_invest_direction,
                                                      b.c_long_stop_type,
                                                      b.c_etf_value_type,
                                                      b.c_accountant_type,
                                                      b.c_bond_stop_type,
                                                      b.c_calculate_type,
                                                      b.c_class_bond_type,
                                                      d.c_Market_No,
                                                      d.c_Stock_Type,
                                                      d.Vc_Busin_Classes,
                                                      d.Vc_Mixed_Type,
                                                      d.En_Avg_Price,
                                                      d.En_Fair_Price2,
                                                      d.En_Yesterday_Close_Price,
                                                      d.En_Last_Price,
                                                      d.c_Long_Stop_Flag,
                                                      d.Vc_Asset_Relative_Code,
                                                      d.c_Stop_Flag,
                                                      d.l_total_lock_days,
                                                      d.l_left_lock_days,
                                                      d.c_Asset_Class,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      b.c_exchange_abs_type,
                                                      b.c_bank_abs_type,
                                                      b.c_exchange_net_type,
                                                      0,
                                                      d.vc_reference_fa_code,
                                                      a.c_position_flag,
                                                      b.c_inactive_type,
                                                      d.c_trade_active,
                                                      b.c_zq_gzms,
                                                      b.c_yhjzq_price_source,
                                                      b.c_jyszq_price_source),
                               2)
                      end) d_qjsz, --全价市值 
               
               case
                 when d.c_asset_class = '9' then
                  (round((case
                           when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                            abs(a.l_current_amount)
                           else
                            a.l_current_amount
                         end) *
                         trade.sf_avg_price_new(a.l_fund_id,
                                                a.vc_inter_code,
                                                a.c_invest_type,
                                                0,
                                                b.c_value_class,
                                                '1',
                                                b.c_out_bond_type,
                                                0,
                                                a.l_basecombi_id,
                                                '1',
                                                b.l_business_date,
                                                b.c_invest_direction,
                                                b.c_long_stop_type,
                                                b.c_etf_value_type,
                                                b.c_accountant_type,
                                                b.c_bond_stop_type,
                                                b.c_calculate_type,
                                                b.c_class_bond_type,
                                                d.c_Market_No,
                                                d.c_Stock_Type,
                                                d.Vc_Busin_Classes,
                                                d.Vc_Mixed_Type,
                                                d.En_Avg_Price,
                                                d.En_Fair_Price2,
                                                d.En_Yesterday_Close_Price,
                                                d.En_Last_Price,
                                                d.c_Long_Stop_Flag,
                                                d.Vc_Asset_Relative_Code,
                                                d.c_Stop_Flag,
                                                d.l_total_lock_days,
                                                d.l_left_lock_days,
                                                d.c_Asset_Class,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                null,
                                                b.c_exchange_abs_type,
                                                b.c_bank_abs_type,
                                                b.c_exchange_net_type,
                                                0,
                                                d.vc_reference_fa_code,
                                                a.c_position_flag,
                                                b.c_inactive_type,
                                                d.c_trade_active,
                                                b.c_zq_gzms,
                                                b.c_yhjzq_price_source,
                                                b.c_jyszq_price_source),
                         2) - a.en_current_cost) * case
                    when a.l_current_amount < 0 then
                     -1
                    when a.c_position_flag = '1' then
                     1
                    else
                     -1
                  end
                 else
                  round((case
                          when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                           abs(a.l_current_amount)
                          else
                           a.l_current_amount
                        end) *
                        trade.sf_avg_price_new(a.l_fund_id,
                                               a.vc_inter_code,
                                               a.c_invest_type,
                                               0,
                                               b.c_value_class,
                                               '1',
                                               b.c_out_bond_type,
                                               0,
                                               a.l_basecombi_id,
                                               '1',
                                               b.l_business_date,
                                               b.c_invest_direction,
                                               b.c_long_stop_type,
                                               b.c_etf_value_type,
                                               b.c_accountant_type,
                                               b.c_bond_stop_type,
                                               b.c_calculate_type,
                                               b.c_class_bond_type,
                                               d.c_Market_No,
                                               d.c_Stock_Type,
                                               d.Vc_Busin_Classes,
                                               d.Vc_Mixed_Type,
                                               d.En_Avg_Price,
                                               d.En_Fair_Price2,
                                               d.En_Yesterday_Close_Price,
                                               d.En_Last_Price,
                                               d.c_Long_Stop_Flag,
                                               d.Vc_Asset_Relative_Code,
                                               d.c_Stop_Flag,
                                               d.l_total_lock_days,
                                               d.l_left_lock_days,
                                               d.c_Asset_Class,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               null,
                                               b.c_exchange_abs_type,
                                               b.c_bank_abs_type,
                                               b.c_exchange_net_type,
                                               0,
                                               d.vc_reference_fa_code,
                                               a.c_position_flag,
                                               b.c_inactive_type,
                                               d.c_trade_active,
                                               b.c_zq_gzms,
                                               b.c_yhjzq_price_source,
                                               b.c_jyszq_price_source),
                        2) - decode(d.c_asset_class,
                                    '9',
                                    a.en_current_cost,
                                    case
                                      when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                                           l_multiple = 0 then
                                       0
                                      else
                                       (a.EN_UNTRANSFERED_INVEST + a.EN_BUY_BALANCE + a.en_buy_fee) *
                                       (1 -
                                       a.L_SALE_AMOUNT / (a.l_current_amount + a.L_SALE_AMOUNT))
                                    end)
               end d_jjfy, --净价浮盈   
               
               case
                 when a.l_current_amount = 0 then
                  0
                 else
                  case
                    when d.c_asset_class = '3' then
                     round((case
                             when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                              abs(a.l_current_amount)
                             else
                              a.l_current_amount
                           end) *
                           trade.sf_avg_price_new(a.l_fund_id,
                                                  a.vc_inter_code,
                                                  a.c_invest_type,
                                                  0,
                                                  b.c_value_class,
                                                  '1',
                                                  b.c_out_bond_type,
                                                  0,
                                                  a.l_basecombi_id,
                                                  '1',
                                                  b.l_business_date,
                                                  b.c_invest_direction,
                                                  b.c_long_stop_type,
                                                  b.c_etf_value_type,
                                                  b.c_accountant_type,
                                                  b.c_bond_stop_type,
                                                  b.c_calculate_type,
                                                  b.c_class_bond_type,
                                                  d.c_Market_No,
                                                  d.c_Stock_Type,
                                                  d.Vc_Busin_Classes,
                                                  d.Vc_Mixed_Type,
                                                  d.En_Avg_Price,
                                                  d.En_Fair_Price2,
                                                  d.En_Yesterday_Close_Price,
                                                  d.En_Last_Price,
                                                  d.c_Long_Stop_Flag,
                                                  d.Vc_Asset_Relative_Code,
                                                  d.c_Stop_Flag,
                                                  d.l_total_lock_days,
                                                  d.l_left_lock_days,
                                                  d.c_Asset_Class,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  null,
                                                  b.c_exchange_abs_type,
                                                  b.c_bank_abs_type,
                                                  b.c_exchange_net_type,
                                                  0,
                                                  d.vc_reference_fa_code,
                                                  a.c_position_flag,
                                                  b.c_inactive_type,
                                                  d.c_trade_active,
                                                  b.c_zq_gzms,
                                                  b.c_yhjzq_price_source,
                                                  b.c_jyszq_price_source),
                           2) +
                     nvl(h.en_today_interest *
                         (1 - (select nvl(k.en_interest_tax, 0.00)
                                 from trade.TBONDDETAILPROPERTY k
                                where k.l_date = d.l_date
                                  and k.c_stock_type = d.c_stock_type
                                  and k.c_tax_type = b.c_tax_type)),
                         0.00) * a.l_current_amount - case
                       when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                            l_multiple = 0 then
                        0
                       else
                        (a.EN_UNTRANSFERED_INVEST + a.EN_BUY_BALANCE + a.en_buy_fee) *
                        (1 -
                        a.L_SALE_AMOUNT / (a.l_current_amount + a.L_SALE_AMOUNT))
                     end - case
                       when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                            decode(d.c_asset_class,
                                   'a',
                                   o.l_multiplier_unit,
                                   trade.sf_future_multiple(a.vc_inter_code)) = 0 then
                        0
                       else
                        (a.en_interest_invest +
                        a.L_BUY_AMOUNT *
                        nvl(h.en_today_interest *
                             (1 - (select nvl(k.en_interest_tax, 0.00)
                                     from trade.TBONDDETAILPROPERTY k
                                    where k.l_date = d.l_date
                                      and k.c_stock_type = d.c_stock_type
                                      and k.c_tax_type = b.c_tax_type)),
                             0.00)) * (1 - a.L_SALE_AMOUNT /
                        (a.l_current_amount + a.L_SALE_AMOUNT))
                     end
                    else
                     case
                       when d.c_asset_class = '9' then
                        (round((case
                                 when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                                  abs(a.l_current_amount)
                                 else
                                  a.l_current_amount
                               end) *
                               trade.sf_avg_price_new(a.l_fund_id,
                                                      a.vc_inter_code,
                                                      a.c_invest_type,
                                                      0,
                                                      b.c_value_class,
                                                      '1',
                                                      b.c_out_bond_type,
                                                      0,
                                                      a.l_basecombi_id,
                                                      '1',
                                                      b.l_business_date,
                                                      b.c_invest_direction,
                                                      b.c_long_stop_type,
                                                      b.c_etf_value_type,
                                                      b.c_accountant_type,
                                                      b.c_bond_stop_type,
                                                      b.c_calculate_type,
                                                      b.c_class_bond_type,
                                                      d.c_Market_No,
                                                      d.c_Stock_Type,
                                                      d.Vc_Busin_Classes,
                                                      d.Vc_Mixed_Type,
                                                      d.En_Avg_Price,
                                                      d.En_Fair_Price2,
                                                      d.En_Yesterday_Close_Price,
                                                      d.En_Last_Price,
                                                      d.c_Long_Stop_Flag,
                                                      d.Vc_Asset_Relative_Code,
                                                      d.c_Stop_Flag,
                                                      d.l_total_lock_days,
                                                      d.l_left_lock_days,
                                                      d.c_Asset_Class,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      null,
                                                      b.c_exchange_abs_type,
                                                      b.c_bank_abs_type,
                                                      b.c_exchange_net_type,
                                                      0,
                                                      d.vc_reference_fa_code,
                                                      a.c_position_flag,
                                                      b.c_inactive_type,
                                                      d.c_trade_active,
                                                      b.c_zq_gzms,
                                                      b.c_yhjzq_price_source,
                                                      b.c_jyszq_price_source),
                               2) - a.en_current_cost) * case
                          when a.l_current_amount < 0 then
                           -1
                          when a.c_position_flag = '1' then
                           1
                          else
                           -1
                        end
                       else
                        round((case
                                when d.c_market_no = 'Y' and j.c_stock_type = 'R' then
                                 abs(a.l_current_amount)
                                else
                                 a.l_current_amount
                              end) *
                              trade.sf_avg_price_new(a.l_fund_id,
                                                     a.vc_inter_code,
                                                     a.c_invest_type,
                                                     0,
                                                     b.c_value_class,
                                                     '1',
                                                     b.c_out_bond_type,
                                                     0,
                                                     a.l_basecombi_id,
                                                     '1',
                                                     b.l_business_date,
                                                     b.c_invest_direction,
                                                     b.c_long_stop_type,
                                                     b.c_etf_value_type,
                                                     b.c_accountant_type,
                                                     b.c_bond_stop_type,
                                                     b.c_calculate_type,
                                                     b.c_class_bond_type,
                                                     d.c_Market_No,
                                                     d.c_Stock_Type,
                                                     d.Vc_Busin_Classes,
                                                     d.Vc_Mixed_Type,
                                                     d.En_Avg_Price,
                                                     d.En_Fair_Price2,
                                                     d.En_Yesterday_Close_Price,
                                                     d.En_Last_Price,
                                                     d.c_Long_Stop_Flag,
                                                     d.Vc_Asset_Relative_Code,
                                                     d.c_Stop_Flag,
                                                     d.l_total_lock_days,
                                                     d.l_left_lock_days,
                                                     d.c_Asset_Class,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     null,
                                                     b.c_exchange_abs_type,
                                                     b.c_bank_abs_type,
                                                     b.c_exchange_net_type,
                                                     0,
                                                     d.vc_reference_fa_code,
                                                     a.c_position_flag,
                                                     b.c_inactive_type,
                                                     d.c_trade_active,
                                                     b.c_zq_gzms,
                                                     b.c_yhjzq_price_source,
                                                     b.c_jyszq_price_source),
                              2) - decode(d.c_asset_class,
                                          '9',
                                          a.en_current_cost,
                                          case
                                            when (a.l_current_amount + a.L_SALE_AMOUNT) = 0 or
                                                 l_multiple = 0 then
                                             0
                                            else
                                             (a.EN_UNTRANSFERED_INVEST + a.EN_BUY_BALANCE + a.en_buy_fee) *
                                             (1 -
                                             a.L_SALE_AMOUNT / (a.l_current_amount + a.L_SALE_AMOUNT))
                                          end)
                     end
                  end
               end d_qjfy, --全价浮盈 --全价浮盈 = 全价市值 - 净价成本 - 利息成本
               
               case
                 when a.l_current_amount + a.l_sale_amount = 0 then
                  0
                 else
                  (a.l_current_amount *
                  trade.sf_avg_price(a.l_fund_id,
                                      a.vc_inter_code,
                                      a.c_invest_type,
                                      0,
                                      0,
                                      1,
                                      0,
                                      0,
                                      a.l_basecombi_id) -
                  decode(d.c_stock_type,
                          'R',
                          a.en_current_cost,
                          (a.en_untransfered_invest + a.en_buy_balance +
                          a.en_buy_fee) /
                          (a.l_current_amount + a.l_sale_amount) *
                          a.l_current_amount)) *
                  decode(a.c_position_flag, '1', 1, -1)
               end en_float_profit, --浮动盈亏
               
               case
                 when a.l_current_amount + a.l_sale_amount = 0 then
                  null
                 else
                  a.en_accumulate_profit +
                  decode(d.c_stock_type,
                         'R',
                         a.en_today_profit,
                         a.en_sale_balance - a.en_sale_fee -
                         a.l_sale_amount * (a.en_untransfered_invest +
                         a.en_buy_balance + a.en_buy_fee) /
                         (a.l_current_amount + a.l_sale_amount))
               end en_accumulate_profit_new, --累计盈亏
               
               case
                 when a.l_current_amount + a.l_sale_amount = 0 then
                  null
                 else
                  decode(d.c_stock_type,
                         'R',
                         a.en_current_cost,
                         (a.en_untransfered_invest + a.en_buy_balance +
                         a.en_buy_fee) /
                         (a.l_current_amount + a.l_sale_amount) *
                         a.l_current_amount)
               end en_current_cost_now, --当前成本
               
               case
                 when (d.c_stock_type in ('8', '9') or d.c_asset_class = '5') then
                  0
                 when (a.l_current_amount = 0) or
                      (a.l_current_amount + a.l_sale_amount = 0) then
                  0
                 else
                  ((case
                    when d.c_market_no = 'Y' and d.c_stock_type = 'R' then
                     abs(a.l_current_amount)
                    else
                     a.l_current_amount
                  end) * TRADE.sf_avg_price_new(a.l_fund_id,
                                                             a.vc_inter_code,
                                                             a.c_invest_type,
                                                             a.l_date,
                                                             b.c_value_class,
                                                             '1',
                                                             b.c_out_bond_type,
                                                             0,
                                                             a.l_basecombi_id,
                                                             '1',
                                                             b.l_business_date,
                                                             b.c_invest_direction,
                                                             b.c_long_stop_type,
                                                             b.c_etf_value_type,
                                                             b.c_accountant_type,
                                                             b.c_bond_stop_type,
                                                             b.c_calculate_type,
                                                             b.c_class_bond_type,
                                                             d.c_Market_No,
                                                             d.c_Stock_Type,
                                                             d.Vc_Busin_Classes,
                                                             d.Vc_Mixed_Type,
                                                             d.En_Avg_Price,
                                                             d.En_Fair_Price2,
                                                             d.En_Yesterday_Close_Price,
                                                             d.En_Last_Price,
                                                             d.c_Long_Stop_Flag,
                                                             d.Vc_Asset_Relative_Code,
                                                             d.c_Stop_Flag,
                                                             d.l_total_lock_days,
                                                             d.l_left_lock_days,
                                                             d.c_Asset_Class,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             null,
                                                             b.c_exchange_abs_type,
                                                             b.c_bank_abs_type,
                                                             b.c_exchange_net_type,
                                                             0,
                                                             d.vc_reference_fa_code,
                                                             a.c_position_flag,
                                                             b.c_inactive_type,
                                                             d.c_trade_active,
                                                             b.c_zq_gzms,
                                                             b.c_yhjzq_price_source,
                                                             b.c_jyszq_price_source,
                                                             0,
                                                             '')) - case
                    when d.c_asset_class <> '9' then
                     ((a.EN_UNTRANSFERED_INVEST + a.en_buy_balance +
                     a.EN_BUY_FEE) * a.l_current_amount /
                     (a.l_current_amount + a.l_sale_amount))
                    else
                     nvl(a.en_current_cost, 0)
                  end
               end * decode(a.C_POSITION_FLAG, '2', -1, 'b', -1, 1) en_float_profit_now --当日浮动盈亏
               
          from trade.Tunitstock a,
               trade.tstockmarketinfo d,
               (select tc.vc_inter_code, tc.vc_custom_class
                  from trade.TCUSTOMCLASS tc
                 where tc.l_org_id = 0) tc,
               trade.tBONDPROPERTY h,
               trade.toptionproperty o,
               trade.tfuturesinfo ft,
               trade.TSPECSTOCK f,
               trade.vfundasset g,
               trade.TFUNDINFO b,
               trade.TCOMBI c,
               trade.tfundbonusoption tb,
               trade.tasset i,
               trade.tstocktype j,
               trade.TISSUER z,
               (select ta.l_date,
                       ta.l_asset_id,
                       sum(ta.en_asset_value *
                           trade.sf_currency_rate(ta.l_date,
                                                  ta.vc_currency_no,
                                                  tf.vc_currency_no,
                                                  tf.l_fund_id,
                                                  tf.l_set_no)) en_asset_value
                  from trade.tassetday ta, trade.tfundinfo tf
                 where ta.l_fund_id = tf.l_fund_id
                 group by ta.l_date, ta.l_asset_id) k,
               (select t.vc_inter_code, min(t.l_pay_date) l_pay_date
                  from trade.tbondpayratio t
                 group by t.vc_inter_code) bpr
         where a.l_basecombi_id = c.l_combi_id
           and a.l_fund_id = b.l_fund_id
           and a.l_asset_id = i.l_asset_id
           and a.vc_inter_code = d.vc_inter_code
           and a.l_date = d.l_date
           and a.l_unit_id = f.l_unit_id(+)
           and a.l_date = g.l_date(+)
           and a.l_fund_id = g.l_fund_id(+)
           and a.l_date = h.l_date(+)
           and a.vc_inter_code = h.vc_inter_code(+)
           and a.l_date = o.l_date(+)
           and a.vc_inter_code = o.vc_inter_code(+)
           and d.c_stock_type = j.c_stock_type
           and d.c_market_no = j.c_market_no
           and a.l_date = k.l_date
           and a.l_asset_id = k.l_asset_id
           and d.l_company_id = z.l_issuer_id(+)
           and d.vc_inter_code = tc.vc_inter_code(+)
           and a.l_basecombi_id = tb.l_basecombi_id(+)
           and a.l_fund_id = tb.l_fund_id(+)
           and a.c_invest_type = tb.c_invest_type(+)
           and a.vc_inter_code = tb.vc_inter_code(+)
           and a.vc_inter_code = bpr.vc_inter_code(+)
           and a.l_date = ft.l_date(+)
           and a.vc_inter_code = ft.vc_inter_code(+)
           and c.c_combi_status not in ('2', '3')
           and ((a.l_buy_amount + a.l_sale_amount) <> 0 or
               a.l_current_amount <> 0)
           and d.c_asset_class in
               ('1', '2', '3', '4', '5', '7', '8', '9', 'a')
           and a.C_POSITION_FLAG not in ('7', 'c', 'd')
           and a.l_date >= PARAM_BUSI_DATE_TODAY
           and a.l_date <= PARAM_BUSI_DATE_TODAY) tt1
 where 1 = 1
      --and tt1.vc_fund_code in ('CJ0284')
--and tt1.VC_FUND_NAME like '%创金合信超精选%'
--and tt1.VC_COMBI_NO in ('3239_001')
--and tt1.vc_report_code like '%%'
--and tt1.vc_stock_name like '%长盈精密%'
--and tt1.C_MARKET_NO = '2'
--order by tt1.L_FUND_ID asc, tt1.VC_REPORT_CODE asc
