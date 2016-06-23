/**
 * Created by meng on 2015/7/5.
 */
$(function() {
    $('#notificationList').dataTable({
        "iDisplayLength": 25,
        "aaSorting": [[2, 'desc']],
        "oLanguage": {
            "sLengthMenu": "显示 _MENU_ 条记录",
            "sSearch": "搜索:",
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

});

$('.templateItem').click(function() {

    $('.templateItem').removeClass('active');
    $(this).addClass('active');
    var url = 'template/' + $(this).data('id');
    $('#pdfIFrame').attr('src', url);
});
$('.templateItem').first().trigger('click');

$('#cancelFileBtn').click(function() {
    $('#localFilePanel').modal('hide');
});

$('.set-default-link').click(function(e) {
    e.stopPropagation();
    $.get('/contract/setDefault/' + $(this).data('id'), function(data) {
    	var info = jQuery.parseJSON(data);
    	console.log('setDefault/' + $(this).data('id'));
    	console.log(this);
        if(info && info.success === 1){
            alert('设置默认模板成功！');
            location.reload();
        }
    }).fail(function() {
        alert('设置默认模板失败！');
    });
});
$('.delete-template-link').click(function(e) {
	if(confirm('确实要删除该内容吗?')){
		 e.stopPropagation();
		    $.get('/contract/delete/' + $(this).data('id'), function() {
		        alert('删除模板成功！');
		        location.reload();
		    }).fail(function() {
		        alert('删除模板失败！');
		    });
	}
});
$('#reloadPage').click(function() {
    location.reload();
});
$('#uploadTemplateBtn').click(function() {
    bootbox.dialog({
        message: $('#localFilePanel').html(),
        title: "上传模板",
        className: "modal-darkorange"
    });
    /////////////////////////////////////////////////////////////////////////////////////////
    // 本地上传模板
    /////////////////////////////////////////////////////////////////////////////////////////

    var aceInput = $('#uploadTemplateInput').ace_file_input({
        style: 'well',
        btn_choose: '拖动文件到此处或点击上传',
        btn_change: null,
        no_icon: 'fa fa-upload',
        droppable: true,
        thumbnail: 'small',
        icon_remove: null,
        whitelist: 'pdf',
        backlist: 'exe|php',
        preview_error: function(filename, error_code) {}
    }).on('change', function() {
        $('#saveFileBtn').prop('disabled', false);
        var template = aceInput.data('ace_input_files')[0];
        $('#templateName').val(template.name.replace('.pdf', ''));
    });
    function resetUploader() {
        aceInput.data('ace_file_input').reset_input();
        $('#templateName').val('');
        $('#saveFileBtn').prop('disabled', true);
    }
    $('#localFilePanel').on('show.bs.modal', function() {
        $('#fileMasker').hide();
        resetUploader();
    });

    $('#saveFileBtn').click(function() {
        $('#fileMasker').show();
        var files = aceInput.data('ace_input_files');
        $.each(files, function(index, file) {
            var formData = new FormData();
            formData.append("file", file);
            formData.append("name", $('#templateName').val().trim());
            var checkName = $('#templateName').val().trim();
            if(checkName!=''){
            	$.ajax({
                    url: '/contract/uploadTemplate',
                    data: formData,
                    processData: false,
                    contentType: false,
                    type: 'POST',
                    success: function(data) {
                        var data = JSON.parse(data);
                        if(data.success=='0'){
                        	alert(data.comment);
                        }
                        if(data.success=='1'){
                        	$('#uploadFileMasker').hide();
                        	alert(data.comment);
                        	location.reload();
                        }
                        
                    }
                }).fail(function() {
                    $('#fileMasker').hide();
                    alert("上传失败！");
                });
            }else{
            	alert("模板名称不能为空！");
            }
            
            
            //if (file.type.indexOf('image') == 0)
        });
    });
});