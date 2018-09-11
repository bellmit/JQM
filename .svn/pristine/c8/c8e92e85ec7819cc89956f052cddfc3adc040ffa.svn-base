package com.cjhxfund.ats.sm.comm;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;

import com.eos.system.annotation.Bizlet;

import commonj.sdo.DataObject;
/**
 * @author 罗倔怀
 * @date 2017-09-15 14:30:37
 *
 */
@Bizlet("判断交易对手查询类型")
public class TraderSearchType {
	@Bizlet("返回查询类型")
	public int returnSearchType(String searchField){
		if(StringUtils.isEmpty(searchField)){
			return 1;//数字类型
		}
		Pattern patternNum = Pattern.compile("^-?[1-9]\\d*$",1);
		Matcher matcherNum = patternNum.matcher(searchField);
		if(matcherNum.matches()){
			return 1;//数字类型
		}
		Pattern patternEn = Pattern.compile("[a-zA-Z]*",1);
		Matcher matcherEn = patternEn.matcher(searchField);
		if(matcherEn.matches()){
			return 2;//英文类型
		}
		Pattern patternCode = Pattern.compile("^\\w+$",1);
		Matcher matcherCode = patternCode.matcher(searchField);
		if(matcherCode.matches()){
			return 4;//Code类型（英文+字母）
		}else{
			return 3;//中文类型或者其他
		}
		
	}
	@SuppressWarnings("unchecked")
	@Bizlet("交易对手排序")
	public List<DataObject> TradePYSort(DataObject[] list,String sortField,String fieldName){
		DataObject[] listTemp = new DataObject[500];
		if(list.length > 500){
			System.arraycopy(list, 0, listTemp, 0, 500);
		}else{
			listTemp = list;
		}
		List<DataObject> list2 = new ArrayList<DataObject>();
		Collections.addAll(list2, listTemp);
		int length = list2.size();
		List<PYSorter> traderList = new ArrayList<PYSorter>();
		for(int i =0; i<length; i++){
			String vcName = ((DataObject)list2.get(i)).getString(fieldName);
			PYSorter pySort = new PYSorter();
			if(vcName.equals(sortField)){
				pySort.setIndex(-2);
			}else{
				pySort.setIndex(vcName.indexOf(sortField));
			}
			pySort.setTrader((DataObject)list2.get(i));
			traderList.add(pySort);
		}
		ComparatorTrader comparator=new ComparatorTrader();
		Collections.sort(traderList, comparator);
		List<DataObject> lastList = new ArrayList<DataObject>();
		for(int j =0;j<length;j++){
			lastList.add(traderList.get(j).getTrader());
		}
		return lastList;
	}
}

