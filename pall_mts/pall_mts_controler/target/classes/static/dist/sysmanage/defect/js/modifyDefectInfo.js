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
        	configName: {
                validators: {
                    notEmpty: {
                        message: '缺损名不能为空'
                    }
                }
            },
            description: {
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
    	$.post(contextPath+"/dataconfig/modDataconfig",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"缺损配置更新成功",'success',1000*5);
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#modDefectModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			showNotice('Error','<span style="padding-top:5px">缺损配置更新失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
        },'json'); 
    });
});
