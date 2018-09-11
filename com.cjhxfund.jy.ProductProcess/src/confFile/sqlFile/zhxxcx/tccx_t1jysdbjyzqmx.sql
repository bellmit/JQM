--当日T+1头寸差额：交易所担保交易债券明细
select t1.l_fund_id, --基金ID
       t1.vc_fund_code, --基金代码
       t1.vc_fund_name, --基金名称
       t1.vc_report_code, --债券代码
       t1.vc_stock_name, --债券名称
       t1.vc_market_no, --交易市场
       0 l_sale_amount_count, --可用数量总数
       t1.l_sale_amount, --可用数量
       t1.c_bond_rating, --债项评级
       t1.c_subject_rating, --主体评级
       t1.vc_bond_type_wind_first, --Wind一级债券类型
       t1.vc_bond_type_wind_second, --Wind一级债券类型
       t1.l_trade_date --债券信息表业务日期
  from (select a.l_fund_id,
               e.vc_fund_code,
               e.vc_fund_name,
               b.vc_report_code,
               b.vc_stock_name,
               (select t.vc_market_name
                  from trade.tmarketinfo t
                 where t.c_market_no = b.c_market_no) vc_market_no,
               (select t.vc_dict_name
                  from tdictentry t
                 where t.vc_dict_type_id = 'BOND_APPRAISE'
                   and t.vc_dict_id = nvl(d.c_bond_appraise, '0')) c_bond_rating,
               (select t.vc_dict_name
                  from tdictentry t
                 where t.vc_dict_type_id = 'ISSUER_APPRAISE'
                   and t.vc_dict_id = nvl(d.c_issuer_appraise, '0')) c_subject_rating,
               sum(nvl(a.l_current_amount - a.l_frozen_amount +
                       a.l_unfrozen_amount,
                       0)) l_sale_amount,
               (select t.vc_dict_name
                  from tdictentry t
                 where t.vc_dict_type_id = 'BOND_TYPE_WIND'
                   and t.vc_dict_level = '1'
                   and t.vc_dict_id = nvl(d.vc_bond_type_wind_first, '0')) vc_bond_type_wind_first,
               (select t.vc_dict_name
                  from tdictentry t
                 where t.vc_dict_type_id = 'BOND_TYPE_WIND'
                   and t.vc_dict_level = '2'
                   and t.vc_dict_id = nvl(d.vc_bond_type_wind_second, '0')) vc_bond_type_wind_second,
               d.l_trade_date
          from trade.tunitstock    a,
               trade.tstockinfo    b,
               tbondinfo           d,
               trade.tfundinfo     e
         where a.l_fund_id = e.l_fund_id
           and a.c_position_flag = '1'
           and a.c_market_no in ('1', '2')
           and a.vc_inter_code = b.vc_inter_code
           and b.vc_report_code = d.vc_stock_code
           and b.c_market_no = d.c_market_no
           --and d.l_trade_date = to_number(to_char(sysdate,'yyyyMMdd'))
              /*担保交收债券*/
           and ((a.c_market_no = '2' and
               not (instr(',' || nvl(b.vc_busin_classes, '0') || ',', ',E,') > 0 and
                instr(',' || nvl(b.vc_busin_classes, '0') || ',', ',1,') <= 0 and
                (b.c_stock_type = '4' or b.c_stock_type = 'S' or
                (b.c_stock_type = '5' and
                instr(nvl(b.vc_mixed_type, '0'), '=') > 0)))) or
               (a.c_market_no = '1' and
               not (instr(',' || nvl(b.vc_busin_classes, '0') || ',', ',I,') > 0 and
                instr(',' || nvl(b.vc_busin_classes, '0') || ',', ',1,') <= 0 and
                instr(',' || nvl(b.vc_busin_classes, '0') || ',', ',E,') <= 0 and
                (instr(nvl(b.vc_mixed_type, '0'), 'i') > 0 or
                instr(nvl(b.vc_mixed_type, '0'), 'p') > 0 or
                instr(nvl(b.vc_mixed_type, '0'), '=') > 0))))
              /*排除掉已经抵押部分的债券*/
           and not (b.vc_inter_code <> b.vc_frozen_code and
                ((a.c_market_no = '1' and b.vc_frozen_code = '888880SS') or
                (a.c_market_no = '2' and b.vc_frozen_code = '131990SZ')) and
                exists (select 1
                             from trade.thgratio e
                            where e.c_parameter_type = '4'
                              and e.vc_inter_code = a.vc_inter_code))
           and abs(a.l_current_amount - a.l_frozen_amount +
                   a.l_unfrozen_amount) > 0
         group by a.l_fund_id,
                  e.vc_fund_code,
                  e.vc_fund_name,
                  b.c_market_no,
                  b.vc_report_code,
                  b.vc_stock_name,
                  d.c_bond_appraise,
                  d.c_issuer_appraise,
                  d.vc_bond_type_wind_first,
                  d.vc_bond_type_wind_second,
                  d.l_trade_date
         order by a.l_fund_id, b.c_market_no, b.vc_report_code) t1
 where 1 = 1