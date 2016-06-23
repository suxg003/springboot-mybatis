
/**
 * Created by lxl on 15/6/25.
 */
$('#loanTabs li').eq(location.search.slice(1)).addClass('active');

var oTable = $('#LOANS_LIST').dataTable({
    "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
    "iDisplayLength": 10,
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
function getList(iData){alert(iData);}
//$('#loanTabs li').click(function(){
//    var sIndex=$(this).index();
//    var href='loan/loanList?'+sIndex;
//    location.replace(href);
//})

