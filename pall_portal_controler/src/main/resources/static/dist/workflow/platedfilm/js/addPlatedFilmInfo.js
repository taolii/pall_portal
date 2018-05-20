$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addFormCoatingTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormPfTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
    $addDataForm=$('#addDataForm'),
	$addDataForm.bootstrapValidator({
        message: 'This value is not valid',
        group:'.rowGroup',
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
            underIQCQty: {
                validators: {
                	notEmpty: {
                        message: '领用Qty(pcs)值不能为空'
                    },
                    digits: {
	                    message: '领用Qty(pcs)值必须为数字'
	                }
                }
            },
            qcUseQty: {
                validators: {
                    digits: {
	                    message: 'QC Use Qty(pcs)值必须为数字'
	                }
                }
            },
            functionalTestQty: {
                validators: {
                    digits: {
	                    message: 'Functional Test Qty(pcs)值必须为数字'
	                }
                }
            },
            toHUBQty: {
                validators: {
                    digits: {
	                    message: 'To HUB Qty(pcs)值必须为数字'
	                }
                }
            },
            remainQty: {
                validators: {
                    digits: {
	                    message: 'REMAIN QTY值必须为数字'
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
    	var scrapQty=Number($('#addDataForm [name=underIQCQty]').val())+Number($('#addDataForm [name=qcUseQty]').val())+Number($('#addDataForm [name=functionalTestQty]').val())+Number($('#addDataForm [name=toHUBQty]').val());
    	$('#addDataForm [name=scrapQty]').val(scrapQty);
    	var outputQty=Number($('#addDataForm [name=inputQty]').val())-Number($('#addDataForm [name=scrapQty]').val());
    	$('#addDataForm [name=outputQty]').val(outputQty);
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/workflow/addPlatedFilm",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"添加化学镀膜信息成功",'success',1000*5);
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加化学镀膜信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
        },'json'); 
    });
    $("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/workflow/platedFilmManage";
    });
});
