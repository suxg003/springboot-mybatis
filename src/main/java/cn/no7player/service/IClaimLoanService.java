/**
 * Project Name:springboot-mybatis
 * File Name:IClaimLoanService.java
 * Package Name:cn.no7player.service
 * Date:2017年4月14日下午4:18:21
 *
*/

package cn.no7player.service;


import java.util.List;
import java.util.Map;

import com.baomidou.framework.service.IService;
import com.baomidou.framework.service.ISuperService;

import cn.no7player.model.ClaimLoan;


/**
 * ClassName:IClaimLoanService
 * Function: TODO ADD FUNCTION.
 * Reason:	 TODO ADD REASON.
 * Date:     2017年4月14日 下午4:18:21 
 * @author:   suxg
 * @version  
 * @since    JDK 1.8
 * @see 	 
 */
public interface IClaimLoanService extends ISuperService<ClaimLoan> {

	void exportClaimExcel(List<ClaimLoan> records, List<Map<String, Object>> listMap);

}

