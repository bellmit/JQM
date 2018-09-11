package com.cjhxfund.jy.DataProcess;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.util.List;

public class MapperProxy implements InvocationHandler{
	
	private SqlSession sqlSession;
	
	public MapperProxy(SqlSession sqlSession){
		this.sqlSession = sqlSession;
	}
	
	@SuppressWarnings("unchecked")
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		// TODO 自动生成的方法存根
		
		int len = args.length;
		if(len >= 3){
			if(args[2] != null){
				Excutor excutor = (Excutor) args[2];
			if(len >= 4){
				if(args[3] != null){
					return excutor.query(sqlSession.getConnect(),String.valueOf(args[0]), (List<Object>) args[1], (Integer) args[3]);
				}
			}
			else
				return excutor.query(sqlSession.getConnect(),String.valueOf(args[0]), (List<Object>) args[1]);
			}
		}
		
		return sqlSession.select(String.valueOf(args[0]), (List<Object>) args[1]);

	}
	
	
}
