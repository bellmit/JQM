--综合信息查询-恒生科目金额表
select distinct b.vc_code     cpdm, --产品代码
                b.vc_name     cpmc, --产品名称
                b.vc_fullname cpqc, --产品全称
                a.L_FUNDID, --账套编号
                a.L_DATE, --日期
                a.VC_CODE, --科目代码
                a.VC_NAME, --科目名称
                a.NCYE, --年初余额
                a.QCYE, --期初余额
                a.BQJFFSE, --本期借方发生（当日）
                a.BQDFFSE, --本期贷方发生（当日）
                a.LJJFFSE, --累计借方发生
                a.LJDFFSE, --累计贷方发生
                a.QMYE, --期末余额
                a.SRCSYS, --来源系统
                a.INSERTTIME --写入时间
  from STAGE.FA_TMP_KMYEB a, stage.fa_tfundinfo b --估值系统科目余额表
 where a.l_fundid = b.l_fundid(+)
   --and a.l_date = '20161219' --截至日期
   --and b.vc_code in ('CJ0012', '001199', 'CJ0009') --产品代码
   --and a.vc_code like '%%' --科目代码
   --and a.vc_name like '%%' --科目名称