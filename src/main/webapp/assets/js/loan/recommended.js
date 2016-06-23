function deleteRecommend(recid){
    if(!confirm("确定要取消吗？")){
        return;
    }
    $.ajax({
        url:'/loan/deleteRecommend/'+recid,
        data:recid,
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
function deleteRecommendMS(loanId){
    if(!confirm("确定要取消吗？")){
        return;
    }
    $.ajax({
        url:'/loan/deleteRecommendMS/'+loanId,
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
        url:'/loan/createRecommendMS/'+loanId,
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
            <th>借款人</th>\
            <th>借款金额</th>\
            <th>年利率</th>\
            <th>期限</th>\
            <th>还款方式</th>\
            <th>抵押品</th>\
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
                {"mData": "loanName"},
                {"mData": "loanAmount"},
                {"mData": "rate"},
                {"mData": "duration"},
                {"mData": "repayMethod"},
                {"mData": "mortgaged"},
                {"mData": "type"},
                {"mData": "options"}
            ],
            "aoColumnDefs": [{
                "aTargets": [2],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">￥' + formatAmount(data) + '</span>';
                }
            }, {
                "aTargets": [7], //uid link
                "mRender": function (data, type, row) {
                    var s= data;
                    if($("#msId").val()!=""&&$("#msId").val()==row.loanId){
                        s +="(M站推荐)";
                    }
                    return s;
                }
            },
            {
                "aTargets": [8], //uid link
                "mRender": function (data, type, row) {
                    if(row.type!=undefined){
                        var s="";
                        if('WEB'==row.source&&row.enable ==true&&($("#LOAN_DELETE_RECOMMEND").val()!=undefined)){
                            s += "<a class='btn btn-small btn-danger btn-recommend' onclick='deleteRecommend(&quot;"+row.recId+"&quot;)'> <i class='fa fa-minus'></i>取消推荐</a>";
                        }
                        if(row.enable ==false){
                        	if($("#LOAN_CREATE_RECOMMEND").val()!=undefined){
                                s += "<a class='btn btn-small btn-success btn-recommend' onclick='showUploadImg(&quot;"+row.loanId+"&quot;,&quot;"+row.requestTitle+"&quot;)'> <i class='fa fa-plus'></i> 推荐首页 </a>";
                            }
                        }
                        s +="&nbsp;";
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
            "sAjaxSource": "/loan/getRecommendeds",
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


function showUploadImg(loanID,title){

    /**
     推荐弹出层
     */
    bootbox.dialog({
        message: $("#myModal").html().replace("m_loan_title_value",title).replace("m_loan_id_value",loanID),
        title: "推荐标详情",
        className: "modal-darkorange",

    });

    $("#recommendConfirm").on("click",function(){
            $.ajax({
                url:'/loan/createRecommend',
                data:{loanId:$("#m_loan_id").val(),url:$("#m_loan_url").val(),rectype:$("#m_loan_type").val()},
                type: 'POST',
                error: function(request) {
                    alert("Connection error");
                    location.reload();
                },
                success: function (data) {
                    location.reload();
                }
            });
    });

    /**
     * 上传图片
     * @param {type} event
     * @returns {undefined}
     */

    $('#uploadImageBtn').on('click',function(){
        $('.imageFileInput').click();
    });
    var files = null;
    $('#imageFileInput').change(function (event) {
        //$('#imageFileInput').val()
        files = event.target.files;
        $('#uploadImageBtn').html('<i class="icon-spinner icon-spin"></i> 上传中..');
        $('form[name=uploadImageForm]').trigger('submit');
    });

    $('form[name=uploadImageForm]').on('submit', uploadImage);


    function uploadImage(event) {
        event.stopPropagation();
        event.preventDefault();
        var data = new FormData();
        $.each(files, function (index, file) {
            data.append("file", file);
            data.append("name", file.name);
            data.append("ownerId", $("#m_loan_id").val());
        });
        $.ajax({
            url: '/loan/uploadFile',
            data: data,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (data) {
                var obj = jQuery.parseJSON(data);
                $('.ace-thumbnails').html("<li><img src='"+obj.url+"'></li>");
                $('#m_loan_url').val(obj.url);
                $('#uploadImageBtn').html('<i class="icon-plus-sign"></i> 上传图片');
            }
        }).fail(function () {
            alert('上传图片失败：网络错误');
        });
    }


}

getList();