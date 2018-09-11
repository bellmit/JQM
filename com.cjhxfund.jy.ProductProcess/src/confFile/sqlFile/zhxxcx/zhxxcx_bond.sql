select cbd.s_info_windcode, --Wind代码
       cbd.b_info_issuercode,
       cbd.s_info_name, --证券名称
       cbd.B_INFO_DELISTDATE, --债券摘牌日 
       cba.B_ANAL_NET_CNBD, --净价
       cbt.B_INFO_CREDITRATING       bIC1, --债项评级（孰新）
       cbi.B_INFO_CREDITRATING       bIC2, --主体评级（孰新）
       zxpj.B_INFO_CREDITRATING      bIC3, --债项评级（孰低）
       zhuxpj.B_INFO_CREDITRATING    bIC4, --主体评级（孰低）
       cbp.B_INFO_PAYMENTDATE, --距离付息日
       cbpc.bICD, --下一行权日
       cbis.B_AGENCY_GUARANTORNATURE, --公司属性
       isr.B_RATE_RATINGOUTLOOK, --是否负面
       decode(pw.object_id,null,'0','1') is_city_invest, --是否城投
       instr(val.B_ANAL_PTMYEAR,'+N') B_ANAL_PTMYEAR, --是否永续
       ind.S_INFO_INDUSTRYNAME2, --wind一级行业
       cin.province, --发行人省份
       decode(tqhb.b_info_provisiontype,null,'0','1') is_pay_early --是否提前还本

  from (select *
          from wind2_CBondDescription
         where s_info_windcode in (To_Replace_Windcode)) cbd
  left join wind2_CBondAnalysisCNBD cba
    on cbd.s_info_windcode = cba.s_info_windcode

  left join (select cbt1.s_info_windcode,
                    cbt1.B_INFO_CREDITRATING,
                    cbt1.ANN_DT
               from WIND2_CBONDRATING cbt1
              inner join (select s_info_windcode, max(ANN_DT) as ad
                           from WIND2_CBONDRATING
                          group by s_info_windcode) cbt2
                 on cbt1.s_info_windcode = cbt2.s_info_windcode
                and cbt1.ANN_DT = cbt2.ad) cbt
    on cbd.s_info_windcode = cbt.s_info_windcode

  left join (select cbi1.s_info_compcode,
                    cbi1.B_INFO_CREDITRATING,
                    cbi1.ANN_DT
               from WIND2_CBONDISSUERRATING cbi1
              inner join (select s_info_compcode, max(ANN_DT) as at
                           from WIND2_CBONDISSUERRATING
                          group by s_info_compcode) cbi2
                 on cbi1.s_info_compcode = cbi2.s_info_compcode
                and cbi1.ANN_DT = cbi2.at) cbi
    on cbd.b_info_issuercode = cbi.s_info_compcode
  
  left join (
  select s_info_windcode, B_INFO_CREDITRATING, max(ANN_DT) at
  from (select zxpj3.s_info_windcode,
               zxpj3.B_INFO_CREDITRATING,
               zxpj3.ANN_DT
          from (select s_info_windcode,
                       B_INFO_CREDITRATING,
                       decode(B_INFO_CREDITRATING,
                              'AAA',
                              1,
                              'AA+',
                              2,
                              'AA',
                              3,
                              'AA-',
                              4,
                              'A+',
                              5,
                              'A',
                              6,
                              'A-',
                              7,
                              'BBB',
                              8,
                              'BB+',
                              9,
                              'BB',
                              10,
                              'BB-',
                              11,
                              'B+',
                              12,
                              'B',
                              13,
                              'B-',
                              14,
                              'CCC',
                              15,
                              'CC',
                              16,
                              'C',
                              17,
                              0) bondrank,
                       ANN_DT
                  from WIND2_CBONDRATING
                 where to_number(ANN_DT) >=
                       to_number(to_char(sysdate, 'yyyymmdd')) - 10000) zxpj3,
               (select s_info_windcode, max(bondrank) bondrank
                  from (select s_info_windcode,
                               B_INFO_CREDITRATING,
                               decode(B_INFO_CREDITRATING,
                                      'AAA',
                                      1,
                                      'AA+',
                                      2,
                                      'AA',
                                      3,
                                      'AA-',
                                      4,
                                      'A+',
                                      5,
                                      'A',
                                      6,
                                      'A-',
                                      7,
                                      'BBB',
                                      8,
                                      'BB+',
                                      9,
                                      'BB',
                                      10,
                                      'BB-',
                                      11,
                                      'B+',
                                      12,
                                      'B',
                                      13,
                                      'B-',
                                      14,
                                      'CCC',
                                      15,
                                      'CC',
                                      16,
                                      'C',
                                      17,
                                      0) bondrank,
                               ANN_DT
                          from WIND2_CBONDRATING
                         where to_number(ANN_DT) >=
                               to_number(to_char(sysdate, 'yyyymmdd')) - 10000) zxpj1
                 group by s_info_windcode) zxpj2
         where zxpj3.bondrank = zxpj2.bondrank
           and zxpj3.s_info_windcode = zxpj2.s_info_windcode) zxpj4
 group by s_info_windcode, B_INFO_CREDITRATING
  )zxpj
  on cbd.s_info_windcode = zxpj.s_info_windcode
  
  left join(
select s_info_compcode, B_INFO_CREDITRATING, max(ANN_DT) at
  from (select zhuxpj3.s_info_compcode,
               zhuxpj3.B_INFO_CREDITRATING,
               zhuxpj3.ANN_DT
          from (select s_info_compcode,
                       B_INFO_CREDITRATING,
                       decode(B_INFO_CREDITRATING,
                              'AAA',
                              1,
                              'AA+',
                              2,
                              'AA',
                              3,
                              'AA-',
                              4,
                              'A+',
                              5,
                              'A',
                              6,
                              'A-',
                              7,
                              'BBB',
                              8,
                              'BB+',
                              9,
                              'BB',
                              10,
                              'BB-',
                              11,
                              'B+',
                              12,
                              'B',
                              13,
                              'B-',
                              14,
                              'CCC',
                              15,
                              'CC',
                              16,
                              'C',
                              17,
                              0) bondrank,
                       ANN_DT
                  from WIND2_CBONDISSUERRATING
                 where to_number(ANN_DT) >=
                       to_number(to_char(sysdate, 'yyyymmdd')) - 10000) zhuxpj3,
               (select s_info_compcode, max(bondrank) bondrank
                  from (select s_info_compcode,
                               B_INFO_CREDITRATING,
                               decode(B_INFO_CREDITRATING,
                                      'AAA',
                                      1,
                                      'AA+',
                                      2,
                                      'AA',
                                      3,
                                      'AA-',
                                      4,
                                      'A+',
                                      5,
                                      'A',
                                      6,
                                      'A-',
                                      7,
                                      'BBB',
                                      8,
                                      'BB+',
                                      9,
                                      'BB',
                                      10,
                                      'BB-',
                                      11,
                                      'B+',
                                      12,
                                      'B',
                                      13,
                                      'B-',
                                      14,
                                      'CCC',
                                      15,
                                      'CC',
                                      16,
                                      'C',
                                      17,
                                      0) bondrank,
                               ANN_DT
                          from WIND2_CBONDISSUERRATING
                         where to_number(ANN_DT) >=
                               to_number(to_char(sysdate, 'yyyymmdd')) - 10000) zhuxpj1
                 group by s_info_compcode) zhuxpj2
         where zhuxpj3.bondrank = zhuxpj2.bondrank
           and zhuxpj3.s_info_compcode = zhuxpj2.s_info_compcode) zhuxpj4
 group by s_info_compcode, B_INFO_CREDITRATING
  )zhuxpj
  on cbd.b_info_issuercode = zhuxpj.s_info_compcode
  
  left join (
       select s_info_windcode,min(B_INFO_PAYMENTDATE) B_INFO_PAYMENTDATE
       from wind2_CBondPayment
       where B_INFO_PAYMENTDATE > to_char(sysdate,'yyyymmdd')
       group by s_info_windcode
  )cbp
    on cbd.s_info_windcode = cbp.s_info_windcode

  left join (
       select s_info_windcode,max(B_INFO_CALLBKORPUTBKDATE) as bICD
       from wind2_CBondSpecialConditions
       group by s_info_windcode
  ) cbpc
    on cbd.s_info_windcode = cbpc.s_info_windcode

  left join WIND2_CBONDISSUER cbis
    on cbd.s_info_windcode = cbis.s_info_windcode

  left join (select isr1.s_info_compcode,
                    isr1.B_RATE_RATINGOUTLOOK,
                    isr1.ANN_DT
               from wind2_CBondIssuerRating isr1
              inner join (select s_info_compcode, max(ANN_DT) as at
                           from wind2_CBondIssuerRating
                          group by s_info_compcode) isr2
                 on isr1.s_info_compcode = isr2.s_info_compcode
                and isr1.ANN_DT = isr2.at) isr
    on cbd.b_info_issuercode = isr.s_info_compcode

  left join wind2_cbondplatewind pw
    on cbd.s_info_windcode = pw.s_info_windcode

  left join (select val1.s_info_windcode, val1.B_ANAL_PTMYEAR, val1.TRADE_DT
               from wind2_CBondValuation val1
              inner join (select s_info_windcode, max(TRADE_DT) as at
                           from wind2_CBondValuation
                          group by s_info_windcode) val2
                 on val1.s_info_windcode = val2.s_info_windcode
                and val1.TRADE_DT = val2.at) val
    on cbd.s_info_windcode = val.s_info_windcode

  left join WIND2_CBONDINDUSTRYWIND ind
    on cbd.s_info_windcode = ind.s_info_windcode

  left join wind2_compintroduction cin
    on cbd.b_info_issuercode = cin.comp_id
  
  left join(
       select s_info_windcode,b_info_provisiontype from wind2_CBondSpecialConditions
       where b_info_provisiontype like '%债券提前偿还%'
  )tqhb
  on cbd.s_info_windcode = tqhb.s_info_windcode
  
 where 1 = 1
--and cbd.s_info_windcode = '143081.SH'
