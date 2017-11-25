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
    	$.post(contextPath+"/dataconfig/addDataconfig",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>添加缺损信息成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addDefectModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">添加缺损信息失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
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
    });
});
