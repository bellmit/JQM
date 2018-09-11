package com.cjhxfund.ats.sm.comm.instructEntity;

import java.lang.reflect.Field;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import com.eos.foundation.data.DataObjectUtil;

import commonj.sdo.DataObject;


public class Instruct {
	@InstructFieldAnnotation(ContextField = "msgtype")
	String vcMsgType;//obj.getString("msgtype"));//*******业务类型：D-指令下达； G-指令修改；F-指令撤销；H-指令查询；
	String vcSenderSubID;//FixToUtil.getO32OperatorNo(obj.getString("vcProductCode"),obj.getString("vcFsSenderName")); 指令下达人的操作员编号
	@InstructFieldAnnotation(ContextField = "vcClordId")
	String vcClOrdID;// 第三方系统指令编号
	@InstructFieldAnnotation(ContextField = "businClass")
	String vcBusinClass ;// 【前端设置】业务类别 2-银行间二级市场业务 E-交易所大宗交易 I-固收平台
	@InstructFieldAnnotation(ContextField = "vcEntrustDirection")
	String vcBusinType;// 委托方向：3-债券买入 ，4-债券卖出    5–融资回购    6–融券回购  15-协议式正回购   16-协议式逆回购
	@InstructFieldAnnotation(ContextField = "vcCombiCode")
	String vcAccount;////恒生系统组合编号
	String vcSymbol ;//
	String vcSecurityID ;//等于同vcSymbol
	String vcSide ;//
	@InstructFieldAnnotation(ContextField = "exdestination")
	String vcExDestination;//【前端设置】 交易市场：OTC-场外(银行间) SS-上交所  SZ-深交所；
	@InstructFieldAnnotation(ContextField = "vcInvestType")
	String vcInvestType ;//【前端设置1】 
	@InstructFieldAnnotation(ContextField = "vcSettleSpeed")
	String vcSettlType;//清算速度
	String vcPrice;//
	String vcReporate;//
	@InstructFieldAnnotation(ContextField = "")
	String vcOrdType;//"2");  //【前端设置2】 价格模式：1 - 市价（表示不限制委托价格，在涨跌停范围内即可）；2 - 限价（表示限制委托价格，买入不高于，卖出不低于）；
	@InstructFieldAnnotation(ContextField = "enFaceAmount")
	String vcOrderQty ;//String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("enFaceAmount"))*10000/100) //指令数量(张)，机器猫前端页面单位为万元，所以需要乘以10000(元)，又因100元/张，所以再需要除以100.
	@InstructFieldAnnotation(ContextField = "enFaceAmount")
	String vcCashOrderQty ;//String.valueOf(StrUtil.delThousandthEmptyTo0(obj.getString("enFaceAmount"))*10000));//指令金额
	String vcYTM;//
	@InstructFieldAnnotation(ContextField = "vcFirstSettleMode")
	String vcBondSettleType ;//【前端设置3】13204-结算方式（首次结算方式）：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户
	String vcBondSettleType2;//
	String vcTargetSubID;//
	
	
	//构造方法
	public Instruct(DataObject obj) throws IllegalArgumentException, IllegalAccessException, InvocationTargetException {
		Field[] fields = this.getClass().getFields();
		for(int i =0;i<fields.length;i++){
			fields[i].set((new Instruct()), obj.getString(fields[i].getAnnotation(InstructFieldAnnotation.class).toString()));
		}
		
		Method [] mes = this.getClass().getMethods();
		mes[0].invoke(1,1,1,1);
	}

	public Instruct() {
	}
	
	
}
