$('.cc-alert-failed-btn,.cc-alert-success-btn').click(function () {
    hideCCAlert();    
});
$('.cc-alert-success-btn').click(function () {
	location.reload(); 
});

var aceInput = $('#uploadFileInput').ace_file_input({
    style: 'well',
    btn_choose: '拖动文件到此处或点击上传（支持批量上传）',
    btn_change: null,
    no_icon: 'fa fa-upload',
    droppable: true,
    thumbnail: 'small',
    icon_remove: null,
    whitelist: 'csv|xls|xlsx',
    backlist: 'exe|php',
    preview_error: function (filename, error_code) {
    }
}).on('change', function () {
    $('#saveFileBtn').prop('disabled', false);
});

$('#saveFileBtn').click(function(){
	var files = aceInput.data('ace_input_files');
	if (!files) {
		//showCCAlert("请上传文件！", false);
		return false;
	}
    var files_length = files.length;
    var count = 0;
    $.each(files, function (index, file) {    	
    	var formData = new FormData();
        formData.append("file", file);
        //formData.append("fileName", file.name);
        $.ajax({
            url: '/withdraw/importFile',
            data: formData,
            processData: false,
            contentType: false,
            type: 'POST',
            success: function (dataTmp) {
            	var data = eval("(" + dataTmp + ")");
            	bootbox.dialog({
                     message: data.comment,
                     title: "提示信息",
                     className: ""
                });
            }
        }).fail(function () {            
        	 $('.btn-reset').click();
             bootbox.dialog({
                 message: "导入数据失败，请检查是否符合规范！",
                 title: "提示信息",
                 className: ""
             });
        });
    });
});