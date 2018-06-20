$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addFormDeliveryTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$("#workingfaceType").change(function(){
		var workingfaceType=$(this).val();
		$("#addefect").empty();
		$("#defect").find("option").each(function(){
			  if(workingfaceType==$(this).attr("dataType")){
				  $("#addefect").append("<option value='"+$(this).val()+"'>"+$(this).html()+"</option>");
			  };
		  }); 
		   
	});
	$("#deliveryType").change(function(){
		if($(this).val()==2){
			$("#addDataForm [name=inputLotNum]").removeAttr("readonly");
			$("#addDataForm [name=fixtureNum]").removeAttr("readonly");
			$("#addInputLotNum").addClass("disabled");
		}else{
			$("#addDataForm [name=inputLotNum]").attr("readonly","readonly");
			$("#addDataForm [name=fixtureNum]").attr("readonly","readonly");
			$("#addInputLotNum").removeClass("disabled");
		}
	});
    $addDataForm=$('#addDataForm'),
    $addDefectPanel=$('#addDefectPanel'),
    $addDefectButton=$('#addDefectButton');
	$addDefectButton.on('click', function() {
        var $that     = $(this),
        $template = $('#template'),
        $addDefect=$('#addefect'),
        $workingfaceType=$('#workingfaceType'),
        $newRow   =$template.clone().removeAttr('id').find('.defect').html($addDefect.find("option:selected").text()).end();
        $newRow=$newRow.find('input').attr('name', $addDefect.val()).end().
        	on('click', '.removeButton', function() {
        		$addDataForm.bootstrapValidator('removeField', $addDefect.val());
                $newRow.remove();
                if($addDefectPanel.find(".removeButton").length<=0){
                	$addDefectPanel.hide();
                }
            });
            if($addDefectPanel.find("[name='"+$addDefect.val()+"']").length>0){
            	var v_msg=$addDefect.find("option:selected").text()+'已经存在，不允许重复';
            	Lobibox.alert('success', {
                    msg: v_msg,
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
            	return;
            }else{
            	$addDefectPanel.show();
            }
            $("#workingface"+$workingfaceType.val()).find(".panel-body").each(function(){
            	$(this).append($newRow).show();
			});
            $addDataForm.bootstrapValidator('addField', $addDefect.val(), {
	            message: '缺损值必须为数字类型',
	            validators: {
	                digits: {
	                    message: '缺损值必须为数字类型'
	                }
	            }
	        });
    });

	$addDataForm.bootstrapValidator({
        message: 'This value is not valid',
        group:'.rowGroup',
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
            outputLotNum: {
                validators: {
                    notEmpty: {
                        message: 'Output LOT#不能为空'
                    }
                }
            },
            partNum: {
                validators: {
                    notEmpty: {
                        message: 'PN#不能为空'
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
    	var defectNum=0;
    	$(".defect-panel input").each(function(){
    		if($(this).val()!=null){
    			defectNum=defectNum+Number($(this).val());
    		}
    	});
    	$('#addDataForm [name=scrapQty]').val(defectNum);
    	var outputQty=Number($('#addDataForm [name=inputQty]').val())-defectNum;
    	$('#addDataForm [name=outputQty]').val(outputQty);
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/workflow/addAssembly",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			showNotice('Success',"添加组装信息成功",'success',1000*5);
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加组装信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
    		$form.bootstrapValidator('disableSubmitButtons', false);
        },'json'); 
    });
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/workflow/assemblyManage";
    });
});
