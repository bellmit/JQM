/**
 * 
 */
package com.cjhxfund.ats.sm.comm;

import java.util.ArrayList;
import java.util.List;

import com.cjhxfund.commonUtil.model.TProductHandle;
import com.eos.system.annotation.Bizlet;

/**
 * @author 童伟
 * @date 2017-02-15 11:14:55 
 *	list处理类
 */
@Bizlet("")
public class ListManageUtil {

	/**
     * 去除用户id和当前登录用户相同的记录
     * @author 童伟
     * @date 2017-02-15 13:01:55 
     * @return list（返回取出后记录）
     */
    @Bizlet("去除用户id和当前登录用户相同的记录")
	public static List<TProductHandle> disposeList(List<TProductHandle> list, String userId) {
		List<TProductHandle> result = new ArrayList<TProductHandle>();
		if(list != null && list.size()>0){
			for(int i=0; i<list.size(); i++){
				TProductHandle productHandle = list.get(i);
				if(!productHandle.getVcUserId().equals(userId)){
					result.add(productHandle);
				}
			}
		}
		return result;
	}
}
