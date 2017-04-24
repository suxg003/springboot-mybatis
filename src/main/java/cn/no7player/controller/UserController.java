package cn.no7player.controller;

import cn.no7player.controller.util.ImportCredtorUtils;
import cn.no7player.model.CLoan;
import cn.no7player.model.ClaimLoan;
import cn.no7player.model.User;
import cn.no7player.service.UserService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.annotation.MultipartConfig;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;

/**
 * Created by zl on 2015/8/27.
 */
@Controller
//@RequestMapping("/user")
//@MultipartConfig(maxFileSize = 1024*1024*1024, maxRequestSize = 1024*1024*1024)
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
			modelAndView.setViewName("/WEB-INF/jsp/index");

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
	@ResponseBody
	public RestData importFileFixedLoan(MultipartFile file) throws Exception {
		RestData resultMsg = new RestData();
		Map map=new HashMap();
		if (file.getSize() == 0) {
			resultMsg.setSuccess(0);
			resultMsg.setComment("请选择要上传的文件！");
			map.put("data",resultMsg );
//			return map;
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
				map.put("data",resultMsg );
//				return map;
				return resultMsg;

			}
			System.out.println("###############" + list.size());
			//TODO   插入数据见junit，缺少查询和导出---------
			
			resultMsg.setSuccess(0);

			resultMsg.setComment("文件中的数据已全部导入！一共" + list.size() + "条，成功导入" + list.size() + "条\r\n");
			//TODO 坑壁的js  返回json数据解析错误
			map.put("data",resultMsg );
//			return map;
			return resultMsg;
		} catch (Exception e) {
			e.printStackTrace();
			resultMsg.setSuccess(0);
			resultMsg.setComment(e.getMessage());
			map.put("data",resultMsg );
//			return map;
			return resultMsg;
		}
	}
	
	
	@RequestMapping(value = "/claimLoan/fixedLoanList")
	  public JSONObject fixedLoanList(String dateRange,String dateFilter,
	    		@RequestParam(value = "sSearch", required = false) String search,
	    		@RequestParam(value = "iDisplayStart") Integer startRow,
	    		@RequestParam(value = "iDisplayLength") Integer pageSize){
		
		ClaimLoan cl=new ClaimLoan();
		cl.setAddessid("111");
		cl.setCarcjh("222");
		cl.setCarnumber("333");
		cl.setCarpp("pp");
		cl.setCartype("111");
		cl.setGctime("123");
		cl.setPersionid("555");
		cl.setPersionname("ccccc");
		cl.setPhone("1888888");
		
		List<ClaimLoan> list=new ArrayList<ClaimLoan>();
	    
		list.add(cl);
		
		JSONObject jsonObject = new JSONObject();
			jsonObject.put("aaData", list);
	        jsonObject.put("iTotalRecords", 10);
	        jsonObject.put("iTotalDisplayRecords", 20);
			return jsonObject;
	    }
}
