--综合报表->O32定期存款到期浏览表 取数逻辑SQL
select a.l_fund_id, --基金序号
       b.vc_fund_code, --基金代码
       b.vc_fund_name, --基金名称
       '定期存款' c_asset_class, --资产类别:1-定期存款,2-收益凭证
       d.vc_bank_name, --对手方
       c.vc_report_code, --证券代码
       c.vc_stock_name, --证券简称
       a.en_balance, --存单金额(元)
       (to_date(a.l_end_date, 'yyyymmdd') -
       to_date(a.l_begin_date, 'yyyymmdd')) l_limit_time, --存款期限(天)
       a.l_begin_date, --起息日
       a.l_end_date, --到期日
       a.l_end_date l_payment_date, --到期本息兑付日:定期存款-与到期日一致,收益凭证-手工录入
       a.en_rate * 100 en_rate, --存款利率
       (select t.c_lemma_item || '-' || t.vc_item_name
          from trade.tdictionary t
         where t.l_dictionary_no = '60087'
           and t.c_lemma_item = a.c_advance_limit_flag
           and t.c_lemma_item <> '!') c_advance_limit_flag, --提前支取限制:0-不控制,1-不可提前支取,2-可提前支取无利息损失,3-可提前支取但损失利息
       a.c_status, --协议存款/存单状态:0-未存入;1-存款存入;2-到期兑付;3-提前兑付;4-提前解约;5-一次性还本付息;6-无效存单;
       (select t.c_lemma_item || '-' || t.vc_item_name
          from trade.tdictionary t
         where t.l_dictionary_no = '40364'
           and t.c_lemma_item = a.c_status
           and t.c_lemma_item <> '!') depositreceipt_status --协议存款/存单状态:0-未存入;1-存款存入;2-到期兑付;3-提前兑付;4-提前解约;5-一次性还本付息;6-无效存单;
  from trade.tdepositreceipt a, --在途存单信息表
       trade.tfundinfo       b, --基金信息表
       trade.tstockinfo      c, --证券信息表
       trade.tbankinfo       d --银行信息
 where a.l_bank = d.l_bank_no
   and a.l_fund_id = b.l_fund_id
   and a.vc_inter_code = c.vc_inter_code
   --and b.vc_fund_code in ('001662', '001909')
   --and a.l_begin_date >= '20151123'
   --and a.l_begin_date <= '20151125'
   --and a.l_end_date >= '20151224'
   --and a.l_end_date <= '20151231'
   --and d.vc_bank_name like '%%'
   --and a.c_status in ('1','2')
 --order by b.vc_fund_code asc, a.l_end_date desc
