package com.cjhxfund.foundation.fix.impl;

import java.util.Iterator;

import com.cjhxfund.commonUtil.DateUtil;

import quickfix.Application;
import quickfix.ConfigError;
import quickfix.DefaultMessageFactory;
import quickfix.DoubleField;
import quickfix.FileLogFactory;
import quickfix.FileStoreFactory;
import quickfix.LogFactory;
import quickfix.RuntimeError;
import quickfix.Session;
import quickfix.SessionID;
import quickfix.SessionNotFound;
import quickfix.SessionSettings;
import quickfix.SocketInitiator;
import quickfix.StringField;
import quickfix.field.Account;
import quickfix.field.ClOrdID;
import quickfix.field.ExDestination;
import quickfix.field.FutSettDate;
import quickfix.field.FutSettDate2;
import quickfix.field.ListID;
import quickfix.field.MsgType;
import quickfix.field.OrdType;
import quickfix.field.OrderQty;
import quickfix.field.Price;
import quickfix.field.SecurityID;
import quickfix.field.SenderSubID;
import quickfix.field.SettlType;
import quickfix.field.Side;
import quickfix.field.Symbol;
import quickfix.field.Text;
import quickfix.field.TimeInForce;
import quickfix.fix44.NewOrderSingle;
import quickfix.fix44.OrderCancelRequest;

public class TestSenderApp {
	
	public static boolean running = true;
	
	//获取当前文件路径
	public String getPath(){
		String path = this.getClass().getResource("").getFile().toString();
		return path.substring(1, path.length());
	}
	
	public static void main(String[] args) throws ConfigError, InterruptedException, SessionNotFound {
		try {
			TestSenderApp SenderApp1 = new TestSenderApp();
			
			//SessionSettings settings_server = new SessionSettings(path + "HSFix42_client.cfg");
			//SessionSettings settings_client = new SessionSettings(SenderApp.FIX_FILE_PATH + "HSFix42_client.cfg");
			//ScreenLogFactory screenLogFactory = new ScreenLogFactory(settings_client);
			//SessionID sessionID = new SessionID("FIX.4.2", "BUYSIDE", "SELLSIDE");
			//FIX指令导入
			System.out.println(SenderApp1.getPath());
			SessionSettings settings_client = new SessionSettings(SenderApp1.getPath()+"hsfix_instruction_instrimport.cfg");
			FileStoreFactory fileStoreFactory = new FileStoreFactory(settings_client);
			LogFactory logFactory = new FileLogFactory(settings_client);
			DefaultMessageFactory msgFactory = new DefaultMessageFactory();
			Application myApp = new FixToInstrImport();
			//客户端会话开启...
			SocketInitiator initiator = new SocketInitiator(myApp, fileStoreFactory, settings_client, logFactory, msgFactory);
			initiator.start();
			SessionID sessionID = new SessionID("FIX.4.2", "SBI1", "SBI0");
			
			//Fix指令委托反馈
			SessionSettings entrustback_client = new SessionSettings(SenderApp1.getPath()+"hsfix_instruction_entrustback.cfg");
			FileStoreFactory entrustbackFactory = new FileStoreFactory(entrustback_client);
			LogFactory logFactory1 = new FileLogFactory(entrustback_client);
			FixToEntrustBack entrustback = new FixToEntrustBack();
			//Fix指令委托反馈 客户端会话开启...
			SocketInitiator initiator1 = new SocketInitiator(entrustback, entrustbackFactory, entrustback_client, logFactory1, msgFactory);
			initiator1.start();
			SessionID sessionID1 = new SessionID("FIX.4.2", "SBI5", "SBI4");
			
			//Fix指令状态反馈
			SessionSettings instrback_client = new SessionSettings(SenderApp1.getPath()+"hsfix_instruction_instrback.cfg");
			FileStoreFactory instrbackFactory = new FileStoreFactory(instrback_client);
			LogFactory logFactory2 = new FileLogFactory(instrback_client);
			FixToInstrBack fixinstrback = new FixToInstrBack();   //指令状态反馈回调类
			//Fix指令状态反馈 客户端会话开启...
			SocketInitiator initiator2 = new SocketInitiator(fixinstrback, instrbackFactory, instrback_client, logFactory2, msgFactory);
			initiator2.start();
			SessionID sessionID2 = new SessionID("FIX.4.2", "SBI3", "SBI2");
			
			
			//Fix指令成交反馈
			SessionSettings dealback_client = new SessionSettings(SenderApp1.getPath()+"hsfix_instruction_dealback.cfg");
			FileStoreFactory dealbackFactory = new FileStoreFactory(dealback_client);
			LogFactory logFactory3 = new FileLogFactory(dealback_client);
			FixToDealBack fixDealback = new FixToDealBack(); //Fix指令成交反馈回调类
			//Fix指令成交反馈 客户端会话开启...
			SocketInitiator initiator3 = new SocketInitiator(fixDealback, dealbackFactory, dealback_client, logFactory3, msgFactory);
			initiator3.start();
			SessionID sessionID3 = new SessionID("FIX.4.2", "SBI7", "SBI6");
			
			
			System.out.println(DateUtil.currentDateTimeString()+" Fix开始执行...");
			System.out.println("initiator.isLoggedOn(1)="+initiator.isLoggedOn());
			
			while(true){
				
				////--------------测试下单开始...
				/*NewOrderSingle order = new NewOrderSingle();				
				order.getHeader().setField(new SenderSubID("1000"));
				order.getHeader().setField(new PossResend(false));
				order.set(new ClOrdID(DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER)+"_"+String.valueOf((int)(Math.random()*10000))));
				order.set(new HandlInst(HandlInst.MANUAL_ORDER));
				order.set(new Symbol("600570"));
				order.set(new Side(Side.BUY));
				order.set(new OrdType(OrdType.MARKET));*/
				//order.set(new TransactTime(new Date()));			
				/*order.setField(new StringField(60, "20160201-19:45:12"));//-----
				order.set(new Account("1001_000"));
				order.set(new OrderQty(100));
				order.set(new Price(67.12));
				order.set(new Text("FIX test ... by huangmz"));
				order.set(new TimeInForce(TimeInForce.DAY));
				order.set(new ExDestination("SS"));
//				order.setField(new StringField(152, "6721"));//-----
				order.setField(new StringField(13000, "1"));//-----
				order.setField(new StringField(13301, "1"));//-----
				order.setField(new StringField(15007, "1"));//-----
				order.setField(new StringField(15009, "1"));//-----
				order.setField(new StringField(15997, "1"));//-----
				order.setField(new StringField(13001, "1"));//-----
				Session.sendToTarget(order, sessionID);*/
				////--------------测试下单结束!!!
				
				
				
				//--------------银行间二级市场业务-债券 指令下达（New Order-Single）测试下单开始...
				NewOrderSingle order = new NewOrderSingle();
				order.getHeader().setField(new MsgType("G"));
				order.getHeader().setField(new SenderSubID("1000"));
				order.setField(new ClOrdID("20160629157299_6666"));
				order.setField(new StringField(41,"20160629157299_5558")); //被修改的第三方编号
				//order.setField(new StringField(66,"20160629157256_9608")); //ListId
				order.setField(new StringField(13000, "2"));//业务类别：2-银行间二级市场业务
				order.setField(new StringField(13001, "3"));//委托方向：银行间二级市场业务，债券：3 – 债券买入，4 – 债券卖出；回购：5 – 融资回购，6 – 融券回购
				order.setField(new Account("1001_000"));//恒生系统组合编号，指定指令下达到恒生的哪个组合下。（投资组合表：TCOMBI[VC_COMBI_NO]）
				order.setField(new Symbol("100005"));//证券申报代码
				order.setField(new SecurityID("100005"));//等于同Tag55
				order.setField(new Side(Side.BUY));//买卖方向，目前恒生系统对该Tag不处理，1 - 买入；2 - 卖出
				order.setField(new ExDestination("OTC"));//交易市场：OTC 场外
				order.setField(new SettlType("1"));//清算速度：默认为T+1，0 = T+0，1 = T+1
				order.setField(new Price(100.1234));
				order.setField(new OrdType(OrdType.LIMIT));//价格模式
				order.setField(new OrderQty(172000));//指令数量
				order.setField(new DoubleField(13203, 0.028439));
				order.setField(new StringField(13204, "3"));//结算方式（首次结算方式）
				order.setField(new StringField(13227, "1"));//清算类型：1-全额结算；2-净额结算；缺省为1，取自数据字典60151-银行间指令清算类型
				order.setField(new StringField(13224, "1"));//1-到期收益率，2-行权收益率
				order.setField(new TimeInForce(TimeInForce.GOOD_TILL_DATE));//指令有效模式，默认为0-Day,指令日期 6 - GOOD_TILL_DATE
				order.setField(new StringField(15203,"20090109"));
				order.setField(new StringField(432,"20160705"));
				order.setField(new StringField(60, "20160522-13:11:11"));//订单发起时间，格式：yyyyMMdd-HH:mm:ss
				order.setField(new FutSettDate("20160522"));//交割日（首次交割日）
				order.setField(new FutSettDate2("0"));//到期交割日：0表示取当天
				order.setField(new StringField(15007, "1"));//判断可用 0-不判， 1-判
				order.setField(new StringField(15009, "1"));//判断风控 0-不判， 1-判
				order.setField(new StringField(13301, "1"));//指令操作级别：0无 1快速 2一般 3慢速；	数据字典40345项
				
				order.setField(new StringField(14000, "1"));//指令操作级别：0无 1快速 2一般 3慢速；	数据字典40345项
				
				order.setField(new Text(DateUtil.currentDateString(DateUtil.HOUR_MINUTE_SECOND_PATTERN)+" yin hang 11 er ji shi chang ye wu..."));
				Session.sendToTarget(order, sessionID);
				//--------------银行间二级市场业务-债券 指令下达（New Order-Single）测试下单结束!!!
				
				//测试撤销指令
//				OrderCancelRequest order = new OrderCancelRequest();
//				order.getHeader().setField(new SenderSubID("1000"));
//				order.setField(new ClOrdID(DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER)+"_"+String.valueOf((int)(Math.random()*10000))));  //第三方系统指令编号
//				order.setField(new StringField(41, "20160622157234_9608"));//要撤销的指令的第三方指令编号
//				order.setField(new ListID("20160622157234_9608"));
//				order.setField(new StringField(60, "20160522-13:11:11"));
//				Session.sendToTarget(order, sessionID);   //发送指令
				
//				////--------------银行间二级市场业务-回购 指令下达（New Order-Single）测试下单开始...
//				NewOrderSingle order = new NewOrderSingle();
//				order.getHeader().setField(new SenderSubID("1000"));
//				order.setField(new ClOrdID(DateUtil.currentDateString(DateUtil.YYYYMMDDHHMMSS_NUMBER)+"_"+String.valueOf((int)(Math.random()*10000))));
//				order.setField(new StringField(13000, "2"));//业务类别：2-银行间二级市场业务
//				order.setField(new StringField(13001, "6"));//委托方向：银行间二级市场业务，债券：3 – 债券买入，4 – 债券卖出；回购：5 – 融资回购，6 – 融券回购
//				order.setField(new Account("1001_000"));//恒生系统组合编号，指定指令下达到恒生的哪个组合下。（投资组合表：TCOMBI[VC_COMBI_NO]）
//				order.setField(new Symbol("R001"));//证券申报代码
//				order.setField(new SecurityID("R001"));//等于同Tag55
//				order.setField(new Side(Side.SELL));//买卖方向，目前恒生系统对该Tag不处理，1 - 买入；2 - 卖出
//				order.setField(new ExDestination("OTC"));//交易市场：OTC 场外
//				order.setField(new SettlType("0"));//清算速度：默认为T+1，0 = T+0，1 = T+1
//				order.setField(new Price(100.1234)); 
//				order.setField(new StringField(13107, "0.03"));//回购利率，回购业务必须填写，如回购利率3%时需填入0.03。
//				order.setField(new OrdType(OrdType.LIMIT));//价格模式
//				order.setField(new OrderQty(100));//指令数量
//				order.setField(new CashOrderQty(1000));//指令金额，指令数量为0时必须填写，否则无需填写，还是按照数量控制。
//				order.setField(new DoubleField(13203, 0.028439));//债券收益率
//				order.setField(new StringField(13204, "3"));//结算方式（首次结算方式）
//				order.setField(new StringField(13208, "3"));//【只用于银行间回购】到期结算方式：1-见款付券\2- 见券付款\3-券款对付\4-纯券过户
//				order.setField(new StringField(13227, "1"));//清算类型：1-全额结算；2-净额结算；缺省为1，取自数据字典60151-银行间指令清算类型
//				order.setField(new StringField(13224, "1"));//1-到期收益率，2-行权收益率
//				order.setField(new TimeInForce(TimeInForce.DAY));//指令有效模式，默认为0-Day
//				order.setField(new StringField(60, DateUtil.currentDateString("yyyyMMdd-HH:mm:ss")));//订单发起时间，格式：yyyyMMdd-HH:mm:ss
//				order.setField(new FutSettDate(DateUtil.currentDateString(DateUtil.YMD_NUMBER)));//交割日（首次交割日）
//				order.setField(new FutSettDate2(DateUtil.currentDateString(DateUtil.YMD_NUMBER)));//到期交割日：0表示取当天
//				//order.setField(new StringField(15400, ""));//回购用途类别：1：等期限套利；2：不等期限套利；3：短期资金运用；4：超配；5：放大；
//				order.setField(new StringField(15007, "1"));//判断可用 0-不判， 1-判
//				order.setField(new StringField(15009, "1"));//判断风控 0-不判， 1-判
//				order.setField(new StringField(13301, "1"));//指令操作级别：0无 1快速 2一般 3慢速；	数据字典40345项
//				order.setField(new Text(DateUtil.currentDateString(DateUtil.HOUR_MINUTE_SECOND_PATTERN)+" yin hang jian er ji shi chang ye wu..."));
//				//int field, int delim, int[] order  如： super(78, 79, new int[] { 79, 661, 736, 467, 539, 80, 0 });
//				Group group = new Group(NoAllocs.FIELD, Account.FIELD, new int[]{1, 14000, 13211, 13212, 13213, 0});
//				group.setField(new Account("1001_000"));//恒生系统组合编号，指定指令下达到恒生的哪个组合下。
//				group.setField(new StringField(14000, "1"));//投资类型：1-可交易；2-持有到期；3-可供出售；
//				group.setField(new StringField(13211, "7091"));//债券代码，银行间抵押债券的申报代码
//				group.setField(new DoubleField(13212, 1));//质押比例，抵押的比例90％填0.9
//				group.setField(new DoubleField(13213, 10));//质押数量，单位是张
//				order.addGroup(group);
//				group.setField(new StringField(1, "1001_000"));//恒生系统组合编号，指定指令下达到恒生的哪个组合下。
//				group.setField(new StringField(14000, "1"));//投资类型：1-可交易；2-持有到期；3-可供出售；
//				group.setField(new StringField(13211, "7092"));//债券代码，银行间抵押债券的申报代码
//				group.setField(new DoubleField(13212, 1));//质押比例，抵押的比例90％填0.9
//				group.setField(new DoubleField(13213, 100));//质押数量，单位是张
//				order.addGroup(group);
//				Session.sendToTarget(order, sessionID);
//				////--------------银行间二级市场业务-回购 指令下达（New Order-Single）测试下单结束!!!
				
				
				
				
				
				System.out.println("initiator.isLoggedOn(2)="+initiator.isLoggedOn());
				Iterator<?> it = initiator.getSessions().iterator();
				while(it.hasNext()){
					SessionID sid = (SessionID) it.next();
					System.out.println("=====sid="+sid);
				}
				
				
				if(DateUtil.currentDate().compareTo(DateUtil.parse("2016-06-30 18:30:00", DateUtil.YMDHMS_PATTERN))>0){
					System.out.println("当前时间大于设定时间，循环终止!!!");
					break;
				}
				Thread.sleep(60000*60);//暂停1分钟
			}
			
			
			initiator.stop();//客户端会话关闭!!!
			//initiator1.stop();
			System.out.println(DateUtil.currentDateTimeString()+" Fix终止执行!!!");
			
		} catch (RuntimeError e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}