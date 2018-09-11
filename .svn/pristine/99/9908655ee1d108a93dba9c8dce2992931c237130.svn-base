----综合信息查询SQL-银行间回购：信息查询-综合信息查询-银行间回购[9]
--需要字段：回购日期，基金名称，组合名称，回购代码，委托方向，数量，净资金额，交易对手，平均利率，利润，实际回购日期【实际购回日期】，回购叫个日期【购回交割日期】，实际占款天数【无】，证券类别，实际回购代码
select tt.L_HG_DATE, --回购日期
       tt.L_SERIAL_NO, --流水号
       tt.L_FUND_ID, --基金序号
       tt.VC_FUND_CODE, --基金代码
       tt.VC_FUND_NAME, --基金名称
       tt.VC_COMBI_NO, --组合代码
       tt.VC_COMBI_NAME, --组合名称
       tt.VC_REPORT_CODE, --回购代码
       tt.VC_ENTRUSTDIR_NAME, --委托方向
       tt.L_DEAL_AMOUNT, --数量
       tt.EN_NET_ZJ, --净资金额
       tt.EN_RET_ZJ, --返回金额
       tt.VC_RIVAL_NAME, --交易对手
       tt.EN_INTEREST_RATE, --平均利率
       tt.EN_PROFIT, --利润
       tt.L_REDEEM_LAWDATE, --法定购回日期
       tt.L_REDEEM_LIQUIDATE, --实际购回日期
       tt.L_SETTLE_DATE, --购回交割日期
       tt.C_STOCK_TYPE, --证券类别
       tt.VC_REAL_CODE, --实际回购代码
       tt.C_TRUSTEE, --托管机构
       ttt.l_date,--日期
       ttt.vc_report_code as vc_zq_code,--证券代码
       ttt.vc_stock_name,--证券名称
       ttt.EN_RATIO,--质押比例
       ttt.l_mortagage_amount,--质押数量
       ttt.c_invest_type--投资类型
  from (select L_HG_DATE, --回购日期
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
  from stage.fm_0002 tt 
  where 1=1 
  and tt.L_HG_DATE>=PARAM_BUSI_DATE_BEGIN
  and tt.L_HG_DATE<=PARAM_BUSI_DATE_END
        ) tt left join (
        select to_char(a.l_date) l_date, --日期
       b.vc_report_code, --证券代码
       b.vc_stock_name, --证券名称
       a.EN_RATIO, --抵押比例（%）
       a.l_mortagage_amount, --质押数量
       a.l_fund_id, --基金编号
       a.l_basecombi_id, --组合序号
       tf.vc_fund_name, --基金名称
       cb.vc_combi_name, --组合名称
       a.l_serial_no,
       (select vc_item_name
          from trade.tdictionary@dblink_o32
         where l_dictionary_no = 40351
           and c_lemma_item = a.c_invest_type) c_invest_type --投资类型
  from trade.THGMortagage@dblink_o32 a,
       trade.TSTOCKINFO@dblink_o32   b,
       trade.tfundinfo@dblink_o32    tf,
       trade.tcombi@dblink_o32       cb
 where a.l_fund_id = tf.l_fund_id
   and a.l_basecombi_id = cb.l_combi_id
   and a.vc_inter_code = b.vc_inter_code
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
       a.l_serial_no,
       (select vc_item_name
          from trade.tdictionary@dblink_o32
         where l_dictionary_no = 40351
           and c_lemma_item = a.c_invest_type) c_invest_type
  from trade.ThisSTOCKINFO@dblink_o32   b,
       trade.tfundinfo@dblink_o32       tf,
       trade.tcombi@dblink_o32          cb,
       trade.thishgmortagage@dblink_o32 a
 where a.l_fund_id = tf.l_fund_id
   and a.l_basecombi_id = cb.l_combi_id
   and a.vc_inter_code = b.vc_inter_code
   and a.l_date = b.l_date
        ) ttt on tt.L_SERIAL_NO=ttt.l_serial_no 
 where 1 = 1 
   --and tt.VC_FUND_CODE in ('001199') --基金代码
   --and tt.VC_COMBI_NO in ('') --组合代码
   --and tt.VC_COMBI_NAME like '%%' --组合名称
   --and tt.VC_REPORT_CODE like '%%' --回购代码
   --and tt.VC_ENTRUSTDIR_NAME like '%%' --委托方向
   --and tt.L_REDEEM_LIQUIDATE >= '' --实际购回日期
   --and tt.L_REDEEM_LIQUIDATE <= ''
 --order by tt.L_HG_DATE desc, tt.L_FUND_ID asc, tt.L_REDEEM_LIQUIDATE asc