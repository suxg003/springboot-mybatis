package cn.no7player.taglib;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

import javax.servlet.jsp.JspContext;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.PageContext;
import javax.servlet.jsp.tagext.SimpleTagSupport;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

/*import com.rmbbox.common.Constants;
import com.rmbbox.context.ContextUtils;
import com.rmbbox.context.SessionUtils;
import com.rmbbox.entity.CoreEmployee;
import com.rmbbox.enums.bbt.Privilege;
import com.rmbbox.enums.bbt.UpperRealm;
import com.rmbbox.service.core.EmployeeService;*/

/**
 * 作为辅助JSP控制输出的Tag.
 * <p/>
 * 根据 LoginRequired 和 Privilege 来进行限制
 *
 * @author haojunfu
 */
public class SecurityTagHandler extends SimpleTagSupport {

	private boolean loginRequired = false;

	/**
	 * 选择除privilegeString之外的所有权限
	 */
	private boolean reverse = true;

	/**
	 * 需要的权限列表，逗号分隔，形如"FUND_LIST, FUND_DEPOSIT"
	 */
	private String privilegeString;

	public boolean isLoginRequired() {
		return loginRequired;
	}

	public void setLoginRequired(boolean loginRequired) {
		this.loginRequired = loginRequired;
	}

	public boolean isReverse() {
		return reverse;
	}

	public void setReverse(boolean reverse) {
		this.reverse = reverse;
	}

	public String getPrivilegeString() {
		return privilegeString;
	}

	public void setPrivilegeString(String privilegeString) {
		this.privilegeString = privilegeString;
	}

	public String getRealmString() {
		return realmString;
	}

	public void setRealmString(String realmString) {
		this.realmString = realmString;
	}

	public String getUpperRealmString() {
		return upperRealmString;
	}

	public void setUpperRealmString(String upperRealmString) {
		this.upperRealmString = upperRealmString;
	}

	/**
	 * 需要的realm
	 */
	private String realmString;

	/**
	 * 需要的上一级realm
	 */
	private String upperRealmString;

	/*
	 * @Autowired private EmployeeService employeeService;
	 */
	@Override
	public void doTag() throws JspException, IOException {
		// getJspBody().invoke(null); //上线的时候注释掉该处，释放掉一下注释的地方
		if (loginRequired && !checkLogin()) {
			return;
		}
		/*
		 * Set<Privilege> granted = getGrantedPrivileges();
		 * 
		 * if (privilegeString != null && granted != null) { String[] privileges
		 * = privilegeString.split(","); if (reverse) { List<String>
		 * privilegeList = new ArrayList(); for (Privilege p :
		 * Privilege.values()) { privilegeList.add(p.name()); } for (String
		 * privilege : privileges) { String p = privilege.trim(); if
		 * (privilegeList.contains(p)) { privilegeList.remove(p); } } String[]
		 * temp = {}; privileges = privilegeList.toArray(temp); } for (String
		 * privilege : privileges) { Privilege p =
		 * Privilege.valueOf(privilege.trim()); if (p != null &&
		 * granted.contains(p)) { getJspBody().invoke(null); return; } } } else
		 * { if (StringUtils.isNotEmpty(upperRealmString)&& granted != null)
		 * {//角色的上一级校验 Iterator it = granted.iterator(); Privilege
		 * privilegeForRealm; while (it.hasNext()) { privilegeForRealm =
		 * (Privilege) it.next(); if
		 * (Arrays.asList(UpperRealm.getUpperRealm(upperRealmString)).contains(
		 * privilegeForRealm.getRealm().name())) { getJspBody().invoke(null);
		 * return; } } } if (StringUtils.isNotEmpty(realmString)&& granted !=
		 * null) { Iterator it = granted.iterator(); Privilege
		 * privilegeForRealm; while (it.hasNext()) { privilegeForRealm =
		 * (Privilege) it.next(); if
		 * (privilegeForRealm.getRealm().name().equals(realmString)) {
		 * getJspBody().invoke(null); return; } } } } if (checkAdmin()) {
		 * getJspBody().invoke(null); }
		 */
	}

	private boolean checkAdmin() {
		/*
		 * SessionUtils sessionUtils = getSessionUtils(); return
		 * sessionUtils.getEmployee() != null &&
		 * isAdminEmployee(sessionUtils.getEmployee());
		 */
		return true;
	}

	/**
	 * 检查当前是否登录
	 *
	 * @return
	 */
	private boolean checkLogin() {
		/*
		 * SessionUtils sessionUtils = getSessionUtils(); return sessionUtils !=
		 * null && sessionUtils.getEmployee() != null;
		 */
		return true;
	}

	/**
	 * 判断给定用户是否为Admin
	 *
	 * @param employee
	 * @return
	 */
	private boolean isAdminEmployee(CoreEmployee employee) {
		// return Constants.ADMIN.equalsIgnoreCase(employee.getLoginName());
		return true;
	}
	/**
	 * 获得当前登录用户的权限
	 *
	 * @return 没有登录用户返回null，无权限返回空数组
	 */
	/*
	 * private Set<Privilege> getGrantedPrivileges() { SessionUtils sb =
	 * getSessionUtils(); if (sb != null) { return sb.getPrivileges(); } else {
	 * return null; } }
	 */

	/**
	 * 获取当前的SessionUtils
	 *
	 * @return
	 */
	/*
	 * private SessionUtils getSessionUtils() { JspContext jc = getJspContext();
	 * Object sb = jc.getAttribute(ContextUtils.SESSIONUTILS,
	 * PageContext.SESSION_SCOPE); if (sb != null && sb instanceof SessionUtils)
	 * { return (SessionUtils) sb; } return null; }
	 */
}
