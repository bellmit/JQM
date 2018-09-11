--后台成交-中债-结算指令下载表
select a.VC_INSTRID, --指令编号                                                                                  
       a.VC_ORGTRNM, --客户简称   
       a.L_UPDATEDT,--更新日期                                                                                 
       a.VC_ORGTRSUBACCTID, --本方分组合号                                                                              
       a.VC_ORGTRSUBNM, --本方分组合简称                                                                            
       a.VC_ORGTRACCTID, --债券账号                                                                                  
       a.VC_ACCTWTHDVPNETGCONFD, --预发行净额结算DVP被确认账号                                                               
       a.VC_ACCTWTHMRGNBLCKGCONFD, --保证金冻结确认被确认账号                                                                  
       a.VC_ACCTWHTMRGNUNBLCKGCONFD, --保证金解冻确认被确认账号                                                                  
       a.VC_CTRPTYNM, --对手方简称                                                                                
       a.VC_CTRPTYACCT, --对手方账号                                                                                
       a.VC_BIZTPCD, --业务类别编号                                                                              
       a.VC_BIZTP, --业务类别描述                                                                              
       a.VC_TXDRCTN, --交易方向描述                                                                              
       a.VC_CSHSTTLEMDRCTN, --现金了结方向描述                                                                          
       a.VC_CONFDCSHDRCTN, --预发行净额结算DVP被确认款方向描述                                                         
       a.VC_FRSTLEGCD, --首次结算方式代码                                                                          
       a.VC_FRSTLEG, --首次结算方式符号描述                                                                      
       a.VC_FRSTLEGINCHIN, --首次结算方式中文描述                                                                      
       a.VC_SCNDLEGCD, --到期结算方式代码                                                                          
       a.VC_SCNDLEG, --到期结算方式符号描述                                                                      
       a.VC_SCNDLEGINCHIN, --到期结算方式中文描述                                                                      
       a.VC_FRSTDLVRYDT, --首次交割日                                                                                
       a.VC_SCNDDLVRYDT, --到期交割日/远期交割成交日                                                                 
       a.VC_FRSTSTTLEMVAL, --首期资金清算额/净价金额/融资解押返还资金额(含融资利息)/BEPS调增、调减额度/BEPS置换换入额度
       a.VC_CSHSTTLEMVAL, --现金了结交割金额                                                                          
       a.VC_MRGNBLCKGVAL, --保证金冻结金额                                                                            
       a.VC_MRGNUNBLCKGVAL, --保证金解冻金额                                                                            
       a.VC_SCNDSTTLEMVAL, --到期资金清算额/全价金额/融资解押融资利息/融资质押起点金额/BEPS置换换出额度                
       a.VC_FRSTLEGPRIC, --首次结算价格/净价                                                                         
       a.VC_SCNDLEGPRIC, --到期结算价格/全价                                                                         
       a.VC_TTLFACEAMT, --债券面额合计                                                                              
       a.VC_TXID, --业务标识号                                                                                
       a.VC_REPORATE, --回购年利率                                                                                
       a.VC_OVRDUEDAYS, --逾期天数/融资解押资金使用天数                                                             
       a.VC_SCTIESLNDGTERM, --质押融券期限                                                                              
       a.VC_ORGTRGRTETPCD, --发令方保证方式                                                                            
       a.VC_MRGNBLCKGIND, --保证金冻结成功失败标志                                                                    
       a.VC_MRGNUNBLCKGIND, --保证金解冻成功失败标志                                                                    
       a.VC_ORGTRGRTETP, --发令方保证方式描述                                                                        
       a.VC_CNTRPTYGRTETPCD, --对手方保证方式                                                                            
       a.VC_COLLSBSTITNIND, --是否允许替换质押品                                                                        
       a.VC_CNTRPTYGRTETP, --对手方保证方式描述                                                                        
       a.VC_ORGTRGRTEBDSEQNB, --发令方保证券债券序号                                                                      
       a.VC_ORGTRGRTEBDID, --发令方保证券债券代码                                                                      
       a.VC_ORGTRGRTEBDSHRTNM, --发令方保证券债券简称                                                                      
       a.VC_ORGTRGRTEBDFACEAMT, --发令方保证券债券面额                                                                      
       a.VC_OTCBUYGFACEAMT, --柜台专项结算买入面额                                                                      
       a.VC_ORGTRGRTEMRGN, --发令方保证金                                                                              
       a.VC_OTCBUYGVAL, --柜台专项结算买入金额                                                                      
       a.VC_CTRPTYGRTEBDSEQNB, --对手方保证券债券序号                                                                      
       a.VC_CNTRPTYGRTEBDID, --对手方保证券债券代码                                                                      
       a.VC_CNTRPTYGRTEBDSHRTNM, --对手方保证券债券简称                                                                      
       a.VC_CNTRPTYGRTEBDFACEAMT, --对手方保证券债券面额                                                                      
       a.VC_OTCSELLGFACEAMT, --柜台专项结算卖出面额                                                                      
       a.VC_CNTRPTYCSHCOLL, --对手方保证金                                                                              
       a.VC_OTCSELLGVAL, --柜台专项结算卖出金额                                                                      
       a.VC_CROSSTRFAPLT, --转托管申请人                                                                              
       a.VC_ORGNLCTRCTID, --对应合同号                                                                                
       a.VC_ORGNLINSTRID, --对应指令号                                                                                
       a.VC_TRANSFEREEID, --转入方账号                                                                                
       a.VC_TRANSFERORID, --转出方账号                                                                                
       a.VC_OPRTR, --操作员                                                                                    
       a.VC_CHCKER, --复核员                                                                                    
       a.VC_CNFRMOR, --确认员                                                                                    
       a.VC_INSTRACCPTTM, --指令接收时间                                                                              
       a.VC_INSTRCHCKTM, --指令复核时间                                                                              
       a.VC_INSTRCNFRMTM, --指令确认时间                                                                              
       a.VC_INSTRSTSCD, --指令状态                                                                                  
       a.VC_INSTRSTS, --指令状态描述                                                                              
       a.VC_LASTUPDTM, --最近更新时间                                                                              
       a.VC_GVRCSHLCTNCD, --付券方保证金保管地                                                                        
       a.VC_GVRCSHLCTN, --付券方保证金保管地描述                                                                    
       a.VC_TAKERCSHLCTNCD, --收券方保证金保管地                                                                        
       a.VC_TAKERCSHLCTN, --收券方保证金保管地描述                                                                    
       a.VC_COLLMDLCD, --担保模式代码                                                                              
       a.VC_COLLMDL --担保模式描述       
  from stage.T_ATS_BS_TALLY_ORDER a
 where 1 = 1
   --and a.vc_orgtrnm like '% %' --客户简称    
   --and a.vc_ctrptynm like '% %' --对手方简称                
   --and a.vc_biztp like '% %' --业务类别描述          
   --and a.vc_frstdlvrydt = '' --首次交割日
   --and a.vc_scnddlvrydt = '' --到期交割日/远期交割成交日
   --and a.vc_instrsts like '% %' --指令状态描述 
