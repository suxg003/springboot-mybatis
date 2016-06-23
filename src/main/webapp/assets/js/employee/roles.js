function fetch(rid) {
    $.ajax("/employee/role/" + rid, {
        success: function (data) {
        	var data = JSON.parse(data);
            $("#roleId").val(data.roleId);
            $("#roleName").val(data.roleName);
            $('#roleDesc').val(data.description);

            $("input[name=privileges]").each(function (index, item) {
                if ($.inArray($(item).val(), data.privileges) > -1) {
                    $(item).prop("checked", true)
                } else {
                    $(item).prop("checked", false)
                }
            });
            $("#membersCount").html(data.members.length);
            $("#members > tbody").empty();
            $.each(data.members, function (index, item) {
                $("#members > tbody").append("<tr><td><a target='_blank' href='/employee/profile/" + item.empId + "'>" + item.userName + "</a></td><td>" + item.empCode + "</td><td>" + item.loginName + "</td></tr>")
            })
        }
    });
    $.ajax({
        url:'/employee/getChildRoles',
        data:{'rolePid':rid},
        dataType:'JSON',
        type:'POST',
        success:function(data){
            if(data.success){
                var conList = '';
                if(data.data.length==0){
                    conList+='&nbsp;'
                }else{
                    $.each(data.data,function(i,n){
                        conList += '<li class="roleCh" onclick="fetch('+n.roleId+')" data-rid="'+n.roleId+'">'+n.roleName+'</li>';

                    })
                }
                $('[name=roleId'+rid+']').find('.accordion-inner').html(conList);
            }
            //$('[name=roleId'+rid+']').find('.accordion-inner').html(data.data[0].roleName);
        }
    });

    editRole();
}

/*$('.roleCh').on('click',function(){
    var rid = $(this).attr('data-rid');
    fetch(rid);
})*/
function editRole(){
    $('#editRoles').show();
    $('#delete_role').show();
    $('#roleDefaultC').hide();
    $('.roleEditbtn').show();
    $('.editRolesWarp').show();

    $('#newRolesDt').hide();
}

/*$('.btn-reply').on('click',function(){
    editRole();

})*/

$('.dropdown-menu li').on('click',function(){
   var pid = $(this).find('a').attr('value'),
       title = $(this).find('a').html();
    $('.roleDefault').html(title);
    $('input[name=rolePid]').val(pid);
});
$('.newRoles').on('click',function(){
    $('.editRoles,#editRoles,#roleDefaultC').hide();
    $('#newRolesDt').show();

});
$("#delete_role").click(function () {
    var roleId = $("#roleId").val();
    if (roleId != ""&&roleId!='0') {
        if (confirm("确定要删除该角色吗？")) {
            $.post("/employee/deleteRoleById", {roleId: roleId}, function (data) {
                    window.location.reload();
                }
            );
        }
    }
});
$("input.check_all").on('change',function(){
    var $this=$(this);
    if($this.is(':checked')){
        $this.parents('.widget').find('.check_each').prop("checked",true);
    }else{
        $this.parents('.widget').find('.check_each').prop("checked",false);
    }
});
$(".check_each").on('change',function(){
    var $this=$(this);
    var len=$this.parents('.widget').find(".check_each[type=checkbox]:checked").length;
    var tlen=$this.parents('.widget').find(".check_each[type=checkbox]").length;
    //var len=$(".check_each[type=checkbox]:checked").length;
    //var tlen=$(".check_each[type=checkbox]").length;
    if(len==tlen){
        $this.parents('.widget').find("input.check_all").prop("checked",true);
    }else{
        $this.parents('.widget').find("input.check_all").prop("checked",false);
    }
});

$("input.first-input").on('change',function(){
    var $this=$(this);
    if($this.is(':checked')){
        $this.parent().siblings('.widget').find('input[type=checkbox]').prop("checked",true);
    }else{
        $this.parent().siblings('.widget').find('input[type=checkbox]').prop("checked",false);
    }
});
$('.widget input[type=checkbox]').on('change',function(){
    var $this=$(this);
    var alen=$(".check_each[type=checkbox]:checked").length;
    var atlen=$(".check_each[type=checkbox]").length;

    if(alen==atlen){
        $("input.first-input").prop("checked",true);
    }else{
        $("input.first-input").prop("checked",false);
    }
});
