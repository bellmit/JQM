<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%@include file="/JQMHistory/common/commscripts.jsp" %>
<%@include file="/ProductProcess/zhxxcx/CFJY_zhxxcx_common.jsp" %>
<!-- 
  - Author(s): 章璐
  - Date: 2017-06-15 09:42:31
  - Description:
-->
<head>
<title>投资资产及负债信息</title>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/nui/locale/zh_CN.js" type="text/javascript"></script>
</head>
<body style="width:100%;height:100%;">
		   <%--查询条件开始... --%>
		   <div class="search-condition">
			   <div class="list">
				 <form id="form_TZZCJFZXX" method="post">
		   		<%-- 查询用户类型，url，导出文件名称 --%>
			 	<input class="nui-hidden" name="paramObject/queryUserType" value="<%=request.getParameter("queryUserType")%>">
			 	<input class="nui-hidden" name="paramObject/url" value="/ProductProcess/Bank_Push/queryInvestmentAssets.jsp">
			 	<input class="nui-hidden" id="fileName" name="paramObject/fileName" value="">
			 	<input class="nui-hidden" id="flag" value="<b:write property="flag"/>"/>
			 	<%-- 查询类型 --%>
			 	<input class="nui-hidden" name="paramObject/queryType" value="TZZCJFZXX">
	                <table id="table1" class="table" style="height:100%;table-layout:fixed;">
	                    <tr>
	                        <td style="width:60px" align="right">
								日期:
	                        </td>
	                        <td style="width:15%" align="left">
	                            <input id="L_DATE" class="nui-datepicker" width="100%" format="yyyy-MM-dd" name="paramObject/lDate" required="true" allowInput="false"/>
	                        </td>
	                    	<td style="width:80px" align="right">
								产品名称:
							</td>
							<td style="width:30%" align="left">
								<input id="vCFundCode_HSFAGZB" class="nui-buttonedit" width="100%" name="paramObject/vCFundCode" onbuttonclick="ButtonClickGetFundName_HSFAGZB"/>
							</td>
	                        <td colspan="4" >
	                        	<input class='nui-button' plain='false' text="查询" iconCls="icon-search" onclick="search_TZZCJFZXX()"/>&nbsp;&nbsp;
	                        	<input class='nui-button' plain='false' text="重置" iconCls="icon-cancel"  onclick="resetDire_TZZCJFZXX()"/>&nbsp;&nbsp;
	                            <input id="export_TZZCJFZXX" class='nui-button' plain='false' text="导出" iconCls="icon-download" onclick="export_TZZCJFZXX()"/>
	                        </td>
	                    </tr>
					</table>
				</form>
			  </div>
		   </div>
		   <%-- 查询条件结束!!! --%>
           <div class="nui-fit">
                <div 
                        id="datagrid_TZZCJFZXX"
                        dataField="resultObjectList"
                        class="nui-datagrid"
                        style="width:100%;height:100%;"
                        url="com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz.queryWTRD.biz.ext"
                        pageSize="50"
                        frozenStartColumn="0"
                        virtualScroll="true"
						frozenEndColumn="5"
                        showPageInfo="true"
                        allowSortColumn="true"
                        sortMode="client"
                        enableHotTrack="true"
                        sizeList="[20,50,100,500,1000]">

                    <div property="columns">
                        <div type="indexcolumn"></div>
                        
                        <div field="COL001" headerAlign="center" allowSort="true" align="left" width="130px">*行内资产/负债编码                  </div>
						<div field="COL002" headerAlign="center" allowSort="true" align="left" width="100px">*发行机构代码                       </div>
						<div field="COL003" headerAlign="center" allowSort="true" align="left" width="130px">*资产/负债类别                      </div>
						<div field="COL004" headerAlign="center" allowSort="true" align="left" width="160px">*交易流通场所                       </div>
						<div field="COL005" headerAlign="center" allowSort="true" align="left" width="130px">*币种                               </div>
						<div field="COL006" headerAlign="center" allowSort="true" align="left" width="150px">资金存入银行                        </div>
						<div field="COL007" headerAlign="center" allowSort="true" align="left" width="100px">*存款金额                           </div>
						<div field="COL008" headerAlign="center" allowSort="true" align="left" width="80px">*起息日                             </div>
						<div field="COL009" headerAlign="center" allowSort="true" align="left" width="80px">*到期日                             </div>
						<div field="COL010" headerAlign="center" allowSort="true" align="left" width="80px">*年利率%                            </div>
						<div field="COL011" headerAlign="center" allowSort="true" align="left" width="80px">*计息基础                           </div>
						<div field="COL012" headerAlign="center" allowSort="true" align="left" width="120px">*是否为结构性存款                   </div>
						<div field="COL013" headerAlign="center" allowSort="true" align="left" width="140px">结构性存款挂钩标的类别              </div>
						<div field="COL014" headerAlign="center" allowSort="true" align="left" width="120px">结构性存款挂钩标的                  </div>
						<div field="COL015" headerAlign="center" allowSort="true" align="left" width="100px">*代码                               </div>
						<div field="COL016" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL017" headerAlign="center" allowSort="true" align="left" width="100px">具体类别                            </div>
						<div field="COL018" headerAlign="center" allowSort="true" align="left" width="100px">*发行方式                           </div>
						<div field="COL019" headerAlign="center" allowSort="true" align="left" width="100px">*主体评级                           </div>
						<div field="COL020" headerAlign="center" allowSort="true" align="left" width="180px">*发行机构类型（按规模划分）         </div>
						<div field="COL021" headerAlign="center" allowSort="true" align="left" width="200px">*发行机构类型（按技术领域划分）     </div>
						<div field="COL022" headerAlign="center" allowSort="true" align="left" width="200px">*发行机构类型（按经济类型划分）     </div>
						<div field="COL023" headerAlign="center" allowSort="true" align="left" width="120px">*发行机构所属行业                   </div>
						<div field="COL024" headerAlign="center" allowSort="true" align="left" width="100px">*登记托管机构                       </div>
						<div field="COL025" headerAlign="center" allowSort="true" align="left" width="120px">登记托管机构说明                    </div>
						<div field="COL026" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL027" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL028" headerAlign="center" allowSort="true" align="left" width="100px">*对手方                             </div>
						<div field="COL029" headerAlign="center" allowSort="true" align="left" width="100px">*年利率%                            </div>
						<div field="COL030" headerAlign="center" allowSort="true" align="left" width="100px">*计息基础                           </div>
						<div field="COL031" headerAlign="center" allowSort="true" align="left" width="100px">回购标的类别                        </div>
						<div field="COL032" headerAlign="center" allowSort="true" align="left" width="100px">回购标的金额                        </div>
						<div field="COL033" headerAlign="center" allowSort="true" align="left" width="100px">收/受益权类型                       </div>
						<div field="COL034" headerAlign="center" allowSort="true" align="left" width="120px">*是否属于买入返售                   </div>
						<div field="COL035" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL036" headerAlign="center" allowSort="true" align="left" width="100px">*金额                               </div>
						<div field="COL037" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL038" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL039" headerAlign="center" allowSort="true" align="left" width="120px">*是否有预期收益率                   </div>
						<div field="COL040" headerAlign="center" allowSort="true" align="left" width="130px">项目收益率(利率)%                   </div>
						<div field="COL041" headerAlign="center" allowSort="true" align="left" width="140px">*付息频率（个月/次）                </div>
						<div field="COL042" headerAlign="center" allowSort="true" align="left" width="120px">*还本付息情况说明                   </div>
						<div field="COL043" headerAlign="center" allowSort="true" align="left" width="100px">*计息基础                           </div>
						<div field="COL044" headerAlign="center" allowSort="true" align="left" width="100px"> 基准利率种类                       </div>
						<div field="COL045" headerAlign="center" allowSort="true" align="left" width="100px">浮动因子（%）                       </div>
						<div field="COL046" headerAlign="center" allowSort="true" align="left" width="100px">利差(BP)                            </div>
						<div field="COL047" headerAlign="center" allowSort="true" align="left" width="100px">*融资人                             </div>
						<div field="COL048" headerAlign="center" allowSort="true" align="left" width="140px">*融资人内部信用评级                 </div>
						<div field="COL049" headerAlign="center" allowSort="true" align="left" width="200px">外部评级机构名称及对融资人评级结果  </div>
						<div field="COL050" headerAlign="center" allowSort="true" align="left" width="160px">*融资人类型（按规模划分）           </div>
						<div field="COL051" headerAlign="center" allowSort="true" align="left" width="180px">*融资人类型（按技术领域划分）       </div>
						<div field="COL052" headerAlign="center" allowSort="true" align="left" width="180px">*融资人类型（按经济类型划分）       </div>
						<div field="COL053" headerAlign="center" allowSort="true" align="left" width="100px">*融资项目                           </div>
						<div field="COL054" headerAlign="center" allowSort="true" align="left" width="100px">*融资人所属行业                     </div>
						<div field="COL055" headerAlign="center" allowSort="true" align="left" width="200px">*项目是否属于重点监控行业和领域     </div>
						<div field="COL056" headerAlign="center" allowSort="true" align="left" width="160px">重点监控行业和领域类别              </div>
						<div field="COL057" headerAlign="center" allowSort="true" align="left" width="180px">重点监控行业和领域类别说明          </div>
						<div field="COL058" headerAlign="center" allowSort="true" align="left" width="100px">担保方式                            </div>
						<div field="COL059" headerAlign="center" allowSort="true" align="left" width="100px">担保情况说明                        </div>
						<div field="COL060" headerAlign="center" allowSort="true" align="left" width="100px">*融资人主体评级                     </div>
						<div field="COL061" headerAlign="center" allowSort="true" align="left" width="100px">*资产内部评级                       </div>
						<div field="COL062" headerAlign="center" allowSort="true" align="left" width="100px">*资产外部评级                       </div>
						<div field="COL063" headerAlign="center" allowSort="true" align="left" width="100px">*选择权                             </div>
						<div field="COL064" headerAlign="center" allowSort="true" align="left" width="100px">*行权条件说明                       </div>
						<div field="COL065" headerAlign="center" allowSort="true" align="left" width="100px">*融资人所属地区                     </div>
						<div field="COL066" headerAlign="center" allowSort="true" align="left" width="200px">*融资人组织机构（社会信用）代码     </div>
						<div field="COL067" headerAlign="center" allowSort="true" align="left" width="100px">*融资总费率%                        </div>
						<div field="COL068" headerAlign="center" allowSort="true" align="left" width="100px">*融资项目所属行业                   </div>
						<div field="COL069" headerAlign="center" allowSort="true" align="left" width="100px">*是否为收/受益权                    </div>
						<div field="COL070" headerAlign="center" allowSort="true" align="left" width="100px">*是否属于买入返售                   </div>
						<div field="COL071" headerAlign="center" allowSort="true" align="left" width="100px">*类型                               </div>
						<div field="COL072" headerAlign="center" allowSort="true" align="left" width="100px">*数量                               </div>
						<div field="COL073" headerAlign="center" allowSort="true" align="left" width="100px">*合计金额                           </div>
						<div field="COL074" headerAlign="center" allowSort="true" align="left" width="120px">*加权剩余期限（天）                 </div>
						<div field="COL075" headerAlign="center" allowSort="true" align="left" width="120px">*最长剩余期限（天）                 </div>
						<div field="COL076" headerAlign="center" allowSort="true" align="left" width="120px">*最短剩余期限（天）                 </div>
						<div field="COL077" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL078" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL079" headerAlign="center" allowSort="true" align="left" width="100px">*行业                               </div>
						<div field="COL080" headerAlign="center" allowSort="true" align="left" width="100px">*贴现利率（%）                      </div>
						<div field="COL081" headerAlign="center" allowSort="true" align="left" width="100px">股票代码                            </div>
						<div field="COL082" headerAlign="center" allowSort="true" align="left" width="100px">*股票/企业名称                      </div>
						<div field="COL083" headerAlign="center" allowSort="true" align="left" width="100px">股票类型                            </div>
						<div field="COL084" headerAlign="center" allowSort="true" align="left" width="100px">*行业                               </div>
						<div field="COL085" headerAlign="center" allowSort="true" align="left" width="100px">投资阶段                            </div>
						<div field="COL086" headerAlign="center" allowSort="true" align="left" width="160px">*企业类型（按规模划分）             </div>
						<div field="COL087" headerAlign="center" allowSort="true" align="left" width="180px">*企业类型（按技术领域划分）         </div>
						<div field="COL088" headerAlign="center" allowSort="true" align="left" width="180px">*企业类型（按经济类型划分）         </div>
						<div field="COL089" headerAlign="center" allowSort="true" align="left" width="100px">*是否为质押融资                     </div>
						<div field="COL090" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL091" headerAlign="center" allowSort="true" align="left" width="100px">*名义本金                           </div>
						<div field="COL092" headerAlign="center" allowSort="true" align="left" width="100px">*标的类别                           </div>
						<div field="COL093" headerAlign="center" allowSort="true" align="left" width="120px">*所属国家或地区                     </div>
						<div field="COL094" headerAlign="center" allowSort="true" align="left" width="100px">*债券名称                           </div>
						<div field="COL095" headerAlign="center" allowSort="true" align="left" width="100px">*债券代码                           </div>
						<div field="COL096" headerAlign="center" allowSort="true" align="left" width="100px">*发行机构                           </div>
						<div field="COL097" headerAlign="center" allowSort="true" align="left" width="120px">*发行机构所属行业                   </div>
						<div field="COL098" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL099" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL100" headerAlign="center" allowSort="true" align="left" width="100px">*期限（月）                         </div>
						<div field="COL101" headerAlign="center" allowSort="true" align="left" width="180px">*发行机构主体信用评级               </div>
						<div field="COL102" headerAlign="center" allowSort="true" align="left" width="100px">*债券信用评级                       </div>
						<div field="COL103" headerAlign="center" allowSort="true" align="left" width="100px">*票面利率%                          </div>
						<div field="COL104" headerAlign="center" allowSort="true" align="left" width="160px">*付息频率（个月/次）                </div>
						<div field="COL105" headerAlign="center" allowSort="true" align="left" width="100px">*担保情况说明                       </div>
						<div field="COL106" headerAlign="center" allowSort="true" align="left" width="200px">*是否含权等特殊条款情况说明         </div>
						<div field="COL107" headerAlign="center" allowSort="true" align="left" width="100px">*所属国家或地区                     </div>
						<div field="COL108" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL109" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL110" headerAlign="center" allowSort="true" align="left" width="100px">*对手方                             </div>
						<div field="COL111" headerAlign="center" allowSort="true" align="left" width="100px">*年利率%                            </div>
						<div field="COL112" headerAlign="center" allowSort="true" align="left" width="100px">*计息基础                           </div>
						<div field="COL113" headerAlign="center" allowSort="true" align="left" width="100px">*所属国家或地区                     </div>
						<div field="COL114" headerAlign="center" allowSort="true" align="left" width="100px">*股票/基金代码                      </div>
						<div field="COL115" headerAlign="center" allowSort="true" align="left" width="100px">*股票/基金名称                      </div>
						<div field="COL116" headerAlign="center" allowSort="true" align="left" width="100px">*发行机构                           </div>
						<div field="COL117" headerAlign="center" allowSort="true" align="left" width="100px">*行业                               </div>
						<div field="COL118" headerAlign="center" allowSort="true" align="left" width="100px">*所属国家或地区                     </div>
						<div field="COL119" headerAlign="center" allowSort="true" align="left" width="100px">*合约名称                           </div>
						<div field="COL120" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL121" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL122" headerAlign="center" allowSort="true" align="left" width="100px">票面利率%                           </div>
						<div field="COL123" headerAlign="center" allowSort="true" align="left" width="120px">付息频率（个月/次）                 </div>
						<div field="COL124" headerAlign="center" allowSort="true" align="left" width="200px">*固定收益部分所占比例(%)            </div>
						<div field="COL125" headerAlign="center" allowSort="true" align="left" width="200px">*衍生金融工具所占比例(%)            </div>
						<div field="COL126" headerAlign="center" allowSort="true" align="left" width="200px">*衍生金融工具具体投资方式           </div>
						<div field="COL127" headerAlign="center" allowSort="true" align="left" width="200px">*衍生金融工具挂钩的标的资产         </div>
						<div field="COL128" headerAlign="center" allowSort="true" align="left" width="100px">*利息结算方式                       </div>
						<div field="COL129" headerAlign="center" allowSort="true" align="left" width="100px">*含权情况说明                       </div>
						<div field="COL130" headerAlign="center" allowSort="true" align="left" width="200px">*结构性票据最高收益率%              </div>
						<div field="COL131" headerAlign="center" allowSort="true" align="left" width="200px">结构性票据最低收益率%               </div>
						<div field="COL132" headerAlign="center" allowSort="true" align="left" width="200px">挂钩标的资产基准价格                </div>
						<div field="COL133" headerAlign="center" allowSort="true" align="left" width="200px">*挂钩标的资产登记日价格             </div>
						<div field="COL134" headerAlign="center" allowSort="true" align="left" width="100px">*交易费                             </div>
						<div field="COL135" headerAlign="center" allowSort="true" align="left" width="100px"> *资管计划名称                      </div>
						<div field="COL136" headerAlign="center" allowSort="true" align="left" width="200px">*资管计划发起人机构编码             </div>
						<div field="COL137" headerAlign="center" allowSort="true" align="left" width="160px">资管计划登记编码                    </div>
						<div field="COL138" headerAlign="center" allowSort="true" align="left" width="100px">*管理人                             </div>
						<div field="COL139" headerAlign="center" allowSort="true" align="left" width="100px">*托管人                             </div>
						<div field="COL140" headerAlign="center" allowSort="true" align="left" width="100px">*金额                               </div>
						<div field="COL141" headerAlign="center" allowSort="true" align="left" width="100px">*资金实际投向                       </div>
						<div field="COL142" headerAlign="center" allowSort="true" align="left" width="100px"> *资金运用方式                      </div>
						<div field="COL143" headerAlign="center" allowSort="true" align="left" width="100px"> *资金运用行业                      </div>
						<div field="COL144" headerAlign="center" allowSort="true" align="left" width="120px">*资管计划成立日期                   </div>
						<div field="COL145" headerAlign="center" allowSort="true" align="left" width="120px">*资管计划终止日期                   </div>
						<div field="COL146" headerAlign="center" allowSort="true" align="left" width="100px">*资管计划属性                       </div>
						<div field="COL147" headerAlign="center" allowSort="true" align="left" width="120px">*是否有预期收益率                   </div>
						<div field="COL148" headerAlign="center" allowSort="true" align="left" width="120px">预期最高收益率%                     </div>
						<div field="COL149" headerAlign="center" allowSort="true" align="left" width="120px">预期最低收益率%                     </div>
						<div field="COL150" headerAlign="center" allowSort="true" align="left" width="100px">*购买结构                           </div>
						<div field="COL151" headerAlign="center" allowSort="true" align="left" width="100px">*管理方式                           </div>
						<div field="COL152" headerAlign="center" allowSort="true" align="left" width="200px">*是否掌控计划底层资产详情           </div>
						<div field="COL153" headerAlign="center" allowSort="true" align="left" width="100px">*管理费率%                          </div>
						<div field="COL154" headerAlign="center" allowSort="true" align="left" width="100px">*托管费率%                          </div>
						<div field="COL155" headerAlign="center" allowSort="true" align="left" width="140px">*交易相关合计费率%                  </div>
						<div field="COL156" headerAlign="center" allowSort="true" align="left" width="140px">*中介服务机构合计费率%              </div>
						<div field="COL157" headerAlign="center" allowSort="true" align="left" width="100px"> *其他合计费率%                     </div>
						<div field="COL158" headerAlign="center" allowSort="true" align="left" width="100px">*所属国家或地区                     </div>
						<div field="COL159" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL160" headerAlign="center" allowSort="true" align="left" width="100px">期限（天）                          </div>
						<div field="COL161" headerAlign="center" allowSort="true" align="left" width="100px">*资产价值                           </div>
						<div field="COL162" headerAlign="center" allowSort="true" align="left" width="100px"> 资产收益率%                        </div>
						<div field="COL163" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL164" headerAlign="center" allowSort="true" align="left" width="100px">*行内资产类别                       </div>
						<div field="COL165" headerAlign="center" allowSort="true" align="left" width="100px">*金额                               </div>
						<div field="COL166" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL167" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL168" headerAlign="center" allowSort="true" align="left" width="120px">*所属国家或地区                     </div>
						<div field="COL169" headerAlign="center" allowSort="true" align="left" width="120px">*是否有预期收益率                   </div>
						<div field="COL170" headerAlign="center" allowSort="true" align="left" width="160px">项目收益率（利率）%                 </div>
						<div field="COL171" headerAlign="center" allowSort="true" align="left" width="160px">*付息频率（个月/次）                </div>
						<div field="COL172" headerAlign="center" allowSort="true" align="left" width="100px">*融资人                             </div>
						<div field="COL173" headerAlign="center" allowSort="true" align="left" width="220px">*融资人组织机构（社会信用）代码     </div>
						<div field="COL174" headerAlign="center" allowSort="true" align="left" width="240px">外部评级机构名称及对融资人评级结果  </div>
						<div field="COL175" headerAlign="center" allowSort="true" align="left" width="160px">*融资人类型（按规模划分）           </div>
						<div field="COL176" headerAlign="center" allowSort="true" align="left" width="180px">*融资人类型（按技术领域划分）       </div>
						<div field="COL177" headerAlign="center" allowSort="true" align="left" width="180px">*融资人类型（按经济类型划分）       </div>
						<div field="COL178" headerAlign="center" allowSort="true" align="left" width="100px">*融资项目                           </div>
						<div field="COL179" headerAlign="center" allowSort="true" align="left" width="100px">*融资人所属行业                     </div>
						<div field="COL180" headerAlign="center" allowSort="true" align="left" width="100px">*融资项目所属行业                   </div>
						<div field="COL181" headerAlign="center" allowSort="true" align="left" width="200px">*项目是否属于重点监控行业和领域     </div>
						<div field="COL182" headerAlign="center" allowSort="true" align="left" width="160px">重点监控行业和领域类别              </div>
						<div field="COL183" headerAlign="center" allowSort="true" align="left" width="180px">重点监控行业和领域类别说明          </div>
						<div field="COL184" headerAlign="center" allowSort="true" align="left" width="100px">对应资产外部评级                    </div>
						<div field="COL185" headerAlign="center" allowSort="true" align="left" width="100px">*所属国家或地区                     </div>
						<div field="COL186" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL187" headerAlign="center" allowSort="true" align="left" width="100px">*起息日                             </div>
						<div field="COL188" headerAlign="center" allowSort="true" align="left" width="100px">*到期日                             </div>
						<div field="COL189" headerAlign="center" allowSort="true" align="left" width="100px">*资产价值                           </div>
						<div field="COL190" headerAlign="center" allowSort="true" align="left" width="100px">资产收益率%                         </div>
						<div field="COL191" headerAlign="center" allowSort="true" align="left" width="100px">*基金代码                           </div>
						<div field="COL192" headerAlign="center" allowSort="true" align="left" width="100px">*基金名称                           </div>
						<div field="COL193" headerAlign="center" allowSort="true" align="left" width="100px">*行业                               </div>
						<div field="COL194" headerAlign="center" allowSort="true" align="left" width="100px">*登记备案机构                       </div>
						<div field="COL195" headerAlign="center" allowSort="true" align="left" width="100px">产业投资基金公司名称                </div>
						<div field="COL196" headerAlign="center" allowSort="true" align="left" width="100px">*基金管理机构名称                   </div>
						<div field="COL197" headerAlign="center" allowSort="true" align="left" width="100px">*基金托管机构名称                   </div>
						<div field="COL198" headerAlign="center" allowSort="true" align="left" width="100px">投资阶段                            </div>
						<div field="COL199" headerAlign="center" allowSort="true" align="left" width="200px">投资企业类型（按规模划分）          </div>
						<div field="COL200" headerAlign="center" allowSort="true" align="left" width="200px">投资企业类型（按技术领域划分）      </div>
						<div field="COL201" headerAlign="center" allowSort="true" align="left" width="200px">投资企业类型（按经济类型划分）      </div>
						<div field="COL202" headerAlign="center" allowSort="true" align="left" width="100px">*基金投资资产                       </div>
						<div field="COL203" headerAlign="center" allowSort="true" align="left" width="100px">*所属国家或地区                     </div>
						<div field="COL204" headerAlign="center" allowSort="true" align="left" width="100px">*名称                               </div>
						<div field="COL205" headerAlign="center" allowSort="true" align="left" width="100px">期限（天）                          </div>
						<div field="COL206" headerAlign="center" allowSort="true" align="left" width="100px">*负债规模                           </div>
						<div field="COL207" headerAlign="center" allowSort="true" align="left" width="100px">利率%                               </div>
						<div field="COL208" headerAlign="center" allowSort="true" align="left" width="100px">备注                                </div>
                    </div>
                </div>
            </div>

<script type="text/javascript">
    nui.parse();
    nui.get("L_DATE").setValue((new Date()));
    var grid_TZZCJFZXX = nui.get("datagrid_TZZCJFZXX");//产品交易流水-交易所
    var form = new nui.Form("#form_TZZCJFZXX");
	var json = form.getData(false,false);
	//grid_TZZCJFZXX.load(json);
	
	//查询
	function search_TZZCJFZXX() {
		var fundName = changeNull(nui.get("vCFundCode_HSFAGZB").getText());
		if(fundName==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var qdate = nui.get("L_DATE").getValue();
		if(qdate ==""){
			nui.alert("请先选择日期！");
			return;
		}
		search(grid_TZZCJFZXX, "#form_TZZCJFZXX");
	}
		//获取查询条件的基金名称
	function ButtonClickGetFundName_HSFAGZB(e){
        ButtonClickGetFundNameOne(this, null);
	}
		//导出
	function export_TZZCJFZXX(){
		var fundName = changeNull(nui.get("vCFundCode_HSFAGZB").getText());
		if(fundName==""){
			nui.alert("请先选择产品名称！");
			return;
		}
		var qdate = nui.get("L_DATE").getValue();
		if(qdate ==""){
			nui.alert("请先选择日期！");
			return;
		}
		var fileName = "投资资产及负债信息";
		qdate = qdate.substring(0,10);
		fileName = fileName +"-"+fundName+"-"+qdate+".xls";
		nui.get("fileName").setValue(fileName);
		var frm = document.getElementById("form_TZZCJFZXX");
		frm.action = "com.cjhxfund.jy.excelUploadAdd.exclUploadForWtrd.flow";
		frm.submit();
		var exportId = "export_TZZCJFZXX";
		nui.get(exportId).disable();
		enableExportId = exportId;
		setTimeout("enableExportFun()",60000);//启用“导出”按钮
	}
			//启用“导出”按钮
	var enableExportId = "";//启用“导出”按钮ID
	function enableExportFun(){
		nui.get(enableExportId).enable();
		enableExportId = "";
	}
	
	//重置指令信息
	function resetDire_TZZCJFZXX(){
		var form = new nui.Form("form_TZZCJFZXX");
		form.reset();
	}
		//判断是否下载成功的返回路劲
	var flag = nui.get("flag").getValue();
	if(flag == "false"){
		nui.alert("导出失败 ！", "系统提示");
	}
	
</script>
</body>
</html>