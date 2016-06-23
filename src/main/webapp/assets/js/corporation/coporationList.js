/**
 * Created by meng on 2015/7/5.
 */


$('#userList').dataTable({
    "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "iDisplayLength": 10,
    "aoColumns": [
        {"mData": "shortName"},
        {"mData": "loginName"},
        {"mData": "userName"},
        {"mData": "id"},
        {"mData": "name"},
        {"mData": "category"},
        {"mData": "type"},
        {"mData": "orgCode"},
        {"mData": "busiCode"},
        {"mData": "taxCode"},
        {"mData": "lastLoginDate"},
        {"mData": "registerDate"},
        {"mData": "id"}
    ],
    "aoColumnDefs": [{
        "aTargets": [0], //uid link
        'bSortable': false,
        "mRender": function(data, type, row) {
            return '<a href="corporation/' + row['id'] + '">' + data + '</a>';
        }
    },
        {
            "aTargets": [1], //uid link
            'bSortable': false
        },
        {
            "aTargets": [2], //uid link
            'bSortable': false,
            "mRender": function(data, type, row) {
                if(data){
                    return '<a href="user/profile/' + row['id'] + '">' + data + '</a>';
                }else{
                    return "";
                }
            }
        },
        {
            "aTargets": [3], //legal person link
            'bSortable': false,
            "mRender": function(data, type, row) {
                var id = 'lp' + row['id'];
                $.get("corporation/getLegalPerson/" + row['id'], function(user) {
                    if (user != null) {
                        $('#' + id).attr('href', 'user/' + user.id).text(user.loginName);
                    }
                });
                return '<a id="' + id + '"href="javascript:;" target="_blank"></a>';
            }
        },
        {
            "aTargets": [6],
            'bSortable': false,
            "mRender": function(data, type, row) {
                return types[data];
            }
        },
        {
            "aTargets": [12],
            'bSortable': false,
            "mRender": function(data, type, row) {
                var html = operationHTML
                    .replace(new RegExp("corporation.id", "gm"), row['id'])
                    .replace(/corporation.name/g, row['name']);
                if (!row['user']['enabled']) {
                    html = html.replace('disable', 'enable').replace('btn-danger', 'btn-success').replace(/禁用/g,'启用').replace('icon-ban-circle', 'icon-ok');
                }
                return html;
            }
        },
        {
            "aTargets": [10],
            'bSortable': false,
            "mRender": function(data, type, row) {
                return formatTime(parseInt(data));
            }
        },
        {
            "aTargets": [11],
            'bSortable': false,
            "mRender": function(data, type, row) {
                return formatTime(parseInt(data));
            }
        }],
    "sAjaxSource": "/corporation/list/getData",
    "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

        for (var i = 0; i < aoData.length; i++) {
            if (aoData[i]['name'] == 'iSortCol_0') {
                var cols = this.fnSettings().aoColumns;
                var index = parseInt(aoData[i]['value']);
                aoData.push({"name": "sColName", "value": cols[index]['mData']});
                //break;
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


/**
 * 编辑新建 员工信息
 * @param ele 编辑时触发的元素，为了的到empId
 */
function showSingleUser(ele,url){
    var template = Handlebars.compile( $("#singleUser-template").html());
    //默认数据
    var context = {loginName: "", name:'',idNumber:"",mobile:"",employeeId:""};
    var html='';
    if(ele==true){
        //编辑员工信息
        $.ajax({url:url,data:{},type:"get",dataType:'json',success:function(data){
            context = {loginName: data.loginName, name:data.name,idNumber:data.idNumber,mobile:data.mobile,employeeId:data.empId};
            showdailog(context);
        }})
    }else{
        showdailog(context)
    }
    function showdailog(context){
        html    = template(context);
        bootbox.dialog({
            message: html,
            title: "用户记录",
            className: "modal-darkorange"
        });
        validateUser();
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
                        delay: 2000
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
            mobile: {
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
            employeeId: {
                validators: {
                    notEmpty: {
                        message: '请输入员工唯一号'
                    },
                    remote: {
                        url: '/employee/check',
                        type: 'POST',
                        delay: 2000
                    }
                }
            }
        }
    });
}