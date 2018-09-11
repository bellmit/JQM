package com.cjhxfund.jy.DataProcess;

import java.util.List;
import java.util.Map;

public interface PbMapper {
	
	public List<PositionBasic> getPosition(String sql,List parm,Object excutor);
	
	public List<PositionBasic> getBond(String sql,List parm,Object excutor);
	
	public List<PositionBasic> getBondParllel(String sql,List parm,Object excutor,int split);
	
	public Map<String,String> getSellBackTag(String sql,List parm,Object excutor);
	
}
