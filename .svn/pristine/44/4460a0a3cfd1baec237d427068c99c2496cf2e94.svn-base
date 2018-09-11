--头寸查询-产品头寸风险测算
select t1.l_fund_id,                            --A 基金ID
       t1.vc_fund_code,                         --B 基金代码
       t1.vc_fund_name,                         --C 基金名称
       t1.EN_FUND_NET_ASSET as ak_col,      --AK 基金净资产
       t1.EN_FUND_TOTAL_ASSET as al_col,    --AL 基金总资产
       t1.en_hg_expire_leverage_ratio as d_col,  --D 融资回购占净资产比例
       t1.en_hg_expire_no_leverage_ratio e_col,  --E 融资回购占净资产比例_未到期
       t1.en_financial_leverage_ratio as f_col,  --F 财务杠杆率
       t1.en_pos_covrg_ratio_guar as g_col,--G 交易所担保交收头寸覆盖率
       t1.en_pos_covrg_ratio_all_guar as h_col,  --H 交易所担保交收头寸覆盖率_全部
       t1.en_pos_covrg_ratio_non_guar as i_col, --I 交易所非担保交收头寸覆盖率
       t1.en_pos_covrg_ratio_cibm as j_col,     --J 银行间头寸覆盖率
       t1.en_pos_covrg_ratio_net_cibm as k_col,  --K 银行间头寸覆盖率_质押券
       t1.en_realizable_covrg_ratio_cibm l_col,  --L 银行间T+0可变现覆盖率
       t1.en_realizable_covrg_ratio tl_col,  --TL T+0可变现覆盖率
       t1.en_rz_gh_bal as m_col,                --M 交易所正回购到期余额 
       t1.en_rq_gh_bal as n_col,                --N 交易所逆回购到期余额
       t1.EN_RZ_GH_OVER_BAL as am_col,      --AM 交易所正回购未到期余额
       t1.en_rz_gh_bal_pact as o_col,           --O 交易所协议正回购到期余额
       t1.en_rq_gh_bal_pact as p_col,           --P 交易所协议逆回购到期余额
       t1.EN_RZ_GH_OVER_BAL_PACT as an_col,    --AN 交易所协议正回购未到期余额
       t1.en_rz_gh_bal_cibm as q_col,           --Q 银行间正回购到期余额
       t1.en_rq_gh_bal_cibm as r_col,           --R 银行间逆回购到期余额
       t1.EN_RZ_GH_OVER_BAL_CIBM as ao_col,    --AO 银行间正回购未到期余额
       t1.en_dpst_expire_bal as s_col,          --S 存款到期兑付金额
       t1.en_fund_redeem_bal as t_col,          --T 基金赎回款
       t1.en_ytd_t1_sale_bal_cibm as u_col,     --U 昨日T+1银行间卖券金额
       t1.en_t0_realizable_bal as v_col,        --V T+0可变现金额
       t1.en_t0_realizable_sh_bal as w_col,     --W T+0可变现金额_上海固收平台
       t1.en_t0_realizable_sz_bal as x_col,     --X T+0可变现金额_深圳协议平台
       t1.en_t0_realizable_cibm_bal as y_col,   --Y T+0可变现金额_银行间市场
       t1.en_t0_realizable_cibm_zz_bal as z_col,--Z T+0可变现金额_银行间市场_中债
       t1.en_t0_realizable_cibm_sq_bal aa_col,  --AA T+0可变现金额_银行间市场_上清
       t1.en_t1_realizable_bal as ab_col,       --AB T+1可变现金额
       t1.en_t1_realizable_std_bal as ac_col,   --AC T+1可变现金额_标准券可用金额
       t1.en_t1_realizable_pledge_amt as ad_col,--AD T+1可变现金额_可质押入库数量
       t1.en_t1_realizable_pledge_bal as ae_col,--AE T+1可变现金额_可质押入库金额
       t2.wtr as af_col,                        --AF 委托人
       t2.sczjly as ag_col,                     --AG 上层资金来源
       t2.sczjzjgl as ah_col,                   --AH 上层资金概率
       t2.sczjzjed as ai_col,                   --AI 上层资金额度
       t2.bz as aj_col                          --AJ 手工调整备注
  from o32_cj.tpositionriskforecast t1
  left join (select a.*
  from o32_cj.to32_sj_sczjzj a
 inner join (select l_fund_id, max(tzsj) as tzsj
               from o32_cj.to32_sj_sczjzj
              group by l_fund_id) b
    on a.l_fund_id = b.l_fund_id
   and a.tzsj = b.tzsj) t2
    on t1.l_fund_id = t2.l_fund_id
 where 1 = 1