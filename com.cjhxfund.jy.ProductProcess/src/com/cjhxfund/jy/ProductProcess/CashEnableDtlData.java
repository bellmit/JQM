package com.cjhxfund.jy.ProductProcess;

import java.io.Serializable;
/**
 * 计算总明细(期初余额、T+0、T+1头寸)javaBean
 * @author chendi
 *
 */
public class CashEnableDtlData implements Serializable {
  private static final long serialVersionUID = 201705161349570000L;

  public CashEnableDtlData() {}

  /* 基金序号 */
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
  
  /* 资产单元序号 */
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
  
  /* 数据返回顺序编号 */
  private Integer orderId = 9999;
  public Integer getOrderId() {
    return orderId;
  }
  public void setOrderId(Integer orderId) {
    this.orderId = orderId;
  }

  /* 市场编号 */
  private String marketNo;
  public String getMarketNo() {
    return marketNo;
  }
  public void setMarketNo(String marketNo) {
    this.marketNo = marketNo==null||marketNo.equals("")?null:marketNo.trim();
  }

  /* 委托方向 */
  private String entrustDirection;
  public String getEntrustDirection() {
    return entrustDirection;
  }
  public void setEntrustDirection(String entrustDirection) {
    this.entrustDirection = entrustDirection==null||entrustDirection.equals("")?null:entrustDirection.trim();
  }

  /* 证券代码 */
  private String stockCode;
  public String getStockCode() {
    return stockCode;
  }
  public void setStockCode(String stockCode) {
    this.stockCode = stockCode;
  }

  /* 证券名称 */
  private String stockName;
  public String getStockName() {
    return stockName;
  }
  public void setStockName(String stockName) {
    this.stockName = stockName;
  }

  /* 担保交收标志:0-担保,1-非担保 */
  private Integer guarFlag;
  public Integer getGuarFlag() {
    return guarFlag;
  }
  public void setGuarFlag(Integer guarFlag) {
    this.guarFlag = guarFlag;
  }

  /* 交割日期 */
  private Integer settleDate;
  public Integer getSettleDate() {
    return settleDate;
  }
  public void setSettleDate(Integer settleDate) {
    this.settleDate = settleDate;
  }

  /* 交割金额 */
  private Double settleBalance;
  public Double getSettleBalance() {
    return settleBalance;
  }
  public void setSettleBalance(Double settleBalance) {
    this.settleBalance = settleBalance;
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

  /* 数据来源:0-交易端,1-指令端 */
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
}
