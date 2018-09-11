select t1.b_check_flag,					--标志
       t1.l_date,						--录入日期
       t1.l_tradeorderno,				--交易指令编号
       t1.vc_srctradeid,				--源成交号，即外汇交易中心的成交编号
       t1.c_sourcefrom,					--交易来源 0 客户端（分销录入) 1 交易中心
       t1.vc_tablesource,				--表来源 1 交易指令
       t1.c_auditstatus,				--复核状态（X-不需复核、1-已撤回、2-待复核、3-复核中、4-复核退回、5-已作废、6-已复核、7-已复核未生效、8-已复核已生效）
       t1.c_orderstatus,				--指令状态（0-未生效、8-已生效、9-已修改、A-已删除、D-作废）
       t1.vc_tradeid,            		--成交编号，上清所给的交易指令ID，业务主键            
       t1.l_opordertype,				--会员操作指令类别 1 交易录入 10 交易买方确认 11 交易代理确认
       t1.c_tradetype,					--交易方式（4-现券买卖、5-债券远期、8-债券借贷、9-质押式回购、10-买断式回购、91非交易质押）
       t1.c_cleartype,					--清算方式（1-净额清算、2-全额结算）
       t1.vc_productcode,				--产品代码
       t1.vc_productname,				--产品简称
       t1.en_facevalue,					--产品面值（万元）
       t1.vc_buyerholderaccount,		--买方持有人账号
       t1.vc_bholdershortname,			--买方持有人简称
       t1.vc_boperholderaccount,		--买方操作持有人账号
       t1.vc_sellerholderaccount,		--卖方持有人账号
       t1.vc_sholdershortname,			--卖方持有人简称
       t1.vc_soperholderaccount,		--卖方操作持有人账号
       t1.en_settlementamount,			--结算金额
       t1.l_tradedate,					--交易日期
       t1.l_settlementdate,				--结算日期
       t1.c_buyerstatus,				--买方状态（0-待确认、3-确认拒绝、4-已确认、5-代理待确认、6-代理确认中、7-代理拒绝、8-代理已确认、9-风控检查不通过、A-风控检查通过）
       t1.c_sellerstatus,				--卖方状态（ 0-待确认、3-确认拒绝、4-已确认、5-代理待确认、6-代理确认中、7-代理拒绝、8-代理已确认、9-风控检查不通过、A-风控检查通过、C-已撤销）
       t1.vc_boperorderstatus,			--买方指令可操作状态
       t1.vc_soperorderstatus,			--卖方指令可操作状态
       t1.l_operid,						--操作员ID
       t1.vc_opername,					--操作员姓名
       t1.l_auditoperid,				--复核人编号
       t1.vc_auditopername,				--复核人姓名
       t1.l_settlementtype,				--结算方式（0-DVP 券款对付、11-NDVP 净额券款对付）
       t1.l_duesettledate,				--到期结算日期（用于回购）
       t1.en_duesettleamount,			--到期结算金额（用于回购）
       t1.l_duesettlemethod,			--到期结算方式（用于回购 0-DVP 券款对付 11-NDVP 净额券款对付）
       t1.c_send_status,				--发送状态（0-未生效、1-未报、2-待报、3-已报、4-待确认、5-匹配失败）
       t1.c_match_flag,					--成交匹配状态 /*0-未匹配未确认(缺省)，1-已匹配未确认，2-无需匹配未确认，3-未匹配已确认，4-已匹配已确认， 5-无需匹配已确认，6-未匹配无需确认，7-已匹配无需确认，8-无需匹配无需确认 9-已撤成交未确认 a-已撤成交已确认 b-已撤成交无需确认 */
       t1.vc_match_errmsg,				--匹配返回信息
       t1.l_conf_operator,				--确认人编号
       t1.vc_conf_operator_name,		--确认人名称
       t1.en_cleanprice,				--净价
       t1.en_fullprice,					--全价
       t1.en_accruedinterest,			--应计利息
       t1.en_repodays,					--回购天数
       t1.c_distributionflag,			--是否分销
       t1.vc_reason,					--失败原因
       t1.c_paystock_dir,
       t1.c_from,
       t1.vc_selfconf_status,
       t1.vc_ravilconf_status
  from (select b.*,
               case
                 when b.c_paystock_dir = '1' then
                  c_buyerstatus
                 else
                  c_sellerstatus
               end vc_selfconf_status,
               case
                 when b.c_paystock_dir = '2' then
                  c_buyerstatus
                 else
                  c_sellerstatus
               end vc_ravilconf_status
          from (select 0 b_check_flag,
                       l_date,
                       l_initdate,
                       l_tradeorderno,
                       vc_srctradeid,
                       decode(c_sourcefrom,
                       '0','客户端（分销录入)',
                       '1','交易中心')as c_sourcefrom,
                       vc_tablesource,
                       c_auditstatus,
                       decode(c_orderstatus,
                       '0','未生效',
                       '8','已生效',
                       '9','已修改',
                       'A','已删除',
                       'D','作废')as c_orderstatus,
                       vc_tradeid,
                       l_opordertype,
                       decode(c_tradetype,
				       '4','现券买卖',
				       '5','债券远期',
				       '8','债券借贷',
				       '9','质押式回购',
				       '10','买断式回购',
				       '91','非交易质押') as c_tradetype,
                       decode(c_cleartype,
                       '1','净额清算',
                       '2','全额结算')as c_cleartype,
                       vc_productcode,
                       vc_productname,
                       en_facevalue,
                       vc_buyerholderaccount,
                       vc_bholdershortname,
                       vc_boperholderaccount,
                       vc_sellerholderaccount,
                       vc_sholdershortname,
                       vc_soperholderaccount,
                       en_settlementamount,
                       l_tradedate,
                       l_settlementdate,
                       decode(c_buyerstatus,
				       '0','待确认',
				       '3','确认拒绝',
				       '4','已确认',
				       '5','代理待确认',
				       '6','代理确认中',
				       '7','代理拒绝',
				       '8','代理已确认',
				       '9','风控检查不通过',
				       'A','风控检查通过') as c_buyerstatus,
				       decode(c_sellerstatus,
				       '0','待确认',
				       '3','确认拒绝',
				       '4','已确认',
				       '5','代理待确认',
				       '6','代理确认中',
				       '7','代理拒绝',
				       '8','代理已确认',
				       '9','风控检查不通过',
				       'A','风控检查通过',
				       'C','已撤销') as c_sellerstatus,
                       vc_boperorderstatus,
                       vc_soperorderstatus,
                       l_operid,
                       vc_opername,
                       l_auditoperid,
                       vc_auditopername,
                       decode(l_settlementtype,
                       '0','DVP 券款对付',
                       '11','NDVP 净额券款对付')as l_settlementtype,
                       l_duesettledate,
                       en_duesettleamount,
                       decode(l_duesettlemethod,
                       '0','DVP 券款对付',
                       '11','NDVP 净额券款对付')as l_duesettlemethod,
                       c_send_status,
                       l_serial_no,
                       decode(c_match_flag,
				       '0','未匹配未确认',
				       '1','已匹配未确认',
				       '2','无需匹配未确认',
				       '3','未匹配已确认',
				       '4','已匹配已确认',
				       '5','无需匹配已确认',
				       '6','未匹配无需确认',
				       '7','已匹配无需确认',
				       '8','无需匹配无需确认',
				       '9','已撤成交未确认',
				       'a','已撤成交已确认',
				       'b','已撤成交无需确认') as c_match_flag,
                       vc_match_errmsg,
                       l_conf_operator,
                       vc_conf_operator_name,
                       en_cleanprice,
                       en_fullprice,
                       en_accruedinterest,
                       en_repodays,
                       c_distributionflag,
                       vc_reason,
                       nvl((select case
                                    when instr(f.vc_shclearing_account,
                                               a.vc_buyerholderaccount) > 0 then
                                     '1'
                                    else
                                     '2'
                                  end
                             from trade.tfundinfo f
                            where (instr(f.vc_shclearing_account,
                                         a.vc_buyerholderaccount) > 0 or
                                  instr(f.vc_shclearing_account,
                                         a.vc_sellerholderaccount) > 0)
                              and f.l_org_id = 0
                              and f.l_dept_id = 0
                              and rownum = 1),
                           '1') c_paystock_dir,
                       1 c_from
                  from trade.tsqsjyinst a) b) t1
   where 1 = 1