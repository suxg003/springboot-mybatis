/**
 * Created by apple on 15/7/14.
 */
$('#date-range-picker').daterangepicker({
    format: 'YYYY-MM-DD',
    opens: 'left',
    ranges: {
        '昨天': [moment().subtract('days', 1), moment().subtract('days', 1)],
        '过去一周': [moment().subtract('days', 6), moment()],
        '过去30天': [moment().subtract('days', 29), moment()],
        '本月': [moment().startOf('month'), moment().endOf('month')],
        '上个月': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
    },
    startDate: moment(),
    endDate: moment(),
    locale: {
        applyLabel: '确定',
        clearLabel: "取消",
        fromLabel: '开始时间',
        toLabel: '结束时间',
        weekLabel: '周',
        customRangeLabel: '选择范围',
        daysOfWeek: "日_一_二_三_四_五_六".split("_"),
        monthNames: "一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月".split("_"),
        firstDay: 0
    }
}, function (start, end) {
    console.log(moment().subtract('days', 6));
    /*$('input[name=startDate]').val(start.format("YYYY-MM-DD"));
     $('input[name=endDate]').val(end.format("YYYY-MM-DD"));*/
    //$(this).val(start.format("YYYY-MM-DD")+' - '+end.format("YYYY-MM-DD"));
});
$('#date-range-picker').val(moment().subtract('days', 29).format("YYYY-MM-DD")+' - '+moment().format("YYYY-MM-DD"));
function showINvestRecordsTable(type){
    var $dateRange = $('input[name=date-range-picker]');
    var type = type;
    $('#investRecordsTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "aoColumns": [
            {"mData": "loginName"},//0
            {"mData": "userName"},//1
            {"mData": "productName"},//2
            {"mData": "productType"},//3
            {"mData": "amount"},//4
            {"mData": "submitTime"},//5
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets": [0],
            "mRender": function (data, type, row) {
                var uid = row.userId;
                return '<a href="/user/profile/?userId=' + uid + '">' + data + '</a>';
            }
        },{
            "aTargets": [5],
            "mRender": function (data, type, row) {
                return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        },{
            "aTargets": [4],
            "mRender": function (data) {
                return "￥"+data;
            }
        },{
            "bSortable": false,
            "aTargets": [1],
            "mRender": function (data, type, row) {
                return data;
            }
        },{
            "bSortable": false,
            "aTargets": [2]
        },{
            "bSortable": false,
            "aTargets": [3],
            "mRender": function (data, type, row) {
                if(data=='UPLAN'){
                   return "优选项目";
                }
                if(data == 'BBT') {
                    return "直投项目";
                }
            }
        }
        ],
        "sAjaxSource": "/fund/invest/records",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {

            aoData.push({
                "name": "startDate",
                "value": $dateRange.val().split(' - ')[0]
            });
            aoData.push({
                "name": "endDate",
                "value": $dateRange.val().split(' - ')[1]
            });
            aoData.push({
                "name": "type",
                "value": type
            });
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
}

showINvestRecordsTable();
var investBtn = $('.investBtnGroup a');

investBtn.on('click',function(){
    investBtn.removeClass('btn-sky');
    $(this).addClass('btn-sky');
    var type = $(this).attr('data-id');
    showINvestRecordsTable(type);
});
$('#searchRechargeHistory').on('click',function(){
    var type = $(this).attr('data-id');
    showINvestRecordsTable(type);
});

$('#downloadinvest').on('click',function (){

    var $dateRange=$('#date-range-picker').val();
    var type = $('.investBtnGroup .btn-sky').attr('data-id');
    var searchStr = $('#investRecordsTable_filter input').val();
    var href = '/fund/invest/down?startDate=' + $dateRange.split(' - ')[0]+'&endDate='+$dateRange.split(' - ')[1]+'&type='+type+'&sSearch='+searchStr;
    location.replace(href);
});

