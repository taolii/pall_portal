$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$("#configName").change(function(){
		_table.draw();
	});
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
                        message: '数据配置名不能为空'
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
    			showNotice('Success',"添加数据配置信息成功",'success',1000*5);
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addDefectModal").modal("hide");
    			$("#queryForm [name=dataType]").val($("#addDataForm [name=dataType]").val());
    			$("#btn_refresh").click();
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加数据配置信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
        },'json'); 
    }).on('error.form.bv', function(e, data) {
    	showNotice('Error','参数非法，请检查参数','error',1000*10);
    });
});
