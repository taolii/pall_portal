$(document).ready(function() {
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
            apsBottle: {
                validators: {
                    notEmpty: {
                        message: 'APS Bottle不能为空'
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
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post("/workflow/addPlatedFilm",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>添加化学镀膜信息成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">添加化学镀膜信息失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    });
});
