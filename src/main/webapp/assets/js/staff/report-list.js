/**
 * Created by fsg on 2016/6/23.
 */
$('#LOANS_LIST').dataTable({
    "sDom": "flt<'row'<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "aDataSort":false,
    "iDisplayLength": 10,
    //"aaSorting":[[6,"desc"]],
    "aoColumns": [
        {"mData": "investorLoginName"},//0
        {"mData": "investorUserName"},//1
        {"mData": "investorIdNumber"},//2
        {"mData": "investDate"},//3
        {"mData": "dueDate"},//4
        {"mData": "productType"},//5
        {"mData": "timeLimit"},//6
        {"mData": "investAmount"},//7
        {"mData": "standardPerformance"},//8
        {"mData": "maintainStaffName"},//9
        {"mData": "maintainStaffId"},//10
        {"mData": "maintainBranchOffice"}//11
    ],
    "aoColumnDefs": [{
        //"bSortable": false,
        "aTargets": [0],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    }, {
        "aTargets": [1],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [2],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [3],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return data;
            }else{
                return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [4],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return data;
            }else{
                return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [5],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [6],
        "mRender": function (data, type, row) {
            if(data == ''||data ==null){
                return data;
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [7],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
      },{
        //"bSortable": false,
        "aTargets": [8],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [9],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [10],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    },{
        //"bSortable": false,
        "aTargets": [11],
        "mRender": function (data, type, row) {
            if(data == ''||data == null){
                return '';
            }else{
                return data;
            }
        }
    }
    ],
    "sAjaxSource": "/nmd/report/list/getData",
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
//批量更新诺曼底员工信息
function uploadStaffInfo() {
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
            url: '/nmdStaff/nmdImportStaff',
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
/**
 * 编辑新建 员工信息
 * @param ele 编辑时触发的元素，为了的到empId
 */
function showSingleStaff(ele){
    var source   = $("#singleStaff-template").html();
    var template = Handlebars.compile(source);
    //默认数据
    var context = {staffId: "", staffName:"",id:"",branchOffice:"",department:"",position:"",inductionTime:"",quitTime:""};
    var html='';
    if(ele){
        alert("编辑");
        ////编辑员工信息
        //var empId=$(ele).attr("data-empid");
        //$.ajax({url:'/employee/edit',data:"id="+empId,type:"get",dataType:'json',success:function(data){
        //    context = {loginName: data.loginName, userName:data.userName,idNumber:data.idNumber,userMobile:data.userMobile,enabled:data.enabled,empId:data.empId,empCode:data.empCode};
        //    html= template(context);
        //    bootbox.dialog({
        //        message: html,
        //        title: "员工记录",
        //        className: "modal-darkorange"
        //    });
        //    $('input[name=loginName]').attr('readonly','readonly');
        //    $('input[name=empId]').attr('readonly','true');
        //    validateEditEmployee();
        //}})
    }else{
        html    = template(context);
        bootbox.dialog({
            message: html,
            title: "员工信息",
            className: "modal-darkorange"
        });
        $('.date-picker').datepicker({
            'language': 'cn',
            startDate: new Date(moment),
            endDate: new Date(moment)
        });
        validateStaff();
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
Handlebars.registerHelper('formatdata', function(data, options){
    if (data == '') {
        return '';
    }
    return new Date(data).Format("yyyy-MM-dd");
});
/*$("#staffForm").bootstrapValidator();*/
function validateStaff(){
    $("#staffForm").bootstrapValidator({
        message: 'This value is not valid',
        fields: {
            staffId: {
                validators: {
                    notEmpty: {
                        message: '请输入员工编号'
                    },
                    stringLength: {
                        min: 6,
                        max: 6,
                        message: '请输入6位员工编号'
                    }
                }
            },
            staffName: {
                validators: {
                    notEmpty: {
                        message: '请输入员工姓名'
                    }
                }
            },
            id: {
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
            branchOffice: {
                validators: {
                    notEmpty: {
                        message: '请输入分公司'
                    }
                }
            },
            department: {
                validators: {
                    notEmpty: {
                        message: '请输入部门'
                    }
                }
            },
            position: {
                validators: {
                    notEmpty: {
                        message: '请输入职位'
                    }
                }
            },
            inductionTime: {
                validators: {
                    notEmpty: {
                        message: '请输入入职日期'
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
            if(res.result){
                alert(res.message);
                location.href="/nmdStaff/nmdStaffList";
            }else{
                alert(res.message);
            }
        });
    });
}
/**导出员工信息列表*/

$("#downstafflist").on('click',function(){
    location.replace('/nmdStaff/staffExport');
});