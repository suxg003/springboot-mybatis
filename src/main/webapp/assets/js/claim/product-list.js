
/**
 * Created by dandan on 15/10/20.
 */


function Func(type,path) {
    this.type = type;
    this.path = path;
    this.init();
}

Func.prototype.init = function () {
    var self = this;
    self.loadData();

    //日历
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
    });

    $('#reservation').daterangepicker();

    $('#reservation').val(moment().subtract('days', 29).format("YYYY-MM-DD") + ' - ' + moment().format("YYYY-MM-DD"));

    $('#btn_search').on('click', function () {
        self.loadData.apply(self, []);
    });
};

Func.prototype.loadData = function () {
    var _self = this;
    var aoColumns;
    var length;
    // 月盈和复利需要显示大额标
    if (_self.type == 'MONTH_WIN' || _self.type == 'RECYCLE_INTEREST') {
        length = 11;
        aoColumns = [{"mData": "productName", "sDefaultContent": ""},//0
            {"mData": "amount", "sDefaultContent": ""},//1
            {"mData": "remainAmount", "sDefaultContent": ""},//2
            {"mData": "openTime", "sDefaultContent": ""},//3
            {"mData": "investEndDate", "sDefaultContent": ""},//4
            {"mData": "status", "sDefaultContent": ""},//5
            {"mData": "fixedRate", "sDefaultContent": ""},//6
            {"mData": "flagCanbreak", "sDefaultContent": ""},//7
            {"mData": "breakRate", "sDefaultContent": ""},//8
            {"mData": "expireOutType", "sDefaultContent": ""},//9
            {"mData": "flagBig", "sDefaultContent": ""},//10
            {"mData": "productId", "sDefaultContent": ""}];//11
    } else {
        length = 10;
        aoColumns = [{"mData": "productName", "sDefaultContent": ""},//0
            {"mData": "amount", "sDefaultContent": ""},//1
            {"mData": "remainAmount", "sDefaultContent": ""},//2
            {"mData": "openTime", "sDefaultContent": ""},//3
            {"mData": "investEndDate", "sDefaultContent": ""},//4
            {"mData": "status", "sDefaultContent": ""},//5
            {"mData": "fixedRate", "sDefaultContent": ""},//6
            {"mData": "flagCanbreak", "sDefaultContent": ""},//7
            {"mData": "breakRate", "sDefaultContent": ""},//8
            {"mData": "expireOutType", "sDefaultContent": ""},//9
            {"mData": "productId", "sDefaultContent": ""}];//10
    }

    var $dateRange = $('#reservation');
    var opType = $('#operetionType').val();
    
    $('#reProRecordsTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": false,
        "bServerSide": true,
        "bSort": false,
        "bFilter": true,
        "bPaginate": true,
        "bSortable": false,
        "bDestroy": true,
        "aoColumns": aoColumns,
        "aoColumnDefs": [
            {
                "aTargets": [0],
                "mRender": function (data, type, row) {
                    return '<a class="blue" href="/claimInvest/'+ _self.path +'?productId=' + row.productId + '">' + data+ '</a>';
                }
            },{
                "aTargets": [1],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                }
            },
            {
                "aTargets": [2],
                "mRender": function (data, type, row) {
                    return '<span class="red bold">' + formatAmount(data, 2) + '元</span>';
                }
            },
            {
                "aTargets": [3],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd");
                }
            },
            {
                "aTargets": [4],
                "mRender": function (data, type, row) {
                    if (data != null) {
                        return new Date(data).Format("yyyy-MM-dd");
                    } else {
                        return null;
                    }
                }
            },
            {
                "aTargets": [5],
                "mRender": function (data, type, row) {
                    if (data == 'INITIALIZED' || data == 'OPENED') {
                        return '<span style="color:red;">未满标</span>';
                    }
                    
                    if (data == 'FINISHED') {
                        return "已满标";
                    }
                }
            }, {
                "aTargets": [6],
                "mRender": function (data, type, row) {
                	console.log(_self.type);
                	if(_self.type=='MONTH_WIN'){
                		return '12.36%-12.84%';
                	}else if(_self.type=='RECYCLE_INTEREST'){
                		return '13.15%-13.69%';
                	}else{
                		return data+'%';
                	}
                	
                	
                    
                }
            },
            {
                "aTargets": [7],
                "mRender": function (data, type, row) {
                    if (data == 1) {
                        return "是";
                    } else {
                        return "否";
                    }
                }
            },
            {
                "aTargets": [8],
                "mRender": function (data, type, row) {
                    if(data != null){
                        return data + "%";
                    }else{
                        return null;
                    }

                }
            },
            {
                "aTargets": [9],
                "mRender": function (data, type, row) {
                    if (data == 'AUTO_EXPIRE') {
                        return '自动';
                    }
                    if (data == 'MANUAL_EXPIRE') {
                        return '手动';
                    }
                    if (data == 'EARLY_EXIT') {
                        return "提前退出";
                    }
                    if (data == 'ANYTIME') {
                        return "随时退出";
                    }
                }
            },
            {
                "aTargets": [length - 1],
                "mRender": function (data, type, row) {
                    if (_self.type == 'MONTH_WIN' || _self.type == 'RECYCLE_INTEREST') {
                        if (data == 1) {
                            return "大额标";
                        } else {
                            return "";
                        }
                    }
                }
            },
            {
                "aTargets": [length],
                "mRender": function (data, type, row) {
                    return '<div class="btn-group btn-group-justified" style="width: 80px;"><a class="btn btn-sm btn-blue" href="/claimInvest/'+ _self.path +'?productId=' + row.productId + '">投资记录</a></div>';
                }
            }
        ],
        "sAjaxSource": "/claimProduct/list/" + this.type,
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
                "value": opType
            });
            var downParams = [];
            for (var i = 0; i < aoData.length; i++) {

                if (aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'startDate'
                    || aoData[i]['name'] == 'endDate' || aoData[i]['name'] == 'type') {
                    downParams.push(aoData[i]['name'] + '=' + aoData[i]['value']);
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
};

