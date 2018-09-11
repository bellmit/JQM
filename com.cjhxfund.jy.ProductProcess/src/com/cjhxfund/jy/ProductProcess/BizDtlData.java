package com.cjhxfund.jy.ProductProcess;

import java.io.Serializable;

public class BizDtlData implements Serializable {
  private static final long serialVersionUID = 201706201841190000L;

  public BizDtlData() {}

  /** 基金序号 */
  private Integer fundId;
  public Integer getFundId() {
    return fundId;
  }
  public void setFundId(Integer fundId) {
    this.fundId = fundId;
  }

  /** 基金代码 */
  private String fundCode;
  public String getFundCode() {
    return fundCode;
  }
  public void setFundCode(String fundCode) {
    this.fundCode = fundCode;
  }

  /** 基金名称 */
  private String fundName;
  public String getFundName() {
    return fundName;
  }
  public void setFundName(String fundName) {
    this.fundName = fundName;
  }

  /** 资产单元序号 */
  private Integer assetId;
  public Integer getAssetId() {
    return assetId;
  }
  public void setAssetId(Integer assetId) {
    this.assetId = assetId;
  }

  /** 资产单元名称 */
  private String assetName;
  public String getAssetName() {
    return assetName;
  }
  public void setAssetName(String assetName) {
    this.assetName = assetName;
  }

  /** 交易日期 */
  private Integer tradeDate;
  public Integer getTradeDate() {
    return tradeDate;
  }
  public void setTradeDate(Integer tradeDate) {
    this.tradeDate = tradeDate;
  }

  /** 交割日期 */
  private Integer settleDate;
  public Integer getSettleDate() {
    return settleDate;
  }
  public void setSettleDate(Integer settleDate) {
    this.settleDate = settleDate;
  }

  /** 交易市场 */
  private String marketNo;
  public String getMarketNo() {
    return marketNo;
  }
  public void setMarketNo(String marketNo) {
    this.marketNo = marketNo;
  }

  /** 交易平台 */
  private String businClass;
  public String getBusinClass() {
    return businClass;
  }
  public void setBusinClass(String businClass) {
    this.businClass = businClass;
  }

  /** 证券代码 */
  private String stockCode;
  public String getStockCode() {
    return stockCode;
  }
  public void setStockCode(String stockCode) {
    this.stockCode = stockCode;
  }

  /** 证券名称 */
  private String stockName;
  public String getStockName() {
    return stockName;
  }
  public void setStockName(String stockName) {
    this.stockName = stockName;
  }

  /** 证券类别 */
  private String stockType;
  public String getStockType() {
    return stockType;
  }
  public void setStockType(String stockType) {
    this.stockType = stockType;
  }

  /** 委托方向 */
  private String entrustDirection;
  public String getEntrustDirection() {
    return entrustDirection;
  }
  public void setEntrustDirection(String entrustDirection) {
    this.entrustDirection = entrustDirection;
  }

  /** 业务类型 */
  private Integer businType;
  public Integer getBusinType() {
    return businType;
  }
  public void setBusinType(Integer businType) {
    this.businType = businType;
  }
  
  /** 业务类型名称 */
  private String businTypeName;
  public String getBusinTypeName() {
    return businTypeName;
  }
  public void setBusinTypeName(String businTypeName) {
    this.businTypeName = businTypeName;
  } 

  /** 发生金额 */
  private Double occurBal;
  public Double getOccurBal() {
    return occurBal;
  }
  public void setOccurBal(Double occurBal) {
    this.occurBal = occurBal;
  }

  /** 数据来源:0-交易端,1-指令端 */
  private Integer dataSource;
  public Integer getDataSource() {
    return dataSource;
  }
  public void setDataSource(Integer dataSource) {
    this.dataSource = dataSource;
  }
  
  /** 托管机构0-中证登1-中债登2-上清所 */
  private Integer trusteeShip;
  public Integer getTrusteeShip() {
    return trusteeShip;
  }
  public void setTrusteeShip(Integer trusteeShip) {
    this.trusteeShip = trusteeShip;
  }
  
  /** 交易对手托管序号 */
  private String tradeRivalId;
  public String getTradeRivalId() {
    return tradeRivalId;
  }
  public void setTradeRivalId(String tradeRivalId) {
    this.tradeRivalId = tradeRivalId;
  }
  /** 交易对手名称 */
  private String tradeRivalName;
  public String getTradeRivalName() {
    return tradeRivalName;
  }
  public void setTradeRivalName(String tradeRivalName) {
    this.tradeRivalName = tradeRivalName;
  }
  
}
