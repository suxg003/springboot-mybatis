/**
 * Created by meng on 2015/6/25.
 */
//开始验证
$("#loginForm").bootstrapValidator({
    message: 'This value is not valid',
    fields: {
        loginName: {
            validators: {
                notEmpty: {
                    message: '请输入员工登录名'
                }
            }
        },
        password: {
            validators: {
                notEmpty: {
                    message: '请输入您的密码'
                }
            }
        }
    }
});


