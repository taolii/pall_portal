$(document).ready(function() {
	var contextPath=$("#contextPath").val();
    $('#modDataForm').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
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
            "name": {
                validators: {
                    notEmpty: {
                        message: '操作员名称不能为空'
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
    	$.post(contextPath+"/user/modifyUser",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>用户信息更新成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			if($("#modUserModal").length>0){
    				$form.data('bootstrapValidator').resetForm(true);
        			$("#modUserModal").modal("hide");
        			$("#btn_refresh").click();
    			};
    			
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">用户信息更新失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    }).on('error.form.bv', function(e, data) {
    	Lobibox.alert('error', {
            msg: '<span class="red">参数非法，请检查参数</span>',
            title:Lobibox.base.OPTIONS.title.error,
            width:Lobibox.base.OPTIONS.width,
            buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
        });
    }).on('error.form.bv', function(e, data) {
    	Lobibox.alert('error', {
            msg: '<span class="red">参数非法，请检查参数</span>',
            title:Lobibox.base.OPTIONS.title.error,
            width:Lobibox.base.OPTIONS.width,
            buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
        });
    });
});
