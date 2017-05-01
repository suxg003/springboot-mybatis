package cn.no7player.controller;

import cn.no7player.controller.util.DateUtils;
import cn.no7player.controller.util.ExportExcelUtil;
import cn.no7player.controller.util.ImportCredtorUtils;
import cn.no7player.model.ClaimLoan;
import cn.no7player.model.User;
import cn.no7player.service.IClaimLoanService;
import cn.no7player.service.UserService;

import java.util.ArrayList;
import java.util.Collection;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.joda.time.LocalDate;
import org.joda.time.format.DateTimeFormat;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.plugins.Page;

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
	@Autowired
	private IClaimLoanService claimLoanServiceImpl;
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
			//TODO  批量插入数据
			claimLoanServiceImpl.insertBatch(list);
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
	@ResponseBody
	  public JSONObject fixedLoanList(String dateRange,String dateFilter,
	    		@RequestParam(value = "sSearch", required = false) String search,
	    		@RequestParam(value = "iDisplayStart") Integer startRow,
	    		@RequestParam(value = "iDisplayLength") Integer pageSize,ClaimLoan claimLoan){
		Page<ClaimLoan> page=claimLoanServiceImpl.selectPage(new Page<ClaimLoan>(startRow, pageSize), null); 
		JSONObject jsonObject = new JSONObject();
			jsonObject.put("aaData", page.getRecords());
	        jsonObject.put("iTotalRecords", page.getSize());
	        jsonObject.put("iTotalDisplayRecords", page.getTotal());
			return jsonObject;
	    }
	
	/**
	 * 
	 * fixedLoanListExport:导出列表. 
	 * TODO(这里描述这个方法适用条件 – 可选)
	 * TODO(这里描述这个方法的执行流程 – 可选)
	 * TODO(这里描述这个方法的使用方法 – 可选)
	 * TODO(这里描述这个方法的注意事项 – 可选)
	 *
	 * @author: suxg
	 * @param dateRange
	 * @param dateFilter
	 * @param search
	 * @param response
	 * @since JDK 1.8
	 */
	  @RequestMapping(value = "/claimLoan/fixedLoanListExport")
//    @PrivilegeRequired(Privilege.CLAIM_FIXED_IMPORT)
    public void fixedLoanListExport(String dateRange,String dateFilter,
    		@RequestParam(value = "sSearch", required = false) String search,HttpServletResponse response){
    	
    	Page<ClaimLoan> pageInfo = new Page<ClaimLoan>();
    	Date startDate = null;
		Date endDate = null;
		if (StringUtils.isNotEmpty(dateRange)) {
			startDate = DateTimeFormat.forPattern("yyyy-MM-dd").parseDateTime(dateRange.split(" - ")[0]).toDate();
			endDate = DateUtils.getOneDayRange(dateRange.split(" - ")[1])[1];
		}
    	String currDateStr = new LocalDate().toString("yyyyMMdd");
    	String fileName = currDateStr+".xls";
    	List<Map<String, Object>> listMap = new ArrayList<Map<String,Object>>();
    	pageInfo = claimLoanServiceImpl.selectPage(new Page<ClaimLoan>(1, 100000), null);
//    	pageInfo = claimLoanService.queryClaimByLoanTypeLoanRecords(startDate, endDate,dateFilter,search,ClaimType.FIXED);
    	claimLoanServiceImpl.exportClaimExcel(pageInfo.getRecords(), listMap);
    	defineExcelTemplate(currDateStr, fileName, listMap, response);
    }
    public static void defineExcelTemplate (String sheetStr,String fileName,List<Map<String, Object>> listMap ,HttpServletResponse response){
    	String[] sheet= {sheetStr};
		String[][] heards = {{"编号","汽车类型","车牌号","品牌","车架号","身份证号","姓名","购车日期","联系地址","手机号"}};
		String[][] keys = {{"id","cartype","carnumber","carpp","carcjh","persionid","persionname","gctime","addessid","phone"}};
		Collection<?>[] listC = new Collection[]{listMap};
 	ExportExcelUtil.exportExcel(fileName, response, listC, heards,keys,sheet);
    }
	
	
	
	
	
	
	
	
}
