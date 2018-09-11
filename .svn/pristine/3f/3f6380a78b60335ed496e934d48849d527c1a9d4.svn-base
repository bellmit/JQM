--后台成交-上清-现券交易表
select
		a.L_UPDATEDT,--更新日期
		a.VC_TXID, --源交易编号    
       a.VC_TXCD, --成交编号      
       a.VC_TXDT, --交易日期      
       a.VC_TRADESTS, --交易状态      
       a.VC_TRADESTSREM, --交易状态备注  
       a.VC_STTLMDT, --结算日期      
       a.VC_STOCKCD, --证券代码      
       a.VC_STOCKNM, --证券简称      
       a.VC_BUYERACCT, --买方持有人账号
       a.VC_BUYERNM, --买方持有人简称
       a.VC_SELLERACCT, --卖方持有人账号
       a.VC_SELLERNM, --卖方持有人简称
       a.VC_TXFACEAMT, --成交面额(万元)
       a.VC_STTLMVAL, --结算金额(元)  
       a.VC_PERCLPRIC, --百元净价(元)  
       a.VC_PEROHPRIC, --百元全价(元)  
       a.VC_INTEREST, --应计利息(元)  
       a.VC_CLTP, --清算方式      
       a.VC_STTLMTP, --结算方式      
       a.VC_BUYERSTS, --买方状态      
       a.VC_BUYERSTSREM, --买方状态备注  
       a.VC_SELLERSTS, --卖方状态      
       a.VC_SELLERSTSREM, --卖方状态备注  
       a.VC_TRADESRC --交易来源   
  from stage.t_ats_bs_bond_trade a
 where 1 = 1
   --and a.VC_TXDT = '' --交易日期
   --and a.VC_TRADESTS like '% %' --交易状态
   --and a.VC_STTLMDT = '' --结算日期
   --and a.VC_STOCKNM like '% %' --证券简称
   --and a.VC_BUYERNM like '% %' --买方持有人简称
   --and a.VC_SELLERNM like '% %' --卖方持有人简称
   --and a.VC_BUYERSTS like '% %' --买方状态
   --and a.VC_SELLERSTS like '% %' --卖方状态
