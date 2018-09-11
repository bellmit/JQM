select t.l_date, --统计日期
       t.vc_fund_code, --基金代码
       t.vc_fund_name, --基金名称
       sum(t.en_dwjz) en_nav, --单位净值
       sum(t.en_ljdwjz) en_total_nav, --累计单位净值
       sum(t.en_jjzcjz) en_fund_value, --净值
       sum(t.en_jjzczzc) en_total_zc--总资产
  from (select case
                 when a.vc_bzw = '0110' then
                  replace(a.vc_kmmc, ',', '')
                 else
                  '0'
               end en_dwjz, --单位净值
               case
                 when a.vc_bzw = '0114' then
                  replace(a.vc_kmmc, ',', '')
                 else
                  '0'
               end en_ljdwjz, --累计单位净值
               case
                 when a.vc_bzw = '0001' then
                  a.en_sz
                 else
                  0
               end en_jjzcjz, --净值
               case
                 when a.vc_bzw = '0008' then
                  a.en_sz
                 else
                  0
               end en_jjzczzc,--总资产
               b.vc_name vc_fund_name, --基金名称
               to_char(a.d_ywrq, 'yyyymmdd') l_date, --统计日期
               b.vc_code vc_fund_code --基金代码
          from stage.fa_ttmp_h_gzb a, stage.fa_tfundinfo b
         where 1 = 1
           and a.l_ztbh = b.l_fundid(+)) t
 where 1 = 1