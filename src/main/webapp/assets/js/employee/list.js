/**
 * Created by meng on 2015/6/23.
 */
var oTable = $('#LOANS_LIST').dataTable({
    "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
    "iDisplayLength": 10,
    "bSort": false,
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

/**
 * 编辑新建 员工信息
 * @param ele 编辑时触发的元素，为了的到empId
 */
function showSingleEmployee(ele){
    var source   = $("#singleEmployee-template").html();
    var template = Handlebars.compile(source);
    //默认数据
    var context = {loginName: "", userName:'',idNumber:"",userMobile:"",enabled:"",empId:""};
    var html='';
    if(ele){
        //编辑员工信息
        var empId=$(ele).attr("data-empid");
        $.ajax({url:'/employee/edit',data:"id="+empId,type:"get",dataType:'json',success:function(data){
            context = {loginName: data.loginName, userName:data.userName,idNumber:data.idNumber,userMobile:data.userMobile,enabled:data.enabled,empId:data.empId,empCode:data.empCode};
            html= template(context);
            bootbox.dialog({
                message: html,
                title: "员工记录",
                className: "modal-darkorange"
            });
            $('input[name=loginName]').attr('readonly','readonly');
            $('input[name=empId]').attr('readonly','true');
            validateEditEmployee();
        }})
    }else{
        html    = template(context);
        bootbox.dialog({
            message: html,
            title: "员工记录",
            className: "modal-darkorange"
        });
        validateEmployee();
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
function validateEditEmployee(){
    $("#employeeForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            loginName: {
                validators: {
                    notEmpty: {
                        message: '请输入员工登录名'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '登录名最少3位字母/数字'
                    }
                }
            },
            name: {
                validators: {
                    notEmpty: {
                        message: '请输入员工姓名'
                    }
                }
            },
            idNumber: {
                validators: {
                    notEmpty: {
                        message: '请输入员工身份证号'
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
                        message: '请输入员工手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
                    }
                }
            },
            empCode: {
                validators: {
                    notEmpty: {
                        message: '请输入员工唯一号'
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
                location.href="/employee/list";
            }else{
                alert(res.message);
            }
        });
    });
}
function validateEmployee(){
    $("#employeeForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            loginName: {
                validators: {
                    notEmpty: {
                        message: '请输入员工登录名'
                    },
                    stringLength: {
                        min: 3,
                        max: 30,
                        message: '登录名最少3位字母/数字'
                    },
                    remote: {
                        url: '/employee/check',
                        type: 'POST',
                        delay: 2000,
                        message:'员工登录 名不能重复'
                    }
                }
            },
            name: {
                validators: {
                    notEmpty: {
                        message: '请输入员工姓名'
                    }
                }
            },
            idNumber: {
                validators: {
                    notEmpty: {
                        message: '请输入员工身份证号'
                    },
                    regexp: {
                        regexp: /[1-9][0-9]{16}[0-9xX]/,
                        message: '身份证号码格式不正确'
                    },
                    remote: {
                        url: '/employee/check',
                        type: 'POST',
                        delay: 2000,
                        message:'身份证号码不能重复'
                    }
                }
            },
            userMobile: {
                validators: {
                    notEmpty: {
                        message: '请输入员工手机号'
                    },
                    regexp: {
                        regexp: /1\d{10}/,
                        message: '请输入有效的11位数字手机号码'
                    },
                    remote: {
                        url: '/employee/check',
                        type: 'POST',
                        delay: 2000,
                        message:'员工手机号不能重复'
                    }
                }
            },
            empCode: {
                validators: {
                    notEmpty: {
                        message: '请输入员工唯一号'
                    },
                    remote: {
                        url: '/employee/check',
                        type: 'POST',
                        delay: 2000,
                        message:'员工唯一号不能重复'
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
                location.href="/employee/list";
            }else{
                alert(res.message);
            }
        });
    });
}

