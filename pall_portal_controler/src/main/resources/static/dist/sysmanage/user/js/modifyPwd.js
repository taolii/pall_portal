$(document).ready(function() {
	var contextPath=$("#contextPath").val();
    $('#dataForm').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	"password": {
                validators: {
                    notEmpty: {
                        message: '原密码不能为空'
                    }
                }
            },
            newPwd: {
                validators: {
                    notEmpty: {
                        message: '新密码不能为空'
                    },
                    stringLength: {
                        min: 4,
                        max: 18,
                        message: '新密码长度应该满足4-18位'
                    },
                    identical: {
                        field: 'ensureNewPwd',
                        message: '新密码与确认密码不一致'
                    },
                    different: {
                        field: 'account',
                        message: '确认密码不能与用户名相同'
                    },
                    different: {
                        field: 'password',
                        message: '新密码不能与原密码相同'
                    }
                }
            },
            ensureNewPwd: {
                validators: {
                    notEmpty: {
                        message: '确认密码不能为空'
                    },
                    stringLength: {
                        min: 4,
                        max: 18,
                        message: '确认密码长度应该满足4-18位'
                    },
                    identical: {
                        field: 'newPwd',
                        message: '新密码与确认密码不一致'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/user/modifyPwd", $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>密码更新成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">密码更新失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    })
    .on('error.form.bv', function(e, data) {
    	Lobibox.alert('error', {
            msg: '<span class="red">参数非法，请检查参数</span>',
            title:Lobibox.base.OPTIONS.title.error,
            width:Lobibox.base.OPTIONS.width,
            buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
        });
    });
});
