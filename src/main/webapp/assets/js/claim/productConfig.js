
	//  status 0 OPENED、1 INITIATED、2 SCHEDULED、3 FINISHED、4 SETTLED、5 FAILED、6 CANCELED、7 CLEARED、8 OVERDUE、
	// 9 BREACH、10 ARCHIVED
	    
		/*$('#loanTabs li').eq(iData.status).addClass('active');
		$('#downloadLoan').attr('href','/loan/download/'+iData.status);*/
			
       /* var oTable = $('#LOANS_LIST').dataTable({
            "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
            "iDisplayLength": 10,
            "bProcessing": true,
            "bServerSide": true,
            "bSort": false,
            "bFilter": true,
            "bPaginate": true,
			"bRetrieve": true,
			"aaSorting":[[2,"desc"]],
            "aoColumns": [
                    {"mData": "productId"},
                    {"mData": "pcHomeIndex"},
                    {"mData": "pcClaimListIndex"},
                    {"mData": "pcBbtListIndex"},
                    {"mData": "mhomeIndex"},
                    {"mData": "mclaimListIndex"},
                    {"mData": "mbbtListIndex"},
                    {"mData": "appHomeIndex"},
                    {"mData": "appClaimListIndex"},
                    {"mData": "appBbtListIndex"},
                    {"mData": ""}
            ],
            "aoColumnDefs": [
				{
				    "aTargets": [10], //uid link
				    "mRender": function (data, type, row) {						
							return ' <a href="#" class="btn btn-info btn-xs edit"><i class="fa fa-edit"></i> 编辑</a>';						
				    }
				}
            ],
            "fnDrawCallback": function (oSettings) {
                $("#searchRechargeHistory").html('查询');
                $("#searchRechargeHistory").prop('disabled', false);
            },
            //"sAjaxSource": "/productConfig/list",
            "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
				$('#downloadLoan').attr('href','/loan/download/'+iData.status+'?search='+getSearchVal(aoData));
				aoData.push({
					"name": "status",
					"value": iData.status
				});
                oSettings.jqXHR = $.ajax({
                    "dataType": 'json',
                    "type": "GET",
                    "url": sSource,
                    "data": aoData,
                    "success": fnCallback,
                    "error": function () {
                        console.log('error'+aoData);
                    }
                });
            },
            "oLanguage": {
                "sLengthMenu": "_MENU_",
                "sSearch": "",
                "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
                "sInfoEmpty": "没有符合条件的记录",
                "sZeroRecords": "没有符合条件的记录",
                "oPaginate": {
					"sFirst": "首页",
					"sPrevious": "前一页",
					"sNext": "后一页",
					"sLast": "尾页"
				}
            }
        });*/
        
        var oTable = $('#LOANS_LIST').dataTable({
            "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
            "iDisplayLength": 10,
            "bProcessing": true,
            //"bServerSide": true,
            "bSort": false,
            "bFilter": true,
            "bPaginate": true,
			"bRetrieve": true,
            "oLanguage": {
                "sLengthMenu": "_MENU_",
                "sSearch": "",
                "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
                "sInfoEmpty": "没有符合条件的记录",
                "sZeroRecords": "没有符合条件的记录",
                "oPaginate": {
					"sFirst": "首页",
					"sPrevious": "前一页",
					"sNext": "后一页",
					"sLast": "尾页"
				}
            }
        });
        //InitiateEditableDataTable.init();
var status=location.href.substr(location.href.lastIndexOf("/")+1);

$('#loanTabs li').click(function(){
	var sIndex=$(this).index();
	var href='/loan/loanList/'+sIndex;
	location.replace(href)
});
function archiveLoan(loanId){
	var href='/loan/archiveLoan/'+loanId;
	location.replace(href)
}


function getSearchVal(params) {
	for(var i=0;i<params.length;i++){
		if(params[i].name=="sSearch"){
			return params[i].value;
		}
	}
}

/**
 * 编辑标的顺序
 * @param ele 编辑时触发的元素，为了的到productId
 */
function showSingleUser(ele,url){
    var template = Handlebars.compile( $("#singleUser-template").html());
    //默认数据
    var context = {loginName: "", name:'',idNumber:"",mobile:"",employeeId:""};
    var html='';
    if(ele==true){
        //编辑员工信息
        $.ajax({url:url,data:{},type:"get",dataType:'json',success:function(data){
        	var data=data.data;
            context = {
            	pcHomeIndex: data.pcHomeIndex,
            	pcClaimListIndex: data.pcClaimListIndex,
            	pcBbtListIndex: data.pcBbtListIndex,
            	mHomeIndex: data.mhomeIndex,
            	mClaimListIndex: data.mclaimListIndex,
            	mBbtListIndex: data.mbbtListIndex,
            	appHomeIndex: data.appHomeIndex,
            	appClaimListIndex: data.appClaimListIndex,
            	appBbtListIndex: data.appBbtListIndex,
            	productId:data.productId,
            	productType:data.productType
            };
            showdailog(context);
            validateEditUser();
        }})
    }else{
        showdailog(context);
        validateUser();
    }
    function showdailog(context){
        html    = template(context);
        bootbox.dialog({
            message: html,
            title: "标的顺序",
            className: "modal-darkorange"
        });
    }
}

function validateEditUser(){
    $("#userForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
        	pcIndex: {
                validators: {
                	regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            pcClaimList: {
            	validators: {
            		regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            pcBBTList: {
                validators: {
                	regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            MIndex: {
                validators: {
                	regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            MClaimList: {
            	validators: {
            		regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            MBBTList: {
                validators: {
                	regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            APPIndex: {
                validators: {
                	regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            APPClaimList: {
            	validators: {
            		regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
                    }
                }
            },
            APPBBTList: {
                validators: {
                	regexp: {
                        regexp: /\d{1,3}/,
                        message: '位置必须为数字'
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

        //var $form = $(e.target),        // The form instanc
        //    fv    = $(e.target).data('formValidation');
        //
        //alert(fv);

        $.post($form.attr('action'), $form.serialize(), function(data) {
            var res= jQuery.parseJSON(data);
            if(res.success){
                location.href="/productConfig/Up";
            }else{
                alert(res.comment);
            }
        });
    });
}
