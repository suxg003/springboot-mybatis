/**
 * Created by meng on 2015/6/23.
 */

$('#customerList').dataTable({
    "sDom": "flt<'row'<'col-sm-6'i><'col-sm-6'p>>",
    "bProcessing": false,
    "bServerSide": true,
    "aDataSort":false,
    "iDisplayLength": 10,
    //"aaSorting":[[6,"desc"]],
    "aoColumns": [
        {"mData": "chienesName"},//0
        {"mData": "iddenticationNum"},//1
        {"mData": "mobilePhone"},//2
        {"mData": "customerNum"},//3
        {"mData": "managementTeamUserid"},//4
        {"mData": "managementCustomerUserid"}//5
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
    }
    ],
    "sAjaxSource": "/nmdLendCustomer/list/getData",
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
