package com.cjhxfund.fpm.bpsExpend;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.eos.das.entity.IDASCriteria;
import com.eos.data.datacontext.DataContextManager;
import com.eos.data.datacontext.IMUODataContext;
import com.eos.data.datacontext.IUserObject;
import com.eos.foundation.database.DatabaseExt;
import com.eos.system.annotation.Bizlet;
import com.eos.workflow.api.BPSServiceClientFactory;
import com.eos.workflow.api.IWFNotificationManager;
import com.eos.workflow.data.WFNotificationInst;
import com.eos.workflow.omservice.IWFOMService;
import com.eos.workflow.omservice.WFParticipant;
import com.primeton.workflow.api.PageCond;
import com.primeton.workflow.api.ParticipantType;
import com.primeton.workflow.api.WFServiceException;
import com.primeton.workflow.commons.utility.StringUtil;

/**
 * 通知业务工具类
 * 
 * @author Administrator
 * 
 */
@Bizlet("NoticeUtil")
public class NoticeUtil {

	

	/**
	 * 确认通知
	 * 
	 * @param notificationID
	 * @throws WFServiceException
	 */
	@Bizlet("confirmNotification")
	public static void confirmNotification(long notificationID) throws WFServiceException {
		IWFNotificationManager confirmNotificationManager = ServiceFactory
				.getIWFNotificationManager();
		confirmNotificationManager.confirmNotification(notificationID);
		Map<String, Long> parameterMap=new HashMap<String, Long>();
		parameterMap.put("notificationid", notificationID);
		DatabaseExt.executeNamedSql("default", "com.cjhxfund.fpm.bpsExpend.notice.deleteWFHNotificationinst", parameterMap);
	}

	/**
	 * 根据criteria条件查询通知列表
	 * @param criteria
	 * @param pageCond
	 * @return
	 * @throws WFServiceException
	 * @throws ParseException
	 */
	@Bizlet("queryNotificationsCriteria")
	public static List<WFNotificationInst> queryNotificationsCriteria(
			IDASCriteria criteria, PageCond pageCond)
			throws WFServiceException, ParseException {
		IWFNotificationManager queryNotificationsCriteria = ServiceFactory
				.getIWFNotificationManager();
		List<WFNotificationInst> notificationList = queryNotificationsCriteria
				.queryNotificationsCriteria(criteria, pageCond);
        notificationList = stringToDate(notificationList);
		return notificationList;
	}
	/**
	 * 将通知的时间格式转换成所需要的格式
	 * @param notificationList
	 * @return
	 * @throws ParseException
	 */
	public static List<WFNotificationInst> stringToDate(List<WFNotificationInst> notificationList) throws ParseException {
		Iterator<WFNotificationInst> it = notificationList.iterator();
		while (it.hasNext()) {
			WFNotificationInst notificationInst = it.next();
			if (notificationInst.getCreateTime() != null) {
				String createTime = CommonUtil.transTime(notificationInst.getCreateTime());
				notificationInst.setCreateTime(createTime);
			}
			if (notificationInst.getConfirmTime() != null) {
				String confirmTime = CommonUtil.transTime(notificationInst.getConfirmTime());
				notificationInst.setConfirmTime(confirmTime);
			}
			if (notificationInst.getRemindTime() != null) {
				String remindTime = CommonUtil.transTime(notificationInst.getRemindTime());
				notificationInst.setRemindTime(remindTime);
			}
			if(notificationInst.getFinalTime()!=null){
				String finalTime=CommonUtil.transTime(notificationInst.getFinalTime());
				notificationInst.setFinalTime(finalTime);
			}
		}

		return notificationList;
	}

	@Bizlet("根据人物ID和通知ID查询通知信息")
	public static WFNotificationInst getNotification(String userId,String notificationID){
		if(notificationID!=null && !notificationID.equals("")){
			List<WFNotificationInst> noList = new ArrayList<WFNotificationInst>();
			WFNotificationInst notification = new WFNotificationInst();
			try {
				IWFNotificationManager notificationManager = ServiceFactory.getIWFNotificationManager();
				noList = notificationManager.queryViewedProcessInstNotifications(userId, null, null);
			} catch (WFServiceException e) {
				e.printStackTrace();
			}
			
			for(int i=0;i<noList.size();i++){
				notification = noList.get(i);
				String notiID = notification.getNotificationID()+"";
				if(notiID.equals(notificationID)){
					break;
				}
			}
			
			return notification;
		} else {
			return null;
		}
	}
	
	
	@Bizlet("获取人员角色范围字符串")
	public static String getParticipantScopeString(){
		StringBuilder sb = new StringBuilder(50);
		IMUODataContext muo = DataContextManager.current().getMUODataContext();
		String participantID = null;
		if (muo != null) {
			IUserObject userObject = muo.getUserObject();
			participantID = userObject.getUserId();			
		}
		if(StringUtil.isNullOrBlank(participantID)){
			return sb.toString();
		}
		try {
			List<WFParticipant> participantList = BPSServiceClientFactory.getDefaultClient().getOMService().
			getParticipantScope(getLeafParticipantType(), participantID);			
			if(null == participantList || participantList.isEmpty()){
				return sb.toString();
			}
			int len = participantList.size();
			int i=0;
			for(;i<len-1;i++){
					sb.append(getGlobalWFParticipantID(participantList.get(i)));
				sb.append(",");
			}
			sb.append(getGlobalWFParticipantID(participantList.get(i)));
		} catch (WFServiceException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	private static String getGlobalWFParticipantID(WFParticipant participant) throws WFServiceException{
	   IWFOMService omService = BPSServiceClientFactory.getDefaultClient().getOMService();
       return makeGlobalID(omService.getParticipantType(participant.getTypeCode()).getPrefix(),participant.getId());
   }
	private static String getLeafParticipantType() throws WFServiceException {
		String leafType = null;
		ParticipantType pt = null;
		List<ParticipantType> ptl = BPSServiceClientFactory.getDefaultClient().getOMService().getParticipantTypes();
		for (Iterator<ParticipantType> iter = ptl.iterator(); iter.hasNext();) {
			pt = (ParticipantType) iter.next();
			if(pt.isLeafParticipant()){
				leafType = pt.getCode();     
			}
		}	
		return leafType;
	}
	
   private static String makeGlobalID(char prefix,String localID){
       return prefix+"{"+localID+"}";
   }
   
   
	@Bizlet("分类型返回通知标题")
	public static String getNoticeTile(String noticeType,String title){
		if("auditNotice".equals(noticeType)){
			title += "--待处理";
		}
		if("viewNotice".equals(noticeType)){
			title += "--待审阅";
		}
		if("finishNotice".equals(noticeType)||"pubFinishNotice".equals(noticeType)){
			title += "--已完成";
		}
		if("reviewNotice".equals(noticeType)){
			title += "--审批通过";
		}
		if("Notice".equals(noticeType)){
			title += "--通知";
		}
		if("passRoundNotice".equals(noticeType)){
			title += "--传阅";
		}
		if("pubFundSealNotice".equals(noticeType)){
			title += "--基金合同/托管协议用印";
		}
		if("pubRecruitSealNotice".equals(noticeType)){
			title += "--招募说明书等全套材料用印";
		}
		return title;
	}
}




	