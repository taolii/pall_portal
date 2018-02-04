$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var dataForm='#dataForm';
    $(dataForm).bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	"password": {
        		container: '.password',
        		validators: {
                    notEmpty: {
                        message: '原密码不能为空'
                    }
                }
            },
            newPwd: {
            	container: '.newPwd',
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
            	container: '.ensureNewPwd',
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
    			showNotice('Success',"密码更新成功",'success',1000*5);
    		}else{
    			$(dataform).bootstrapValidator('disableSubmitButtons', false); 
    			showNotice('Error','<span style="padding-top:5px">密码更新失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
        },'json'); 
    });
});
