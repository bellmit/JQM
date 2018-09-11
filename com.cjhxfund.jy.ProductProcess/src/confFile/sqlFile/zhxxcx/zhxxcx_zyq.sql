----综合信息查询SQL-质押券：信息查询-综合信息查询-质押券[C]
--需要字段：日期，基金名称，组合名称，股东代码，证券代码，证券名称，可质押数量，已质押数量，持仓，抵押比率（%），已转标准券数量，可转标准券数量
select L_DATE, --日期
       L_FUND_ID, --基金序号
       VC_FUND_CODE, --基金代码
       VC_FUND_NAME, --基金名称
       VC_COMBI_NO, --组合名称
       VC_COMBI_NAME, --组合名称
       VC_STOCKHOLDER_ID, --股东代码
       VC_REPORT_CODE, --证券代码
       VC_STOCK_NAME, --证券名称
       L_ENABLE_AMOUNT, --可质押数量
       L_IMPAWN_AMOUNT, --已质押数量
       L_AMOUNT, --持仓
       L_RATIO, --抵押比率（%）
       L_IMPAWNSTD_AMOUNT, --已转标准券数量
       L_ENABLESTD_AMOUNT --可转标准券数量
  from (select a.l_date,
               a.l_fund_id,
               f.vc_fund_code,
               f.vc_fund_name,
               e.vc_combi_no,
               e.vc_combi_name,
               a.vc_stockholder_id,
               a.vc_bind_seat,
               (case
                 when count(distinct a.l_fund_id) = 1 then
                  min(a.c_market_no)
                 else
                  '-1'
               end) c_market_no,
               b.vc_report_code,
               (case
                 when count(distinct d.vc_inter_code) = 1 then
                  min(d.en_sys_ratio)
                 else
                  -1
               end) l_ratio,
               c.vc_report_code vc_frozen_code,
               (case
                 when count(distinct b.vc_inter_code) = 1 then
                  min(b.vc_stock_name)
                 else
                  '-1'
               end) vc_stock_name,
               sum(nvl(a.l_current_amount, 0)) l_amount,
               (case
                 when count(distinct h.l_fund_id) = 1 then
                  min(h.l_asset_id)
                 else
                  -1
               end) l_asset_id,
               (case
                 when count(distinct h.l_fund_id) = 1 then
                  min(h.vc_asset_name)
                 else
                  '-1'
               end) vc_asset_name,
               min(h.vc_asset_no) vc_asset_no,
               min(b.c_stop_flag) c_stop_flag,
               sum(nvl(a.en_current_impawn_amount + a.en_impawn_amount -
                       a.en_return_amount,
                       0)) l_impawn_amount,
               sum(nvl(a.l_current_amount - a.l_frozen_amount +
                       a.l_unfrozen_amount,
                       0)) l_enable_amount,
               trunc(sum(nvl(a.en_current_impawn_amount + a.en_impawn_amount -
                             a.en_return_amount,
                             0) *
                         decode(a.c_market_no,
                                '1',
                                nvl2(tb.en_curr_face_price,
                                     tb.en_curr_face_price / 100,
                                     b.en_face_values / 100),
                                '2',
                                nvl2(tb.en_curr_face_price,
                                     1,
                                     b.en_face_values / 100))) *
                     min(d.en_sys_ratio) / 100) l_impawnSTD_amount,
               trunc(sum(nvl(a.l_current_amount - a.l_frozen_amount +
                             a.l_unfrozen_amount,
                             0) *
                         decode(a.c_market_no,
                                '1',
                                nvl2(tb.en_curr_face_price,
                                     tb.en_curr_face_price / 100,
                                     b.en_face_values / 100),
                                '2',
                                nvl2(tb.en_curr_face_price,
                                     1,
                                     b.en_face_values / 100))) *
                     min(d.en_sys_ratio) / 100) l_EnableSTD_amount,
               (case
                 when count(distinct b.vc_inter_code) = 1 then
                  min(b.EN_YESTERDAY_CLOSE_PRICE)
                 else
                  -1
               end) EN_YESTERDAY_CLOSE_PRICE,
               round((nvl(min(b.EN_YESTERDAY_CLOSE_PRICE), 0) *
                     sum(nvl(a.en_current_impawn_amount +
                              a.en_impawn_amount - a.en_return_amount,
                              0))),
                     2) zysz
          from trade.tunitstock    a,
               trade.tstockinfo    b,
               trade.tstockinfo    c,
               trade.thgratio      d,
               trade.tcombi        e,
               trade.tfundinfo     f,
               trade.tasset        h,
               trade.tspecstock    k,
               trade.tbondproperty tb
         where a.vc_inter_code = b.vc_inter_code
           and a.l_date = b.l_date
           and a.l_unit_id = k.l_unit_id(+)
           and a.l_date = k.l_date(+)
           and b.vc_frozen_code = c.vc_inter_code
           and b.l_date = c.l_date
           and c.c_stock_type in ('x', 'A')
           and b.vc_inter_code = d.vc_inter_code
           and d.c_parameter_type = '4'
           and a.l_basecombi_id = e.l_combi_id
           and a.l_fund_id = f.l_fund_id
           and e.l_asset_id = h.l_asset_id
           and a.vc_inter_code = tb.vc_inter_code(+)
           and a.l_current_amount > 0
           and e.c_combi_status not in ('2', '3')
           and a.C_POSITION_FLAG not in ('7', 'c', 'd')
         group by a.l_date,
                  a.l_fund_id,
                  f.vc_fund_code,
                  f.vc_fund_name,
                  e.vc_combi_no,
                  e.vc_combi_name,
                  a.vc_stockholder_id,
                  a.vc_bind_seat,
                  b.vc_report_code,
                  c.vc_report_code) tt
 where 1 = 1
   --and tt.VC_FUND_CODE in ('') --基金代码
   --and tt.VC_COMBI_NO in ('') --组合代码
   --and tt.VC_COMBI_NAME like '%%' --组合名称
   --and tt.VC_STOCKHOLDER_ID like '%%' --股东代码
   --and tt.VC_REPORT_CODE like '%%' --证券代码
   --and tt.VC_STOCK_NAME like '%%' --证券名称
 --order by tt.VC_FUND_CODE asc, tt.VC_COMBI_NAME asc, tt.VC_REPORT_CODE asc
