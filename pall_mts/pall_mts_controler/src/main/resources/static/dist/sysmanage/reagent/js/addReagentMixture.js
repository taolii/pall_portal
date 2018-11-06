$(document).ready(function() {
	var ids={"contextPath":"#contextPath","dataForm":"#addDataForm","backButton":"#addBackButton"};
	$('#addFormConfigTime').datetimepicker({  
        format: 'YYYY-MM-DD HH:mm:ss',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormTemperatureUpEndtime').datetimepicker({  
        format: 'YYYY-MM-DD HH:mm:ss',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormTemperatureUpStarttime').datetimepicker({  
        format: 'YYYY-MM-DD HH:mm:ss',  
        locale: moment.locale('zh-cn')  
    });
	$('#addSubReagentButton').click(function(){
		 var $that     = $(this),
	     $template = $('#template'),
	     $subReagent=$('#subReagent'),
	     $subReagentPanel=$('#subReagentPanel'),
	     $newRow   =$template.clone().removeAttr('id').find('.reagentPanel').html($subReagent.find("option:selected").text()).end();
	     $newRow=$newRow.find('input').attr('name', $subReagent.val()).end().
	             on('click', '.removeButton', function() {
	                $newRow.remove();
	            });
        if($subReagentPanel.find("[name='"+$subReagent.val()+"']").length>0){
        	var v_msg=$subReagent.find("option:selected").text()+'  已经存在，不允许重复';
        	showNotice('Error','<span style="padding-top:5px">'+v_msg+'</span>','error',1000*10);
        	return;
        }
        $subReagentPanel.append($newRow).show();
	});
	
	var contextPath=$(ids.contextPath).val();
    $(ids.dataForm).bootstrapValidator({
        message: 'This value is not valid',
        group:'.rowGroup',
        feedbackIcons: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
        	configTime: {
                validators: {
                    notEmpty: {
                        message: 'Date日期不能为空'
                    }
                }
            },
            lotNum: {
                validators: {
                    notEmpty: {
                        message: 'LOT#不能为空'
                    }
                }
            },
            amount: {
            	validators: {
            		numeric: {
	                    message: 'Amount(mg/ml)值必须为数字'
	                }
            	}
            },
            
	        phValue: {
	        	validators: {
	        		numeric: {
		                message: 'PH值必须为数字'
		            }
	        	}
	        }
        }
    }).on('success.form.bv', function(e) {
        	e.preventDefault();
        	var $form = $(e.target);
        	var bv = $form.data('bootstrapValidator');
        	$.post(contextPath+"/reagent/addReagentMixture",  $form.serialize(), function(result) {
        		if(result.resultCode==0){
        			showNotice('Success',"添加混合试剂成功",'success',1000*5);
        		}else{
        			showNotice('Error','<span style="padding-top:5px">添加混合试剂失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        		}
            },'json'); 
        	$form.bootstrapValidator('disableSubmitButtons', false);  
    });
    $(ids.backButton).on("click",function(){
    	window.location.href=contextPath+"/reagent/reagentMixtureManage";
    });
});
