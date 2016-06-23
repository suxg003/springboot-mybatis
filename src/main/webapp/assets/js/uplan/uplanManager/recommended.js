function deleteRecommendMS(loanId){
    if(!confirm("确定要取消吗？")){
        return;
    }
    $.ajax({
        url:'/uplanLoan/deleteRecommendMS/'+loanId,
        type: 'POST',
        error: function(request) {
            alert("Connection error");
            location.reload();
        },
        success: function (data) {
            location.reload();
        }
    });
}
function createRecommendMS(loanId){
    if(!confirm("确定要设置为推荐标吗？")){
        return;
    }
    $.ajax({
        url:'/uplanLoan/createRecommendMS/'+loanId,
        type: 'POST',
        error: function(request) {
            alert("Connection error");
            location.reload();
        },
        success: function (data) {
            location.reload();
        }
    });
}
function getList(){
    var th='';
    th+='<tr>\
            <th>产品名称</th>\
            <th>借款金额</th>\
            <th>预期年利率</th>\
            <th>还款方式</th>\
            <th>还款时间</th>\
            <th>推荐类型</th>\
            <th>操作</th>';
    th+='</tr>';
    $('#list_th').html(th);
        var oTable = $('#LOANS_LIST').dataTable({
            "sDom": "flt<'row DTTTFooter'<'col-sm-6'i><'col-sm-6'p>>",
            "iDisplayLength": 10,
            "bProcessing": true,
            "bServerSide": true,
            "bSort": false,
            "bFilter": true,
            "bPaginate": true,
            "aoColumns": [
                {"mData": "requestTitle"},
                {"mData": "loanAmount"},
                {"mData": "rate"},
                {"mData": "repaymentType"},
                {"mData": "repaymentDate"},
                {"mData": "type"},
                {"mData": "options"}
            ],
            "aoColumnDefs": [{
                "aTargets": [1],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                }
            },
            {
                "aTargets": [4], //uid link
                "mRender": function (data, type, row) {
                    if(undefined!=data){
                        return (new Date(data)).Format("yyyy-M-d h:m")
                    }else {
                        return '-'
                    }
                }
            },{
                "aTargets": [5], //uid link
                "mRender": function (data, type, row) {
                    var s= data;
                    if($("#msId").val()!=""&&$("#msId").val()==row.loanId){
                        s +="推荐标";
                    }
                    return s;
                }
            },
            {
                "aTargets": [6], //uid link
                "mRender": function (data, type, row) {
                    if(row.type!=undefined){
                        var s="";
                        if($("#msId").val()!=""&&$("#msId").val()==row.loanId){
                            s +="<a class='btn btn-small btn-danger btn-recommend' onclick='deleteRecommendMS(&quot;"+row.loanId+"&quot;)'> <i class='fa fa-minus'></i>取消推荐</a>";
                        }else if($("#msId").val()!=""&&$("#msId").val()!=row.loanId){
                            s +="<a class='btn btn-small btn-gray btn-recommend'>只能推荐一个</a>";
                        }
                        if($("#msId").val()==""){
                            s += "<a class='btn btn-small btn-success btn-recommend' onclick='createRecommendMS(&quot;"+row.loanId+"&quot;)'> <i class='fa fa-plus'></i> 推荐M站首页 </a>";
                        }
                        
                    }
                    
                    return s;
                }
            }
            ],
            "fnDrawCallback": function (oSettings) {
                $("#searchRechargeHistory").html('查询');
                $("#searchRechargeHistory").prop('disabled', false);
            },
            "sAjaxSource": "/uplanLoan/getRecommendeds",
            "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
                aoData.push({});
                oSettings.jqXHR = $.ajax({
                    "dataType": 'json',
                    "type": "GET",
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

        //Check All Functionality
        jQuery('#simpledatatable .group-checkable').change(function () {
            var set = $(".checkboxes");
            var checked = jQuery(this).is(":checked");
            jQuery(set).each(function () {
                if (checked) {
                    $(this).prop("checked", true);
                    $(this).parents('tr').addClass("active");
                } else {
                    $(this).prop("checked", false);
                    $(this).parents('tr').removeClass("active");
                }
            });

        });
        jQuery('#simpledatatable tbody tr .checkboxes').change(function () {
            $(this).parents('tr').toggleClass("active");
        });
}

getList();