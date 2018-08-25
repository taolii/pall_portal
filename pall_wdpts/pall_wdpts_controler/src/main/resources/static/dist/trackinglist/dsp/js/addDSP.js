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
	
	$("addDataForm").bootstrapValidator({
        message: 'This value is not valid',
        group:'.rowGroup',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	productionTime: {
                validators:{
                    notEmpty: {
                        message: '生产时间不能为空'
                    },
                    date:{  
                    	format:'YYYY-MM-DD HH:mm:ss',
                    	message:'日期格式不正确'  
                     }
                }
            },
            assembleTime: {
                validators:{
                    notEmpty: {
                        message: '装配日期不能为空'
                    },
                    date:{  
                    	format:'YYYY-MM-DD',
                    	message:'日期格式不正确'  
                     }
                }
            },
            dspPn: {
                validators: {
                    notEmpty: {
                        message: '型号/PN不能为空'
                    }
                }
            },
            serialNo: {
                validators: {
                    notEmpty: {
                        message: '序列号/Serial NO不能为空'
                    }
                }
            },
            workorderNo: {
                validators: {
                    notEmpty: {
                        message: '工单号/WO不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/trackinglist/addDSP",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"添加DSP装配流程跟踪单成功",'success',1000*5);
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加DSP装配流程跟踪单失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
    		$form.bootstrapValidator('disableSubmitButtons', false);
        },'json'); 
    });
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/trackinglist/dspManage";
    });
});
