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
 * Fix指令委托反馈处理类
 * @author huangmizhi
 */
@Bizlet("")
public class FixToEntrustBack implements Application {
	
	/** 是否连接成功并登录成功（Fix指令委托反馈处理类） */
	private boolean isOnLogon;
	
	/**
	 * @return 获取是否连接成功并登录成功结果（Fix指令委托反馈处理类）
	 * @author huangmizhi
	 */
	public boolean getIsOnLogon(){
		return isOnLogon;
	}
	
	public void fromAdmin(Message msg, SessionID sessionID) throws FieldNotFound, IncorrectDataFormat, IncorrectTagValue, RejectLogon {
		System.out.println(DateUtil.currentDateTimeString()+" Fix指令委托反馈FixToEntrustBack fromAdmin...\n" + msg);
	}
	
	public void fromApp(Message msg, SessionID sessionID) throws FieldNotFound, IncorrectDataFormat, IncorrectTagValue, UnsupportedMessageType {
		try {
			FixToMsgUtil.myFromApp(msg, sessionID, "Fix指令委托反馈FixToEntrustBack");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void onCreate(SessionID msg) {
		System.out.println(DateUtil.currentDateTimeString()+" Fix指令委托反馈FixToEntrustBack onCreate.." + msg);
	}
	
	public void onLogon(SessionID msg) {
		isOnLogon = true;//连接成功并登录成功
		System.out.println(DateUtil.currentDateTimeString()+" Fix指令委托反馈FixToEntrustBack onLogon.." + msg);
	}
	
	public void onLogout(SessionID msg) {
		System.out.println(DateUtil.currentDateTimeString()+" Fix指令委托反馈FixToEntrustBack onLogout.." + msg);
	}
	
	public void toAdmin(Message msg, SessionID sessionID) {
		System.out.println(DateUtil.currentDateTimeString()+" Fix指令委托反馈FixToEntrustBack toAdmin.." + msg);
	}
	
	public void toApp(Message msg, SessionID sessionID) throws DoNotSend {
		System.out.println(DateUtil.currentDateTimeString()+" Fix指令委托反馈FixToEntrustBack toApp.." + msg.toString());
	}
}