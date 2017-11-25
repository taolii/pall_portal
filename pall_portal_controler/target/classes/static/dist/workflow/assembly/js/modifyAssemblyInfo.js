$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#modFormDeliveryTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$("#modWorkingfaceType").change(function(){
		var workingfaceType=$(this).val();
		$("#modDefect").empty();
		$("#modAllDefect").find("option").each(function(){
			  if(workingfaceType==$(this).attr("dataType")){
				  $("#modDefect").append("<option value='"+$(this).val()+"'>"+$(this).html()+"</option>");
			  };
		  }); 
		   
	});
    $modDataForm=$('#modDataForm'),
    $modDefectPanel=$('#modDefectPanel'),
    $modDefectButton=$('#modDefectButton');
	$modDefectButton.on('click', function() {
        var $that     = $(this),
        $modTemplate = $('#modTemplate'),
        $modDefect=$('#modDefect'),
        $modWorkingfaceType=$('#modWorkingfaceType'),
        $newRow   =$modTemplate.clone().removeAttr('id').find('.defect').html($modDefect.find("option:selected").text()).end();
        $newRow=$newRow.find('input').attr('name', $modDefect.val()).end().
        	on('click', '.removeButton', function() {
        		$modDataForm.bootstrapValidator('removeField', $modDefect.val());
                $newRow.remove();
                if($modDefectPanel.find(".removeButton").length<=0){
                	$modDefectPanel.hide();
                }
            });
            if($modDefectPanel.find("[name='"+$modDefect.val()+"']").length>0){
            	var v_msg=$modDefect.find("option:selected").text()+'已经存在，不允许重复';
            	Lobibox.alert('success', {
                    msg: v_msg,
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
            	return;
            }else{
            	$modDefectPanel.show();
            }
            $("#modWorkingface"+$modWorkingfaceType.val()).find(".panel-body").each(function(){
            	$(this).append($newRow).show();
			});
            $modDataForm.bootstrapValidator('addField', $modDefect.val(), {
	            message: '缺损值必须为数字类型',
	            validators: {
	                digits: {
	                    message: '缺损值必须为数字类型'
	                }
	            }
	        });
    });

	$modDataForm.bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	trayLotNum: {
                validators: {
                    notEmpty: {
                        message: 'TRAY#不能为空'
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
            hubLotNum: {
                validators: {
                    notEmpty: {
                        message: 'HUB Lot#不能为空'
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
            scrapQty: {
                validators: {
                    digits: {
	                    message: 'Scrap Qty(pcs)值必须为数字'
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
            },
            remark: {
                validators: {
                    notEmpty: {
                        message: 'Remark不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/workflow/modAssembly",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>更新组装信息成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$modDefectPanel.find(".panel-body").each(function(){
    				$(this).empty();
    			});
    			$modDefectPanel.hide();
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#modModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">更新组装信息失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    });
});
