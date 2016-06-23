/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package cn.no7player.taglib;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.SimpleTagSupport;
import java.io.IOException;

/**
 *
 * @author keven
 */
public class StringMaskHandler extends SimpleTagSupport {

    static Logger logger = LoggerFactory.getLogger(StringMaskHandler.class);

    String beforeMask;

    int start = 1;

    int length = 0;

    /**
     * 字符串打码。例如：keven -> k***n
     *
     * @throws javax.servlet.jsp.JspException
     * @throws java.io.IOException
     */
    @Override
    public void doTag() throws JspException, IOException {
        if (StringUtils.isBlank(beforeMask)) {
            logger.warn("Invalid beforeMask String is null.");
            return;
        }
        JspWriter writer = getJspContext().getOut();
        if (length <= 0) {  //没有设置length或默认length
            length = beforeMask.length() == 2 ? 1 : beforeMask.length() - 2;
        }
        if (length > beforeMask.length() - 1) {
            length = beforeMask.length() - 1;
        }

        //台胞证
        if((beforeMask.length()==8 || beforeMask.length() == 10 ||beforeMask.length() == 13) && start ==3 && length == 11 ){
            length = 5;
        }
        writer.write(mask(beforeMask, start, length));
    }

    public void setBeforeMask(String beforeMask) {
        this.beforeMask = beforeMask.trim();
    }

    public void setStart(int start) {
        this.start = start;
    }

    public void setLength(int length) {
        this.length = length;
    }

    private static char[] mask(String content, int offset, int length) {
        char[] chars = content.toCharArray();
        for (int i = offset; i < offset + length; i++) {
            chars[i] = '*';
        }
        return chars;
    }
}
