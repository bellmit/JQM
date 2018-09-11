--当日T+0头寸差额-银行间可用质押券明细
select t1.l_fund_id, --基金ID
       t1.vc_fund_code, --基金代码
       t1.vc_fund_name, --基金名称
       t1.vc_report_code, --债券代码
       t1.vc_stock_name, --债券名称
       t1.vc_market_no, --交易市场
       t1.c_bond_rating, --债项评级
       t1.c_subject_rating, --主体评级
       0 l_sale_amount_count, --可用数量总额
       t1.l_sale_amount, --可用数量
       t1.c_issuer_type, --企业(发行人)性质
       t1.vc_bond_type_wind_first, --Wind一级债券类型
       t1.vc_bond_type_wind_second, --Wind 二级债券类型
       t1.l_trade_date
  from (select a.l_fund_id, 
               f.vc_fund_code, 
               f.vc_fund_name, 
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
               sum(nvl(a.l_current_amount *
                       decode(a.c_position_flag, '6', -1, 'e', '-1', 1) -
                       a.l_frozen_amount + a.l_unfrozen_amount,
                       0)) l_sale_amount, 
               (select t.vc_item_name
                  from trade.tdictionary t
                 where t.l_dictionary_no = 10090
                   and t.c_lemma_item = nvl(e.c_issuer_type, '0')) c_issuer_type, 
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
               trade.tissuer       e,
               trade.tfundinfo     f
         where a.l_fund_id = f.l_fund_id
           and a.c_market_no in ('5')
           and a.vc_inter_code = b.vc_inter_code
           and b.l_company_id = e.l_issuer_id
           and b.vc_report_code = d.vc_stock_code
           and b.c_market_no = d.c_market_no
           --and d.l_trade_date = to_number(to_char(sysdate,'yyyyMMdd'))
           and (instr(',3,4,5,S,T,', b.c_stock_type) <= 0 and
               a.c_position_flag in ('1') or
               instr(',3,4,5,S,T,', b.c_stock_type) > 0 and
               a.c_position_flag in ('1', '6'))
           and abs(a.l_current_amount - a.l_frozen_amount +
                   a.l_unfrozen_amount) > 0
         group by a.l_fund_id,
                  b.c_market_no,
                  b.vc_report_code,
                  b.vc_stock_name,
                  d.c_bond_appraise,
                  d.c_issuer_appraise,
                  d.vc_bond_type_wind_first,
                  d.vc_bond_type_wind_second,
                  e.c_issuer_type,
                  f.vc_fund_code,
                  f.vc_fund_name,
                  d.l_trade_date
         order by a.l_fund_id, b.c_market_no, b.vc_report_code) t1
where 1=1