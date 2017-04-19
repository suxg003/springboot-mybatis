/**
 * Project Name:springboot-mybatis
 * File Name:ClaimLoan.java
 * Package Name:cn.no7player.model
 * Date:2017年4月13日下午5:31:32
 *
*/

package cn.no7player.model;
import java.io.Serializable;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * ClassName:ClaimLoan
 * Function: TODO ADD FUNCTION.
 * Reason:	 TODO ADD REASON.
 * Date:     2017年4月13日 下午5:31:32 
 * @author:   suxg
 * @version  
 * @since    JDK 1.8
 * @see 	 
 */

@TableName("carinfo")
public class ClaimLoan   {
	
	/**
	 * serialVersionUID:TODO(用一句话描述这个变量表示什么).
	 * @since JDK 1.8
	 */

@TableField(exist = false)
	private static final long serialVersionUID = -7455127841243654053L;

	/** 主键ID */
	@TableId(value = "id")
	private Long id;

public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
private String cartype;

private String carnumber;


private String carpp;

private String carcjh;

private String persionid;
private String persionname;
private String gctime;
private String addessid;
private String phone;

public String getCartype() {
	return cartype;
}
public void setCartype(String cartype) {
	this.cartype = cartype;
}
public String getCarnumber() {
	return carnumber;
}
public void setCarnumber(String carnumber) {
	this.carnumber = carnumber;
}
public String getCarpp() {
	return carpp;
}
public void setCarpp(String carpp) {
	this.carpp = carpp;
}
public String getCarcjh() {
	return carcjh;
}
public void setCarcjh(String carcjh) {
	this.carcjh = carcjh;
}
public String getPersionid() {
	return persionid;
}
public void setPersionid(String persionid) {
	this.persionid = persionid;
}
public String getPersionname() {
	return persionname;
}
public void setPersionname(String persionname) {
	this.persionname = persionname;
}
public String getGctime() {
	return gctime;
}
public void setGctime(String gctime) {
	this.gctime = gctime;
}
public String getAddessid() {
	return addessid;
}
public void setAddessid(String addessid) {
	this.addessid = addessid;
}
public String getPhone() {
	return phone;
}
public void setPhone(String phone) {
	this.phone = phone;
}
 
}

