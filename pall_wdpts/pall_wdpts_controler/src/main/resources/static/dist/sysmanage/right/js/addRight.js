$(document).ready(function() {
	var contextPath=$("#contextPath").val();
    $('#addDataForm').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	roleName: {
                validators: {
                    notEmpty: {
                        message: '角色名不能为空'
                    }
                }
            },
            rDetail: {
                validators: {
                    stringLength: {
                        min: 0,
                        max: 100,
                        message: '描述不能超过100个字符'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/role/addRole",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"添加角色成功",'success',1000*5);
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加角色失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	}
        },'json'); 
    }).on('error.form.bv', function(e, data) {
    	showNotice('Error','参数非法，请检查参数','error',1000*10);
    });
});
