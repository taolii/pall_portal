$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addFormCleanTime').datetimepicker({  
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
            cleanLotNum: {
                validators: {
                    notEmpty: {
                        message: 'Clean LOT#不能为空'
                    }
                }
            },
            scrapQty: {
                validators: {
                    digits: {
	                    message: 'Scrap Qty值必须为数字'
	                }
                }
            },
            outputQty: {
                validators: {
                    notEmpty: {
                        message: 'Output Qty不能为空'
                    },
                    digits: {
	                    message: 'Output Qty值必须为数字'
	                }
                }
            },
            toOCQty: {
                validators: {
                    notEmpty: {
                        message: 'to Optical Coating Qty不能为空'
                    },
                    digits: {
	                    message: 'to Optical Coating Qty值必须为数字'
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
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/workflow/addClean",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			Lobibox.alert('success', {
                    msg: "<h3><span class='green'>添加清洗信息成功</span>",
                    title:Lobibox.base.OPTIONS.title.success,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
                });
    			$addDefectPanel.find(".panel-body").each(function(){
    				$(this).empty();
    			});
    			$addDefectPanel.hide();
    			$form.data('bootstrapValidator').resetForm(true);
    			$("#addModal").modal("hide");
    			$("#btn_refresh").click();
    		}else{
    			Lobibox.alert('error', {
                    msg: '<span class="red">添加清洗信息失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                    title:Lobibox.base.OPTIONS.title.error,
                    width:Lobibox.base.OPTIONS.width,
                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                });
    		}
        },'json'); 
    });
});
