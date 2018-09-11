----综合信息查询SQL-资金头寸：基金财务-资金类管理-资金管理-资金管理
--需要字段：日期，基金名称，资产单元，交易保证金，冻结金额，期初现金余额，T+0交易可用，T+1交易可用，T+2交易可用，可用期货保证金，日初T日可用金额，日初T+1日可用金额
--取不到字段：T+0交易可用，T+1交易可用，T+2交易可用，可用期货保证金
select L_DATE, --日期
       VC_FUND_CODE, --基金代码
       VC_FUND_NAME, --基金名称
       L_FUND_ID, --基金编号
       L_ASSET_ID, --单元编号
       VC_ASSET_NAME, --资产单元
       T0ZLKY, --T+0 指令可用
       T0JYKY, --T+0 交易可用
       T1ZLKY, --T+1 指令可用
       T1JYKY, --T+1交易可用
       T0ZLKY2, --不包含T+1变化的T+0可用
       EN_BASIC_FROZEN_BALANCE, --交易保证金
       EN_FROZEN_BALANCE, --冻结金额
       EN_BEGIN_CASH, --期初现金余额
       EN_BEGIN_T0_ENABLE, --日初T日可用金额
       EN_BEGIN_T1_ENABLE, --日初T+1日可用金额
       EN_FUTURES_BALANCE --期货保证金余额
  from (select x.*, x.bankAsset - x.en_basic_frozen_balance en_yebzj_balance,jyky.t0zlky,jyky.t0jyky,jyky.t1zlky,jyky.t1jyky,jyky.t0zlky2
          from (SELECT DISTINCT a.l_date,
                                a.l_fund_id,
                                b.vc_fund_code,
                                b.vc_fund_name,
                                a.l_asset_id,
                                c.vc_asset_name,
                                b.c_fund_status,
                                a.en_begin_cash,
                                decode(a.l_date,
                                       b.l_business_date,
                                       (a.en_current_cash +
                                       a.en_unfrozen_balance -
                                       a.en_frozen_balance),
                                       0) en_usable_cash,
                                a.en_current_cash,
                                a.en_basic_frozen_balance en_basic_frozen_balance,
                                a.en_frozen_balance,
                                a.en_unfrozen_balance,
                                0 en_t1_cash,
                                0 en_t2_cash,
                                0 en_new_t0_enable,
                                (a.en_frozen_balance - a.en_unfrozen_balance) en_diff_frozen,
                                a.en_buy_balance,
                                a.en_sale_balance,
                                en_futures_balance,
                                nvl(a.en_payin_balance, 0) en_payin_balance,
                                nvl(en_payout_balance, 0) en_payout_balance,
                                nvl(en_payin_total, 0) en_payin_total,
                                nvl(en_payout_total, 0) en_payout_total,
                                '正常' vc_check_flag,
                                a.vc_currency_no,
                                d.vc_currency_name,
                                0 en_futures_enable,
                                nvl(a.en_begin_t0_enable, 0) en_begin_t0_enable,
                                nvl(a.en_begin_t1_enable, 0) en_begin_t1_enable,
                                a.en_current_cash -
                                trade.sf_account_deposit(a.l_fund_id,
                                                         a.l_asset_id,
                                                         2,
                                                         a.l_date,
                                                         a.vc_currency_no) bankAsset,
                                nvl(a.EN_BEGIN_FUTURE_RIGHTS, 0) EN_BEGIN_FUTURE_RIGHTS,
                                c.vc_remarks,
                                bk.vc_bank_name vc_custodian_name,
                                0 en_t0Ins_cash,
                                0 en_t1Ins_cash,
                                0 en_t2Ins_cash,
                                en_secacc_bonus,
                                nvl(a.en_preipo_deposit, 0) en_preipo_deposit,
                                0 en_bankTradeT0,
                                0 en_bankTradeT1,
                                a.en_current_cash -
                                trade.sf_account_deposit(a.l_fund_id,
                                                         a.l_asset_id,
                                                         2,
                                                         a.l_date,
                                                         a.vc_currency_no) -
                                en_futures_balance en_BankFuture,
                                en_futures_balance en_OccupyFuture
                  FROM trade.tassetday     a,
                       trade.tfundinfo     b,
                       trade.tasset        c,
                       trade.tcurrencyinfo d,
                       trade.tbankinfo     bk
                 WHERE a.l_fund_id = b.l_fund_id
                   AND a.l_asset_id = c.l_asset_id
                   AND d.vc_currency_no = a.vc_currency_no
                   and b.l_local_custodian = bk.l_bank_no(+)
                   and b.c_fund_status not in ('4', '5')
                   and upper(a.vc_currency_no) = 'CNY') x,
               o32_cj.to32_pos_rst jyky
         where x.l_fund_id = jyky.l_fund_id
           and x.l_asset_id = jyky.l_asset_id) tt
 where 1 = 1
   --and tt.VC_FUND_CODE in ('', '') --基金代码
   --and tt.VC_ASSET_NAME like '%%' --资产单元
 --order by tt.L_DATE desc, tt.VC_FUND_CODE asc, tt.VC_ASSET_NAME asc
