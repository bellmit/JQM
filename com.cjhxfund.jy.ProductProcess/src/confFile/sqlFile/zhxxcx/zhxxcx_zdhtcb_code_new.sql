----综合信息查询SQL-获取AK金额中（1 托管户，6 上清DVP，7 中债DVP）任意一项为负数的产品CODE
select t1.vc_fund_code --基金代码
  from o32_cj.to32_js_rs t1
 where 1 = 1
   and t1.ak_col < 0
   and t1.xh in (1, 6, 7,8)
 group by t1.vc_fund_code
