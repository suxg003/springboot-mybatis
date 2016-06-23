$(document).ready(function() {
    $("#uploadify").uploadify({
        auto           : true,
        swf       	 : '/js/jquery/plugins/uploadify/uploadify.swf',
        uploader       : '/register/peBzzRec_uploadFile.action',//后台处理的请求
        queueID        : 'fileQueue',//与下面的id对应
        buttonClass		:'btn',
        buttonImage     : null,
        formData        : {recid:"${rec.id}"},
        buttonText		:'点击浏览图片',
        //multi          : true,多文件上传
        //'uploadLimit' 	 : 2,//允许上传文件的个数
        //'queueSizeLimit' : 3,//同时上传的文件
        fileTypeDesc   : '请选择图片，仅支持格式JPG,BMP,PNG,GIF，最大4M',
        fileTypeExts 	 : '*.JPG;*.GIF;*.PNG;*.BMP;', //控制可上传文件的扩展名，启用本项时需同时声明fileDesc
        buttonText     : '点击上传',
        fileObjName    : 'file',//服务端File对应的名称。
        fileSizeLimit	 : '4MB',//文件上传的大小限制，如果是字符串单位可以是B KB MB GB，默认是0，表示无限制
        width			:65,
        height			:20,
        onUploadSuccess : function(file,data,response) {//上传完成时触发（每个文件触发一次
            if(response==true){//如果服务器返回200表示成功
                if(data.indexOf("#Err")==-1){//判断是否有手动抛出错误信息
                    $("#faximage").attr("src",data+"?"+Math.random());//重新生成缩略图
                    $("#showtrue").attr("href",data+"?"+Math.random());
                    $$("showtrue").style.display="";
                    $("#pic").val(data);//保存数据
                    $("#nowpic").val("2");//表示重新上传了图片
                }else{
                    //否则输出错误信息
                    data=eval("("+data+")");
                    artAlert(data.msg,'e');
                }
            }else{
                artAlert('上传失败','e');
            }
        },
        onUploadError : function(file,data,response) {
            artAlert('上传失败','e');
        }
    });
    $('.uploadImageBtn').on('click',function(){
    	console.log('333');
    	$('.imageFileInput').click();
    })
});