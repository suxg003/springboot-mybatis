package test;
import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.SpringApplicationConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.baomidou.mybatisplus.plugins.Page;

import cn.no7player.Application;
import cn.no7player.model.ClaimLoan;
import cn.no7player.service.IClaimLoanService;

/**
 * Project Name:springboot-mybatis
 * File Name:TestCarInfo.java
 * Package Name:
 * Date:2017年4月14日下午4:31:18
 *
*/

/**
 * ClassName:TestCarInfo Function: TODO ADD FUNCTION. Reason: TODO ADD REASON.
 * Date: 2017年4月14日 下午4:31:18
 * 
 * @author: suxg
 * @version
 * @since JDK 1.8
 * @see
 */
@RunWith(SpringJUnit4ClassRunner.class)
@SpringApplicationConfiguration(classes = Application.class)
@WebAppConfiguration
public class TestCarInfo {
	@Autowired
	private IClaimLoanService claimLoanServiceImpl;
	@Test
	public void saveCarinfo() {
		List<ClaimLoan> entiyList = new ArrayList<ClaimLoan>();
		ClaimLoan claimLoan=null;
		for (int i = 0; i < 10; i++) {
			 claimLoan = new ClaimLoan();
//			claimLoan.setId(Long.valueOf(i+100));
			claimLoan.setAddessid("123");
			claimLoan.setCarcjh("123");
			claimLoan.setCarnumber("1231");
			claimLoan.setCarpp("123123");
			claimLoan.setCartype("1");
			claimLoan.setGctime("123");
			claimLoan.setPersionid("12312");
			claimLoan.setPersionname("test");
			claimLoan.setPhone("18918293121");
			entiyList.add(claimLoan);
		}
 	Boolean b = claimLoanServiceImpl.insertBatch(entiyList);
 		System.out.println("############"+b);
// 		System.out.println(claimLoanServiceImpl.insert(claimLoan));
	}
	
	@Test
	public void getcarinfoList(){
	System.out.println("@@@@@@@@@"+claimLoanServiceImpl.selectCount(null));	
//	Page<ClaimLoan> com.baomidou.framework.service.IService.selectPage(Page<ClaimLoan> arg0, EntityWrapper<ClaimLoan> arg1)
	Page<ClaimLoan> page=claimLoanServiceImpl.selectPage(new Page<ClaimLoan>(0, 12), null);
	
	System.out.println("！！！！！！！！"+page.getTotal());
	List<ClaimLoan> list=page.getRecords();
	for(ClaimLoan a:list){
		System.out.println("###"+a.getId());
	}
	}
	
	

}
