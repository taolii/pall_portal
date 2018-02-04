$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var dataForm='#addDataForm';
    $(dataForm).bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	account: {
        		container: '.account',
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
            name: {
            	container: '.name',
            	validators: {
                    notEmpty: {
                        message: '操作员名称不能为空'
                    }
                }
            },
        	password: {
        		container: '.password',
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
            	container: '.email',
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
            	container: '.mobile',
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
    	$.post(contextPath+"/user/addUser",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"添加用户成功",'success',1000*5);
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addUserModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			$(dataform).bootstrapValidator('disableSubmitButtons', false); 
    			showNotice('Error','<span style="padding-top:5px">添加用户失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
        },'json'); 
    });
});
