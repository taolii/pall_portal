$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#modFormInPutDate').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$("#addChemicalReagentPanel input").each(function(){
		$('#modDataForm').bootstrapValidator('addField', $(this).attr('name'), {
            message: '试剂编号不能为空',
            validators: {
            	notEmpty: {
                    message: '试剂编号不能为空'
                }
            }
        });
		$(this).parent().parent().on('click', '.removeButton', function() {
            $('#modDataForm').bootstrapValidator('removeField', $(this).attr('name'));
            $(this).parent().parent().remove();
        });
	});
	$("#addAssemblyPanel").on('change', 'input[type=checkbox]', function() {
	   	 if(!$(this).prop('checked')){
			 $(this).parent().parent().parent().parent().remove();
		 }
	});
	$modDataForm=$('#modDataForm'),
	$addAssemblyOutputLotNumButton=$('#addAssemblyOutputLotNumButton'),
	$assemblyManageModal=$('#assemblyManageModal'),
	$addChemicalReagentButton=$('#addChemicalReagentButton'),
	$singleReagentMixtureModal=$("#singleReagentMixtureModal"),
	$multipleReagentMixtureModal=$("#multipleReagentMixtureModal"),
	$addAssemblyOutputLotNumButton.on('click', function() {
		$assemblyManageModal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
    	$assemblyManageModal.css("overflow", "hidden");
    	$assemblyManageModal.css("overflow-y", "auto");
    	$assemblyManageModal.modal("show");
    	$("#queryAssemblyModalButton").click();
	});
	$('#addAuxiliaryReagent1').on('click', function() {
		$singleReagentMixtureModal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
		$singleReagentMixtureModal.css("overflow", "hidden");
		$singleReagentMixtureModal.css("overflow-y", "auto");
		$singleReagentMixtureModal.modal("show");
		$("#addAuxiliaryReagent").val("#addAuxiliaryReagent1");
		$("#querySingleReagentMixtureButton").click();
	});
	$('#addAuxiliaryReagent2').on('click', function() {
		$singleReagentMixtureModal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
		$singleReagentMixtureModal.css("overflow", "hidden");
		$singleReagentMixtureModal.css("overflow-y", "auto");
		$singleReagentMixtureModal.modal("show");
		$("#addAuxiliaryReagent").val("#addAuxiliaryReagent2");
		$("#querySingleReagentMixtureButton").click();
	});
	$('#addAuxiliaryReagent3').on('click', function() {
		$singleReagentMixtureModal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
		$singleReagentMixtureModal.css("overflow", "hidden");
		$singleReagentMixtureModal.css("overflow-y", "auto");
		$singleReagentMixtureModal.modal("show");
		$("#addAuxiliaryReagent").val("#addAuxiliaryReagent3");
		$("#querySingleReagentMixtureButton").click();
	});
	$addChemicalReagentButton.on('click', function() {
		$multipleReagentMixtureModal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
		$multipleReagentMixtureModal.css("overflow", "hidden");
		$multipleReagentMixtureModal.css("overflow-y", "auto");
		$multipleReagentMixtureModal.modal("show");
		$("#queryMultipleReagentMixtureButton").click();
	});
	
	$modDataForm.bootstrapValidator({
        message: 'This value is not valid',
        group:'.rowGroup',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	lot: {
                validators: {
                    notEmpty: {
                        message: 'Lot#不能为空'
                    }
                }
            },
            goodsQty: {
                validators: {
                	notEmpty: {
                        message: 'goods Qty(pcs)不能为空'
                    },
                    digits: {
	                    message: 'goods Qty(pcs)值必须为数字'
	                }
                }
            },
            receiveQty: {
                validators: {
                    digits: {
	                    message: '领用QTY必须为数字'
	                }
                }
            },
            toOtherQty: {
                validators: {
                    digits: {
	                    message: '留样QTY必须为数字'
	                }
                }
            },
            heavySmokeQty: {
                validators: {
                    digits: {
	                    message: '重抽 Qty必须为数字'
	                }
                }
            },
            toPqcQty: {
                validators: {
                    digits: {
	                    message: 'To PQC QTY必须为数字'
	                }
                }
            },
            scrapQty: {
                validators: {
                    digits: {
	                    message: '报废QTY必须为数字'
	                }
                }
            },
            partNum: {
                validators: {
                    notEmpty: {
                        message: 'PN#不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var assemblyCount=$("#modDataForm [id=addAssemblyPanel]").find(":checkbox").length;
		$("#modDataForm [name=inputQty]").val(assemblyCount*96);
		//var count=Number($("#modDataForm [name=toPqcQty]").val())+Number($("#modDataForm [name=heavySmokeQty]").val())+Number($("#modDataForm [name=receiveQty]").val())+Number($("#modDataForm [name=toOtherQty]").val());
		//$("#modDataForm [name=scrapQty]").val(count);
		if($("#modDataForm [name=inputQty]").val()==0){
			$("#modDataForm [name=theoryYield]").val(0);
		}else{
			var theoryYield=(Number($("#modDataForm [name=inputQty]").val())-Number($("#modDataForm [name=scrapQty]").val()))/Number($("#modDataForm [name=inputQty]").val())*100;
			$("#modDataForm [name=theoryYield]").val(new Number(theoryYield).toFixed(2));
		}
    	var bv = $form.data('bootstrapValidator');
    	var operator=$("#operator").val();
    	if("copy"==operator){
    		$.post(contextPath+"/workflow/addChemicalReagent",  $form.serialize(), function(result) {
        		if(result.resultCode==0){
        			showNotice('Success',"添加生化镀膜信息成功",'success',1000*5);
        		}else{
        			showNotice('Error','<span style="padding-top:5px">添加生化镀膜信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        		}
        		$form.bootstrapValidator('disableSubmitButtons', false);
            },'json');
    	}else{
    		$.post(contextPath+"/workflow/modChemicalReagent",  $form.serialize(), function(result) {
        		if(result.resultCode==0){
        			showNotice('Success',"更新生化镀膜信息成功",'success',1000*5);
        		}else{
        			showNotice('Error','<span style="padding-top:5px">更新生化镀膜信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        		}
        		$form.bootstrapValidator('disableSubmitButtons', false);
            },'json');
    	}
    });
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/workflow/chemicalReagentManage";
    });
});
