package cn.no7player.model;

import java.math.BigDecimal;
import java.util.Date;
 
public class CLoan  {


	/** 债权编号 */
    private String loanId;

    private String loanerName;

    private String loanerCardNo;

    private String loanerAddress;

    private String loanerProfession;

    private String loanerPurpose;

    public String getLoanId() {
		return loanId;
	}

	public void setLoanId(String loanId) {
		this.loanId = loanId;
	}

	public String getLoanerName() {
		return loanerName;
	}

	public void setLoanerName(String loanerName) {
		this.loanerName = loanerName;
	}

	public String getLoanerCardNo() {
		return loanerCardNo;
	}

	public void setLoanerCardNo(String loanerCardNo) {
		this.loanerCardNo = loanerCardNo;
	}

	public String getLoanerAddress() {
		return loanerAddress;
	}

	public void setLoanerAddress(String loanerAddress) {
		this.loanerAddress = loanerAddress;
	}

	public String getLoanerProfession() {
		return loanerProfession;
	}

	public void setLoanerProfession(String loanerProfession) {
		this.loanerProfession = loanerProfession;
	}

	public String getLoanerPurpose() {
		return loanerPurpose;
	}

	public void setLoanerPurpose(String loanerPurpose) {
		this.loanerPurpose = loanerPurpose;
	}

	public String getContractId() {
		return contractId;
	}

	public void setContractId(String contractId) {
		this.contractId = contractId;
	}

	public BigDecimal getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(BigDecimal loanAmount) {
		this.loanAmount = loanAmount;
	}

	public BigDecimal getMatchedAmount() {
		return matchedAmount;
	}

	public void setMatchedAmount(BigDecimal matchedAmount) {
		this.matchedAmount = matchedAmount;
	}

	public BigDecimal getRemainAmount() {
		return remainAmount;
	}

	public void setRemainAmount(BigDecimal remainAmount) {
		this.remainAmount = remainAmount;
	}

	public String getLoanRepaymentType() {
		return loanRepaymentType;
	}

	public void setLoanRepaymentType(String loanRepaymentType) {
		this.loanRepaymentType = loanRepaymentType;
	}

	public String getLoanType() {
		return loanType;
	}

	public void setLoanType(String loanType) {
		this.loanType = loanType;
	}

	public BigDecimal getLoanRate() {
		return loanRate;
	}

	public void setLoanRate(BigDecimal loanRate) {
		this.loanRate = loanRate;
	}

	public Short getLoanTimeLimit() {
		return loanTimeLimit;
	}

	public void setLoanTimeLimit(Short loanTimeLimit) {
		this.loanTimeLimit = loanTimeLimit;
	}

	public Date getLoanStartDate() {
		return loanStartDate;
	}

	public void setLoanStartDate(Date loanStartDate) {
		this.loanStartDate = loanStartDate;
	}

	public Date getRepayStartDate() {
		return repayStartDate;
	}

	public void setRepayStartDate(Date repayStartDate) {
		this.repayStartDate = repayStartDate;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public Short getBilldateType() {
		return billdateType;
	}

	public void setBilldateType(Short billdateType) {
		this.billdateType = billdateType;
	}

	public String getProductType() {
		return productType;
	}

	public void setProductType(String productType) {
		this.productType = productType;
	}

	public String getLoanStatus() {
		return loanStatus;
	}

	public void setLoanStatus(String loanStatus) {
		this.loanStatus = loanStatus;
	}

	public String getMediatorId() {
		return mediatorId;
	}

	public void setMediatorId(String mediatorId) {
		this.mediatorId = mediatorId;
	}

	public String getMediatorLoginName() {
		return mediatorLoginName;
	}

	public void setMediatorLoginName(String mediatorLoginName) {
		this.mediatorLoginName = mediatorLoginName;
	}

	public BigDecimal getManageFee() {
		return manageFee;
	}

	public void setManageFee(BigDecimal manageFee) {
		this.manageFee = manageFee;
	}

	public Date getCashDate() {
		return cashDate;
	}

	public void setCashDate(Date cashDate) {
		this.cashDate = cashDate;
	}

	public String getLoanSource() {
		return loanSource;
	}

	public void setLoanSource(String loanSource) {
		this.loanSource = loanSource;
	}

	public Boolean getFlagBanned() {
		return flagBanned;
	}

	public void setFlagBanned(Boolean flagBanned) {
		this.flagBanned = flagBanned;
	}

	public String getMediatorUserName() {
		return mediatorUserName;
	}

	public void setMediatorUserName(String mediatorUserName) {
		this.mediatorUserName = mediatorUserName;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public String getCreateEmpId() {
		return createEmpId;
	}

	public void setCreateEmpId(String createEmpId) {
		this.createEmpId = createEmpId;
	}

	public BigDecimal getMatchNow() {
		return matchNow;
	}

	public void setMatchNow(BigDecimal matchNow) {
		this.matchNow = matchNow;
	}

	public BigDecimal getLastProfit() {
		return lastProfit;
	}

	public void setLastProfit(BigDecimal lastProfit) {
		this.lastProfit = lastProfit;
	}

	public Integer getRemainPeriod() {
		return remainPeriod;
	}

	public void setRemainPeriod(Integer remainPeriod) {
		this.remainPeriod = remainPeriod;
	}

	private String contractId;

    private BigDecimal loanAmount;

    private BigDecimal matchedAmount;

    private BigDecimal remainAmount;

    private String loanRepaymentType;

    private String loanType;

    private BigDecimal loanRate;

    private Short loanTimeLimit;

    private Date loanStartDate;

    private Date repayStartDate;

    private Date dueDate;

    private Short billdateType;

    private String productType;

    private String loanStatus;
    private String mediatorId;
    private String mediatorLoginName;
    private BigDecimal manageFee;

    private Date cashDate;

    private String loanSource;

    private Boolean flagBanned=true;
    
    private String mediatorUserName;// 用于页面显示 不如数据库
    
    private Date createTime;
    private String createEmpId;
    
    private BigDecimal matchNow;
    
    private BigDecimal lastProfit;
    
    private Integer remainPeriod;
    
    public static void main(String[] args) {
		System.out.println((23&17|13)%11.31);
	}
 

}