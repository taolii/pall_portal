$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addFormInPutDate').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$addDataForm=$('#addDataForm'),
	$addChemicalReagentButton=$('#addChemicalReagentButton'),
	$addChemicalReagentButton.on('click', function() {
        var $that     = $(this),
        $template = $('#template'),
        $addChemicalReagent=$('#addChemicalReagent'),
        $addChemicalReagentPanel=$('#addChemicalReagentPanel'),
        $workingfaceType=$('#workingfaceType'),
        $newRow   =$template.clone().removeAttr('id').find('.chemicalReagent').html($addChemicalReagent.find("option:selected").text()).end();
        $newRow=$newRow.find('input').attr('name', $addChemicalReagent.val()).end().
        	on('click', '.removeButton', function() {
        		$addDataForm.bootstrapValidator('removeField', $addChemicalReagent.val());
                $newRow.remove();
                if($addChemicalReagentPanel.find(".removeButton").length<=0){
                	$addChemicalReagentPanel.hide();
                }
            });
            if($addChemicalReagentPanel.find("[name='"+$addChemicalReagent.val()+"']").length>0){
            	var v_msg=$addChemicalReagent.find("option:selected").text()+'已经存在，不允许重复';
            	Lobibox.alert('success', {
                    msg: v_msg,
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
            	return;
            }else{
            	$addChemicalReagentPanel.show();
            }
            $("#workingface"+$workingfaceType.val()).find(".panel-body").each(function(){
            	$(this).append($newRow).show();
			});
            $addDataForm.bootstrapValidator('addField', $addChemicalReagent.val(), {
	            message: '试剂编号不能为空',
	            validators: {
	            	notEmpty: {
                        message: '试剂编号不能为空'
                    }
	            }
	        });
    });
	$addAssemblyOutputLotNumButton=$('#addAssemblyOutputLotNumButton'),
	$assemblyManageModal=$('#assemblyManageModal'),
	$addModal=$("#addModal"),
	$addAssemblyOutputLotNumButton.on('click', function() {
		$addModal.modal("hide");
		$assemblyManageModal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
    	$assemblyManageModal.css("overflow", "hidden");
    	$assemblyManageModal.css("overflow-y", "auto");
    	$assemblyManageModal.modal("show");
    	$("#assemblyBtn-query").click();
    	chemicalReagentform="addDataForm";
    	chemicalReagentModal="addModal";
	});
	$addDataForm.bootstrapValidator({
        message: 'This value is not valid',
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
            rawMaterial: {
                validators: {
                    notEmpty: {
                        message: 'FIBER RAW MATERIAL不能为空'
                    }
                }
            },
            inPutDate: {
                validators: {
                    notEmpty: {
                        message: 'FIBER INPUT DATE不能为空'
                    }
                }
            },
            coatingStation: {
                validators: {
                	 notEmpty: {
                         message: 'Coating Station不能为空'
                     }
                }
            },
            docRev: {
                validators: {
                    notEmpty: {
                        message: 'DOC.REV不能为空'
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
            inputQty: {
                validators: {
                    notEmpty: {
                        message: 'input Qty(pcs)不能为空'
                    },
                    digits: {
	                    message: 'input Qty(pcs)值必须为数字'
	                }
                }
            },
            theoryYield: {
                validators: {
                    notEmpty: {
                        message: 'theoretical Yield不能为空'
                    },
                    digits: {
	                    message: 'theoretical Yield值必须为数字'
	                }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	if($('#addChemicalReagentPanel').find('input').length==0){
    		Lobibox.alert('error', {
                msg: '<span class="red">请添加混合化学试剂信息</span><br/>',
                title:Lobibox.base.OPTIONS.title.error,
                width:Lobibox.base.OPTIONS.width,
                buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
            });
    		return;
    	}
    	if($("#addDataForm [id=assemblyOutputLotNum]").find(".panel-body").find(":checked").length==0){
    		Lobibox.alert('error', {
                msg: '<span class="red">请添加组装站位信息</span><br/>',
                title:Lobibox.base.OPTIONS.title.error,
                width:Lobibox.base.OPTIONS.width,
                buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
            });
    		return;
    	}
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/workflow/addChemicalReagent",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>添加生化镀膜信息成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">添加生化镀膜信息失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
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
