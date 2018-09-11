--后台成交-上清-全额结算指令表
select 
		a.L_UPDATEDT,--更新日期
		a.VC_TXID, --源交易编号              
       a.VC_STTLMORDERCD, --结算指令编号            
       a.VC_TXDT, --成交编号                
       a.VC_FRSTORSCND, --首期/到期               
       a.VC_BIZTP, --业务品种                
       a.VC_STTLMTP, --结算方式                
       a.VC_STTLMORDERSTS, --结算指令状态            
       a.VC_PRODSTTLMSTS, --产品结算状态            
       a.VC_FUNDSTTLMSTS, --资金结算状态            
       a.VC_BUYERACCT, --买/融入/逆回购方账号    
       a.VC_BUYERSHORTNM, --买/融入/逆回购方简称    
       a.VC_BUYERAGNTACCT, --买/融入/逆回购方代理账号
       a.VC_BUYERAGNTSHORTNM, --买/融入/逆回购方代理简称
       a.VC_SELLERACCT, --卖/融出/正回购方账号    
       a.VC_SELLERSHORTNM, --卖/融出/正回购方简称    
       a.VC_SELLERAGNTACCT, --卖/融出/正回购方代理账号
       a.VC_SELLERAGNTSHORTNM, --卖/融出/正回购方代理简称
       a.VC_STOCKCD, --证券代码                
       a.VC_STOCKNM, --证券简称                
       a.VC_STOCKFACEAMT, --证券面额(万元)          
       a.VC_FUNDSTTLMVAL, --资金结算金额(元)        
       a.VC_STTLMDT, --结算日                  
       a.VC_ODRGNRTDATE, --指令生成日              
       a.VC_ODRFRSTGNRTTM, --指令首次创建时间        
       a.VC_ODRUPDATETM, --指令更新时间            
       a.VC_PRODSTTLMGRACE, --产品结算宽限期          
       a.VC_FUNDSTTLMGRACE, --资金结算宽限期          
       a.VC_RCVPMTCFMER, --收付款确认人            
       a.VC_RCVPMTCFMCHECKER, --收付款确认复核人        
       a.VC_ODRREVOCATIONSIDE, --指令撤销方              
       a.VC_REVOCATIONTM, --撤销时间                
       a.VC_REVOCATIONCFMER, --撤销确认方              
       a.VC_REVOCATIONCFMTM, --撤销确认时间            
       a.VC_REVOCATIONRSLT --撤销处理结果            
  from stage.t_ats_bs_full_tally_order a
 where 1 = 1
   --and a.vc_biztp like '% %' --业务品种 
   --and a.vc_sttlmordersts like '% %' --结算指令状态  
   --and a.vc_prodsttlmsts like '% %' --产品结算状态  
   --and a.vc_fundsttlmsts like '% %' --资金结算状态 
   --and a.vc_buyershortnm like '% %' --买/融入/逆回购方简称
   --and a.vc_sellershortnm like '% %' --卖/融出/正回购方简称    
   --and a.vc_stocknm like '% %' --证券简称 
   --and a.vc_sttlmdt =	'' --结算日   
   --and a.vc_odrgnrtdate = '' --指令生成日
