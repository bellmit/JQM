package com.cjhxfund.fpm.bpsExpend;

import com.eos.system.annotation.Bizlet;

@Bizlet("")
public class TimerService {

	private static ConnectSolr solr;

	public void init() {
		if (solr == null) {
			solr = new ConnectSolr();
		}
	}

	/**
	 * 导入产品名称的定时器
	 */
	@Bizlet("")
	public void importProductName() {
		init();
		//导入数据
		solr.importDataToSolr("product");
	}
}
