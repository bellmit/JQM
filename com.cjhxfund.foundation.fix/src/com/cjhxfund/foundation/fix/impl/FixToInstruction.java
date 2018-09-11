package com.cjhxfund.foundation.fix.impl;

import com.cjhxfund.commonUtil.DateUtil;
import com.cjhxfund.foundation.fix.FixToMsgUtil;
import com.eos.system.annotation.Bizlet;

import quickfix.Application;
import quickfix.DoNotSend;
import quickfix.FieldNotFound;
import quickfix.IncorrectDataFormat;
import quickfix.IncorrectTagValue;
import quickfix.Message;
import quickfix.RejectLogon;
import quickfix.SessionID;
import quickfix.UnsupportedMessageType;

/**
 * 【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的处理类
 * @author huangmizhi
 */
@Bizlet("")
public class FixToInstruction implements Application {
	
	/** 是否连接成功并登录成功（【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的处理类） */
	private boolean isOnLogon;
	
	/**
	 * @return 获取是否连接成功并登录成功结果（【新】Fix指令下达、状态反馈、委托反馈、成交反馈任务合并后的处理类）
	 * @author huangmizhi
	 */
	public boolean getIsOnLogon(){
		return isOnLogon;
	}
	
	public void fromAdmin(Message msg, SessionID sessionID) throws FieldNotFound, IncorrectDataFormat, IncorrectTagValue, RejectLogon {
		System.out.println(DateUtil.currentDateTimeString()+" Fix合并新任务FixToInstruction fromAdmin...\n" + msg);
	}
	
	public void fromApp(Message msg, SessionID sessionID) throws FieldNotFound, IncorrectDataFormat, IncorrectTagValue, UnsupportedMessageType {
		try {
			FixToMsgUtil.myFromApp(msg, sessionID, "Fix合并新任务FixToInstruction");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void onCreate(SessionID msg) {
		System.out.println(DateUtil.currentDateTimeString()+" Fix合并新任务FixToInstruction onCreate.." + msg);
	}
	
	public void onLogon(SessionID msg) {
		isOnLogon = true;//连接成功并登录成功
		System.out.println(DateUtil.currentDateTimeString()+" Fix合并新任务FixToInstruction onLogon.." + msg);
	}
	
	public void onLogout(SessionID msg) {
		System.out.println(DateUtil.currentDateTimeString()+" Fix合并新任务FixToInstruction onLogout.." + msg);
	}
	
	public void toAdmin(Message msg, SessionID sessionID) {
		System.out.println(DateUtil.currentDateTimeString()+" Fix合并新任务FixToInstruction toAdmin.." + msg);
	}
	
	public void toApp(Message msg, SessionID sessionID) throws DoNotSend {
		System.out.println(DateUtil.currentDateTimeString()+" Fix合并新任务FixToInstruction toApp.." + msg.toString());
	}
}