select 
      a.information_plan_name              --资管计划名称
      ,a.total_amount                       --金额
      ,to_char(to_date(a.expiration_date,'yyyymmdd'),'yyyy/mm/dd')  as EXPIRATION_DATE --到期日
      ,a.no_investment_positions            --资管计划折算人民币未投资头寸(元)
      ,a.balance_code                       --底层资产行内资产负债/编码
      ,a.bottom_name                        --底层名称
      ,a.credit_rating                      --评级
      ,a.bond_type                          --债券类别
      ,replace(a.asset_to_date,'-','/') as ASSET_TO_DATE      --底层资产到期日
      ,a.poairion_quantity                  --底层资产持仓数量
      ,a.rmb_valur                          --底层资产折算人民币市值(元)
      ,to_char(to_date(a.cc_date,'yyyymmdd'),'yyyy/mm/dd')  as CC_DATE --持仓日期
 from dw.a001_position_book a
inner join dw.v_dim_product b
  on a.product_no=b.bk_portfolio
  and b.dk_priority in ('1','3')