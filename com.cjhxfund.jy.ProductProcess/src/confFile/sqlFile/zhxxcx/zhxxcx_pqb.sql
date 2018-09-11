with t1 as (
select to_char(a.l_date) l_date, --日期
     c.l_fund_id, --基金序号
     b.vc_fund_code, --基金代码
     b.vc_fund_name, --基金名称
     c.vc_combi_no, --组合代码
     c.vc_combi_name, --组合名称
     a.vc_inter_code, --证券内码
     d.vc_report_code, --证券代码
     d.vc_stock_name, --证券名称
     d.c_stock_type, --证券类别
     a.l_current_amount + a.l_unfrozen_amount - a.l_frozen_amount l_usable_amount, --可用数量
     a.l_current_amount l_current_amount, --持仓
     a.c_position_flag, --持仓多空标志 1多仓 2空仓 3债券远期买入 4债券远期卖出 5买断式回购远期买入 6买断式回购远期卖出
     d.c_Market_No, --交易市场代码 1上交所 2深交所 3上期所 4郑商所 5银行间 6场外 7中金所 9大商所 j股转市场 n港股通(沪) o港股通(深)
     h.c_trustee, --托管机构
     tasi.vc_inter_code_wind2 --万得代码
     
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
                 group by t.vc_inter_code) bpr,
         t_ats_all_stock_info tasi
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
           and a.vc_inter_code = tasi.vc_inter_code_o32(+)
           and c.c_combi_status not in ('2', '3') --1正常 2过期 3冻结
           and ((a.l_buy_amount + a.l_sale_amount) <> 0 or
               a.l_current_amount <> 0)
           and d.c_asset_class in
               ('1', '2', '3', '4', '5', '7', '8', '9', 'a') --1现金资产 2股票资产 3债券资产 4基金资产 5回购资产 6非资产 7权证资产 8其他资产 9期货盈亏 a期权资产
           and a.C_POSITION_FLAG not in ('7', 'c', 'd') --1多仓 2空仓 3债券远期买入 4债券远期卖出 5买断式回购远期买入 6买断式回购远期卖出 7证券借入 b备兑空仓 c协议回购买入 d协议回购卖出 e债券借贷待返售债券 f债券借贷待购回债券          
           and a.l_date = ?
           --and a.l_date = to_char(sysdate,'yyyyMMdd')
)


select t1.*,
       t3.vc_fund_code||t3.vc_combi_no||t3.vc_inter_code is_buy_back,
       t4.vc_fund_code||t4.vc_combi_no||t4.vc_inter_code is_sell_back
from t1
left join(
select t2.vc_fund_code,
       t2.vc_combi_no,
       t2.vc_inter_code,
       min(t2.c_position_flag) min_position_flag,
       max(t2.c_position_flag) max_position_flag
from
(
select t1.vc_fund_code,
       t1.vc_combi_no,
       t1.vc_inter_code,
       t1.c_position_flag
from t1,
(select vc_fund_code,
       vc_combi_no,
       vc_inter_code,
       count(c_position_flag)
from t1   
group by vc_fund_code,vc_combi_no,vc_inter_code
having count(c_position_flag) = 2) condition
where t1.vc_fund_code = condition.vc_fund_code
and t1.vc_combi_no = condition.vc_combi_no
and t1.vc_inter_code = condition.vc_inter_code
) t2
group by vc_fund_code,vc_combi_no,vc_inter_code
having min(t2.c_position_flag)=1
and max(t2.c_position_flag)=2
) t3
on t1.vc_fund_code = t3.vc_fund_code
and t1.vc_combi_no = t3.vc_combi_no
and t1.vc_inter_code = t3.vc_inter_code

left join(
select t2.vc_fund_code,
       t2.vc_combi_no,
       t2.vc_inter_code,
       min(t2.c_position_flag) min_position_flag,
       max(t2.c_position_flag) max_position_flag
from 
(
select t1.vc_fund_code,
       t1.vc_combi_no,
       t1.vc_inter_code,
       t1.c_position_flag
from t1,
(select vc_fund_code,
       vc_combi_no,
       vc_inter_code,
       count(c_position_flag)
from t1   
group by vc_fund_code,vc_combi_no,vc_inter_code
having count(c_position_flag) = 2) condition
where t1.vc_fund_code = condition.vc_fund_code
and t1.vc_combi_no = condition.vc_combi_no
and t1.vc_inter_code = condition.vc_inter_code
) t2
group by vc_fund_code,vc_combi_no,vc_inter_code
having min(t2.c_position_flag)=1
and max(t2.c_position_flag)=6
) t4
on t1.vc_fund_code = t4.vc_fund_code
and t1.vc_combi_no = t4.vc_combi_no
and t1.vc_inter_code = t4.vc_inter_code
