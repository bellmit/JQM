<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
	
	<!-- 账户-指派委托人环节-选择用印方式（电子用印或书面用印） -->
	<div id="openAccountPart1">
		<l:equal property="workitem/processDefName" targetValue="com.cjhxfund.fpm.openAccount.openAccount">
		    <l:equal property="workitem/activityDefID" targetValue="manualActivitym2">
				<l:equal property="pmOpenProdInfo/pmOpenProdType/openType" targetValue="3">
					<tr id="openAccountPart_tr2">
		                <th class="nui-form-label">
		                <font style="color: red;" >*</font><span id="isSealTitle">是否用印：</span>
		                </th>
		                <td colspan="3" class="radio-border-top-none">
		                	<input id="isSeal" name="isSeal"   class="nui-dictradiogroup" dictTypeId="PM_COMM_YN"/>
		                </td>
		            </tr>
		            <!--<tr id="openAccountPart_tr3">
		                <th class="nui-form-label">
		                <font style="color: red;" >*</font><span id="sealMethodTitle">用印方式：</span>
		                </th>
		                <td colspan="3" class="radio-border-top-none">
		                	<input id="sealMethod" name="pmOpenProdInfo.sealMethod" class="nui-dictradiogroup" dictTypeId="PM_OPEN_SEAL_METHOD"/>
		                </td>
		            </tr>-->
	            </l:equal>
	            <!--<l:notIn property="pmOpenProdInfo/pmOpenProdType/openType" propertyType="scope" targetValue="3,5" seperator=",">
					<tr id="openAccountPart_tr1">
		                <th class="nui-form-label">
		                <font style="color: red;" >*</font><span id="sealMethodTitle">用印方式：</span>
		                </th>
		                <td colspan="3" class="radio-border-top-none">
		                	<input id="sealMethod" name="pmOpenProdInfo.sealMethod" class="nui-dictradiogroup" dictTypeId="PM_OPEN_SEAL_METHOD"/>
		                </td>
		            </tr>
				</l:notIn>-->
		    </l:equal>
	    </l:equal>
	</div>
    