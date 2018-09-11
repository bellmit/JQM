--机器猫-综合报表-交易流水查询-银行间成交回报-当天：O32-信息查询-综合信息查询-银行间成交回报[E]-当天（20180202）
select t.L_DATE, --成交日期
       t.L_TIME, --成交时间
       t.VC_DEAL_NO, --成交编号
       t.L_SERIAL_NO, --成交序号
       t.L_FUND_ID, --基金序号
       t.VC_FUND_CODE, --基金代码
       t.VC_FUND_NAME, --基金名称
       t.VC_COMBI_NO, --组合代码
       t.VC_COMBI_NAME, --组合名称
       t.VC_REPORT_CODE, --证券代码
       t.VC_STOCK_NAME, --证券名称
       t.L_OPERATOR_NO, --操作员代码
       t.VC_ENTRUSTDIR_NAME, --委托方向名称
       t.VC_OPERATOR_NAME, --操作员名称
       t.C_INVEST_TYPE, --投资类型
       t.EN_RATE, --回购利率
       t.L_DEAL_AMOUNT, --成交数量
       t.EN_YESTERDAY_CLOSE_PRICE, --昨收盘价
       t.EN_JGPL,
       t.EN_FAIR_YIELD_RATIO, --公允收益率
       t.EN_FIRST_NET_PRICE, --首次交易净价价格
       t.EN_FIRST_FULL_PRICE, --首次交易全价价格
       t.EN_FIRST_CLEAR_BALANCE, --首次资金清算额
       t.EN_SECOND_CLEAR_BALANCE, --到期资金清算额
       t.EN_FEE, --费用
       t.L_HG_DAYS, --回购天数
       t.L_USE_DAYS, --实际占款天数
       t.L_SETTLE_SPEED, --清算速度
       t.L_FIRST_SETTLE_DATE_BOND,
       t.C_FIRST_SETTLE_TYPE_BOND,
       t.L_FIRST_SETTLE_DATE, --首次交割日
       t.L_SECOND_SETTLE_DATE, --到期交割日
       t.C_FUND_TYPE, --基金类型
       t.C_FIRST_SETTLE_TYPE, --首次交割方式
       t.C_SECOND_SETTLE_TYPE, --到期交割方式
       t.L_TRADE_RIVAL_NO, --交易对手
       t.l_trade_rival_name, --交易对手名称
       t.C_STATUS, --状态
       t.L_DAILY_INSTRUCTION_NO, --指令序号
       t.EN_SECOND_MATURE_YIELD, --到期收益率
       t.EN_CZ_MATURE_FAIR, --到期收益率(%)-公允收益率(%)
       t.VC_DIRECT_OPERATOR_NAME, --指令下达人
       t.C_BUSIN_CLASS, --业务分类
       t.VC_REMARK, --备注
       t.C_TRADE_TYPE, --成交类别
       t.C_TRUSTEE, --托管机构
       t.c_trusteeName, --托管机构名称
       t.C_INSIDE_APPRAISE, --内部评级
       t.C_OUTER_APPRAISE, --外部评级
       t.VC_RIVALTRADER_NAME --对手方交易员中文名称 
  from (select t.L_DATE, --成交日期
               t.L_TIME, --成交时间
               t.VC_DEAL_NO, --成交编号
               t.L_SERIAL_NO, --成交序号
               t.L_FUND_ID, --基金序号
               t.VC_FUND_CODE, --基金代码
               t.VC_FUND_NAME, --基金名称
               t.VC_COMBI_NO, --组合代码
               t.VC_COMBI_NAME, --组合名称
               t.VC_REPORT_CODE, --证券代码
               t.VC_STOCK_NAME, --证券名称
               t.L_OPERATOR_NO, --操作员代码
               t.VC_ENTRUSTDIR_NAME, --委托方向名称
               t.VC_OPERATOR_NAME, --操作员名称
               t.C_INVEST_TYPE, --投资类型
               t.EN_RATE, --回购利率
               t.L_DEAL_AMOUNT, --成交数量
               t.EN_YESTERDAY_CLOSE_PRICE, --昨收盘价
               t.EN_JGPL,
               t.EN_FAIR_YIELD_RATIO, --公允收益率
               t.EN_FIRST_NET_PRICE, --首次交易净价价格
               t.EN_FIRST_FULL_PRICE, --首次交易全价价格
               t.EN_FIRST_CLEAR_BALANCE, --首次资金清算额
               t.EN_SECOND_CLEAR_BALANCE, --到期资金清算额
               t.EN_FEE, --费用
               t.L_HG_DAYS, --回购天数
               t.L_USE_DAYS, --实际占款天数
               t.L_SETTLE_SPEED, --清算速度
               t.L_FIRST_SETTLE_DATE_BOND,
               t.C_FIRST_SETTLE_TYPE_BOND,
               t.L_FIRST_SETTLE_DATE, --首次交割日
               t.L_SECOND_SETTLE_DATE, --到期交割日
               t.C_FUND_TYPE, --基金类型
               t.C_FIRST_SETTLE_TYPE, --首次交割方式
               t.C_SECOND_SETTLE_TYPE, --到期交割方式
               t.L_TRADE_RIVAL_NO, --交易对手
               (select t.vc_name
                  from trade.ttraderival t
                 where t.l_rival_id = t.L_TRADE_RIVAL_NO) l_trade_rival_name, --交易对手
               t.C_STATUS, --状态
               t.L_DAILY_INSTRUCTION_NO, --指令序号
               t.EN_SECOND_MATURE_YIELD, --到期收益率
               t.EN_CZ_MATURE_FAIR, --到期收益率(%)-公允收益率(%)
               t.VC_DIRECT_OPERATOR_NAME, --指令下达人
               t.C_BUSIN_CLASS, --业务分类
               t.VC_REMARK, --备注
               t.C_TRADE_TYPE, --成交类别
               t.C_TRUSTEE, --托管机构
               (select td.vc_item_name
                  from trade.tdictionary td
                 where td.l_dictionary_no = '10075'
                   and td.c_lemma_item = t.C_TRUSTEE) c_trusteeName, --托管机构,具体值域见数据字典10075
               t.C_INSIDE_APPRAISE, --内部评级
               t.C_OUTER_APPRAISE, --外部评级
               t.VC_RIVALTRADER_NAME --对手方交易员中文名称
          from (select /*+ #HINT#41# */
                distinct to_char(a.l_date) l_date,
                         a.l_time l_time,
                         a.vc_deal_no,
                         a.l_Serial_No,
                         a.l_fund_id,
                         decode(a.l_fund_id, '-1', '缺省', d.vc_fund_code) vc_fund_code, --基金代码
                         decode(a.l_fund_id, '-1', '缺省', d.vc_fund_name) vc_fund_name,
                         decode(a.l_basecombi_id, '-1', '缺省', e.vc_combi_no) vc_combi_no,
                         decode(a.l_basecombi_id,
                                '-1',
                                '缺省',
                                e.vc_combi_name) vc_combi_name,
                         b.vc_report_code,
                         b.vc_stock_name,
                         c.l_operator_no,
                         d.c_fund_type,
                         Case
                           When g.c_entrust_direction = '5' And
                                b.c_stock_type = 'z' Then
                            '信用拆入'
                           When g.c_entrust_direction = '6' And
                                b.c_stock_type = 'z' Then
                            '信用拆出'
                           Else
                            g.Vc_Entrustdir_Name
                         End Vc_Entrustdir_Name,
                         f.vc_operator_name,
                         a.c_invest_type,
                         a.en_rate,
                         Case
                           When b.c_market_no <> '5' Then
                            decode(b.en_face_values,
                                   0,
                                   a.En_Balance / 100,
                                   a.En_Balance / b.en_face_values)
                           Else
                            a.En_Balance / 100
                         End l_deal_amount,
                         b.EN_YESTERDAY_CLOSE_PRICE,
                         round(decode(b.EN_YESTERDAY_CLOSE_PRICE,
                                      0,
                                      0,
                                      (a.En_First_Full_Price -
                                      b.EN_YESTERDAY_CLOSE_PRICE) /
                                      b.EN_YESTERDAY_CLOSE_PRICE) * 100,
                               2) en_jgpl,
                         round(nvl(th.En_Fair_Yield_Ratio, 0) * 100, 2) En_Fair_Yield_Ratio,
                         a.en_first_net_price,
                         a.en_first_full_price,
                         a.en_first_clear_balance,
                         a.en_second_clear_balance,
                         a.en_fee,
                         a.l_hg_days,
                         a.l_use_days,
                         to_char(a.l_settle_speed) l_settle_speed,
                         (case
                           when a.c_entrust_direction in ('3', '4') then
                            to_char(a.l_first_settle_date)
                           else
                            ' '
                         end) l_first_settle_date_bond,
                         (case
                           when a.c_entrust_direction in ('3', '4') then
                            a.c_first_settle_type
                           else
                            ' '
                         end) c_first_settle_type_bond,
                         (case
                           when a.c_entrust_direction in ('5', '6') then
                            to_char(a.l_first_settle_date)
                           else
                            ' '
                         end) l_first_settle_date,
                         to_char(a.l_second_settle_date) l_second_settle_date,
                         (case
                           when a.c_entrust_direction in ('5', '6') then
                            a.c_first_settle_type
                           else
                            ' '
                         end) c_first_settle_type,
                         a.c_second_settle_type,
                         decode(a.c_busin_class,
                                '7',
                                tb.vc_broker_name,
                                to_char(a.l_trade_rival_no)) l_trade_rival_no,
                         
                         a.c_status,
                         a.l_daily_instruction_no,
                         a.en_second_mature_yield * 100 en_second_mature_yield,
                         (Nvl(a.en_second_mature_yield, 0) -
                         Nvl(th.EN_FAIR_YIELD_RATIO, 0)) * 100 en_cz_mature_fair,
                         h.vc_operator_name vc_direct_operator_name,
                         a.c_busin_class,
                         a.vc_remark,
                         i.c_trade_type,
                         j.C_TRUSTEE,
                         th.C_INSIDE_APPRAISE,
                         th.C_OUTER_APPRAISE,
                         a.vc_rivaltrader_name
                  from trade.tbankrealdeal a,
                       trade.tstockinfo b,
                       trade.tinstruction c,
                       trade.tbondproperty th,
                       trade.tinstructionstock i,
                       trade.tfundinfo d,
                       trade.tcombi e,
                       trade.toperator f,
                       trade.tentrustdirection g,
                       trade.toperator h,
                       trade.tbroker tb,
                       (select *
                          from trade.tpendsettle a
                         where a.c_market_no = '5') j
                 where a.vc_inter_code = b.vc_inter_code
                   and a.l_date = i.l_date(+)
                   and a.l_daily_instruction_no = i.l_daily_instruction_no(+)
                   and a.c_invest_type = i.c_invest_type(+)
                   and a.l_basecombi_id = i.l_basecombi_id(+)
                   and a.c_entrust_direction = i.c_entrust_direction(+)
                   and a.vc_inter_code = i.vc_inter_code(+)
                   and a.l_index_daily_modify = i.l_index_daily_modify(+)
                   and a.l_date = c.l_date(+)
                   and a.l_daily_instruction_no = c.l_daily_instruction_no(+)
                   and a.L_INDEX_DAILY_MODIFY = c.L_INDEX_DAILY_MODIFY(+)
                   and a.l_fund_id = d.l_fund_id(+)
                   and a.l_basecombi_id = e.l_combi_id(+)
                   and c.l_operator_no = f.l_operator_no(+)
                   and c.l_direct_operator = h.l_operator_no(+)
                   and a.vc_broker_no = tb.vc_broker_no(+)
                   and b.c_market_no = g.c_market_no
                   and a.c_entrust_direction = g.c_entrust_direction
                   and to_char(a.l_serial_no) = j.vc_original_no(+)
                   and a.l_date = j.L_TRADE_DATE(+)
                   and a.c_entrust_direction = j.c_entrust_direction(+)
                   and a.l_date = th.l_date(+)
                   and a.vc_inter_code = th.vc_inter_code(+)
                   and a.c_busin_class <> 'f'
                   and a.c_cancel_flag = '0'
                   and nvl(e.c_combi_status, '-1') not in ('2', '3')
                   and a.l_date >= 'PARAM_BUSI_DATE_BEGIN'
                   and a.l_date <= 'PARAM_BUSI_DATE_END'
                union all
                Select distinct To_Char(a.l_Date) l_Date,
                                k.l_time l_time,
                                k.Vc_Deal_No,
                                k.l_Serial_No,
                                a.l_Fund_Id,
                                d.vc_fund_code, --基金代码
                                d.Vc_Fund_Name,
                                e.Vc_Combi_No,
                                e.Vc_Combi_Name,
                                b.Vc_Report_Code,
                                b.Vc_Stock_Name,
                                a.l_Operator_No,
                                d.c_fund_type,
                                g.Vc_Item_Name Vc_Entrustdir_Name,
                                f.Vc_Operator_Name,
                                '' c_Invest_Type,
                                a.En_Hg_Ratio * 100 En_Hg_Ratio,
                                k.l_Deal_Amount l_Deal_Amount,
                                b.EN_YESTERDAY_CLOSE_PRICE,
                                round(decode(b.EN_YESTERDAY_CLOSE_PRICE,
                                             0,
                                             0,
                                             (k.En_First_Full_Price -
                                             b.EN_YESTERDAY_CLOSE_PRICE) /
                                             b.EN_YESTERDAY_CLOSE_PRICE) * 100,
                                      2) en_jgpl,
                                round(nvl(th.En_Fair_Yield_Ratio, 0) * 100, 2) En_Fair_Yield_Ratio,
                                k.En_First_Net_Price,
                                k.En_First_Full_Price,
                                k.En_First_Clear_Balance,
                                Decode(a.c_Redeal_Flag,
                                       '1',
                                       a.En_Redeem_Balance,
                                       a.En_Instr_Redeem_Balance) En_Second_Clear_Balance,
                                k.En_Fee,
                                a.l_Hg_Days l_Hg_Days,
                                a.l_Hg_Days l_Use_Days,
                                To_Char(k.l_Settle_Speed) l_Settle_Speed,
                                '' l_First_Settle_Date_Bond,
                                '' c_First_Settle_Type_Bond,
                                To_Char(a.L_START_DATE) l_First_Settle_Date,
                                To_Char(a.l_end_date) l_Second_Settle_Date,
                                a.c_First_Settle_Type,
                                a.c_Second_Settle_Type,
                                To_Char(a.l_Trade_Rival_No) l_Trade_Rival_No,
                                k.c_Status,
                                a.l_Daily_Instruction_No,
                                k.En_Second_Mature_Yield * 100 En_Second_Mature_Yield,
                                (Nvl(k.en_second_mature_yield, 0) -
                                Nvl(th.EN_FAIR_YIELD_RATIO, 0)) * 100 en_cz_mature_fair,
                                c.Vc_Operator_Name Vc_Direct_Operator_Name,
                                k.c_Busin_Class,
                                '' Vc_Remark,
                                k.c_trade_type,
                                k.C_TRUSTEE,
                                th.C_INSIDE_APPRAISE,
                                th.C_OUTER_APPRAISE,
                                k.vc_rivaltrader_name
                  From (Select a.l_Date,
                               a.L_START_DATE,
                               a.l_daily_instruction_no,
                               a.l_index_daily_modify,
                               a.l_Fund_Id,
                               a.l_basecombi_id,
                               a.vc_inter_code,
                               a.l_operator_no,
                               a.En_Hg_Ratio,
                               a.En_Redeem_Balance,
                               a.En_Instr_Redeem_Balance,
                               a.l_Redeem_Liquidate,
                               a.l_Hg_Days,
                               a.c_First_Settle_Type,
                               decode(a.c_entrust_direction, '1', '4', '3') c_entrust_direction,
                               a.c_entrust_direction c_entrust_direction2,
                               a.c_Second_Settle_Type,
                               a.l_Trade_Rival_No,
                               'f' c_Busin_Class,
                               a.c_Redeal_Flag,
                               b.l_Direct_Operator,
                               a.l_end_date
                          From trade.Ttreatyhgdetail a, trade.Tinstruction b
                         Where a.l_Date = b.l_Direct_Date
                           And a.l_Daily_Instruction_No =
                               b.l_Daily_Instruction_No
                           And a.l_Index_Daily_Modify = b.l_Index_Daily_Modify
                           and a.l_Date >= 'PARAM_BUSI_DATE_BEGIN'
                           And a.l_Date <= 'PARAM_BUSI_DATE_END'
                           and b.c_Instruction_Status = '1'
                           and b.c_Busin_Class = 'f'
                        Union All
                        Select a.l_Date,
                               a.L_START_DATE,
                               a.l_daily_instruction_no,
                               a.l_index_daily_modify,
                               a.l_Fund_Id,
                               a.l_basecombi_id,
                               a.vc_inter_code,
                               a.l_operator_no,
                               a.En_Hg_Ratio,
                               a.En_Redeem_Balance,
                               a.En_Instr_Redeem_Balance,
                               a.l_Redeem_Liquidate,
                               a.l_Hg_Days,
                               a.c_First_Settle_Type,
                               decode(a.c_entrust_direction, '1', '4', '3') c_entrust_direction,
                               a.c_entrust_direction c_entrust_direction2,
                               a.c_Second_Settle_Type,
                               a.l_Trade_Rival_No,
                               'f' c_Busin_Class,
                               a.c_Redeal_Flag,
                               b.l_Direct_Operator,
                               a.l_end_date
                          From (select *
                                  from trade.Ttreatyhgdetail
                                union
                                select *
                                  from trade.Thistreatyhgdetail) a,
                               trade.Thisinstruction b
                         Where a.l_Date = b.l_Direct_Date
                           And a.l_Daily_Instruction_No =
                               b.l_Daily_Instruction_No
                           And a.l_Index_Daily_Modify = b.l_Index_Daily_Modify
                           and a.l_Date >= 'PARAM_BUSI_DATE_BEGIN'
                           And a.l_Date <= 'PARAM_BUSI_DATE_END'
                           and b.c_Instruction_Status = '1'
                           and b.c_Busin_Class = 'f'
                           and b.c_Deal_Execute_Status In ('3')) a,
                       trade.Tstockinfo b,
                       trade.Tfundinfo d,
                       trade.Tcombi e,
                       trade.Toperator f,
                       trade.Tdictionary g,
                       (select l_Operator_No l_Direct_Operator,
                               Vc_Operator_Name
                          from trade.Toperator) c,
                       (Select Tb.l_Date,
                               min(Tb.l_time) l_time,
                               Tb.l_Daily_Instruction_No,
                               tb.c_Entrust_Direction,
                               Tb.Vc_Inter_Code,
                               Max(Tb.Vc_Deal_No) Vc_Deal_No,
                               max(Tb.l_Serial_No) l_Serial_No,
                               Nvl(Sum(Tb.En_Balance / 100), 0) l_Deal_Amount,
                               Decode(Nvl(Sum(Tb.En_Balance / 100), 0),
                                      0,
                                      0,
                                      Sum(Tb.En_Balance / 100 *
                                          Tb.En_First_Net_Price) /
                                      Sum(Tb.En_Balance / 100)) En_First_Net_Price,
                               Decode(Nvl(Sum(Tb.En_Balance / 100), 0),
                                      0,
                                      0,
                                      Sum(Tb.En_Balance / 100 *
                                          Tb.En_First_Full_Price) /
                                      Sum(Tb.En_Balance / 100)) En_First_Full_Price,
                               Sum(Tb.En_First_Clear_Balance) En_First_Clear_Balance,
                               Sum(Tb.En_Fee) En_Fee,
                               min(Nvl(Tb.l_Settle_Speed, 0)) l_Settle_Speed,
                               Max(Tb.c_Busin_Class) c_Busin_Class,
                               Max(Tb.En_Second_Mature_Yield) En_Second_Mature_Yield,
                               Max(Tb.c_Status) c_Status,
                               min(i.c_trade_type) c_trade_type,
                               min(j.c_trustee) c_trustee,
                               Max(Tb.vc_rivaltrader_id) vc_rivaltrader_id,
                               Max(Tb.vc_rivaltrader_name) vc_rivaltrader_name
                          From trade.Tbankrealdeal Tb,
                               trade.tinstructionstock i,
                               (select *
                                  from trade.tpendsettle a
                                 where a.c_market_no = '5') j
                         Where tb.l_date >= 'PARAM_BUSI_DATE_BEGIN'
                           and tb.l_date <= 'PARAM_BUSI_DATE_END'
                           and to_char(tb.l_serial_no) = j.vc_original_no(+)
                           and tb.l_date = j.L_TRADE_DATE(+)
                           and tb.c_entrust_direction =
                               j.c_entrust_direction(+)
                           and tb.l_date = i.l_date(+)
                           and tb.l_daily_instruction_no =
                               i.l_daily_instruction_no(+)
                           and tb.c_invest_type = i.c_invest_type(+)
                           and tb.l_basecombi_id = i.l_basecombi_id(+)
                           and tb.c_entrust_direction =
                               i.c_entrust_direction(+)
                           and tb.vc_inter_code = i.vc_inter_code(+)
                           and tb.l_index_daily_modify =
                               i.l_index_daily_modify(+)
                           and Tb.c_Busin_Class = 'f'
                           And Tb.c_Cancel_Flag = '0'
                         Group By Tb.l_Date,
                                  Tb.l_Daily_Instruction_No,
                                  Tb.Vc_Inter_Code,
                                  Tb.c_Entrust_Direction) k,
                       (select l_date,
                               vc_inter_code,
                               EN_FAIR_YIELD_RATIO,
                               C_INSIDE_APPRAISE,
                               C_OUTER_APPRAISE
                          from trade.tbondproperty
                         where l_date >= 'PARAM_BUSI_DATE_BEGIN'
                           and l_date <= 'PARAM_BUSI_DATE_END'
                        union all
                        select l_date,
                               vc_inter_code,
                               EN_FAIR_YIELD_RATIO,
                               C_INSIDE_APPRAISE,
                               C_OUTER_APPRAISE
                          from trade.thisbondproperty
                         where l_date >= 'PARAM_BUSI_DATE_BEGIN'
                           and l_date <= 'PARAM_BUSI_DATE_END') th
                 Where a.Vc_Inter_Code = b.Vc_Inter_Code
                   And a.l_Fund_Id = d.l_Fund_Id
                   And a.l_Basecombi_Id = e.l_Combi_Id
                   And a.l_Operator_No = f.l_Operator_No(+)
                   And a.l_Direct_Operator = c.l_Direct_Operator(+)
                   And a.c_Entrust_Direction2 = g.c_Lemma_Item
                   And g.l_Dictionary_No = 60086
                   And a.l_Date = k.l_Date
                   And a.l_Daily_Instruction_No = k.l_Daily_Instruction_No
                   And a.c_Entrust_Direction = k.c_Entrust_Direction
                   and a.l_date = th.l_date(+)
                   and a.vc_inter_code = th.vc_inter_code(+)
                   and nvl(e.c_combi_status, '-1') not in ('2', '3')
                   and a.l_date >= 'PARAM_BUSI_DATE_BEGIN'
                   and a.l_date <= 'PARAM_BUSI_DATE_END') t) t
 where 1 = 1
   --and t.VC_FUND_CODE in ('CJ0050', 'CJ0292') --基金代码
   --and t.L_DATE >= '20180206' --成交日期
   --and t.L_DATE <= '20180206' --成交日期
   --and t.L_FIRST_SETTLE_DATE >= '20180206' --首次交割日
   --and t.L_FIRST_SETTLE_DATE <= '20180206' --首次交割日
   --and t.L_SECOND_SETTLE_DATE >= '' --到期交割日
   --and t.L_SECOND_SETTLE_DATE <= '' --到期交割日
   --and t.VC_REPORT_CODE like '%170201%' --证券代码
   --and t.VC_STOCK_NAME like '%%' --证券名称
   --and t.VC_ENTRUSTDIR_NAME like '%债券买入%' --委托方向名称
 --order by t.L_DATE desc, t.VC_FUND_CODE asc, t.VC_DEAL_NO asc
