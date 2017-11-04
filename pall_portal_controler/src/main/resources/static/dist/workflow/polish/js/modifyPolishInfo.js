$(document).ready(function() {
	$('#modFormPickingTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$('#modFormpolishTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#modDefectButton').on('click', function() {
        var $that     = $(this),
            $template = $('#modTemplate'),
            $polishTableName=$('#polishTableName'),
            $defectPanelBody=$('#modDefect_panel_body'),
            $modDefect=$('#modDefect'),
            $newRow   =$template.clone().removeAttr('id').find('.defect').html($modDefect.find("option:selected").text()).end();
            var defectName=$polishTableName.val()+$modDefect.val();
            $newRow=$newRow.find('input').attr('name', defectName).end().
        	on('click', '.removeButton', function() {
                $('#modDataForm').bootstrapValidator('removeField', defectName);
                $newRow.remove();
                if($defectPanelBody.find(".removeButton").length<=0){
                	$("#modDefectPanel").hide();
                }
            });
            
            if($defectPanelBody.find("[name='"+defectName+"']").length>0){
            	var v_msg=$addDefect.find("option:selected").text()+'已经存在，不允许重复';
            	Lobibox.alert('success', {
                    msg: v_msg,
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
            	return;
            }else{
            	$("#modDefectPanel").show();
            }
            $defectPanelBody.append($newRow).show();
	        $('#modDataForm').bootstrapValidator('addField', defectName, {
	            message: '缺损值必须为数字类型',
	            validators: {
	                digits: {
	                    message: '缺损值必须为数字类型'
	                }
	            }
	        });
    });

    $('#modDataForm').bootstrapValidator({
        message: 'This value is not valid',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	pickingTime: {
                validators: {
                    notEmpty: {
                        message: '领料日期不能为空'
                    }
                }
            },
            polishTime: {
                validators: {
                    notEmpty: {
                        message: 'Polish Date不能为空'
                    }
                }
            },
            fixtureNumber: {
                validators: {
                    notEmpty: {
                        message: 'Fixture#不能为空'
                    }
                }
            },
            throwMillstoneNum: {
                validators: {
                    notEmpty: {
                        message: 'millstone#不能为空'
                    }
                }
            },
            throwMillstonePosition: {
                validators: {
                    notEmpty: {
                        message: 'Loading Fixture Position不能为空'
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
                        message: 'Input Qty不能为空'
                    },
                    digits: {
	                    message: 'Input Qty值必须为数字'
	                }
                }
            },
            polishLotNum: {
                validators: {
                    notEmpty: {
                        message: 'Polish LOT#不能为空'
                    }
                }
            },
            partNum: {
                validators: {
                    notEmpty: {
                        message: 'Part NO不能为空'
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
            casualInspectionNum: {
                validators: {
                    notEmpty: {
                        message: '抽检总数不能为空'
                    },
                    digits: {
	                    message: '抽检总数必须为数字'
	                },
	                callback: {
                        message:'抽检总数应小于 Input Qty',
                        callback:function(value, validator) {
                        	var inputQty=validator.getFieldElements("inputQty").val();
                        	if (parseInt(inputQty)>=parseInt(value)) {
                                  
                                  return true;
                              }else{
                            	  return false;
                              }
                        }
	                }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post("/workflow/modPolish",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>更新信息成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$("#defect_panel_body").empty();
    			$("#defect_panel_body").hide();
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#modModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">更新抛光信息失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    });
});
