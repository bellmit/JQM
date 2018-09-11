----综合信息查询SQL-银行间回购-银行间回购明细表：信息查询-综合信息查询-银行间回购[9]-银行间回购明细表
select to_char(a.l_date) l_date, --日期
       b.vc_report_code, --证券代码
       b.vc_stock_name, --证券名称
       a.EN_RATIO, --抵押比例（%）
       a.l_mortagage_amount, --质押数量
       a.l_fund_id, --基金编号
       a.l_basecombi_id, --组合序号
       tf.vc_fund_name, --基金名称
       cb.vc_combi_name, --组合名称
       (select vc_item_name
          from trade.tdictionary
         where l_dictionary_no = 40351
           and c_lemma_item = a.c_invest_type) c_invest_type --投资类型
  from trade.THGMortagage a,
       trade.TSTOCKINFO   b,
       trade.tfundinfo    tf,
       trade.tcombi       cb
 where a.l_fund_id = tf.l_fund_id
   and a.l_basecombi_id = cb.l_combi_id
   and a.vc_inter_code = b.vc_inter_code
   and a.l_serial_no = PARAM_L_SERIAL_NO
union all
select to_char(a.l_date) l_date,
       b.vc_report_code,
       b.vc_stock_name,
       a.EN_RATIO,
       a.l_mortagage_amount,
       a.l_fund_id,
       a.l_basecombi_id,
       tf.vc_fund_name,
       cb.vc_combi_name,
       (select vc_item_name
          from trade.tdictionary
         where l_dictionary_no = 40351
           and c_lemma_item = a.c_invest_type) c_invest_type
  from trade.ThisSTOCKINFO   b,
       trade.tfundinfo       tf,
       trade.tcombi          cb,
       trade.thishgmortagage a
 where a.l_fund_id = tf.l_fund_id
   and a.l_basecombi_id = cb.l_combi_id
   and a.vc_inter_code = b.vc_inter_code
   and a.l_date = b.l_date
   and a.l_serial_no = PARAM_L_SERIAL_NO
 --order by l_date desc, vc_report_code asc;