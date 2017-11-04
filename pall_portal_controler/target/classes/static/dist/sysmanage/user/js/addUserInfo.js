$(document).ready(function() {
    $('#addDataForm').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	account: {
                validators: {
                    notEmpty: {
                        message: '登录账号不能为空'
                    },
                    stringLength: {
                        min: 4,
                        max: 18,
                        message: '登录账号长度应该满足4-18位'
                    }
                }
            },
        	password: {
                validators: {
                    notEmpty: {
                        message: '密码不能为空'
                    },
                    stringLength: {
                        min: 4,
                        max: 18,
                        message: '密码长度应该满足4-18位'
                    },
                    different: {
                        field: 'userEntity.account',
                        message: '密码不能与用户名相同'
                    }
                }
            },
            "email": {
                validators: {
                    notEmpty: {
                        message: 'email地址不能为空'
                    },
                    emailAddress: {
                        message: '请输入一个有效的email地址'
                    }
                }
            },
            "mobile": {
            	validators: {
            		notEmpty: {
                        message: '手机号不能为空'
                    },
            		phone: {
            			message: '请输入一个有效的手机号',
            			country: 'CN'
            		}
            	}
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post("/user/addUser",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>添加用户成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addUserModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">添加用户失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    });
});
