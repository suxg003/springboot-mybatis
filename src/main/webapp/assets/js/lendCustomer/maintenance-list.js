/**
 * Created by fsg on 2016/3/29.
 */

$('#userMaintenanceListList').dataTable({
    "sDom": "flt<'row'<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "aDataSort":false,
    "iDisplayLength": 10,
    //"aaSorting":[[6,"desc"]],
    "aoColumns": [
        //{"mData": "userId"},//0
        {"mData": "idNumber"},//1
        //{"mData": "empId"},//2
        {"mData": "userMobile"},//3
        {"mData": "userName"},//4
        //{"mData": "referralId"},//5
        {"mData": "referralIdNumber"},//6
        {"mData": "referralEmpId"},//7
        {"mData": "maintenanceIdNumber"},//8
        {"mData": "maintenanceEmpId"}//9
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
            return data;
        }
    }
    ],
    "sAjaxSource": "/coreUserMaintenance/list/getData",
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
            url: '/coreUserMaintenance/ImportCoreUserMaintenance',
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