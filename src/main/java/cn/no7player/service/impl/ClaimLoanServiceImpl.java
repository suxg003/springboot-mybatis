/**
 * Project Name:springboot-mybatis
 * File Name:ClaimLoanServiceImpl.java
 * Package Name:cn.no7player.service.impl
 * Date:2017年4月14日下午4:21:04
 *
*/

package cn.no7player.service.impl;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.baomidou.framework.service.impl.SuperServiceImpl;

import cn.no7player.mapper.ClaimLoanMapper;
import cn.no7player.model.ClaimLoan;
import cn.no7player.service.IClaimLoanService;

/**
 * ClassName:ClaimLoanServiceImpl Function: TODO ADD FUNCTION. Reason: TODO ADD
 * REASON. Date: 2017年4月14日 下午4:21:04
 * 
 * @version
 * @since JDK 1.8
 * @see
 */
@Service
public class ClaimLoanServiceImpl extends SuperServiceImpl<ClaimLoanMapper, ClaimLoan> implements IClaimLoanService {
	@Override
	public void exportClaimExcel(List<ClaimLoan> list, List<Map<String, Object>> listMap) {

		if (null != list && list.size() > 0) {
			SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
			for (int i = 0; i < list.size(); i++) {
				ClaimLoan loan = list.get(i);
				Map<String, Object> downLoadMap = new HashMap<String, Object>();
				downLoadMap.put("index", i + 1);
				downLoadMap.put("addessid", loan.getAddessid());
				downLoadMap.put("carcjh", loan.getCarcjh());
				downLoadMap.put("carnumber", loan.getCarnumber());
				downLoadMap.put("carpp", loan.getCarpp());
				downLoadMap.put("cartype", loan.getCartype());
				downLoadMap.put("gctime", loan.getGctime());
				downLoadMap.put("id", loan.getId());
				downLoadMap.put("persionid", loan.getPersionid());
				downLoadMap.put("persionname", loan.getPersionname());
				downLoadMap.put("phone", loan.getPhone());
				listMap.add(downLoadMap);
			}
		}
	}

}
