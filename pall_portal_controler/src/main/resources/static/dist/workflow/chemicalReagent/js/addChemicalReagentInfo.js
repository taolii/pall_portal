$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addFormInPutDate').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$addDataForm=$('#addDataForm'),
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
	});
	$("#addDataForm").bootstrapValidator({
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
                        message: 'Lot不能为空'
                    }
                }
            },
            goodsQty: {
                validators: {
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
	                    message: '其他QTY必须为数字'
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
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
		var assemblyCount=$("#addDataForm [id=addAssemblyPanel]").find(":checkbox").length;
		$("#addDataForm [name=inputQty]").val(assemblyCount*96);
		var count=Number($("#addDataForm [name=toPqcQty]").val())+Number($("#addDataForm [name=heavySmokeQty]").val())+Number($("#addDataForm [name=receiveQty]").val())+Number($("#addDataForm [name=toOtherQty]").val());
		$("#addDataForm [name=scrapQty]").val(count);
		if($("#addDataForm [name=inputQty]").val()==0){
			$("#addDataForm [name=theoryYield]").val(0);
		}else{
			var theoryYield=(Number($("#addDataForm [name=inputQty]").val())-Number($("#addDataForm [name=scrapQty]").val()))/Number($("#addDataForm [name=inputQty]").val())*100;
			$("#addDataForm [name=theoryYield]").val(theoryYield);
		}
		var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/workflow/addChemicalReagent",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"添加生化镀膜信息成功",'success',1000*5);
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加生化镀膜信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
    		$form.bootstrapValidator('disableSubmitButtons', false);
        },'json');
    });
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/workflow/chemicalReagentManage";
    });
});
