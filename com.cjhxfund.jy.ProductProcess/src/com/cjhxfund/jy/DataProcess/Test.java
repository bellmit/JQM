package com.cjhxfund.jy.DataProcess;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.concurrent.CountDownLatch;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

import com.cjhxfund.commonUtil.JDBCUtil;
import com.eos.engine.component.ILogicComponent;
import com.eos.foundation.data.DataObjectUtil;
import com.eos.system.annotation.Bizlet;
import com.primeton.ext.engine.component.LogicComponentFactory;
import commonj.sdo.DataObject;

public class Test {
	
	@Bizlet("")
	public void test() throws Throwable{
		
		//查询持仓基本信息
		SqlSession sqlSession = new SqlSession(JDBCUtil.DATA_SOURCE_DEFAULT);
		PbMapper mapper = sqlSession.getMapper(PbMapper.class);
		Excutor pbExc  = new PbExcutor();
		List<String> param = new ArrayList<String>();
		param.add("20180830");
		List<PositionBasic> list = mapper.getPosition("zhxxcx_pqb.sql", param, pbExc);
		System.out.println("list:" + list.size());
		
		//持仓去重
		PqbUtil pqbUtil = new PqbUtil();
		pqbUtil.deDuplicate(list);
		
		//添加买断式逆回购标记
		Map<String,String> tagMap = new HashMap<String,String>();
		Excutor tagExc = new TagExcutor(tagMap);
		List<String> tagParam = new ArrayList<String>();
		tagParam.add("20180830");
		mapper.getSellBackTag("zhxxcx_pqb_tag.sql", tagParam, tagExc); 
		System.out.println("tagMap:" + tagMap.size());
		pqbUtil.tagSellBack(list,tagMap);
		sqlSession.closeConnect();
		
		//查询债券基本信息
		SqlSession sqlSession1 = new SqlSession(JDBCUtil.DATA_SOURCE_SJZX);
		final PbMapper mapper1 = sqlSession1.getMapper(PbMapper.class);
		Map<String,Bond> bondMap = new HashMap<String,Bond>();
//		Excutor bdExc = new BondExcutor(list,bondMap);
//		mapper1.getBond("zhxxcx_bond.sql", null, bdExc);
//		System.out.println("bond:" + bondMap.size());		
		final List<String> split = PqbUtil.splitCodition(list,1000);
		int num = split.size();
		ExecutorService threadPool = Executors.newFixedThreadPool(num);
		final CountDownLatch latch = new CountDownLatch(num);
		final BondPrallelExcutor bpExc = new BondPrallelExcutor(list,bondMap,latch);			
		for(int i=0;i<num;i++){  			
			final int index = i;
			threadPool.execute(new Runnable() { 
				// 提交多个线程任务，并行执行
				public void run() { 					
					System.out.println(Thread.currentThread().getName() + " is running .."); 
					mapper1.getBondParllel("zhxxcx_bond.sql", split, bpExc, index); 
					} 
				}); 
		}
		latch.await();
		sqlSession1.closeConnect();
		
		//添加债券属性
		int bondNum = 0;
		for(PositionBasic pb:list){
			if(bondMap.containsKey(pb.getVcInterCodeWind2())){
				bondNum++;
				Bond bond = bondMap.get(pb.getVcInterCodeWind2());
				pb.setbIssuerCode(bond.getbIssuerCode());
				pb.setsInfoName(bond.getsInfoName());
				pb.setbDelistDate(bond.getbDelistDate());
				pb.setbCnbd(bond.getbCnbd());
				pb.setbIC1(bond.getbIC1());
				pb.setbIC2(bond.getbIC2());
				pb.setbIC3(bond.getbIC3());
				pb.setbIC4(bond.getbIC4());
				pb.setbPaymentDate(bond.getbPaymentDate());
				pb.setbICD(bond.getbICD());
				pb.setbGuarantorNature(bond.getbGuarantorNature());
				pb.setbRatingOutlook(bond.getbRatingOutlook());
				pb.setIsCityInvest(bond.getIsCityInvest());
				pb.setbPtmyear(bond.getbPtmyear());
				pb.setsIndustryName2(bond.getsIndustryName2());
				pb.setProvince(bond.getProvince());
				pb.setIsPayEarly(bond.getIsPayEarly());
			}
		}
		System.out.println("bondNum:" + bondNum);
		
		//插入排券基础表
		ILogicComponent comp = LogicComponentFactory.create("com.cjhxfund.jy.ProductProcess.ZhxxcxUtilBiz");		
		DataObject[] dataObjs = pqbUtil.transPbData(list);		
		Object[] params = new Object[]{dataObjs};
		Object[] result = (Object[]) comp.invoke("insertPqbaic", params);
		
	}
	
}
