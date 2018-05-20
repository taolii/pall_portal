$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#modFormCleanTime').datetimepicker({  
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
	$(".defect-panel").each(function(){
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
	$('#modDefectButton').on('click', function() {
	    var $that     = $(this),
	    $modDefectPanel=$('#modDefectPanel');
	    $modTemplate = $('#modTemplate'),
	    $modDefect=$('#modDefect'),
	    $modWorkingfaceType=$('#modWorkingfaceType'),
	    $newRow   =$modTemplate.clone().removeAttr('id').find('.defect').html($modDefect.find("option:selected").text()).end();
	    $newRow=$newRow.find('input').attr('name', $modDefect.val()).end().
	    	on('click', '.removeButton', function() {
	    		$('#modDataForm').bootstrapValidator('removeField', $modDefect.val());
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
	        $('#modDataForm').bootstrapValidator('addField', $modDefect.val(), {
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
	        group:'.rowGroup',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	cleanTime: {
	                validators: {
	                    notEmpty: {
	                        message: 'Clean日期不能为空'
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
	            cleanLotNum: {
	                validators: {
	                    notEmpty: {
	                        message: 'Clean LOT#不能为空'
	                    }
	                }
	            },
	            toOtherQty: {
	                validators: {
	                    digits: {
		                    message: 'to other Qty值必须为数字'
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
	            }
	        }
	    }).on('success.form.bv', function(e) {
	    	var defectNum=0;
	    	$(".defect-panel input").each(function(){
	    		if($(this).val()!=null){
	    			defectNum=defectNum+Number($(this).val());
	    		}
	    	});
	    	$('#modDataForm [name=scrapQty]').val(defectNum);
	    	var outputQty=Number($('#modDataForm [name=inputQty]').val())-defectNum-Number($('#modDataForm [name=toOtherQty]').val());
	    	$('#modDataForm [name=outputQty]').val(outputQty);
	    	e.preventDefault();
	    	var $form = $(e.target);
	    	var bv = $form.data('bootstrapValidator');
	    	var operator=$("#operator").val();
	    	if("copy"==operator){
	    		$.post(contextPath+"/workflow/addClean",  $form.serialize(), function(result) {
		    		if(result.resultCode==0){
		    			showNotice('Success',"添加清洗信息成功",'success',1000*5);
		    		}else{
		    			showNotice('Error','<span style="padding-top:5px">添加清洗信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
		    		}
		    		$form.bootstrapValidator('disableSubmitButtons', false);
		        },'json'); 
	    	}else{
	    		$.post(contextPath+"/workflow/modClean",  $form.serialize(), function(result) {
		    		if(result.resultCode==0){
		    			showNotice('Success',"更新清洗信息成功",'success',1000*5);
		    		}else{
		    			showNotice('Error','<span style="padding-top:5px">更新清洗信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
		    		}
		    		$form.bootstrapValidator('disableSubmitButtons', false);
		        },'json');
	    	}
	    });
		$("#modBackButton").on("click",function(){
	    	window.location.href=contextPath+"/workflow/cleanManage";
	    });
});
