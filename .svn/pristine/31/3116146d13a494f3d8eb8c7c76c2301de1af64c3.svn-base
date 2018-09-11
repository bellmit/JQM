--后台成交-中债-结算合同下载表
select  a.VC_CTRCTID,					  --合同编号                                                                 
		a.VC_INSTRORGNACCT,               --指令来源账号
		a.L_UPDATEDT,--更新日期                                                          
		a.VC_BDGVRACCT,                   --付券方账号                                                               
		a.VC_ACCTWTHDVPNETGCONFD,         --预发行净额结算DVP被确认账号                                              
		a.VC_ACCTWTHMRGNBLCKGCONFD,       --保证金冻结确认被确认账号                                                 
		a.VC_ACCTWHTMRGNUNBLCKGCONFD,     --保证金解冻确认被确认账号                                                 
		a.VC_BDGVRNM,                     --付券方简称                                                               
		a.VC_BDGVRSUBACCT,                --付券方分组合号                                                           
		a.VC_BDGVRSUBNM,                  --付券方分组合简称                                                         
		a.VC_BDTAKERACCT,                 --收券方账号                                                               
		a.VC_BDTAKERNM,                   --收券方简称                                                               
		a.VC_BDTAKERSUBACCT,              --收券方分组合号                                                           
		a.VC_BDTAKESUBRNM,                --收券方分组合简称                                                         
		a.VC_TXID,                        --业务标识号                                                               
		a.VC_BIZTPCD,                     --业务类别编号                                                             
		a.VC_BIZTP,                       --业务类别描述                                                             
		a.VC_STTLMTPCD,                   --结算方式代码                                                             
		a.VC_STTLMTP,                     --结算方式符号描述                                                         
		a.VC_STTLMTPINCHIN,               --结算方式中文描述                                                         
		a.VC_BDGVRGRTEBDID,               --付券方保证券债券代码                                                     
		a.VC_BDGVRGRTEBDSHRTNM,           --付券方保证券债券简称                                                     
		a.VC_BDGVRGRTEBDFACEAMT,          --付券方保证券债券面额                                                     
		a.VC_OTCBUYGFACEAMT,              --柜台专项结算买入面额                                                     
		a.VC_BDGVRCSHCOLL,                --付券方保证金/融资质押实际融资金额/BEPS质押增加待分配额度/BEPS置换换入额度
		a.VC_OTCBUYGVAL,                  --柜台专项结算买入金额                                                     
		a.VC_BDTAKERGRTEBDID,             --收券方保证券债券代码                                                     
		a.VC_BDTAKERGRTEBDSHRTNM,         --收券方保证券债券简称                                                     
		a.VC_BDTAKERGRTEBDFACEAMT,        --收券方保证券债券面额                                                     
		a.VC_OTCSELLGVAL,                 --柜台专项结算卖出金额                                                     
		a.VC_BDTAKERCSHCOLL,              --收券方保证金/融资质押起点金额/BEPS置换换出额度                           
		a.VC_OTCSELLGFACEAMT,             --柜台专项结算卖出面额                                                     
		a.VC_BLCKGPMTVAL,                 --冻结缴款金额                                                             
		a.VC_BDCNT,                       --债券数目                                                                 
		a.VC_TTLFACEAMT,                  --债券总额                                                                 
		a.VC_CTRCTVAL,                    --合同金额/BEPS调增、调减额度                                              
		a.VC_SCTIESLNDGFEES,              --借贷业务融券费用                                                         
		a.VC_RATE,                        --回购利率                                                                 
		a.VC_DLVRYDT,                     --交割日                                                                   
		a.VC_INSTRIDTOCTRCT,              --生成合同的指令编号                                                       
		a.VC_ORGNLCTRCTID,                --原合同编号(期调、券置换、撤销合同时使用)                                 
		a.VC_ORGNLINSTRID,                --原指令编号(撤销指令的指令时使用)                                         
		a.VC_GVRBDSTSCD,                  --付券方券状态                                                             
		a.VC_GVRBDSTS,                    --付券方券状态描述                                                         
		a.VC_GVRGRTEBDSTSCD,              --付券方保证券状态                                                         
		a.VC_GVRGRTEBDSTS,                --付券方保证券状态描述                                                     
		a.VC_TAKERBDSTSCD,                --收券方券状态                                                             
		a.VC_TAKERBDSTS,                  --收券方券状态描述                                                         
		a.VC_TAKERGRTEBDSTSCD,            --收券方保证券状态                                                         
		a.VC_TAKERGRTEBD,                 --收券方保证券状态描述                                                     
		a.VC_CSHSTSCD,                    --资金状态                                                                 
		a.VC_CSHSTS,                      --资金状态描述                                                             
		a.VC_BLCKDSTSCD,                  --冻结状态                                                                 
		a.VC_BLCKDSTS,                    --冻结状态描述                                                             
		a.VC_EXCTDTM,                     --过户时间/失败时间                                                        
		a.VC_CTRCTSTSCD,                  --合同状态                                                                 
		a.VC_CTRCTSTS,                    --合同状态描述                                                             
		a.VC_CTRCTCRETM,                  --合同生成时间                                                             
		a.VC_LASTUPDTM,                   --最近更新时间                                                             
		a.VC_BDGVRCSHCOLLSTSCD,           --付券方保证金状态                                                         
		a.VC_BDGVRCSHCOLLSTS,             --付券方保证金状态描述                                                     
		a.VC_BDTAKERCSHCOLLSTSCD,         --收券方保证金状态                                                         
		a.VC_BDTAKERCSHCOLLSTS,           --收券方保证金状态描述                                                     
		a.VC_BDGVRCSHLCTNCD,              --付券方保证金保管地                                                       
		a.VC_BDGVRCSHLCTN,                --付券方保证金保管地描述                                                   
		a.VC_BDTAKERCSHLCTNCD,            --收券方保证金保管地                                                       
		a.VC_BDTAKERCSHLCTN               --收券方保证金保管地描述     
   from stage.T_ATS_bs_tally_contract a
  where 1 = 1
   --and a.VC_BDGVRNM like '% %' --付券方简称
   --and a.VC_BDTAKERNM like '% %'--收券方简称        
   --and a.VC_BIZTP like '% %'--业务类别描述          
   --and a.VC_DLVRYDT = '' --交割日  
   --and a.VC_CSHSTS like '% %' --资金状态描述      
   --and a.VC_CTRCTSTS like '% %' --合同状态描述       
