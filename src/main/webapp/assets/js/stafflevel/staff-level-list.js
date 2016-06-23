/**
 * Created by meng on 2015/6/23.
 */
//var oTable = $('#LOANS_LIST').dataTable({
//    "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
//    "iDisplayLength": 10,
//    "bSort": false,
//    "oLanguage": {
//        "sLengthMenu": "_MENU_",
//        "sSearch": "",
//        "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
//        "sInfoEmpty": "没有符合条件的记录",
//        "sZeroRecords": "没有符合条件的记录",
//        "oPaginate": {
//			"sFirst": "首页",
//			"sPrevious": "前一页",
//			"sNext": "后一页",
//			"sLast": "尾页"
//		}
//    }
//});
$('#LOANS_LIST').dataTable({
    "sDom": "flt<'row'<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "aDataSort":false,
    "iDisplayLength": 10,
    //"aaSorting":[[6,"desc"]],
    "aoColumns": [
        {"mData": "staffId"},//0
        {"mData": "staffName"},//1
        {"mData": "branchOffice"},//2
        {"mData": "department"},//3
        {"mData": "position"},//4
        {"mData": "immediateSuperior"},//5
        {"mData": "teamManagerCode"},//6
        {"mData": "teamManagerName"},//7
        {"mData": "businessOfficesCode"},//8
        {"mData": "businessOfficesName"},//9
        {"mData": "storeManagerCode"},//10
        {"mData": "storeManagerName"},//11
        {"mData": "cityManagerCode"},//12
        {"mData": "cityManagerName"}//13
    ],
    "aoColumnDefs": [{
        //"bSortable": false,
        "aTargets": [0],
        "mRender": function (data, type, row) {
            return data;
        }
    }, {
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
    },{
        //"bSortable": false,
        "aTargets": [5],
        "mRender": function (data, type, row) {
            return data;
        }
    },{
        //"bSortable": false,
        "aTargets": [6],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }

        }
    },{
        //"bSortable": false,
        "aTargets": [7],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [8],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [9],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [10],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [11],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [12],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [13],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return '';
            }else{
                return data;
            }
        }
    }
    ],
    "sAjaxSource": "/nmdStaffLevels/list/getData",
    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

        for (var i = 0; i < aoData.length; i++) {
            if (aoData[i]['name'] == 'iSortCol_0') {
                var cols = this.fnSettings().aoColumns;
                var index = parseInt(aoData[i]['value']);
                aoData.push({"name": "sColName", "value": cols[index]['mData']});
                //break;
            }
            //if(aoData[i]['name'] == 'sSearch') {
            //    if (aoData[i]['value']) {
            //        $('#link_download').attr('href', '/user/download?sSearch=' + aoData[i]['value']);
            //    }
            //    else {
            //        $('#link_download').attr('href', '/user/download');
            //    }
            //}
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
/**
 * 编辑新建 员工信息
 * @param ele 编辑时触发的元素，为了的到empId
 */
function showSingleStaffLevel(ele){
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
//批量更新诺曼底员工信息
function uploadStaffLevelsInfo() {
    $('#uploadLocalModal').modal('show');
    aceInput = $('#uploadFileInput').ace_file_input({
        style: 'well',
        btn_choose: '拖动文件到此处或点击上传（支持批量上传）',
        btn_change: null,
        no_icon: 'fa fa-upload',
        droppable: true,
        thumbnail: 'small',
        icon_remove: null,
        whitelist: 'csv|xls|xlsx',
        backlist: 'exe|php',
        preview_error: function (filename, error_code) {
        }
    }).on('change', function () {
        $('#saveFileBtn').prop('disabled', false);
    });
}
$('#saveFileBtn').on('click', function () {
    var files = document.getElementById("uploadFileInput");
    var files = aceInput.data('ace_input_files');
    if (files == undefined) {
        alert('请上传文件！');
        return false;
    }
    var files_length = files.length;
    var count = 0;
    var files_length = files.length;
    var count = 0;
    $.each(files, function (index, file) {
        var formData = new FormData();
        formData.append("file", file);
        //formData.append("imageName", file.name);
        //console.log(formData)
        $.ajax({
            url: '/nmdStaffLevels/nmdImportStaffLevels',
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
                var data = eval('('+data+')');

                console.log("result===" + data);

                $('.btn-reset').click();
                if (data.success == 0) {
                    bootbox.dialog({
                        message: data.comment,
                        title: "提示信息",
                        className: ""
                    });
                    //showCCAlert(data.comment, false);
                } else {
                    bootbox.dialog({
                        message: data.comment,
                        title: "提示信息",
                        className: "",
                        buttons: {
                            success: {
                                label: "确定",
                                callback: function() {
                                    location.reload();
                                }
                            }
                        }
                    });
                }
            }
        }).fail(function () {
            $('.btn-reset').click();
            bootbox.dialog({
                message: "导入数据失败，请检查是否符合规范！",
                title: "提示信息",
                className: ""
            });

        });
    });
});
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

/**导出员工层级信息列表*/

$("#downstafflevellist").on('click',function(){
    location.replace('/nmdStaff/staffExport');
});
