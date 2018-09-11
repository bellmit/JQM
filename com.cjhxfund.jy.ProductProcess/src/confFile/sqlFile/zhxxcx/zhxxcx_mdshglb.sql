--后台成交-上清-买断式回购表
select a.VC_TXID, --源交易编号        
       a.VC_TXCD, --成交编号   
       a.L_UPDATEDT,--更新日期      
       a.VC_TXDT, --成交日期          
       a.VC_TRADESTS, --交易状态          
       a.VC_TRADERSTSEM, --交易状态备注      
       a.VC_STOCKCD, --证券代码          
       a.VC_STOCKNM, --证券简称          
       a.VC_SELLREPOACCT, --正回购方持有人账号
       a.VC_SELLREPONM, --正回购方持有人简称
       a.VC_REVREPOACCT, --逆回购方持有人账号
       a.VC_REVREPONM, --逆回购方持有人简称
       a.VC_REPODAYS, --回购天数          
       a.VC_CLTP, --清算方式          
       a.VC_STTLMVAL, --成交面额(万元)    
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
  from stage.T_ATS_BS_BUYOUT_REPURCHASE a
 where 1 = 1
   --and a.vc_txdt like '%%'
   --and a.vc_tradests like '%%'
   --and a.vc_stocknm like '%%'
   --and a.vc_sellreponm like '%%'
   --and a.vc_revreponm like '%%'
   --and a.vc_frststtlmdt like '%%'
   --and a.vc_scndsttlmdt like '%%'
   --and a.vc_sellreposts like '%%'
   --and a.vc_revreposts like '%%'
