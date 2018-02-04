$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var dataform='#modDataForm';
    $(dataform).bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
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
            "name": {
            	container: '.name',
            	validators: {
                    notEmpty: {
                        message: '操作员名称不能为空'
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
    	$.post(contextPath+"/user/modifyUser",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"用户信息更新成功",'success',1000*5);
    			if($("#modUserModal").length>0){
    				$form.data('bootstrapValidator').resetForm(true);
        			$("#modUserModal").modal("hide");
        			$("#btn_refresh").click();
    			};
    		}else{
    			$(dataform).bootstrapValidator('disableSubmitButtons', false); 
    			showNotice('Error','<span style="padding-top:5px">用户信息更新失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
        },'json'); 
    });
});
