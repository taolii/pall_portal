$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addFormAssembleTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormProductionTime').datetimepicker({  
        format: 'YYYY-MM-DD HH:mm:ss',  
        locale: moment.locale('zh-cn')  
    });
	
	$("#modDataForm").bootstrapValidator({
        message: 'This value is not valid',
        group:'.rowGroup',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	mainframePn: {
                validators: {
                    notEmpty: {
                        message: '料号/PN不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	var operator=$("#operator").val();
    	if("copy"==operator){
    		$.post(contextPath+"/setting/addMainframeSetting",  $form.serialize(), function(result) {
        		if(result.resultCode==0){
        			//showNotice('Success',"添加主机配置成功",'success',1000*5);
        			window.location.href=contextPath+"/setting/mainframeSetting";
        		}else{
        			showNotice('Error','<span style="padding-top:5px">添加主机配置失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        		}
        		$form.bootstrapValidator('disableSubmitButtons', false);
            },'json'); 
    	}else{
    		$.post(contextPath+"/setting/modMainframeSetting",  $form.serialize(), function(result) {
        		if(result.resultCode==0){
        			//showNotice('Success',"修改主机配置成功",'success',1000*5);
        			window.location.href=contextPath+"/setting/mainframeSetting";
        		}else{
        			showNotice('Error','<span style="padding-top:5px">修改主机配置失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        		}
        		$form.bootstrapValidator('disableSubmitButtons', false);
            },'json'); 
    	}
    }).on("keypress",function(e) {
    	if (e.which == 13) {
    		return false;
    	}
	});
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/setting/mainframeSetting";
    });
});
