/**
 * Created by apple on 15/7/14.
 */

(function(){
    'use strict';


    function Func(){
        this.init();

        this.loadData();
    }

    Func.prototype.init = function(){
        var self = this;

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

        $('#reservation').val(moment().subtract('days', 29).format("YYYY-MM-DD")+' - '+moment().format("YYYY-MM-DD"));

        $('#btn_search').on('click',function(){
            self.loadData.apply(self, []);
        });
    };

    Func.prototype.loadData = function(){
        var $dateRange = $('#reservation');
        var opType = $('#operetionType').val();
        $('#bbtFundRecordsTable').dataTable({
            "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
            "bProcessing": false,
            "bServerSide": true,
            "bSort": false,
            "bFilter": true,
            "bPaginate": true,
            "bSortable": false,
            "bDestroy": true,
            "aoColumns": [
                {"mData": "orderId"},//0
                {"mData": "loginName", sDefaultContent: ""},//1
                {"mData": "userName", sDefaultContent : ""},//2
                {"mData": "changeTypeName"},//3
                {"mData": "amount"},//4
                {"mData": "availableAmount"},//5
                {"mData": "statusName"},//6
                {"mData": "description"},//7
                {"mData": "recordTime"},//8
                {"mData": "platformName"}//9

            ],
            "aoColumnDefs": [
                {
                    "aTargets": [8],
                    "mRender": function (data, type, row) {
                        console.log(data);
                        return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                    }
                },{
                    "aTargets": [4],
                    "mRender": function (data, type, row) {
                        if(row.operation == 'FREEZE' || row.operation == 'OUT'){
                            return '<span style="color:red;">-￥' + formatAmount(data, 2) + '</span>';
                        }

                        return '<span style="color:green;">￥' + formatAmount(data, 2) + '</span>';
                    }
                },{
                    "aTargets": [5],
                    "mRender": function (data, type, row) {
                        return '<span style="color:blue;">￥' + formatAmount(data, 2) + '</span>';
                    }
                },{
                    "aTargets": [9],
                    "mRender": function (data, type, row) {
                        if(data == 'PLATFORM_A') {
                            return "A-官网";
                        }
                        if(data == 'PLATFORM_B') {
                            return "B-后台";
                        }
                        if(data == 'PLATFORM_C') {
                            return "C-后台";
                        }
                    }
                }
            ],
            "sAjaxSource": "/fund/plat/records",
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
                    //if (aoData[i]['name'] == 'iSortCol_0') {
                    //    var cols = this.fnSettings().aoColumns;
                    //    var index = parseInt(aoData[i]['value']);
                    //    aoData.push({"name": "sColName", "value": cols[index]['mData']});
                    //    //break;
                    //}

                    if(aoData[i]['name'] == 'sSearch' || aoData[i]['name'] == 'startDate'
                    ||aoData[i]['name'] == 'endDate' || aoData[i]['name'] == 'type') {
                        downParams.push(aoData[i]['name']+'='+aoData[i]['value']);
                    }
                }
                $('#link_down').attr('href', '/fund/fund/down?'+ downParams.join('&'));

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

    new Func();

})();
