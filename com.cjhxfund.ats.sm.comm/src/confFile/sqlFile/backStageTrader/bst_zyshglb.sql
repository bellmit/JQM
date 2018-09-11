--后台成交-上清-质押式回购表
select
		a.L_UPDATEDT,--更新日期
		a.VC_TXID, --源交易编号        
       a.VC_TXCD, --成交编号          
       a.VC_TXDT, --成交日期          
       a.VC_TRADESTS, --交易状态          
       a.VC_TRADEREM, --交易状态备注      
       a.VC_SELLREPOACCT, --正回购方持有人账号
       a.VC_SELLREPONM, --正回购方持有人简称
       a.VC_REVREPOACCT, --逆回购方持有人账号
       a.VC_REVREPONM, --逆回购方持有人简称
       a.VC_REPODAYS, --回购天数          
       a.VC_CLTP, --清算方式          
       a.VC_FRSTSTTLMVAL, --首期结算金额(元)  
       a.VC_FRSTSTTLMTP, --首期结算方式      
       a.VC_FRSTSTTLMDT, --首期结算日期      
       a.VC_SCNDSTTLMVAL, --到期结算金额(元)  
       a.VC_SCNDSTTLMTP, --到期结算方式      
       a.VC_SCNDSTTLMDT, --到期结算日期      
       a.VC_SELLREPOSTS, --正回购方状态      
       a.VC_SELLREPOSTSREM, --正回购方状态备注  
       a.VC_REVREPOSTS, --逆回购方状态      
       a.VC_REVREPOSTSREM, --逆回购方状态备注  
       a.VC_TRADESRC --交易来源           
  from stage.t_ats_bs_pledge_style_repo a
 where 1 = 1
   --and a.vc_txdt like '%%' --成交日期
   --and a.vc_tradests like '%%' --交易状态    
   --and a.vc_sellreponm like '%%' --正回购方持有人简称
   --and a.vc_revreponm like '%%' --逆回购方持有人简称
   --and a.vc_frststtlmdt = '' --首期结算日期
   --and a.vc_scndsttlmdt = '' --到期结算日期    
   --and a.vc_sellreposts like '%%' --正回购方状态      
   --and a.vc_revreposts like '%%' --逆回购方状态      
