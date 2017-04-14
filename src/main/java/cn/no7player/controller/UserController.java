package cn.no7player.controller;

import cn.no7player.controller.util.ImportCredtorUtils;
import cn.no7player.model.ClaimLoan;
import cn.no7player.model.User;
import cn.no7player.service.UserService;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

/**
 * Created by zl on 2015/8/27.
 */
@Controller
public class UserController {

	private Logger logger = Logger.getLogger(UserController.class);

	@Autowired
	private UserService userService;

	@RequestMapping("/getUserInfo")
	@ResponseBody
	public User getUserInfo() {
		User user = userService.getUserInfo();
		if (user != null) {
			System.out.println("user.getName():" + user.getName());
			logger.info("user.getAge():" + user.getAge());
		}
		return user;
	}

	/**
	 * 
	 * loginUser:登录校验.
	 *
	 * @author: suxg
	 * @param loginName
	 * @param password
	 * @return
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "/login.do")
	public ModelAndView loginUser(String loginName, String password) {
		ModelAndView modelAndView = new ModelAndView("login");
		if ("admin".equals(loginName) && "admin".equals(password)) {
			modelAndView.setViewName("index");

		} else {
			modelAndView.addObject("errors", "用户名或者密码错误");
			modelAndView.setViewName("login");
		}

		return modelAndView;
	}

	/**
	 * 
	 * getUserList:数据列表.
	 *
	 * @author: suxg
	 * @return
	 * @since JDK 1.8
	 */
	@RequestMapping(value = "/periodic/periodiclist")
	public ModelAndView getUserList() {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("claim/periodic/periodiclist");
		return modelAndView;
	}

	@RequestMapping(value = "/claimLoan/importFileFixedLoan")
	public RestData importFileFixedLoan(MultipartFile file) throws Exception {
		RestData resultMsg = new RestData();

		if (file.getSize() == 0) {
			resultMsg.setSuccess(0);
			resultMsg.setComment("请选择要上传的文件！");
			return resultMsg;
		}
		// String empId = ContextUtils.getCurrentEmployee(request).getEmpId();
		// 获取上传文件的类型
		String fileType = file.getOriginalFilename().substring(file.getOriginalFilename().lastIndexOf(".") + 1,
				file.getOriginalFilename().length());

		List<ClaimLoan> list = null;

		try {
			switch (fileType) {
			case "xls":
				list = ImportCredtorUtils.changeXls2BeanForClaimLoan(file.getInputStream());
				break;
			case "xlsx":
				list = ImportCredtorUtils.changeXlsx2BeanForClaimLoan(file.getInputStream());
				break;
			default:
				resultMsg.setSuccess(0);
				resultMsg.setComment("上传的文件类型错误，请重新选择！");
				return resultMsg;

			}
			System.out.println("###############" + list.size());
			resultMsg.setSuccess(1);

			resultMsg.setComment("文件中的数据已全部导入！一共" + list.size() + "条，成功导入" + list.size() + "条\r\n");

			return resultMsg;
		} catch (Exception e) {
			e.printStackTrace();
			resultMsg.setSuccess(0);
			resultMsg.setComment(e.getMessage());
			return resultMsg;
		}
	}

}
