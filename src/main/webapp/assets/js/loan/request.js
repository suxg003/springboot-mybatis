
var CD = function(){
    this.documents;
    this.certificates;
    this.certificateTypeWeights;
    this.type;
    this.isFirstType=true;
};
CD.prototype.showFile = function(type){
    slider = cd.slider;
    while (slider.slides.length > 0) {
        slider.removeSlide(0);
    }
    $.each(cd.documents[type].images, function (k, v) {
        slider.appendSlide('<img class="rsImg" src="' + v.uri + '" data-rsTmb="' + v.uri + '!1" data-pid="' + v.proofId + '" data-name="' + v.name + '" alt="' + v.caption + '" data-cover="' + v.isCover + '" />');
    });
    if (slider.slides.length > 0) {
        $('.rsGCaption').text(slider.slides[0].caption).show();
        $('.rsFullscreenBtn').show();
    } else {
        $('.rsGCaption').hide();
        $('.rsFullscreenBtn').hide();
    }
    $('#fileContainer').html('');
    $.each(cd.documents[type].files, function (k, v) {
        var link = v.uploader !== '用户本人' ? 'employee/' + v.uploaderId : 'user/' + CC.requestId;
        var file = $('#docTemplate').html().replace('$name', v.name)
            .replace('$downloadLink', v.uri).replace('$uri', v.uri)
            .replace('$link', link)
            .replace('$uploader', v.uploader)
            .replace('$submitTime', new Date(v.submitTime)
                .Format("yyyy-MM-dd hh:mm"));
        if (v.uri.indexOf('.pdf') === -1)
            file = file.replace('$icon', 'file_doc');
        else
            file = file.replace('$icon', 'file_pdf');
        $(file).appendTo($('#fileContainer'));
    });
};
CD.prototype.rencerUploadHistory = function(data){
    var historyStr='';
    var list = data.IMAGE;
    if(list <= 0){
        historyStr+='暂无数据'
    }
    for(var i=0;i<list.length;i++){

        historyStr+= '<div class="profile-activity clearfix">\
                        <div>\
                        <div style="margin-bottom:5px;line-height:22px;">';
                        if(list[i].empId==''){
                            historyStr += '<a href="/user/profile/'+CC.user.id+'" target="_blank">'+list[i].uploader+ '</a>'
                        }else{
                            historyStr += '<a href="/employee/profile/'+list[i].empId+'" target="_blank">'+list[i].uploader+ '</a>'
                        }
             historyStr += '上传了图片<a href="'+list[i].uri+'">'+list[i].coreFile.fileName+'</a>\
                        <div class="time"><i class="fa fa-clock bigger-110"></i>'+new Date(list[i].coreFile.submitTime).Format('yyyy-M-d h:m:s')+'</div>\
                        </div></div>';

    }

    $('#uploadHistory').html(historyStr);

};
CD.prototype.rencerActivity = function(data){
    var activityStr = '';
    if(data.length <= 0){
        activityStr+='暂无数据'
    }
    for(var i=0; i<data.length;i++){
        activityStr += '<div class="profile-activity clearfix">'
        +'<div>'+data[i].operationTypeKey+'<span class="blue">'+data[i].description+'</span>'
        +'<div class="time"><i class="fa fa-clock-o bigger-110"></i>'+new Date(data[i].recordTime).Format('yyyy-M-d h:m:s')+'</div></div></div>'
    }
    $('#approvalHistory').html(activityStr);
};

var cd = new CD();

function initCDPage(){
    var currentType = null;
    $('#publishNow').bind('click', function(){
        if($(this).prop('checked'))
            $('#publishSchedule').prop('checked', false);
    });

    $('#publishSchedule').bind('click', function(){
        if($(this).prop('checked'))
            $('#publishNow').prop('checked', false);
    });

    $('#timeOpen').datetimepicker({
        format:'YYYY-MM-DD HH:mm'
    });
    showSCData();
    uploadFile();
    uploadLocalImg();
    uploadCammeraImg();
    initDataOther();


}

function showSCData(){
    var loanId = $('body').attr('data-loanid');
    $.ajax({
        type: "GET",
        url: "/loan/getloan/1/" + loanId,
        data: {},
        dataType: "json",
        success: function (data) {
            $('.royalSlider').attr('data-isFirst','true');
            cd.documents = data.documents;
            cd.certificates = data.certificates;
            cd.certificateTypeWeights = data.certificateTypeWeights;

            renderMain(data);

            cd.rencerUploadHistory(data.proofHistory);

            cd.rencerActivity(data.activitys);
        }
    })
}

function submitForm(approve) {
    if(approve==1&&(!$("#publishNow").is(':checked'))&&(!$("#publishSchedule").is(':checked'))){
        alert("立即发布或预告发布必须选中一项");
        return;
    }

    var action = $("#approvalForm").attr('action');
    
    if(!approve){
        if(!confirm('确认保存？')) return;
        $("#approvalForm").attr('action', action.replace(/reject/i,'approve'));
    }
    else if(approve==1){
        if(!confirm('确认批准发布？')) return;
        $("#approvalForm").attr('action', action.replace(/reject/i,'approve'));
    }
    else if(approve==2){
        if(!confirm('确认拒绝发布？')) return;
        $("#approvalForm").attr('action', action.replace(/approve/i,'reject'));
    }
    $.post($("#approvalForm").attr('action'), $("#approvalForm").serialize(), function(data) {
        var res= jQuery.parseJSON(data);
        alert(res.message);
        if(approve==2){
            location.href="/loan/loanList/8";
        }else if($("#publishNow").is(':checked')){
            location.href="/loan/loanList/0";
        }else{
            location.href="/loan/loanList/2";
        }
    });
}


function showShenHeList(){
    var $tabsWrap = $(".tabs-wrap");
    var $tabsContent = $(".tabs-content");
    var $arrowLeft = $(".tabs-arrow-left");
    var $arrowRight = $(".tabs-arrow-right");

    var totalWidth = 0;
    $("#shenheList li").each(function () {
        totalWidth += $(this).width();
    });

    $tabsContent.width(totalWidth);

    var resetArrow = function () {
        if (totalWidth > $tabsWrap.width()) {
            $arrowRight.show();
        } else {
            $arrowRight.hide();
        }
    };
    resetArrow();

    $(window).resize(function () {
        resetArrow();
    });

    // tabs-arrow-left
    $arrowLeft.click(function () {
        $tabsContent.css({
            left: 0
        });
        $arrowRight.show();
        $arrowLeft.hide();
    });

    // tabs-arrow-right
    $arrowRight.click(function () {
        $tabsContent.css({
            left: -(($tabsWrap.width()) - $arrowRight.width())
        });
        $arrowLeft.show();
        $arrowRight.hide();
    });

}
function initDataOther() {
    $('#shenheList li:first-child').addClass('active');
    $('#uploadHistory').slimScroll({
        height: '400px',
        alwaysVisible: true
    });
    $('#approvalHistory').slimScroll({
        height: '400px',
        alwaysVisible: true
    });
    $('#fileContainer').slimScroll({
        height: '350px',
        alwaysVisible: true
    });
    $('#loanRequestToolbar').width($('#page-content').width());
    moment.lang('zh-cn', {
        months: "一月_二月_三月_四月_五月_六月_七月_八月_九月_十月_十一月_十二月".split("_"),
        monthsShort: "1月_2月_3月_4月_5月_6月_7月_8月_9月_10月_11月_12月".split("_")
    });
  /*  $.fn.editable.defaults.mode = 'inline'
    $.fn.editable.defaults.placement = 'top';
    $.fn.editable.defaults.emptytext = '未填写';
    $.fn.editableform.loading = "<div class='editableform-loading'><i class='light-blue icon-2x icon-spinner icon-spin'></i></div>";
    $.fn.editableform.buttons = '<button type="submit" class="btn btn-info editable-submit"><i class="icon-ok icon-white"></i></button><button type="button" class="btn editable-cancel"><i class="icon-remove"></i></button>';*/
    var date = (new Date()).Format("yyyy 年 MM 月 dd 日 hh : mm");
    /*$('#taskTime').editable({
        value: date,
        combodate: {
            minYear: 2013,
            maxYear: 2015,
            value: new Date()
        }
    });
    $('#taskAddress').editable({value: '西直门外大街18号金贸大厦A座1627'});
    $('.editable').editable({});*/
    $('.easy-pie-chart.percentage').each(function () {
        $(this).easyPieChart({
            barColor: $(this).data('color'),
            trackColor: '#EEEEEE',
            scaleColor: false,
            lineCap: 'butt',
            lineWidth: 8,
            animate: 1000,
            size: 70
        }).css('color', $(this).data('color'));
    });
    $('#checkAllType').change(function () {
        if ($(this).prop('checked')) {
            $('.certificateType').prop('checked', true);
        } else {
            $('.certificateType').prop('checked', false);
        }
    });
    $('.certificateType').change(function () {
        if (!$(this).prop('checked')) {
            $('#checkAllType').prop('checked', false);
        } else {
            var flag = true;
            $('.certificateType').each(function () {
                if (!$(this).prop('checked')) {
                    flag = false;
                }
            });
            if (flag) {
                $('#checkAllType').prop('checked', true);
            }
        }
    });

    var listPage = "loan/request/list";

    $('#doAssign').click(function () {
        var params = {
            'description': $('#loanRequestApprovalDescription').val(),
            'location': $('#taskAddress').text(),
            'startTime': new Date(),
            'simpleTask': $('#simpleTask').prop('checked') ? 'false' : 'true',
            'empId': $('select[name=reporter] option:checked').val()
        };
        var certifications = [];
        $('input[name=certificateType]:checked').each(function () {
            certifications.push($(this).val());
        });
        params['certifications'] = certifications.toString();
        //console.log(params);
        $.post("loan/request/assign/" + CC.requestId, params, function () { // callback
            window.location.href = "loan/request/list";
        });
    });
    $('#cancelBtn').click(function () {
        window.location.href = listPage;
    });
    $(window).resize(function () {
        $('#loanRequestToolbar').width($('#page-content').width());
    });

}

/////////////////////////////////////////////////////////////////////////////////////////
// 上传材料
/////////////////////////////////////////////////////////////////////////////////////////

function uploadFile(){
    var uploadFileInput = $('#uploadFileInput').ace_file_input({
        style: 'well',
        btn_choose: '拖动文件到此处或点击上传（支持批量上传）',
        btn_change: null,
        no_icon: 'icon-upload-alt',
        droppable: true,
        thumbnail: 'small',
        icon_remove: null,
//                    whitelist: 'gif|png|jpg|jpeg',
//                    backlist: 'exe|php',
        preview_error: function (filename, error_code) {
        }
    }).on('change', function () {
        $('#uploadFileBtn').prop('disabled', false);
        //$('#clearUploadFileBtn').prop('disabled', false);
    });

    function resetFileUploader() {
        uploadFileInput.data('ace_file_input').reset_input();
        $('#fileDescription').val('');
        $('#uploadFilePanel option').first().prop('selected', true);
        $('#uploadFileBtn').prop('disabled', true);
        //$('#clearUploadFileBtn').prop('disabled', true);
    }

    $('#uploadFilePanel').on('show.bs.modal', function () {
        $('#uploadFileMasker').hide();
        //resetFileUploader();
    });
    //aceInput = aceInput.data('ace_file_input');

    $('#clearUploadFileBtn').click(function () {
        resetFileUploader();
    });
    $('#uploadFileBtn').click(function () {
        $('#uploadFileMasker').show();
        var files = uploadFileInput.data('ace_input_files');
        $.each(files, function (index, file) {
            var formData = new FormData();
            formData.append("file", file);
            formData.append("fileName", file.name);
            formData.append("type", $("#uploadFilePanel option:selected").val());
            formData.append("description", $.trim($('#fileDescription').val()));
            formData.append("userId", $('#user').data('id'));
            //console.log(formData);

            $.ajax({
                url: 'loan/uploadFile/' + CC.requestId,
                data: formData,
                processData: false,
                contentType: false,
                type: 'POST',
                success: function (data) {
                    Notify('上传成功', 'top-right', '5000', 'success', 'fa-check', true);
                    // showCCAlert("上传成功！", true);
                }
            }).fail(function () {
                $('#uploadFileMasker').hide();
                $('#uploadFilePanel').modal('hide');
                //showCCAlert("上传失败！", false);
                Notify('上传失败', 'top-right', '5000', 'danger', 'fa-check', true);
            });
        });
    });
}


/////////////////////////////////////////////////////////////////////////////////////////
// 本地上传照片
/////////////////////////////////////////////////////////////////////////////////////////
function uploadLocalImg(){
    var aceInput = $('#uploadImageLocalInput').ace_file_input({
        style: 'well',
        btn_choose: '拖动图片到此处或点击上传（支持批量上传）',
        btn_change: null,
        no_icon: 'icon-upload-alt',
        droppable: true,
        thumbnail: 'small',
        icon_remove: null,
        whitelist: 'gif|png|jpg|jpeg',
        backlist: 'exe|php',
        preview_error: function (filename, error_code) {
        }
    }).on('change', function () {
        $('#saveFileBtn').prop('disabled', false);
        //$('#clearFileBtn').prop('disabled', false);
    });

    function resetImageUploader() {
        aceInput.data('ace_file_input').reset_input();
        $('#imageDescription2').val('');
        $('#certificateType2 option').first().prop('selected', true);
        $('input[name=if_mosaic]').first().prop('checked', true);
        $('#saveFileBtn').prop('disabled', true);
        //$('#clearFileBtn').prop('disabled', true);
    }

    $('#uploadLocally').on('show.bs.modal', function () {
        $('#fileMasker').hide();
        resetImageUploader();
    });

    $('#clearFileBtn').click(function () {
        resetImageUploader();
    });
    $('#saveFileBtn').click(function () {
        $('#fileMasker').show();
        var files = aceInput.data('ace_input_files');
        var files_length = files.length;
        var loanRequestId = $('#loanRequestId').val();
        var count = 0;
        $.each(files, function (index, file) {
            var formData = new FormData();
            formData.append("image", file);
            formData.append("imageName", file.name);
            formData.append("loanRequestId", loanRequestId);
            formData.append("type", $("#certificateType2 option:selected").val());
            formData.append("description", $.trim($('#imageDescription2').val()));
            formData.append("userId", $('#userId').val());
            formData.append("score",$('#score').val());
            //console.log(formData);

            $.ajax({
                url: '/loan/uploadImage/',
                data: formData,
                processData: false,
                contentType: false,
                type: 'POST',
                success: function (data) {
                    count++;
                    if(count === files_length){
                        Notify('上传成功', 'top-right', '5000', 'success', 'fa-check', true);
                        resetImageUploader();
                        $('#localFilePanel').modal('hide');
                        $('#fileMasker').remove();
                        cd.type = formData.type;
                        cd.isFirstType = false;
                        showSCData()
                    }
                }
            }).fail(function () {
                Notify('上传失败', 'top-right', '5000', 'danger', 'fa-check', true);
                $('#localFilePanel').modal('hide');
                $('#fileMasker').hide();
            });
        });
    });
}


/////////////////////////////////////////////////////////////////////////////////////////
// 拍照上传
/////////////////////////////////////////////////////////////////////////////////////////
function uploadCammeraImg(){
    var canvas, context, video, videoObj, dataURL, errBack;
    canvas = document.getElementById("canvas");
    context = canvas.getContext("2d");
    video = document.getElementById("video");
    videoObj = {"video": true};
    errBack = function (error) {
        alert("Video capture error: " + error.code);
    };
    navigator.getMedia = (
    navigator.getUserMedia ||
    navigator.webkitGetUserMedia ||
    navigator.mozGetUserMedia ||
    navigator.msGetUserMedia
    );
    $('#uploadWithCamera').click(function () {
        $('#step2').hide();
        $('#step3').hide();
        $('#step1').show();
        $('#imageName').val("");
        $('#imageDescription').val("");
        $('#mosaicRadios1').prop('checked', true);
        $('.control-group').removeClass('error warning success');
        $('.help-block').html('');
        if (video.src === '') {
            navigator.getMedia(videoObj, function (localMediaStream) {
                video.src = window.URL.createObjectURL(localMediaStream);
                video.play();
                $('#captureBtn').show();
            }, errBack);
        }
    });
    $('#snapImage').click(function () {
        context.drawImage(video, 0, 0, 960, 720);
        dataURL = canvas.toDataURL();
        document.getElementById('tupian').src = dataURL;
        document.getElementById('tupian-small').src = dataURL;
        $('#step1').hide();
        $('#step2').show();
    });
    $('#chongpai').click(function () {
        $('#step2').hide();
        $('#step1').show();
    });
    $('#saveImageBtn').click(function () {
        $('#step2').hide();
        $('#step3').show();
    });
    $('#cancelUploadImageBtn').click(function () {
        $('#cameraPanel').modal('hide');
    });
    $('#hideAssignTaskPanelBtn').click(function () {
        $('#assignPanel').modal('hide');
    });
    $('#uploadImageBtn').click(function () {
        $('.perform-validate').trigger("submit.validation");
        if ($('#cameraPanel .control-group').hasClass("warning") || $('#cameraPanel .control-group').hasClass("error")) {
            return;
        }
        $('#imageMasker').show();
        $.ajax({
            type: "POST",
            url: "/loan/uploadImage/" + CC.requestId,
            enctype: "multipart/form-data",
            data: {
                "image": e.target.result,
                "imageName": file.name,
                "description": $.trim($('#imageDescription2').val()),
                "mosaic": $('input[name=if_mosaic]:checked').val(),
                "type": $("#certificateType2 option:selected").val(),
                "userId": $('#user').data('id')
            },
            dataType: "json",
            success: function (data) {
                if(data.result){

                    console.log('3333');
                    $('#loanTabs li').removeClass('active');
                    $('#loanTabs li:eq(3)').addClass('active');
                    $('#loanDetails div').hide();
                    $('#loanDetails div:eq(3)').show();
                }

            }
        });
        /*$.post("loan/uploadImage/" + CC.requestId, {
         "image": dataURL,
         "imageName": $.trim($('#imageName').val()),
         "description": $.trim($('#imageDescription').val()),
         "mosaic": $('input[name=mosaic]:checked').val(),
         "type": $("#certificateType option:selected").val(),
         "userId": $('#user').data('id')
         }, function(newImage) {
         $('#imageMasker').hide();
         var slider = $(".royalSlider").data('royalSlider');
         //slider.appendSlide('<img class="rsImg" src="' + newImage.uri + '" data-rsTmb="' + newImage.uri + '" alt="' + newImage.imageName + '" />');
         alert("上传成功！");
         $('#cameraPanel').modal('hide');
         }).fail(function() {
         $('#imageMasker').hide();
         alert("上传失败！");
         });*/
    });
}

function renderMain(data){
    var documents = cd.documents;
    var certificates = cd.certificates;
    var weights = cd.certificateTypeWeights;
    function setCertificate(type) {
        $('input.pingfen-input').val(certificates[type].score);
        $('#auditInfo').val(certificates[type].auditInfo);
        var w = weights[type];
        $('#typeWeight').html(parseFloat(w) * 100);

        var status = certificates[type].status === 'CHECKED' ? true : false;
        if (status) {
            $('input.certificateStatusRadio[value=true]').prop('checked', true);
            $("#auditInfo").hide();
        } else {
            $('input.certificateStatusRadio[value=false]').prop('checked', true);
            $("#auditInfo").show();
        }
    }
    //console.log(weights);
    //console.log(documents);
    //console.log(certificates);

    function getTotalScore() {
        var sum = 0, totalWeights = 0;
        for (var type in weights) {
            sum += parseFloat(weights[type]) * parseFloat(certificates[type].score);
            totalWeights += parseFloat(weights[type]);
        }
        var total = (sum / totalWeights).toFixed(1);
        return isNaN(total) ? 0 : total;
    }

    $('#totalScore').text(getTotalScore());
    $('#shenheList li').each(function () {
        var type = $(this).data('type');

        $(this).find('.score').text('(' + certificates[type].score + '分)');
        if (certificates[type].status === 'CHECKED') {
            $(this).find('.status').html('<i class="fa fa-check-circle green bigger-110"></i>');
        } else if (certificates[type].status === 'DENIED') {
            $(this).find('.status').html('<i class="fa fa-times-circle red bigger-110"></i>');
        }
        $(this).find('.picNum').text(documents[type].images.length);
        $(this).find('.docNum').text(documents[type].files.length);
    });
    if(cd.isFirstType){
        cd.type = $('#shenheList li:first').data('type');
    }



    $('#certificateName').text($('#shenheList li:first').data('key'));
    $('#fileContainer').html('');




    cd.slider = $(".royalSlider").data('royalSlider');
    cd.currImg = cd.slider.currSlideId;
    cd.showFile(cd.type);

    slider.ev.on('rsEnterFullscreen', function () {
        $('#sliderContainer').css('z-index', 10000);
        $('#certificationContent').css('z-index', 100000).css('overflow', 'visible');
    });
    slider.ev.on('rsExitFullscreen', function () {
        $('#sliderContainer').css('z-index', 11);
        $('#certificationContent').css('z-index', 11).css('overflow', 'auto');
    });
    slider.ev.on('rsAfterSlideChange', function (event) {
        currImg = slider.currSlideId;
    });

    //setCertificate(firstTabType);
   // showFile(firstTabType);

// 显示封面icon
    slider.ev.on('rsAfterContentSet', function (e, slideObject) {
        var isCover = $(slideObject.content[0]).data("cover");
        if (isCover === true) {
            var $thumb = $(".rsNav img[src='" + slideObject.image + "!1']");
            if ($thumb.length > 0) {
                var $thubm_icon = $thumb.parent().find("span");
                $thubm_icon.html('<i class="icon-picture green"></i>');
                $thubm_icon.attr("title", "该图已设置为标封面");
                $thubm_icon.show();
            }
        }
    });

    function showConfirm (str,strHref){
        bootbox.confirm(str, function (result) {
            if (result) {
                var pid = slider.currSlide.content.data('pid');
                var imageName = slider.currSlide.content.data('name');
                $.get(strHref + pid, {name: imageName}, function (res) {
                    hideCCconfirm();
                    if (res) {
                        alert('【 ' + imageName + ' 】删除成功 !');
                        //location.reload();
                    } else {
                        alert('【 ' + imageName + ' 】删除失败 !');
                    }
                }).fail(function () {
                    hideCCconfirm();
                    alert('网络传输错误 !', false);
                });
                /*//return false;
                 $.ajax({
                 url:strHref,
                 type:"POST",
                 dataType:"JSON",
                 data:{},
                 success:function(data) {
                 console.log(data.success);

                 if (data.success == '1')
                 location.reload();
                 else
                 Notify( data.comment, 'top-right', '5000', 'danger', 'fa-check', true);
                 }
                 });*/
            }
        });
    }

    $('.cc-alert-success-btn').click(function () {
        //location.reload();
    });
    $('.cc-alert-failed-btn').click(function () {
        hideCCAlert();
    });
    $('.cc-confirm-ok-btn').click(function () {
        var pid = slider.currSlide.content.data('pid');
        var imageName = slider.currSlide.content.data('name');
        $.get("loan/deleteProof/" + pid, {name: imageName}, function (res) {
            hideCCconfirm();
            if (res) {
                showCCAlert('【 ' + imageName + ' 】删除成功 !', true);
            } else {
                showCCAlert('【 ' + imageName + ' 】删除失败 !', false);
            }
        }).fail(function () {
            hideCCconfirm();
            showCCAlert('网络传输错误 !', false);
        });
    });
    $('.cc-confirm-cancel-btn').click(function () {
        hideCCconfirm();
    });

// 设为封面
    $("#setCoverBtn").click(function () {
        var imageName = slider.currSlide.content.data('name');
        var pid = slider.currSlide.content.data('pid');



        if (confirm("确定把【 " + imageName + " 】设为封面？")) {
            var url = "/loan/setCover/" + CC.user.id + "/" + pid + "/" + CC.requestId;
            $.post(url, function (o) {
                alert("设置成功");
                //location.reload();
            });
        }
    });

    /**
     * 删除认证图片
     */
    $('#deleteImageBtn').click(function () {

        var imageName = slider.currSlide.content.data('name');
        showConfirm("确定要删除【 " + imageName + " 】吗？",'/loan/deleteProof/');
    });

    /**
     * 切换认证项标签页
     */
    $('#shenheList li').click(function () {
        var type = $(this).data('type');
        // 根据标签预设认证类型
        var key = $(this).data('key');
        $('select[name=certificateType] optgroup[label=' + key + '] ').each(function () {
            $(this).children().first().prop('selected', true);
        });
        $('select[name=certificateType2] optgroup[label=' + key + '] ').each(function () {
            $(this).children().first().prop('selected', true);
        });
        $('#certificateName').text($(this).data('key'));
        setCertificate(type);
        cd.showFile(type);
    });
    /*window.showFile = function(type) {
        while (slider.slides.length > 0) {
            slider.removeSlide(0);
        }
        $.each(documents[type].images, function (k, v) {
            slider.appendSlide('<img class="rsImg" src="' + v.uri + '" data-rsTmb="' + v.uri + '!1" data-pid="' + v.proofId + '" data-name="' + v.name + '" alt="' + v.caption + '" data-cover="' + v.isCover + '" />');
        });
        if (slider.slides.length > 0) {
            $('.rsGCaption').text(slider.slides[0].caption).show();
            $('.rsFullscreenBtn').show();
        } else {
            $('.rsGCaption').hide();
            $('.rsFullscreenBtn').hide();
        }
        $('#fileContainer').html('');
        $.each(documents[type].files, function (k, v) {
            var link = v.uploader !== '用户本人' ? 'employee/' + v.uploaderId : 'user/' + CC.requestId;
            var file = $('#docTemplate').html().replace('$name', v.name)
                .replace('$downloadLink', v.uri).replace('$uri', v.uri)
                .replace('$link', link)
                .replace('$uploader', v.uploader)
                .replace('$submitTime', new Date(v.submitTime)
                    .Format("yyyy-MM-dd hh:mm"));
            if (v.uri.indexOf('.pdf') === -1)
                file = file.replace('$icon', 'file_doc');
            else
                file = file.replace('$icon', 'file_pdf');
            $(file).appendTo($('#fileContainer'));
        });
    }*/
// 显示/隐藏审核拒绝理由输入框
    $('input[name=shenhe-radio]').click(function () {
        if ($(this).val() == 'false') {
            $("#auditInfo").show();
        } else {
            $("#auditInfo").hide();
        }
    });
    $('#updateCertificateBtn').click(function () {
        var type = $('#shenheList li.active').data('type');
        var score = $('input.pingfen-input').val();
        var shenhe = $('input[name=shenhe-radio]:checked').val();
        var uid = $('#userId').val();
        var url = "/loan/updateCertificate";
        var self = $(this);
        $(this).html('正在保存').prop('disabled', true);

        //计算总分
        var totalScore = weights[type] * certificates[type].score;
        for (var t in weights) {
            if (t != type) {
                var w = weights[t], s = certificates[t].score;
                totalScore += w * s;
            }
        }
        $.post(url, {
            'userId': uid,
            'score': score,
            'totalScore': parseInt(totalScore.toFixed(0)),
            'shenhe': shenhe,
            'auditInfo': $("#auditInfo").val(),
            'type': type
        }, function (res) {
            var rest = eval('('+res+')');
            self.html('保存修改').prop('disabled', false);
            if (!rest) {
                Notify('保存失败', 'top-right', '5000', 'danger', 'fa-check', true);
            } else {

                Notify('保存成功', 'top-right', '5000', 'success', 'fa-check', true);
                certificates[type].score = score;
                certificates[type].status = shenhe === 'true' ? 'CHECKED' : 'DENIED';
                // 更新信用评分
                $('#creditScore').text(totalScore);
                // 更新信用等级
                if (totalScore < 50) {
                    $("#creditRank").html("HR");
                } else if (totalScore < 59) {
                    $("#creditRank").html("E");
                } else if (totalScore < 69) {
                    $("#creditRank").html("D");
                } else if (totalScore < 79) {
                    $("#creditRank").html("C");
                } else if (totalScore < 89) {
                    $("#creditRank").html("B");
                } else if (totalScore < 99) {
                    $("#creditRank").html("A");
                } else {
                    $("#creditRank").html("AA");
                }
                //$('#totalScore').text(getTotalScore());
            }
        });
    });

    $('input.pingfen-input').tooltip({
        'content': '分数在0-100之间',
        'placement': 'top'
    });
    $('input.pingfen-input').focusin(function () {
        $('input.pingfen-input').tooltip('show');
    });
    $('input.pingfen-input').focusout(function () {
        $('input.pingfen-input').tooltip('hide');
    });

    /**
     *  初始化提示层
     */
    var yf = $('.yellow_fadeout');
    function showYellow(text) {
        yf.text(text).css('margin-left', -yf.width() / 2 + 'px').show().fadeOut(1500);
    }

    $('#changeLoanRequestLink').click(function () {
        $('#changeLoanRequestPanel').modal({'backdrop': 'static'});
    });
    showShenHeList();
}


