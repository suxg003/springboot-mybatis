var tempId, tempStart, tempEl;
//var maxTimeOut = parseInt('<%--<%= LoanConstant.MAX_LOAN_TIME_OUT %>--%>')/24;//小时
var maxTimeOut = parseInt('100')/24;//小时
function scheduleLoan() {
    var timeout = parseInt($('#timeOutValue').val());
    var timeUnit = $('#scheduleTime option:selected').val();
    if (timeUnit == 'day') {
        if (isNaN(timeout) || timeout != $('#timeOutValue').val() || timeout < 1 || timeout > maxTimeOut) {
            alert('筹款周期不正确（应为1～' + maxTimeOut + '天），请重新输入！');
            return;
        }
        timeout = timeout * 24;
    } else {
        if (isNaN(timeout) || timeout != $('#timeOutValue').val() || timeout < 1 || timeout > 24) {
            alert('筹款周期不正确（应为1～24小时），请重新输入！');
            return;
        }
    }
    $.post("loan/doSchedule", {
        'id': tempId,
        'timeOpen': tempStart==null?'':(tempStart.Format('yyyy-MM-dd hh:mm') + ':00'),
        'timeOut': timeout
    }, function(res) {
        if (res) {
            tempEl.status = "SCHEDULED";
            tempEl.timeOut = timeout;
            tempEl.className = colors["SCHEDULED"];
            tempEl.startEditable = false;
            $('#calendar').fullCalendar('updateEvent', tempEl);
            $('.fc-event-pin[data-eid=' + tempId + '] i').removeClass('icon-unlock').addClass('icon-lock');
            $('#scheduleConfirm').modal('hide');
        } else {
            alert('Schedule event failed.');
        }
    }).fail(function() {
        alert('Schedule event failed.');
    });
}
function doChangeTimeOut() {
    var timeout = parseInt($('#timeOutValue2').val());
    var timeUnit = $('#scheduleTime2 option:selected').val();
    if (timeUnit == 'day') {
        if (isNaN(timeout) || timeout != $('#timeOutValue2').val() || timeout < 1 || timeout > maxTimeOut) {
            alert('筹款周期不正确（应为1～' + maxTimeOut + '天），请重新输入！');
            return;
        }
        timeout = timeout * 24;
    } else {
        if (isNaN(timeout) || timeout != $('#timeOutValue2').val() || timeout < 1 || timeout > 24) {
            alert('筹款周期不正确（应为1～24小时），请重新输入！');
            return;
        }
    }
    $.post("loan/changeTimeOut", {
        'id': tempId,
        'timeOut': timeout
    }, function(res) {
        if (res) {
            tempEl.timeOut = timeout;
            $('#calendar').fullCalendar('updateEvent', tempEl);
            $('#changeTimtOutPanel').modal('hide');
        } else {
            alert('修改筹款周期失败！');
        }
    }).fail(function() {
        alert('修改筹款周期失败！');
    });
}
var calendarHeight = 0;
/*
 * Update timeline every 30 seconds.
 * @returns {unresolved}
 */
function updateTimeline() {
    if (calendarHeight === 0)
        return;
    var curTime = new Date();
    var curSeconds = ((curTime.getHours() - 8) * 60 * 60) + (curTime.getMinutes() * 60) + curTime.getSeconds();
    var percentOfDay = curSeconds / 57600; //8am-24pm: 16 * 60 * 60 = 57600, # of seconds in a day
    var topLoc = Math.floor(calendarHeight * percentOfDay);
    $('.timeline').css("top", topLoc + "px");
    $('.timeSpan').css("top", topLoc - 20 + "px");
    var min = curTime.getMinutes() < 10 ? '0' + curTime.getMinutes() : curTime.getMinutes();
    $('.timeSpan').html("现在时间 " + curTime.getHours() + ':' + min);
}
/*
 * Add timeline to calendar.
 * @returns {unresolved}
 */
function setTimeline(view) {
    var parentDiv = $(".fc-agenda-slots:visible").parent();
    var timeline = parentDiv.children(".timeline");
    if (timeline.length === 0) { //if timeline isn't there, add it
        timeline = $("<hr>").addClass("timeline");
        parentDiv.prepend(timeline);
    }

    var curTime = new Date();
    var min = curTime.getMinutes() < 10 ? '0' + curTime.getMinutes() : curTime.getMinutes();
    var timeSpan = parentDiv.children(".timeSpan");
    if (timeSpan.length === 0) {
        timeSpan = $("<span>").addClass("timeSpan").html("现在时间 " + curTime.getHours() + ':' + min);
        parentDiv.prepend(timeSpan);
    }

    var curCalView = $("#calendar").fullCalendar('getView');
    if (curCalView.visStart < curTime && curCalView.visEnd > curTime) {
        timeline.show();
        timeSpan.show();
    } else {
        timeline.hide();
        timeSpan.hide();
        return;
    }

    var curSeconds = ((curTime.getHours() - 8) * 60 * 60) + (curTime.getMinutes() * 60) + curTime.getSeconds();
    var percentOfDay = curSeconds / 57600; //8am-20pm: 16 * 60 * 60 = 57600, # of seconds in a day
    calendarHeight = parentDiv.height();
    var topLoc = Math.floor(parentDiv.height() * percentOfDay);
    timeline.css("top", topLoc + "px");
    timeSpan.css("top", topLoc - 20 + "px");
    if (curCalView.name === "agendaWeek") { //week view, don't want the timeline to go the whole way across
        var dayCol = $(".fc-today:visible");
        var left = dayCol.position().left + 1;
        var width = dayCol.width() - 2;
        timeline.css({
            left: left + "px",
            width: parseInt(width) + "px"
        });
        timeSpan.css({
            left: left + "px"
        });
    }

}
/**
 * Schedule the event clicked
 * @param {type} evt
 * @returns {undefined}
 */
var pinEvent = function(evt) {
    tempId = evt.data('eid');
    var obj = $('#calendar').fullCalendar('clientEvents', tempId);
    console.log(obj);
    if (obj !== null) {
        tempEl = obj[0];
        if (tempEl.startEditable) {
            // Do schedule
            var startDate = new Date(tempEl.start);
            $('#openTimeValue').text(startDate.Format('yyyy-MM-dd hh:mm'));
            if (tempEl.timeOut > 24) {
                $('#timeOutValue').val(tempEl.timeOut/24);
            } else {
                $('#timeOutValue').val(tempEl.timeOut);
                $('#scheduleTime option:last').prop('selected', true);
            }
            tempStart = tempEl.start;
            //tempStart = new Date(tempEl.start).Format('yyyy-MM-dd hh:mm') + ":00";
            $('#scheduleConfirm').modal({'backdrop': 'static'});

        } else {
            tempEl.startEditable = true;
            $('#calendar').fullCalendar('updateEvent', tempEl);
            $('.fc-event-pin[data-eid=' + tempId + '] i').removeClass('icon-lock').addClass('icon-unlock');
        }
    }
};

var changeTimeOut = function(evt) {
    tempId = evt.data('eid');
    var obj = $('#calendar').fullCalendar('clientEvents', tempId);
    if (obj !== null) {
        tempEl = obj[0];
        if (tempEl.timeOut > 24) {
            $('#timeOutValue2').val(tempEl.timeOut/24);
        } else {
            $('#timeOutValue2').val(tempEl.timeOut);
            $('#scheduleTime2 option:last').prop('selected', true);
        }
        $('#changeTimtOutPanel').modal({'backdrop': 'static'});
    }
};
// event styles
//var colors = ['label-success', 'label-important', 'label-purple', 'label-yellow', 'label-pink', 'label-info'];
var colors = {
    'FINISHED': 'label-success', //已结束
    'INITIATED': 'label-grey', //初始
    'CANCELED': 'label-inverse', //已取消
    'SETTLED': 'label-info', //已结算
    'CLEARED': 'label-purple', //已还清
    'OVERDUE': 'label-important', //逾期
    'SCHEDULED': 'label-yellow', //已安排
    'OPENED': 'label-pink'       //开放投标
};
// scheduled events list
var events = [];
/**
 * Insert loan to event list which will display in the calendar.
 * @param {type} timeOpen
 * @param {type} id
 * @param {type} title
 * @returns {unresolved}
 * */
function insertEvent(timeOpen, id, title, status, amount, requestId, timeOut) {
    if (timeOpen === null || timeOpen === '')
        return;
    /*
     * hack: Fix timezone issue: change from CST to GMT+8..
     */
    var date = new Date(timeOpen);
    date.setHours(date.getHours() - 14);
    // Add scheduled events to the list.
    events.push({
        id: id,
        title: title,
        start: date,
        allDay: false,
        startEditable: false,
        durationEditable: false,
        className: colors[status],
        status: status,
        amount: amount,
        requestId: requestId,
        timeOut: timeOut
    });
}


$(function() {
    /* initialize the external events
     -----------------------------------------------------------------*/
    $('#external-events div.external-event').each(function() {
        // create an Event Object (http://arshaw.com/fullcalendar/docs/event_data/Event_Object/)
        // it doesn't need to have a start or end
        var eventObject = {
            id: $(this).attr("loanId"),
            title: $.trim($(this).text()), // use the element's text as the event title
            amount: $(this).data('amount'),
            status: "INITIATED",
            timeOut: $(this).data('timeout'),
            requestId: $(this).data('requestid'),
            className: colors['INITIATED']
        };
        // store the Event Object in the DOM element so we can get to it later
        $(this).data('eventObject', eventObject);
        // make the event draggable using jQuery UI
        $(this).draggable({
            zIndex: 999,
            revert: true,
            revertDuration: 0
        });
    });
    /* initialize the calendar
     -----------------------------------------------------------------*/
    var calendar = $('#calendar').fullCalendar({
        buttonText: {
            prev: '<i class="icon-chevron-left"></i>',
            next: '<i class="icon-chevron-right"></i>'
        },
        header: {
            left: 'prev,next today',
            center: 'title',
            right: 'month,agendaWeek,agendaDay'
        },
        //views
        height: 900,
        weekMode: 'liquid',
        monthNames: ['一月', '二月', '三月', '四月', '五月', '六月', '七月',
            '八月', '九月', '十月', '十一月', '十二月'],
        monthNamesShort: ['1 月', '2 月', '3 月', '4 月', '5 月', '6 月', '7 月',
            '8 月', '9 月', '10 月', '11 月', '12 月'],
        dayNames: ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'],
        dayNamesShort: ['周日', '周一', '周二', '周三', '周四', '周五', '周六'],
        buttonText: {
            prev: '&lsaquo;', // <
            next: '&rsaquo;', // >
            prevYear: '&laquo;', // <<
            nextYear: '&raquo;', // >>
            today: '今天',
            month: '月历',
            week: '周视图',
            day: '单日日程'
        },
        titleFormat: {
            month: 'yyyy年 MMMM', // September 2009
            week: "yyyy年 MMM d日[ yyyy]{ '&#8212;'[ MMM] d日}", // Sep 7 - 13 2009
            day: 'yyyy年 MMM d日 dddd' // Tuesday, Sep 8, 2009
        },
        allDayText: '全天',
        //view config
        defaultEventMinutes: 110,
        defaultView: 'agendaWeek',
        snapMinutes: 1,<!--${applicationUtils.scheduleLoanInterval}-->
        timeFormat: 'HH:mm',
        axisFormat: 'H:mm',
        minTime: '8:00',
        firstHour: new Date().getUTCHours() - 5,
        //events
        events: events,
        editable: true,
        droppable: true, // this allows things to be dropped onto the calendar !!!
        drop: function(date, allDay) { // this function is called when something is dropped
            // retrieve the dropped element's stored Event Object
            var originalEventObject = $(this).data('eventObject');
            var $extraEventClass = $(this).attr('data-class');
            // we need to copy it, so that multiple events don't have a reference to the same object
            var copiedEventObject = $.extend({}, originalEventObject);
            // assign it the date that was reported

            if (date < new Date()) { // Prevent dragging a event to date before today.
                alert('不可把标放置到当前时间之前！');
                return;
            }

            copiedEventObject.start = date;
            copiedEventObject.allDay = allDay;
            copiedEventObject.startEditable = true;
            copiedEventObject.durationEditable = false;
            // render the event on the calendar
            // the last `true` argument determines if the event "sticks"
            $('#calendar').fullCalendar('renderEvent', copiedEventObject, false);
            events.push(copiedEventObject);
            //默认删除Loan对象
            $(this).remove();
        },
        eventRender: function(event, element) {
            // Add status icon
            var $ftime = $(element).find('.fc-event-time');
            if (event.status === 'FINISHED')
                $ftime.prepend('<i class="fa fa-check bigger-110" title="已满标"></i> ');
            else if (event.status === 'INITIATED')
                $ftime.prepend('<i class="fa fa-asterisk bigger-110" title="初始"></i> ');
            else if (event.status === 'OPENED')
                $ftime.prepend('<i class="fa fa-play-circle bigger-110" title="开放投标"></i> ');
            else if (event.status === 'SCHEDULED')
                $ftime.prepend('<i class="fa fa-clock-o bigger-110" title="已安排"></i> ');
            else if (event.status === 'CLEARED')
                $ftime.prepend('<i class="fa fa-thumbs-up bigger-110" title="已还清"></i> ');
            else if (event.status === 'SETTLED')
                $ftime.prepend('<i class="fa fa-check-o bigger-110" title="已结算"></i> ');
            else if (event.status === 'CANCELED')
                $ftime.prepend('<i class="fa fa-times bigger-110" title="已取消"></i> ');
            else if (event.status === 'OVERDUE')
                $ftime.prepend('<i class="fa fa-info-circle bigger-110" title="逾期"></i> ');

            if (event.status === 'INITIATED' || event.status === 'SCHEDULED' || event.status === 'OPENED') {
                var $timeOut = $('<a href="javascript:;" class="fc-event-timeout" data-eid="' + event.id + '" onClick="changeTimeOut($(this));"></a>');
                if (event.timeOut >= 24) {
                    $ftime.append($timeOut.html('（周期：' +  event.timeOut/24 + '天）'));
                } else {
                    $ftime.append($timeOut.html('（周期：' +  event.timeOut + '小时）'));
                }
            }

            // Add amount
            var amount = '<div class="fc-event-amount"><i class="fa fa-cny bigger-110"></i> ' + formatAmount(event.amount) + '</div>';
            $ftime.after(amount);
            $(element).find('.fc-event-title').wrapInner('<a href="loan/request/' + event.requestId + '" title="' + event.title + '"></a>').prepend('<i class="fa fa-tag"></i> ');

            if (event.start > new Date() || event.status === 'INITIATED') {
                // Render lock/unlock icon.
                var pin = '<div class="fc-event-pin" data-eid="' + event.id +'" onclick="pinEvent($(this))"><i class="fa fa-unlock"></i></div>';
                if (!event.startEditable) { // for scheduled events, set the icon to lock.
                    pin = '<div class="fc-event-pin" data-eid="' + event.id + '" onclick="pinEvent($(this))"><i class="fa fa-lock"></i></div>';
                }
                $ftime.before(pin);
            }
        },
        eventAfterRender: function(event, element) {
            if (event.start < event.currentTime) { // Prevent dragging a event to date before today.
                event.start = new Date(event.startBeforeDrag);
                $('#calendar').fullCalendar('updateEvent', event);
            }
        },
        eventDragStart: function(event, element, ui, view) {
            // Store the date before dragging.
            event.startBeforeDrag = event.start.valueOf();
            event.currentTime = new Date();
        },
        viewRender: function(view) {
            // update timeline every 30 seconds.
            timelineInterval = window.setInterval(updateTimeline, 30 * 1000);
            try {
                setTimeline();
            } catch (err) {
                alert(err);
            }
        }
    });

    $('.sparkline').each(function() {
        var $box = $(this).closest('.infobox');
        var barColor = !$box.hasClass('infobox-dark') ? $box.css('color') : '#FFF';
        $(this).sparkline('html', {tagValuesAttribute: 'data-values', type: 'bar', barColor: barColor, chartRangeMin: $(this).data('min') || 0});
    });

    $('#columnChart').highcharts({
        chart: {
            type: 'column'
        },
        title: {
            text: ''
        },
        xAxis: {
            categories: ['今日总余额', '未发布', '明天待收', '后天待收']
        },
        yAxis: {
            allowDecimals: false,
            title: {
                text: ''
            }
        },
        tooltip: {
            formatter: function() {
                return '<b>' + this.x + '</b><br/>' +
                    this.series.name + ': ' + this.y + '<br/>' +
                    'Total: ' + this.point.stackTotal;
            }
        },
        legend: {
            enabled: false
        },
        plotOptions: {
            column: {
                stacking: 'normal'
            }
        },
        credits: {
            enabled: false
        },
        //stack-0
        series: [{
            name: 'A',
            data: [5, 0, 4, 7],
            stack: '0'
        }, {
            name: 'B',
            data: [3, 0, 0, 0],
            stack: '0'
        }, {
            name: 'C',
            data: [3, 0, 0, 0],
            stack: '0'
        }, {
            name: 'D',
            data: [5, -2, 0, 0],
            stack: '0'
        }]
    });
});