;(function($, window) {
	var proType = $("#productType"),selLinkage = $(".sel_linkage"),breakRateBox = $("#breakRateBox");

	/**
	 * 发布成功后跳转对应列表url
	 * @type Object
	 */
	var urlData = {
        "CURRENT_DEPOSIT":"/claimProduct/currentProList",
		"MONTH_WIN":"/claimProduct/pmProList",
		"RECYCLE_INTEREST":"/claimProduct/reProList",
		"FIXED_DEPOSIT_1":"/claimProduct/claimInvestPlanA/proList",
		"FIXED_DEPOSIT_3":"/claimProduct/claimInvestPlanB/proList",
		"FIXED_DEPOSIT_6":"/claimProduct/claimInvestPlanC/proList",
		"FIXED_DEPOSIT_9":"/claimProduct/claimInvestPlanD/proList"
	};

	selLinkage.attr("disabled","disabled");

	listenSel();
	proType.change(function(){
		listenSel();
	});
    showTotalNum("CURRENT");
    var ype;
	function showTotalNum(ctype){
		$.ajax({
			url: '/claimLoan/claimAssertByType/',
			type: 'GET',
			dataType: 'json',
			data: {type:ctype},
			success:function(data){
				//$("#primaryAssert").html(data.claimPara.primaryAssert + "元");
				$("#span_claim_remain_amount").html(data.claimPara.remainAssert + "元")
					.attr('data-remainAmount', data.claimPara.remainAssert);
			},
			error:function(error){
				console.log(error);
			}
		});
	}
	
	function listenSel(){
		proType.find("option").each(function(i){
			var _toption = $(this);
			if(_toption.is(":selected")){
                ype = $("#productType").val();
                if(ype=="CURRENT_DEPOSIT"){
                    ype = "CURRENT";
                }else{
                    ype = "FIXED";
                }
                showTotalNum(ype);
				if(i==0){
					$('.fixedRateWarp').html('12.36%以上');
                    $('#planRepaymentType').val('MONTHLY_INTEREST');
                    
				}
                else{
                    $('#planRepaymentType').val('BULLET_REPAYMENT');
                }
				if(i==1){
					$('.fixedRateWarp').html('13.08%以上');
					$('input[name=fixedRate]').hide();
				}

				if(i==6){
					$('.fixedRateWarp').html('');
                    $('#span_ratetype_text').html('预期');
                    $('#div_group_closurePeriod').hide();
                    $('#div_group_repayType').hide();
                    $('#flagCanbreak').val('1');
                    $('#expireOutType').val('MANUAL_EXPIRE');
                    $('#flagRedpack-group').hide();
                    $('#breakRateBox').find('.control-label').html('转出费率(%)：');
				}
                else{
                    $('#span_ratetype_text').html('固定');
                    $('#div_group_closurePeriod').show();
                    $('#div_group_repayType').show();
                    $('#flagCanbreak').val('0');
                    $('#expireOutType').val('AUTO_EXPIRE');
                    $('#breakRateBox').find('.control-label').html('提前赎回费率(%)：');
                    $('#flagRedpack-group').show();
                }

				// 复利计划 1 和 月盈计划 0 可以手工填写利率
				if (i == 1 || i == 0) {
					$('.fixedRateWarp').hide();
					$('input[name=fixedRate]').show();

					$('div[id=newFlag-group]').hide();// 隐藏新手标
					$('div[id=bigFlag-group]').show();// 显示大额标 默认勾选否
				}
				else if(i >= 2 && i < 6){
					if (i == 2) {// 定期计划A
						$('div[id=newFlag-group]').show();// 显示新手标 默认勾选否
						$('div[id=bigFlag-group]').hide();// 隐藏大额标 默认勾选否
					} else {
						$('div[id=newFlag-group]').hide();// 隐藏新手标 默认勾选否
						$('div[id=bigFlag-group]').hide();// 隐藏大额标 默认勾选否
					}

					breakRateBox.hide();
					$('.fixedRateWarp').hide();
					$('input[name=fixedRate]').show();
				}else{
					$('.fixedRateWarp').show().css('line-height','30px');
					$('input[name=fixedRate]').hide();
					breakRateBox.show();
				}
				if(i==6){
					$('input[name=fixedRate]').show();
					
				}

                selLinkage.each(function(j){
                    this.value =  $(this).siblings('input[type="hidden"]').val();
                });
			}
		})
	}

	$("#newProductForm").bootstrapValidator({
	    message: 'This value is not valid',
	    fields: {
	        amount: {
	            validators: {
	                notEmpty: {
	                    message: '请输入发布金额'
	                },
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '请输入正确的数字格式'
	                }
	            }
	        },
	        productName:{
	            validators: {
	                notEmpty: {
	                    message: '产品名称不能为空'
	                }
	            }
	        },
	        minAmount: {
	            validators: {
	                notEmpty: {
	                    message: '起投金额不能为空'
	                },
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '金额必须为数字'
	                }
	            }
	        },
	        maxAmount: {
	            validators: {
	                notEmpty: {
	                    message: '请输入最大投资金额'
	                },
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '金额必须为数字'
	                }
	            }
	        },
	        increaseNum: {
	            validators: {
	                notEmpty: {
	                    message: '请输入投资增量'
	                },
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '投资增量必须为数字'
	                }
	            }
	        },
	        fixedRate: {
	            validators: {
	                notEmpty: {
	                    message: '请输入固定年化利率'
	                },
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '固定年化利率必须为数字'
	                }
	            }
	        },
	        closurePeriod: {
	            validators: {
	                notEmpty: {
	                    message: '请输入投资期限'
	                },
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '投资期限必须为数字'
	                }
	            }
	        },
	        countRateType: {
	            validators: {
	                notEmpty: {
	                    message: '请选择计息时间'
	                }
	            }
	        },
	        breakRate:{
	            validators: {
	                regexp: {
	                    regexp: /^\d+(\.\d+)?$/,
	                    message: '提前赎回费率必须为数字'
	                }
	            }
	        }
	    }
	}).on("success.form.bv",function(e){
	    var asd =this;
	    // Prevent form submission
	    e.preventDefault();
	    // Get the form instance
	    var $form = $(e.target);
	    // Get the BootstrapValidator instance
	    var bv = $form.data('bootstrapValidator');

		var productType = $('#productType').val();

		// 月盈和复利计划 有大额标
		if (productType == 'MONTH_WIN' || productType == 'RECYCLE_INTEREST') {
			$('input[name=flagFresh]').val(0);
		}
		// 定期计划A 有新手标
		else if (productType == 'FIXED_DEPOSIT_1') {
			$('input[name=flagBig]').val(0);
		} else  {
			$('input[name=flagBig]').val(0);
			$('input[name=flagFresh]').val(0);
		}

        console.log($form.serialize());

	    $.post($form.attr('action'), $form.serialize(), function(data) {
            try{
                var res= $.parseJSON(data);
                if(res.success == 1){
                    var ctype = $("#productType").val();

                    //发布成功后跳转
                    var turl = urlData[ctype];
                    // alert("产品发布成功！");
                    window.location.href = turl;
                }else{
                    alert(res.comment);
                }

            }
            catch(x){
                alert(data);
            }
	    });
	});
})(jQuery, window);