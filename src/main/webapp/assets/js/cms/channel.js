//初始化工作
//var $articleTable;
//$(function() {
//    $('#updateChannel').removeAttr('disabled'); //解决重新加载之后按钮不可用bug
//    $articleTable = buildArticleTable();
//});

function addClickEvent() {
    $('.edit-article-link').unbind("click");
    $('.edit-article-link').on('click',function () {
        var aid = $(this).data('id');
        $.get('/cms/articleDetail/' + aid, function (art) {
            var art=eval('('+art+')');
            if (art && art.success) {
                art = art.data;
                console.log(art);
                //alert(JSON.stringify(art));
                editingArticle = art.cmsId;
                editingChannel = art.channelId;
                $('input[name=artId]').val(art.newsId);//art.id
                $('input[name=artTitle]').val(art.title);
                $('input[name=artKeyWords]').val(art.titleKeyWords);
                $('input[name=artDescription]').val(art.titleDescription);
                $('input[name=artTitleImageUrl]').val(art.titleImageUrl);
                $('input[name=artChannel]').val(currChannel.data('name'));
                $('input[name=seq]').val(art.seq);

                if (art.cmsCategory === 'HOMEPAGE' || art.cmsCategory === 'IMAGE') {
                    //$('#editor1').html('<img src="' + art.content + '" alt="" />');
                    var $img = $('<p><img src="' + art.cmsContent + '" alt="" /></p>');
                    CKEDITOR.instances.contentEditor.setData($img.html());
                } else {
                    //$('#editor1').html(art.content);
                    CKEDITOR.instances.contentEditor.setData(art.cmsContent);
                }
                $('select[name=artCategory]').val(art.cmsCategory);
                if($('select[name=artCategory]').val()=='COVERAGE'||$('select[name=artCategory]').val()=='NEWS'
                    ||$('select[name=artCategory]').val()=='PUBLICATION'||$('select[name=artCategory]').val()=='PROJECT'){

                    $('.putIn-location').css('display','block');
                    if (art.appSite) {
                        $('input[name=putIn-app]').prop('checked', true);
                    } else {
                        $('input[name=putIn-app]').prop('checked', false);
                    }
                    if (art.pcSite) {
                        $('input[name=putIn-pc]').prop('checked', true);
                    } else {
                        $('input[name=putIn-pc]').prop('checked', false);
                    }
                    if (art.mzSite) {
                        $('input[name=putIn-m]').prop('checked', true);
                    } else {
                        $('input[name=putIn-m]').prop('checked', false);
                    }
                }
                else{
                    $('.putIn-location').css('display','none');
                }
                if (art.hasImage) {
                    $('input[name=artHasImg]').first().prop('checked', true);
                } else {
                    $('input[name=artHasImg]').last().prop('checked', true);
                }
                if (art.priority) {
                    $('input[name=artTop]').first().prop('checked', true);
                } else {
                    $('input[name=artTop]').last().prop('checked', true);
                }
                $('#l_artPlace').prop('checked', false);
                $('#m_artPlace').prop('checked', false);
                $('#r_artPlace').prop('checked', false);
                if (art.articlePlace=="LEFT") {
                    $('#l_artPlace').prop('checked', true);
                } else if(art.articlePlace=="MEDIUM"){
                    $('#m_artPlace').prop('checked', true);
                } else if(art.articlePlace=="RIGHT"){
                    $('#r_artPlace').prop('checked', true);
                }
                if(art.cmsCategory!='COVERAGE'){
                    $("#artPlaceDiv").css("display","none");
                }else{
                    $("#artPlaceDiv").css("display","block");
                }
                $('input[name=artUrl]').val(art.url);
                var date = new Date(art.publicTime);
                console.log(date);
                $('.date-picker').val( date.Format("yyyy-MM-dd"));
               /* $('.date-picker').datepicker('update', date.Format("yyyy-MM-dd")).next().on(event, function () {
                    $(this).prev().focus();
                });*/
                
                console.log(date.getHours() + ':' + date.getMinutes());
                $('input[name=timepicker]').val( date.getHours() + ':' + date.getMinutes());
                $('input[name=artMedia]').val(art.media);
                $('input[name=artAuthor]').val(art.cmsAuthor);


                $('#articleListPanel').hide();
                $('#createArticleBtn').hide();
                $('#createArticlePanel').show();
                $('#updateArticleBtn').show();
            }
        });
    });
    $('.top-article-link').unbind("click");
    $('.top-article-link').click(function () {
        var aid = $(this).data('id');
        $.get('/cms/article/top/' + aid, function (result) {
            var result = eval('('+result+')');
            if (result.success) {
                if (result.data.old) {
                    showModal('文章取消置顶成功!', true);
                } else {
                    showModal('文章置顶成功!', true);
                }
            } else {
                showModal('文章置顶失败!', false);
            }
        });
    });
    $('.delete-article-link').unbind("click");
    $('.delete-article-link').click(function () {
        console.log("clicked");
        if (confirm("确定删除文章【" + $(this).data('name') + "】吗？")) {
            var aid = $(this).data('id');
            $.get('/cms/article/delete/' + aid, function (result) {
                var result = eval('('+result+')');
                if (result.success) {
                    showModal('文章删除成功!', true);
                } else {
                    showModal('文章删除失败!', false);
                }
            });
        }
    });
}
//建立文章数据表格
//function buildArticleTable() {
//    return $('#articleTable').dataTable({
//        "aoColumns": [
//            {"bSortable": true}, null, null, null, null
//        ],
//        "oLanguage": {
//            "sLengthMenu": "显示 _MENU_ 条记录",
//            "sSearch": "搜索:",
//            "sInfo": "显示第 _START_ - _END_ 条记录，共 _TOTAL_ 条",
//            "sInfoEmpty": "记录为空",
//            "sZeroRecords": "暂无文章"
//        },
//        "fnDrawCallback": function() {
//            addClickEvent();
//        },
//        "bDestroy": true
//    });
//}


$('input[name=putIn-app]').click(function(){
	if($(this).is(':checked')){
		$('.img-app').css('display','block');
	}else{
		$('.img-app').css('display','none');
	}
});
$('input[name=putIn-m]').click(function(){
	if($(this).is(':checked')){
		$('.img-m').css('display','block');
	}else{
		$('.img-m').css('display','none');
	}
});







var currChannel = null, editingChannel = null, editingArticle = null;
//栏目详细信息事件触发按钮
$('.editChannelLink').click(function () {
    var self = $(this);
    var channelId = self.data('id');
    var channelName = self.data('name');
    var categoryName = self.data('category');
    $('input[name=channelId]').val(channelId);
    $('input[name=channelName]').val(channelName);
    $('select[name=whichCategory]').val(categoryName);
    $('#saveChannel').hide();
    $('#updateChannel').show();
    $('#cancelCreateChannel').show();
    $('#articleListPanel').hide();
    $('#editChannelPanel').show();

});

var $artTr = '<tr><td class="hidden">index</td><td><a href="/cms/article/detail/aid">aTitle</a></td><td>author</td> <td>date</td>';
$artTr += '<td><a href="javascript:;" data-id="aid" class="edit-article-link"><i class="fa fa-edit bigger-110" title="编辑"></i></a><span>&nbsp&nbsp&nbsp</span>';
$artTr += '<a href="javascript:;" data-id="aid" class="delete-article-link" data-name="aTitle"><i class="fa fa-trash-o bigger-110 red" title="删除"></i></a><span>&nbsp&nbsp&nbsp</span>';
$artTr += '<a href="javascript:;" data-id="aid" class="top-article-link"><i class="icon-circle-arrow-up bigger-110 purple" title="置顶/取消"></i></a></td></tr>';

$('.detailChannelLink').click(function () {
    var self = $(this);
    currChannel = self;
    $('#openCreateArticleBtn').show();
    var channelId = self.data('id');
    var $articleTable = $('#articleTable').dataTable({
        "sDom": "flt<'row '<'col-sm-6'i><'col-sm-6'p>>",
        "bProcessing": true,
        "bServerSide": true,
        "bSort": false,
        "aoColumns": [

            {"mData": "title"},
            {"mData": "cmsAuthor"},
            {"mData": "publicTime"},
            {"mData": "cmsId"}
        ],
        "aoColumnDefs": [{
            "bSortable": false,
            "aTargets": [3],
            "mRender": function (data, type, row) {
                if (row.priority) {
                    return '<a href="javascript:;" data-id="' + data + '" class="edit-article-link"><i class="fa fa-edit bigger-110" title="编辑"></i></a><span>&nbsp&nbsp&nbsp</span>\
                    <a href="javascript:;" data-id="' + data + '" class="delete-article-link" data-name="' + row.title + '"><i class="fa fa-trash-o bigger-110 red" title="删除"></i></a><span>&nbsp&nbsp&nbsp</span>';
                } else {
                    return '<a href="javascript:;" data-id="' + data + '" class="edit-article-link"><i class="fa fa-edit bigger-110" title="编辑"></i></a><span>&nbsp&nbsp&nbsp</span>\
                    <a href="javascript:;" data-id="' + data + '" class="delete-article-link" data-name="' + row.title + '"><i class="fa fa-trash-o bigger-110 red" title="删除"></i></a><span>&nbsp&nbsp&nbsp</span>';
                }}},
            {
                "aTargets": [2],
                "mRender": function (data, type, row) {
                    return new Date(data).Format("yyyy-MM-dd hh:mm:ss");
                }
            }],
        "sAjaxSource": "articles/" + channelId,
        "fnServerData": function (sSource, aoData, fnCallback, oSettings) {
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
        },

        "fnDrawCallback": function () {
            addClickEvent();
        },
        "bDestroy": true
    });
    //$.get("cms/articles/" + channelId, function(articles) {
    //    if (articles.data.resultList.length === 0) {
    //        $('#articleTable tbody').html('<tr><td colspan="4">暂无文章</td></tr>');
    //    } else {
    //        $('#articleTable tbody').html('');
    //    }
    //    $articleTable.fnClearTable();
    //    for (var i = 0; i < articles.data.resultList.length; i++) {
    //        var art = articles.data.resultList[i];
    //        var html = $artTr
    //                .replace('index', i + 1)
    //                .replace(/aTitle/g, art.title)
    //                .replace('author', art.author)
    //                .replace(/aid/g, art.id) // !!!!!!!!!!!!!!!!
    //                .replace('date', (new Date(art.pubdate)).Format('yyyy-MM-dd hh:mm'));
    //        if (art.priority) {
    //            html = html.replace('icon-circle-arrow-up', 'icon-circle-arrow-down');
    //        }
    //        $('#articleTable tbody').append($(html));
    //        if (art.priority === true) {
    //            var iconId = '#homeIcon' + art.id;
    //            $(iconId).removeClass('hidden');
    //        }
    //        $articleTable = buildArticleTable();
    //    }
    //addClickEvent();
    //top-article-link
    //addDeleteArticleEvents();
    //delete-article-link
    //});
});

//删除栏目事件处理函数
$('.deleteChannelLink').click(function (e) {
    e.stopPropagation();
    if (confirm("确定删除栏目【" + $(this).parents('.detailChannelLink').data('name') + "】吗？")) {
        var channelId = $(this).data('id');
        $.get('/cms/channel/delete/' + channelId, function (result) {
            var result = eval('('+result+')');
            $(this).prop('disabled', false);
            if (result.result) {
                showModal('栏目删除成功!', true);
            } else {
                showModal('栏目删除失败!', false);
            }
        });
    }
});

//创建栏目事件处理
$('#createChannel').click(function (e) {
    e.stopPropagation();
    $('#articleListPanel').hide();
    $('#updateChannel').hide();
    $('#editChannelPanel').show();
    $('#cancelCreateChannel').show();
    $('#saveChannel').show();
    //$('#updateChannel').hide(); //隐藏创建按钮显示创建和保存按钮
    $('#saveChannel').removeClass('hidden');
    $('#cancelCreateChannel').removeClass('hidden');
    $('#channelName').val('').focus();
    $('select[name=whichCategory] option:first').prop('selected', true);
});

//保存栏目事件处理
$('#saveChannel').click(function () {
    if (!validate()) {
        return;
    }
    $(this).prop('disabled', true);
    var channelId = $('input[name=channelId]').val();
    var channelName = $('input[name=channelName]').val();
    var whichCategory = $('select[name=whichCategory] option:selected').val();
    var data = {
        'id': channelId,
        'channelName': channelName,
        'channelCategory': whichCategory
    };
    $.post("/cms/channel/create/", data, function (result) {
        var result = eval('('+result+')');
        $(this).prop('disabled', false);
        if (result.result) {
            showModal('栏目【 ' + channelName + ' 】创建成功!', true);
        } else {
            showModal('栏目【 ' + channelName + ' 】创建失败!', false);
        }
    });
});

//保存修改栏目事件处理
$('#updateChannel').click(function () {
    if (!validate()) {
        return;
    }
    $(this).prop('disabled', true);
    var channelId = $('input[name=channelId]').val();
    var channelName = $('input[name=channelName]').val();
    var whichCategory = $('select[name=whichCategory] option:selected').val();
    console.log(whichCategory);
    var data = {
        'channelId': channelId,
        'channelName': channelName,
        'whichCategory': whichCategory
    };
    $.post("/cms/updateChannel", data, function (result) {
        var result = eval('('+result+')');
        $(this).prop('disabled', false);
        if (result.result) {
            showModal('栏目【 ' + channelName + ' 】更新成功!', true);
            windows.location.href="/cms/channel";
        } else {
            showModal('栏目【 ' + channelName + ' 】更新失败!', false);
            windows.location.href="/cms/channel";
        }
    });
});

// 取消创建栏目按钮
$('#cancelCreateChannel').click(function () {
    $('#editChannelPanel').hide();
    $('#articleListPanel').show();
    $('.categoryHOMEPAGE').trigger('click');
});

// 验证创建栏目表单输入
function validate() {
    var validated = true;
    var $channelName = $('input[name=channelName]');
    var $whichCategory = $('select[name=whichCategory] option:selected');

    if ($channelName.val() === '') {
        $channelName.addClass('input-invalid');
        validated = false;
    }
    if ($whichCategory.val() === '') {
        $whichCategory.addClass('input-invalid');
        validated = false;
    }
    return validated;
}

//显示遮罩提示层
function showModal(msg, status) {
    if (status) {
        $('.modal-success .modal-message').text(msg);
        $('.modal-success').show();
    } else {
        $('.modal-failed .modal-message').text(msg);
        $('.modal-failed').show();
    }
}
$('.reload-page-btn').click(function () {
    location.reload();
});
$('.close-modal-btn').click(function () {
    $('.modal-bg').hide();
});

var $datePicker = $('input[name=pubDate]');
/*$.fn.datepicker.dates['cn'] = {
    days: ["周日", "周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    daysShort: ["日", "一", "二", "三", "四", "五", "六", "日"],
    daysMin: ["日", "一", "二", "三", "四", "五", "六", "日"],
    months: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"],
    monthsShort: ["一月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
};*/
$('.date-picker').datepicker({
    /*'language': 'cn'*/
});
var date = new Date();
$('.date-picker').val( date.Format("yyyy-MM-dd"));
/*$('.date-picker').val('update', date.Format("yyyy-MM-dd"))*/
$('input[name=timePicker]').timepicker({
    minuteStep: 1,
    showSeconds: false,
    defaultTime: '',
    showMeridian: false
});

$('input[name=timePicker]').val( date.getHours() + ':' + date.getMinutes());

/**
 * 增加文章*/
$('#createArticleBtn').on('click',function () {
    var times = $('input[name=timepicker]').val().split(':');

    var data = {};
    data.channelId = currChannel.data('id');
    data.newsId = $('input[name=artId]').val();
    data.title = $('input[name=artTitle]').val();
    data.titleKeyWords = $('input[name=artKeyWords]').val();
    data.titleDescription = $('input[name=artDescription]').val();
    data.titleImageUrl = $('input[name=artTitleImageUrl]').val();
    //data.content = $.escape($('#editor1').html());

    data.category = currChannel.data('category');
    console.log(data.category);
    if (data.category === 'HOMEPAGE' || data.category === 'IMAGE') {
        //data.content = $('#editor1').children(':first').attr('src');
        data.content = $('iframe.cke_wysiwyg_frame').contents().find('img').attr('src');
        console.log("image content", data.content);
    } else {
        //data.content = $('#editor1').html();
        data.content = CKEDITOR.instances.contentEditor.getData();
        console.log("text content", data.content);
    }
    data.hasImage = $('input[name=artHasImg]:checked').val();
    data.priority = $('input[name=artTop]:checked').val();
    data.place = $('input[name=artPlace]:checked').val();
    data.url = $('input[name=artUrl]').val();
    data.pubDate = $datePicker.val() + ' ' + times[0] + ':' + times[1];
    data.media = $('input[name=artMedia]').val();
    data.author = $('input[name=artAuthor]').val();
    data.seq = $('#seq').val();
    console.log("seq==" + seq);
    
    if($('input[name=putIn-app]').is(':checked')){
    	data.appSite = true;
    }else{
    	data.appSite = false;
    }
    if($('input[name=putIn-pc]').is(':checked')){
    	data.pcSite = true;
    }else{
    	data.pcSite = false;
    }
    if($('input[name=putIn-m]').is(':checked')){
    	data.mzSite = true;
    }else{
    	data.mzSite = false;
    }

    data.appUrl = $('.ace-thumbnails-APP .cboxElement').attr('href');
    data.mzUrl = $('.ace-thumbnails-M .cboxElement').attr('href');
    
    $.post("/cms/createArticle", data, function (result) {
        var result = eval('('+result+')');
        if (result.result) {
            alert('文章创建成功！');
            location.reload();
        } else {
            Notify('文章创建失败', 'top-right', '5000', 'danger', 'fa-check', false);
        }
    }).fail(function () {
        /*Notify('文章创建失败: 网络错误', 'top-right', '5000', 'danger', 'fa-check', false);*/
    });
});

/**
 * 更新文章内容
 */
$('#updateArticleBtn').click(function () {
    console.log($('input[name=timepicker]').val());
    var times = $('input[name=timepicker]').val().split(':');
    var data = {};
    data.id = editingArticle;
    data.newsId = $('input[name=artId]').val();
    data.title = $('input[name=artTitle]').val();
    data.titleKeyWords = $('input[name=artKeyWords]').val();
    data.titleDescription = $('input[name=artDescription]').val();
    data.titleImageUrl = $('input[name=artTitleImageUrl]').val();
    data.category = currChannel.data('category'); //$('select[name=artCategory] option:selected').val();

    if (data.category === 'HOMEPAGE' || data.category === 'IMAGE') {
        //data.content = $('#editor1').children(':first').attr('src');
        data.content = $('iframe.cke_wysiwyg_frame').contents().find('img').attr('src');
        console.log("image content", data.content);
    } else {
        //data.content = $('#editor1').html();
        data.content = CKEDITOR.instances.contentEditor.getData();
        console.log("text content", data.content);
    }
    data.hasImage = $('input[name=artHasImg]:checked').val();
    data.priority = $('input[name=artTop]:checked').val();
    data.place = $('input[name=artPlace]:checked').val();
    data.url = $('input[name=artUrl]').val();
    data.pubDate = $datePicker.val() + ' ' + times[0] + ':' + times[1];
    data.media = $('input[name=artMedia]').val();
    data.author = $('input[name=artAuthor]').val();
    data.seq = $('#seq').val();
    if($('input[name=putIn-app]').is(':checked')){
        data.appSite = true;
    }else{
        data.appSite = false;
    }
    if($('input[name=putIn-pc]').is(':checked')){
        data.pcSite = true;
    }else{
        data.pcSite = false;
    }
    if($('input[name=putIn-m]').is(':checked')){
        data.mzSite = true;
    }else{
        data.mzSite = false;
    }
    data.appUrl = $('.ace-thumbnails-APP .cboxElement').attr('href');
    data.mzUrl = $('.ace-thumbnails-M .cboxElement').attr('href');

    $.post("/cms/article/update", data, function (res) {
        var res = eval('('+res+')');
        if (res.success) {
            alert('文章修改成功！');
            location.reload();
        } else {
            alert('文章修改失败');
        }
    }).fail(function () {
        Notify('文章修改失败: 网络错误', 'top-right', '5000', 'danger', 'fa-check', false);
    });
});

// 打开创建文章面板
$('#openCreateArticleBtn').click(function () {
    $('input[name=artId]').val('');//art.id
    $('input[name=artTitle]').val('');
    $('input[name=artKeyWords]').val('');
    $('input[name=artDescription]').val('');
    $('input[name=artTitleImageUrl]').val('');
    $('#artContent').val('');
    $('input[name=artChannel]').val(currChannel.data('name'));
    $('select[name=artCategory] option[value=' + currChannel.data("category") + ']').prop('selected', true);

    if($('select[name=artCategory]').val()=='COVERAGE'||$('select[name=artCategory]').val()=='NEWS'
        ||$('select[name=artCategory]').val()=='PUBLICATION'||$('select[name=artCategory]').val()=='PROJECT'){
        $('.putIn-location').css('display','block');
    $('input[name=putIn-app]').prop('checked', false);
    $('input[name=putIn-pc]').prop('checked', false);
    $('input[name=putIn-m]').prop('checked', false);
    }
    else{
        $('.putIn-location').css('display','none');
    }
    $('.img-app').css('display','none');
    $('.img-m').css('display','none');

    $('input[name=artHasImg]').first().prop('checked', true);
    $('input[name=artTop]').first().prop('checked', true);
    $('#l_artPlace').prop('checked', false);
    $('#m_artPlace').prop('checked', false);
    $('#r_artPlace').prop('checked', false);
    if(currChannel.data("category")!='COVERAGE'){
        $("#artPlaceDiv").css("display","none");
    } else{
        $("#artPlaceDiv").css("display","block");
    }
    $('input[name=artUrl]').val('');
    var date = new Date();
    console.log(date);

    $('.date-picker').val( date.Format("yyyy-MM-dd"));
    $('input[name=timepicker]').val( date.getHours() + ':' + date.getMinutes());
    $('input[name=artMedia]').val('');
    $('input[name=artAuthor]').val('');
    CKEDITOR.instances.contentEditor.setData('');

    $('#updateArticleBtn').hide();
    $('#articleListPanel').hide();
    $('#createArticleBtn').show();
    $('#createArticlePanel').show();
});
$('#cancelCreateArticleBtn').click(function () {
    $('#createArticlePanel').hide();
    $('#articleListPanel').show();
});

$(document).ready(function () {
    // $('.accordion-body').first().addClass('in');
//    $('#editor1').ace_wysiwyg({
//        toolbar: [
//            'font',
//            null,
//            'fontSize',
//            null,
//            {name: 'bold', className: 'btn-info'},
//            {name: 'italic', className: 'btn-info'},
//            {name: 'strikethrough', className: 'btn-info'},
//            {name: 'underline', className: 'btn-info'},
//            null,
//            {name: 'insertunorderedlist', className: 'btn-success'},
//            {name: 'insertorderedlist', className: 'btn-success'},
//            {name: 'outdent', className: 'btn-purple'},
//            {name: 'indent', className: 'btn-purple'},
//            null,
//            {name: 'justifyleft', className: 'btn-primary'},
//            {name: 'justifycenter', className: 'btn-primary'},
//            {name: 'justifyright', className: 'btn-primary'},
//            {name: 'justifyfull', className: 'btn-inverse'},
//            null,
//            {name: 'createLink', className: 'btn-pink'},
//            {name: 'unlink', className: 'btn-pink'},
//            null,
//            {name: 'insertImage', className: 'btn-success'},
//            null,
//            'foreColor',
//            null,
//            {name: 'undo', className: 'btn-grey'},
//            {name: 'redo', className: 'btn-grey'}],
//        'wysiwyg': {
//            fileUploadError: function() {
//                alert('fileUploadError');
//            }
//        }
//    }).prev().addClass('wysiwyg-style2');

    $('textarea#contentEditor').ckeditor({});

    // 显示第一栏目内容
    $('a.accordion-toggle:first').trigger('click');
    $('.detailChannelLink:first').trigger('click');
});

var colorbox_params = {
    reposition: true,
    scalePhotos: true,
    scrolling: false,
    previous: '<i class="icon-arrow-left"></i>',
    next: '<i class="icon-arrow-right"></i>',
    close: '&times;',
    current: '{current} of {total}',
    maxWidth: '100%',
    maxHeight: '100%',
    photo: true,
    onOpen: function () {
        document.body.style.overflow = 'hidden';
    },
    onClosed: function () {
        document.body.style.overflow = 'auto';
    },
    onComplete: function () {
        $.colorbox.resize();
    }
};
//$.get('cms/getImages', function (imgs) {
//    for (var i = 0; i < imgs.totalSize; i++) {
//        var img = imgs.results[i];
//        var url = img.uri.replace(/(.png)|(.jpg)|(.jpeg)|(.gif)|(.bmp)|(.svg)/, '');
//        $($('#cbLiTemplate').html().replace('link2', url + '!1').replace('link1', url).replace('link3', url)).appendTo('.ace-thumbnails');
//    }
//    $('.ace-thumbnails [data-rel="colorbox"]').colorbox(colorbox_params);
//    var client = new ZeroClipboard($('.copyUrlBtn'));
//});
/**
 * 弹出图片选择按钮
 */
$('#uploadImageBtn').click(function () {
    $('#imageFileInput').click();
});

var files = null;
$('#imageFileInput').change(function (event) {
    //$('#imageFileInput').val()
    files = event.target.files;
    $('#uploadImageBtn').html('<i class="icon-spinner icon-spin"></i> 上传中..');
    $('form[name=uploadImageForm]').trigger('submit');
});

$('form[name=uploadImageForm]').on('submit', uploadImage);

/**
 * 弹出APP图片选择按钮
 */
$('#uploadImageBtn-APP').click(function () {
    $('#imageFileInput-APP').click();
});

var files = null;
$('#imageFileInput-APP').change(function (event) {
    //$('#imageFileInput').val()
    files = event.target.files;
    $('#uploadImageBtn-APP').html('<i class="icon-spinner icon-spin"></i> 上传中..');
    $('form[name=uploadImageForm-APP]').trigger('submit');
});

$('form[name=uploadImageForm-APP]').on('submit', uploadImageAPP);

/**
 * 弹出M站图片选择按钮
 */
$('#uploadImageBtn-M').click(function () {
    $('#imageFileInput-M').click();
});

var files = null;
$('#imageFileInput-M').change(function (event) {
    //$('#imageFileInput').val()
    files = event.target.files;
    $('#uploadImageBtn-M').html('<i class="icon-spinner icon-spin"></i> 上传中..');
    $('form[name=uploadImageForm-M]').trigger('submit');
});

$('form[name=uploadImageForm-M]').on('submit', uploadImageM);

/**
 * 上传图片
 * @param {type} event
 * @returns {undefined}
 */
function uploadImage(event) {
    event.stopPropagation();
    event.preventDefault();
    var data = new FormData();
    
    var channelId = $('input[name=channelId]').val();
    console.log(channelId+"****************************");
 
    $.each(files, function (index, file) {
        data.append("file", file);
        data.append("name", file.name);
        data.append("ownerId", channelId);
    });
    $.ajax({
        url: '/cms/uploadFile',
        data: data,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function (data) {
            var res = eval('('+data+')');
            $($('#cbLiTemplate').html().replace('link2', res.url + '!1').replace('link1',  res.url).replace('link3',  res.url)).appendTo('.ace-thumbnails-list');
            $('.ace-thumbnails-list [data-rel="colorbox"]').colorbox(colorbox_params);
            $('#uploadImageBtn').html('<i class="icon-plus-sign"></i> 上传图片');

            // 初始化复制URL按钮
            var client = new ZeroClipboard($('.copyUrlBtn'));
        }
    }).fail(function () {
        /*Notify('上传图片失败：网络错误', 'top-right', '5000', 'danger', 'fa-check', false);*/
    });
}

/**
 * 上传图片APP
 * @param {type} event
 * @returns {undefined}
 */
function uploadImageAPP(event) {
    event.stopPropagation();
    event.preventDefault();
    var data = new FormData();
    
    var channelId = $('input[name=channelId]').val();
    console.log(channelId+"****************************");
 
    $.each(files, function (index, file) {
        data.append("file", file);
        data.append("name", file.name);
        data.append("ownerId", channelId);
    });
    $.ajax({
        url: '/cms/uploadFile',
        data: data,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function (data) {
            var res = eval('('+data+')');
            $($('#cbLiTemplateAPP').html().replace('link2', res.url + '!1').replace('link1',  res.url).replace('link3',  res.url)).appendTo('.ace-thumbnails-APP');
            $('.ace-thumbnails-APP [data-rel="colorbox"]').colorbox(colorbox_params);
            $('#uploadImageBtn-APP').html('<i class="icon-plus-sign"></i> 上传图片');

            // 初始化复制URL按钮
            var client = new ZeroClipboard($('.copyUrlBtn'));
            $('#uploadImageBtn-APP').css('display','none');
        }
    }).fail(function () {
        /*Notify('上传图片失败：网络错误', 'top-right', '5000', 'danger', 'fa-check', false);*/
    });
}
/**
 * 上传图片M
 * @param {type} event
 * @returns {undefined}
 */
function uploadImageM(event) {
    event.stopPropagation();
    event.preventDefault();
    var data = new FormData();
    
    var channelId = $('input[name=channelId]').val();
    console.log(channelId+"****************************");
 
    $.each(files, function (index, file) {
        data.append("file", file);
        data.append("name", file.name);
        data.append("ownerId", channelId);
    });
    $.ajax({
        url: '/cms/uploadFile',
        data: data,
        processData: false,
        contentType: false,
        type: 'POST',
        success: function (data) {
            var res = eval('('+data+')');
            $($('#cbLiTemplateM').html().replace('link2', res.url + '!1').replace('link1',  res.url).replace('link3',  res.url)).appendTo('.ace-thumbnails-M');
            $('.ace-thumbnails-M [data-rel="colorbox"]').colorbox(colorbox_params);
            $('#uploadImageBtn-M').html('<i class="icon-plus-sign"></i> 上传图片');

            // 初始化复制URL按钮
            var client = new ZeroClipboard($('.copyUrlBtn'));
            $('#uploadImageBtn-M').css('display','none');
        }
    }).fail(function () {
        /*Notify('上传图片失败：网络错误', 'top-right', '5000', 'danger', 'fa-check', false);*/
    });
}

function getArticlePlace(place){
    var data= {};
    data.articlePlace=place;
    $.get("/cms/article/getArticlePlace", data, function (res) {
        var res = eval('('+res+')');
        if (!res.success) {
            if(!confirm("这个位置已经有文章了，是否覆盖?")){
                $('#l_artPlace').prop('checked', false);
                $('#m_artPlace').prop('checked', false);
                $('#r_artPlace').prop('checked', false);
            }
        }
    });
}
