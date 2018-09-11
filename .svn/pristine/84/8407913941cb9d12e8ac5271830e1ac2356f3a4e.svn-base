--综合信息查询-组合持仓（产品持仓明细）-万得BBQ行情展示查询
select distinct A.RT_YIELD, --成交价
                A.RT_ASKYIELD, --卖出收益率
                A.RT_BIDYIELD, --买入收益率
                A.RT_ASIZE, --卖量
                A.RT_BSIZE, --买量
                A.RT_TIME, --时间
                A.vc_inter_code, --证券内码
                B.YIELD_CNBD, --估价收益率(中债)
                B.COUPONRATE, --票息，即票面利率
                B.MATURITYDATE --期限(天)
  from (select t1.BBQ_ID, -- 序号
               t1.RT_YIELD, --成交价
               t1.RT_ASKYIELD, --卖出收益率
               t1.RT_BIDYIELD, --买入收益率
               t1.RT_ASIZE, --卖量
               t1.RT_BSIZE, --买量
               t1.RT_TIME, --时间
               t2.vc_inter_code, --证券内码
               t1.c_market_no, --市场代码
               t1.src_code --证券代码
        --from STAGE.wind_bbq_hq t1, STAGE.fm_thisstockinfo t2, STAGE.Wind_Bbq_Wsd t3 --使用历史表语句备份          
          from STAGE.wind_bbq_hq t1, STAGE.fm_tstockinfo t2
         where t1.c_market_no = t2.c_market_no(+)
           and t1.src_code = t2.vc_report_code(+)) A
  left join (select t3.YIELD_CNBD, --估价收益率(中债)
                    t3.COUPONRATE, --票息，即票面利率
                    t3.c_market_no, --市场代码
                    t3.windcode, --证券代码
                    TO_DATE(t3.maturitydate, 'yyyy-MM-dd') -
                    TO_DATE(TO_CHAR(sysdate, 'yyyy-MM-dd'), 'yyyy-MM-dd') as MATURITYDATE --期限(天)
               from STAGE.Wind_Bbq_Wsd t3
              where TO_CHAR(sysdate, 'yyyy-MM-dd') =
                    to_char(t3.create_time, 'yyyy-MM-dd')) B
    on (A.src_code = B.windcode and A.c_market_no = B.c_market_no)
 where 1 = 1
   --and t2.l_date = (select max(t.l_date) from STAGE.Fm_Thisstockinfo t) --使用历史表语句备份
   --and A.vc_inter_code in ('0980n7YH') --证券内码
 --order by A.vc_inter_code asc, A.rt_time desc;