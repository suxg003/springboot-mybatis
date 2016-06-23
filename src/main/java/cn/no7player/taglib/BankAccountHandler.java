/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.no7player.taglib;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;


/**
 * @author sobranie
 */
public class BankAccountHandler extends SimpleTagSupport {

    Logger logger = LoggerFactory.getLogger(this.getClass());

    /**
     * 银行卡号，16位或19位数字
     */
    String account;

    @Override
    public void doTag() throws JspException, IOException {
        if (account == null) {
            logger.warn("Invalid account is null.");
            return;
        }
        JspWriter writer = getJspContext().getOut();
        if (account.length() == 16) {
            writer.write(account, 0, 4);
            writer.write("&nbsp;");
            writer.write(account, 4, 4);
            writer.write("&nbsp;");
            writer.write(account, 8, 4);
            writer.write("&nbsp;");
            writer.write(account, 12, 4);
        } else if (account.length() == 19) {
            writer.write(account, 0, 6);
            writer.write("&nbsp;");
            writer.write(account, 6, 13);
        } else {
            logger.warn("Bank account number " + account + "is invalid !");
            writer.write(account);
        }
    }

    public void setAccount(String account) {
        this.account = account.trim();
    }
}
