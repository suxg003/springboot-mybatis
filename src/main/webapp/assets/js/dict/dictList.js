/**
 * Created by lxl on 15/7/9.
 */
$(function () {

    var oTable = $('#commonDataTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "iDisplayLength": 10,
        "aoColumns": [
            {"mData": "id"}, //0
            {"mData": "value"}, //1
            {"mData": "label"},//2
            {"mData": "type"},//3
            {"mData": "description"}, //4
            {"mData": "sort"},//5
            {"mData": "parentId"},//6
            {"mData": "remarks"},//7
            {"mData": "createDate"},//8
            {"mData": "delFlag"},//9
            {"mData": "delFlag"}//10
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets":[0]
        },{
            "bSortable": false,
            "aTargets":[1]
        },{
            "bSortable": false,
            "aTargets":[2]
        },{
            "bSortable": false,
            "aTargets": [3] //来源
        },{
            "bSortable": false,
            "aTargets": [4]
        }, {
            "bSortable": false,
            "aTargets": [8],
            "mRender": function (data, type, row) {
                if(!data){
                    return "";
                }
                return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
            }
        },{
            "bSortable": false,
            "aTargets": [7]
        },{
            "bSortable": false,
            "aTargets":[5]
        },{
            "bSortable": false,
            "aTargets":[9],
            "mRender": function (data, type, row) {
                //if(!data){
                //    return "1";
                //}
                if(data==false){
                    return "启用中";
                }else{
                    return "已禁用";
                }
            }
        },{
            "bSortable": false,
            "aTargets":[10],
            "mRender": function (data, type, row) {
                var e= "<a class='btn btn-info btn-xs edit' title='编辑' onclick='showSingleDict(this)' data-dictId='"+row.id+"'><i class='fa fa-edit'></i></a>";
                if(data==false){
                    return e+"<a class='btn btn-danger btn-xs ban' title='禁用' onclick='showConfirm(&quot;确定要禁用么？&quot;,&quot;/dict/disable/"+row.id+"&quot;)'><i class='fa fa-ban'></i></a>";
                }else{
                    return e+"<a class='btn btn-success  btn-xs ok' title='启用' onclick='showConfirm(&quot;确定要启用用户？&quot;,&quot;/dict/enable/"+row.id+"&quot;)'><i class='fa fa-check'></i></a>";
                }
            }
        }],
        "fnDrawCallback": function (oSettings) {
            $("#searchRechargeHistory").html('查询');
            $("#searchRechargeHistory").prop('disabled', false);
        },
        "sAjaxSource": "/dict/query",
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
            aoData.push({
                "name": "sValue",
                "value": $('#sValue').val()
            });
            aoData.push({
                "name": "sLabel",
                "value": $('#sLabel').val()
            });
            aoData.push({
                "name": "sType",
                "value": $('#sType').val()
            });
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

    addCondition();

    $("#aAccess").click(function () {
        return false;
    }).keyup(function () {
    });

    $('#searchRechargeHistory').click(function () {
        $("#searchRechargeHistory").html('<i class="icon-spin icon-spinner"></i> 查询中');
        $("#searchRechargeHistory").prop('disabled', true);
        oTable.fnPageChange('first');
    });
    $('#clearBtn').click(function () {
        $('#sValue').val("");
        $('#sLabel').val("");
        $('#sType').val("");
        oTable.fnPageChange('first');
    });
});
function addCondition(){
    var sValue = "<label><input type='text' class='form-control input-sm' id='sValue' placeholder='请输入数据值'></label>";
    var sLabel = "<label><input type='text' class='form-control input-sm' id='sLabel' placeholder='请输入标签名'></label>";
    var sType = "<label><input type='text' class='form-control input-sm' id='sType' placeholder='请输入类型'></label>";
    $("#commonDataTable_filter").append(sValue);
    $("#commonDataTable_filter").append(sLabel);
    $("#commonDataTable_filter").append(sType);
    $("#commonDataTable_filter").css({position:"relative"});
    $("#commonDataTable_filter label input").css({"margin-right":"10px"});
    $("#commonDataTable_filter label input[type=search]").css({display:"none"});
}
function showConfirm (str,strHref){
    if (confirm(str)) location.replace(strHref)
}

function showSingleDict(ele){
    var source   = $("#singleDict-template").html();
    var template = Handlebars.compile(source);
    //默认数据
    var context = {value: "", label:'',type:"",description:"",sort:"",parentId:"",remarks:"",id:""};
    var html='';
    if(ele){
        ////编辑员工信息
        var dictId=$(ele).attr("data-dictId");
        $.ajax({url:'/dict/edit/'+dictId,type:"get",dataType:'json',success:function(data){
            context = {value: data.value, label:data.label,type:data.type,description:data.description,sort:data.sort,parentId:data.parentId,remarks:data.remarks,id:data.id};
            html= template(context);
            bootbox.dialog({
                message: html,
                title: "字典",
                className: "modal-darkorange"
            });
        }})
    }else{
        html    = template(context);
        bootbox.dialog({
            message: html,
            title: "字典",
            className: "modal-darkorange"
        });
    }

}

