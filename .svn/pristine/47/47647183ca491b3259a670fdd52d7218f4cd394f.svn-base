 select 
       FXJG_NAME                         --
      ,DY_BALANCE_CODE                   --发行机构代码
      ,ISSUE_AMOUNT                      --对应资产管理计划行内资产/负债编码
      ,CURRENT_AMOUNT                    --资管计划当前总发行数量
      ,NO_INVESTMENT_POSITIONS           --资管计划当前总折算人民币发行金额(元)
      ,BALANCE_NAME                      --资管计划折算人民币未投资头寸(元)
      ,BALANCE_CODE                      --底层资产行内资产负债/编码
      ,POAIRION_QUANTITY                 --底层资产持仓数量
      ,RMB_VALUR                         --底层资产折算人民币市值(元)
      ,TO_CHAR(TO_DATE(CC_DATE,'YYYYMMDD'),'YYYY/MM/DD') as CC_DATE--持仓日期
  from dw.A001_ASSET_POSITION a
inner join dw.v_dim_product b
  on a.product_no=b.bk_portfolio
  and b.dk_priority in ('1','3')