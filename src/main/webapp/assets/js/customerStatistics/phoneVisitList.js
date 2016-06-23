
/**
 * Created by meng on 2015/7/13.
 */

$('#reservation').daterangepicker({
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
    $(this).val(start.format("YYYY-MM-DD")+' - '+end.format("YYYY-MM-DD"));
});
$('#reservation').val((moment().subtract('days', 6)).format("YYYY-MM-DD")+' - '+(moment()).format("YYYY-MM-DD"));

function getList(){
    var th='',$callStatus=$('#callStatus'),$dateRange=$('#reservation');
   /* th+='<tr>\
            <th><i class="icon-tag"></i>登录名</th>\
            <th><i class="hidden-480"></i>姓名</th>\
            <th class="hidden-480">手机号码</th>\
            <th>\
                <i class="icon-money"></i> 注册时间\
            </th>\
            <th class="hidden-480">投资次数</th>\
            <th class="">投资总额</th>\
            <th class="hidden-480">\
                <i class="icon-calendar hidden-480"></i> 来源\
            </th>\
			<th><i class="icon-time"></i> 操作</th></tr>';
    $('#list_th').html(th);*/

    $('#USERCALLED_LIST').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "iDisplayLength": 10,        
        "bDestroy": true,
        "retrieve": false,
        "bSearchable": false,
        "aoColumns": [
            {"mData": "loginName"},
            {"mData": "userName"},
            {"mData": "userMobile"},
            {"mData": "registerTime"},
            {"mData": "investCount"},
            {"mData": "investAmount"},
            {"mData": "registerSourceType"},
            {"mData": "called"}
        ],
        "aoColumnDefs": [
            {
                "aTargets": [0], //uid link
                "mRender": function (data, type, row) {
                    var uid = row.userId;
                    return '<a href="/user/profile/?userId='+ uid +'">' + data + '</a>';
                }
            },
            {
                "aTargets": [1], //uid link
                "mRender": function (data, type, row) {
                    var uid = row.userId;
                    return  data ;
                }
            },{
                "aTargets": [5], //uid link
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥ '+formatAmount(data,0)+'</span>'
                }
            },{
                "aTargets": [3], //uid link
                "mRender": function (data, type, row) {
                    return (new Date(data)).Format("yyyy-M-d h:m")
                }
            }
            ,{
                "aTargets": [7], //uid link
                "mRender": function (data, type, row) {
                    if(data=='0'){
                        return '<i class="icon-ok-sign green bigger-120"></i>回访'
                    }else{

                    }

                }
            }
        ],
        "fnDrawCallback": function (oSettings) {
            $("#userCalled").html('查询');
            $("#userCalled").prop('disabled', false);
        },
        "sAjaxSource": "/customerStatistics/selectUserCalled",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            aoData.push({
                "name": "called",
                "value": $callStatus.val()
            });
            aoData.push({
                "name": "from",
                "value": $dateRange.val().split(' - ')[0]
            });
            aoData.push({
                "name": "to",
                "value": $dateRange.val().split(' - ')[1]
            });
            oSettings.jqXHR = $.ajax({
                "dataType": 'json',
                "type": "POST",
                "url": sSource,
                "data": aoData,
                "success": fnCallback,
                "error": function () {
                    console.log('error');
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
function filterGlobal() {
    $('#USERCALLED_LIST').DataTable().search(
        $('#global_filter').val(),
        $('#global_regex').prop('checked'),
        $('#global_smart').prop('checked')
    ).draw();
}

getList();

$('#userCalled').click(getList);

$("#downloadLoan").on('click',function(){
	var $callStatus=$('#callStatus'),$dateRange=$('#reservation');
    var searchData=$('#USERCALLED_LIST_filter input').val();
    location.replace('/customerStatistics/download/?called='+$callStatus.val()+'&from='+$dateRange.val().split(' - ')[0]+'&to='+$dateRange.val().split(' - ')[1]+'&sSearch='+searchData)

});
