$('#userList').dataTable({
    "sDom": "flt<'row'<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "iDisplayLength": 10,
    "aaSorting":[[6,"desc"]],
    "aoColumns": [
        {"mData": "loginName"},//0
        {"mData": "userName"},//1
        {"mData": "idNumber"},//2
        {"mData": "userMobile"},//3
        {"mData": "email"},//4
        {"mData": "lastLoginTime"},//5
        {"mData": "registerTime"},//6
        {"mData": "referralLoginName"},//7
        {"mData": "registerSource"},//8
        {"mData": "id"}//9
    ],
    "aoColumnDefs": [{
        //"bSortable": false,
        "aTargets": [0], //uid link
        "mRender": function (data, type, row) {
            var uid = row.userId;
            if(data!=undefined){
                return '<a href="/user/profile/?userId=' + uid + '">' + data + '</a>';
            }else{
                return '<a href="/user/profile/?userId=' + uid + '"></a>';
            }
            //                                $.get("corporation/isLegalPserson/" + uid, function(res) {
            //                                    if (res) {
            //                                        $('#u' + uid).show();
            //                                    }
            //                                });

        }
    }, {
        //"bSortable": false,
        "aTargets": [9],
        "mRender": function (data, type, row) {
            var template = Handlebars.compile($("#editUser").html());
            var contextData = {userId:row.userId,name:row.userName,isEnabled:row.enabled,loginname:row.loginName,referralLoginName:row.referralLoginName};
            html= template(contextData);
            return html;
        }
    }, {
        "aTargets": [6],
        "mRender": function (data, type, row) {
            return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
        }
    }, {
        //"bSortable": false,
        "aTargets": [7],
        "mRender": function (data, type, row) {
        	var eid = row.referralId;
            var referralLoginName = row.referralLoginName;
            if(referralLoginName==''){
            	  return "无";
            }else{
            	return '<a href="/user/profile/?userId=' + eid + '" target="_blank" class="eid' + eid + '">' + referralLoginName + '</a>';
            }
        	
            /* if (data.realm === 'USER_NULL') {
             return "无";
             } else if (data.realm === 'EMPLOYEE') {
             var eid = data.entityId;
             var referralLoginName = row.referralLoginName;
             //
             return '<a href="employee/profile/' + eid + '" target="_blank" class="eid' + eid + '">' + referralLoginName + '</a>';
             } else if (data.realm === 'USER') {
             var uid = data.entityId;
             var referralLoginName = row.referralLoginName;
             //
             return '<a href="user/profile/' + uid + '" target="_blank" class="uuid' + uid + '">' + referralLoginName + '</a>';
             } else {
             return data.entityId;
             }*/
        }
    }, {
        //"bSortable": false,
        "aTargets": [8],
        "mRender": function (data, type, row) {
            return source[data];
        }
    }, {
        "aTargets": [5],
        "mRender": function (data, type, row) {
            return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
        }
    },{
        //"bSortable": false,
        "aTargets": [1],
        "mRender": function (data, type, row) {
            return data;
        }
    },{
        //"bSortable": false,
        "aTargets": [2],
        "mRender": function (data, type, row) {
            return data;
        }
    },{
        //"bSortable": false,
        "aTargets": [3],
        "mRender": function (data, type, row) {
            return data;
        }
    },{
        //"bSortable": false,
        "aTargets": [4],
        "mRender": function (data, type, row) {
            return data;
        }
    }
    ],
    "sAjaxSource": "/user/list/getData",
    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

        for (var i = 0; i < aoData.length; i++) {
            if (aoData[i]['name'] == 'iSortCol_0') {
                var cols = this.fnSettings().aoColumns;
                var index = parseInt(aoData[i]['value']);
                aoData.push({"name": "sColName", "value": cols[index]['mData']});
                //break;
            }
            if(aoData[i]['name'] == 'sSearch') {
                if (aoData[i]['value']) {
                    $('#link_download').attr('href', '/user/download?sSearch=' + aoData[i]['value']);
                }
                else {
                    $('#link_download').attr('href', '/user/download');
                }
            }
        }

        oSettings.jqXHR = $.ajax({
            "dataType": 'json',
            "type": "GET",
            "url": sSource,
            "data": aoData,
            "success": fnCallback,
            "error": function () {

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
});


var userFlag = false;
var oprType = "add";
/**
 * 编辑新建 员工信息
 * @param ele 编辑时触发的元素，为了的到empId
 */
function showSingleUser(ele,url){
    var template = Handlebars.compile( $("#singleUser-template").html());
    //默认数据
    var context = {
        loginName: "",
        userName:"",
        idNumber:"",
        userMobile:"",
        cardNo:"",
        email:"",
        enName:"",
        loginName:"",
        enLicenseNo:""};

    var html='';

    if(ele==true){
        //编辑员工信息
        $.ajax({url:url,data:{},type:"get",dataType:'json',success:function(data){
            context = {
                loginName: data.loginName,
                userId: data.userId,
                userName: data.userName,
                idNumber: data.idNumber,
                userMobile: data.userMobile,
                email: data.email,
                cardNo: data.cardNo,
                enLicenseNo:data.enLicenseNo
            };
            userFlag = data.enterprise;

            showdailog(context);
            displayByType(data.enterprise);
            document.getElementById('userType').style.display = "none";

            validateEditUser();

            $("#bankName").val(data.bankName);
        }});
        oprType = 'edit';
    }else {
        showdailog(context);
        validateUser();

        $('#userType li').click(function () {
            displayByType($(this).index() != 0);
        })
    }

    function showdailog(context){
        html    = template(context);
        bootbox.dialog({
            message: html,
            title: "用户记录",
            className: "modal-darkorange"
        });
    }

    function displayByType(type) {
        if (!type) {// 个人用户
            document.getElementById("enInfo").style.display = "none";
            document.getElementById("perInfo").style.display = "block";
        } else {// 企业用户
            document.getElementById("enInfo").style.display = "block";
            document.getElementById("perInfo").style.display = "none";
        }
    }
}

function editOrAdd() {
    if(oprType == 'edit'){
        if (userFlag) {
            $("#enUserForm").submit();
        } else {
            $("#userForm").submit();
        }
    } else {
        var type = $('#userType li[class=active]').data('type');
        if (type == 'en') {
            $("#enUserForm").submit();
        } else {
            $("#userForm").submit();
        }
    }
}
/**
 * confirm提示框
 * @param str  confirm提示语句
 * @param strHref  要执行的url
 */
function showConfirm (str,strHref){
    //bootbox.setLocale("zh_CN");
    bootbox.confirm(str, function (result) {
        if (result) {
            location.replace(strHref)
        }
    });
}

/*$("#employeeForm").bootstrapValidator();*/
function validateUser(){
    $("#userForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            loginName: {
                validators: {
                    notEmpty: {
                        message: '请输入用户登录名'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '登录名最少3位字母/数字'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'用户登录名重复'
                    }
                }
            },
            userName: {
                validators: {
                    notEmpty: {
                        message: '请输入用户姓名'
                    }
                }
            },
            idNumber: {
                validators: {
                    notEmpty: {
                        message: '请输入用户身份证号'
                    },
                    regexp: {
                        regexp: /[1-9][0-9]{16}[0-9xX]/,
                        message: '身份证号码格式不正确'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'身份证号码不能重复'
                    }
                }
            },
            userMobile: {
                validators: {
                    notEmpty: {
                        message: '请输入用户手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'用户手机号不能重复'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: '请输入用户邮箱'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message: '用户邮箱不能重复'
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
            if(res.result){
                location.href="/user/list";
            }else{
                alert(res.message);
            }
        });
    });
    $("#enUserForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            loginName: {
                validators: {
                    notEmpty: {
                        message: '请输入登录名(企业简称)'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '登录名(企业简称)3位字母/数字'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'登录名(企业简称)重复'
                    }
                }
            },
            userName: {
                validators: {
                    notEmpty: {
                        message: '请输入企业名称(全称)'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'企业名称(全称)重复'
                    }
                }
            },
            enLicenseNo: {
                validators: {
                    notEmpty: {
                        message: '请输入营业执照编号'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'营业执照编号不能重复'
                    }
                }
            },
            idNumber: {
                validators: {
                    notEmpty: {
                        message: '请输入法人身份证号'
                    },
                    regexp: {
                        regexp: /[1-9][0-9]{16}[0-9xX]/,
                        message: '法人身份证号格式不正确'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'法人身份证号不能重复'
                    }
                }
            },
            userMobile: {
                validators: {
                    notEmpty: {
                        message: '请输入法人手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'法人手机号不能重复'
                    }
                }
            },
            cardNo: {
                validators: {
                    notEmpty: {
                        message: '请输入银行卡号'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message:'银行卡号不能重复'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: '请输入企业邮箱'
                    },
                    remote: {
                        url: '/user/check',
                        type: 'POST',
                        delay: 2000,
                        message: '企业邮箱不能重复'
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
            if(res.result){
                location.href="/user/list";
            }else{
                alert(res.message);
            }
        });
    });
}

function validateEditUser(){
    $("#userForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            loginName: {
                validators: {
                    notEmpty: {
                        message: '请输入用户登录名'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '登录名最少3位字母/数字'
                    }
                }
            },
            userName: {
                validators: {
                    notEmpty: {
                        message: '请输入用户姓名'
                    }
                }
            },
            idNumber: {
                validators: {
                    notEmpty: {
                        message: '请输入用户身份证号'
                    },
                    regexp: {
                        regexp: /[1-9][0-9]{16}[0-9xX]/,
                        message: '身份证号码格式不正确'
                    }
                }
            },
            userMobile: {
                validators: {
                    notEmpty: {
                        message: '请输入用户手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: '请输入用户邮箱'
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
            if(res.result){
                alert(res.message);
                location.href="/user/list";
            }else{
                alert(res.message);
            }
        });
    });

    $("#enUserForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            loginName: {
                validators: {
                    notEmpty: {
                        message: '请输入登录名(企业简称)'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '登录名(企业简称)最少3位字母/数字'
                    }
                }
            },
            userName: {
                validators: {
                    notEmpty: {
                        message: '请输入企业名称(全称)'
                    }
                }
            },
            enLicenseNo: {
                validators: {
                    notEmpty: {
                        message: '请输入营业执照编号'
                    }
                }
            },
            idNumber: {
                validators: {
                    notEmpty: {
                        message: '请输入法人身份证号:'
                    },
                    regexp: {
                        regexp: /[1-9][0-9]{16}[0-9xX]/,
                        message: '身份证号码格式不正确'
                    }
                }
            },
            userMobile: {
                validators: {
                    notEmpty: {
                        message: '请输入法人手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
                    }
                }
            },
            email: {
                validators: {
                    notEmpty: {
                        message: '请输入公司银行卡号'
                    }
                }
            },
            cardNo: {
                validators: {
                    notEmpty: {
                        message: '请输入企业邮箱'
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
            if(res.result){
                alert(res.message);
                location.href="/user/list";
            }else{
                alert(res.message);
            }
        });
    });
}


/**
 * 补充推荐人
 */
function showRecommend(userId){
    var template = Handlebars.compile( $("#recommend-template").html());
    //默认数据
    var context = {referralUserMobile:"",userId:userId};
    var html='';
//    $.ajax({url:url,data:{},type:"post",dataType:'json',success:function(data){
//        context = {
//        		referralUserMobile: data.referralUserMobile,
//        };
//        showdailog(context);
//        validateRecommend();
//    }})
    showdailog(context);
    validateRecommend();
    function showdailog(context){
        html    = template(context); 
        bootbox.dialog({
            message: html,
            title: "推荐人手机号",
            className: "modal-darkorange"
        });
    	$("#referralUserMobile").bind('focus',function(){
    		//alert('sssss');
    		$("#recommendUserMobileMessage").html('');
    	})
    }
}

function validateRecommend(){
    $("#recommendForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            
        	referralUserMobile: {
                validators: {
                    notEmpty: {
                        message: '请输入推荐人手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
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
        $.post($form.attr('action'), $form.serialize(), function(data) {
            var res= jQuery.parseJSON(data);
            console.log(res);
            
            if(res.success=='0'){
            	$("#recommendUserMobileMessage").html(res.comment);
            }else{
            	alert('保存成功！');
            	location.href="/user/list";
            }
        });
    });
}


