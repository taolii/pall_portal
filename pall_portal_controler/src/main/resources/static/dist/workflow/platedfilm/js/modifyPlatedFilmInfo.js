$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#modFormCoatingTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#modFormPfTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });  
	
	$(".defect-body").each(function(){
		$(this).find("input").each(function(){
			$('#modDataForm').bootstrapValidator('addField', $(this).attr('name'), {
	            message: '缺损值必须为数字类型',
	            validators: {
	                digits: {
	                    message: '缺损值必须为数字类型'
	                }
	            }
	        });
			$(this).parent().parent().on('click', '.removeButton', function() {
                $('#modDataForm').bootstrapValidator('removeField', $(this).attr('name'));
                $(this).parent().parent().remove();
            });
		}
		);
	});
	
    $modDataForm=$('#modDataForm'),
	$modDataForm.bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	coatingTime: {
                validators: {
                    notEmpty: {
                        message: 'Coating Date不能为空'
                    }
                }
            },
            pfTime: {
                validators: {
                    notEmpty: {
                        message: 'Date不能为空'
                    }
                }
            },
            inputLotNum: {
                validators: {
                    notEmpty: {
                        message: 'Input LOT#不能为空'
                    }
                }
            },
            inputQty: {
                validators: {
                	 notEmpty: {
                         message: 'Input Qty(pcs)不能为空'
                     },
                    digits: {
	                    message: 'Input Qty(pcs)值必须为数字'
	                }
                }
            },
            fixtureNum: {
                validators: {
                    notEmpty: {
                        message: 'Fixture#不能为空'
                    }
                }
            },
            outputLotNum: {
                validators: {
                    notEmpty: {
                        message: 'Output LOT#不能为空'
                    }
                }
            },
            outputQty: {
                validators: {
                    notEmpty: {
                        message: 'Output Qty(pcs)不能为空'
                    },
                    digits: {
	                    message: 'Output Qty(pcs)值必须为数字'
	                }
                }
            },
            underIQCQty: {
                validators: {
                    notEmpty: {
                        message: 'Under IQC Qty(pcs)不能为空'
                    },
                    digits: {
	                    message: 'Under IQC Qty(pcs)值必须为数字'
	                }
                }
            },
            partNum: {
                validators: {
                    notEmpty: {
                        message: 'Part NUM不能为空'
                    }
                }
            },
            workOrderNum: {
                validators: {
                    notEmpty: {
                        message: 'Work Order Number不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	var outputQty=Number($('#modDataForm [name=inputQty]').val())-Number($('#modDataForm [name=scrapQty]').val())-Number($('#modDataForm [name=underIQCQty]').val())
    		-Number($('#modDataForm [name=qcUseQty]').val())-Number($('#modDataForm [name=functionalTestQty]').val())-Number($('#modDataForm [name=toHUBQty]').val())
    				-Number($('#modDataForm [name=remainQty]').val());
    	$('#modDataForm [name=outputQty]').val(outputQty);
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	var operator=$("#operator").val();
    	if("copy"==operator){
    		$.post(contextPath+"/workflow/addPlatedFilm",  $form.serialize(), function(result) {
	    		if(result.resultCode==0){
	    			showNotice('Success',"添加化学镀膜信息成功",'success',1000*5);
	    		}else{
	    			showNotice('Error','<span style="padding-top:5px">添加化学镀膜信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
	    		}
	    		$form.bootstrapValidator('disableSubmitButtons', false);
	        },'json'); 
    	}else{
    		$.post(contextPath+"/workflow/modPlatedFilm",  $form.serialize(), function(result) {
	    		if(result.resultCode==0){
	    			showNotice('Success',"更新化学镀膜信息成功",'success',1000*5);
	    		}else{
	    			showNotice('Error','<span style="padding-top:5px">更新化学镀膜信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
	    		}
	    		$form.bootstrapValidator('disableSubmitButtons', false);
	        },'json');
    	}
    }).on('error.form.bv', function(e, data) {
    	showNotice('Error','参数非法，请检查参数','error',1000*10);
    });
    $("#modBackButton").on("click",function(){
    	window.location.href=contextPath+"/workflow/platedFilmManage";
    });
});
