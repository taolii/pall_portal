$(document).ready(function() {
	/*$('#addDataForm [name=ptOption]').select2({
		minimumResultsForSearch: -1
		});*/
	
	var contextPath=$("#contextPath").val();
	var ids={"dataForm":"#addDataForm","contextPath":contextPath,"preprocessingAssembleTable":"#preprocessingAssemblesDatatable","preprocessingInspectTable":"#preprocessingInspectsDatatable"};
	//装配记录
	var preprocessingAssembleTable=new PreprocessingAssembleTable(contextPath,ids);
	var preprocessingAssembleDatatables=preprocessingAssembleTable.initTable();
	//送检记录
	var preprocessingInspectTable=new PreprocessingInspectTable(contextPath,ids);
	var preprocessingInspectDatatables=preprocessingInspectTable.initTable();
	
	/*var modalids={"dataForm":"#addDataForm","modal":"#selpreprocessingSettingModal","wrapper":"#preprocessingSettingDatatableContainer","preprocessingSettingDatatable":"#preprocessingSettingDatatable","queryForm":"#queryPreprocessingSettingForm","assemblesDetail":"#showAssemblesDetail","inspectsDetail":"#showInspectsDetail","shutModalButton":"#selpreprocessingSettingButton","contextPath":contextPath,"queryModalButton":"#btn-modal-query"};
	var preprocessingSettingModal=new PreprocessingSettingModal(contextPath,modalids);
	var modalTables=preprocessingSettingModal.initModalTable();
	preprocessingSettingModal.initModalShut(modalTables,preprocessingAssembleTable,preprocessingAssembleDatatables,preprocessingInspectTable,preprocessingInspectDatatables);*/
	$('#addFormAssembleTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormProductionTime').datetimepicker({  
        format: 'YYYY-MM-DD HH:mm:ss',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormInspectTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$("#addPreprocessingPn").on("click",function(){
		/*$selpreprocessingSettingModal=$("#selpreprocessingSettingModal");
        $selpreprocessingSettingModal.draggable({ handle:".table-header",
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
        $selpreprocessingSettingModal.css("overflow", "hidden");
        $selpreprocessingSettingModal.css("overflow-y", "auto");
        $selpreprocessingSettingModal.modal("show");
        $selpreprocessingSettingModal.on("shown.bs.modal",function(){
			$.each($.fn.dataTable.tables(true), function(){
				$(this).DataTable().columns.adjust();
			});
		});*/
		preprocessingAssembleDatatables.clear().draw();
		preprocessingAssembleTable.addPreprocssingSettingAssemblesPassAjax(preprocessingAssembleDatatables,"",$("#preprocessingSettingPreprocessingPn").val(),ids.dataForm);
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
        	/*productionTime: {
                validators:{
                    notEmpty: {
                        message: '生产时间不能为空'
                    },
                    date:{  
                    	format:'YYYY-MM-DD HH:mm:ss',
                    	message:'日期格式不正确'  
                     }
                }
            },*/
            /*assembleTime: {
                validators:{
                    notEmpty: {
                        message: '装配日期不能为空'
                    },
                    date:{  
                    	format:'YYYY-MM-DD',
                    	message:'日期格式不正确'  
                     }
                }
            },*/
            /*preprocessingPn: {
                validators: {
                    notEmpty: {
                        message: '型号/PN不能为空'
                    }
                }
            },*/
            serialNo: {
                validators: {
                    notEmpty: {
                        message: '序列号/Serial NO不能为空'
                    }
                }
            },
            assembleOperator: {
                validators: {
                    notEmpty: {
                        message: '装配人员不能为空'
                    }
                }
            },
            /*inspectOperator: {
                validators: {
                    notEmpty: {
                        message: '送检人员不能为空'
                    }
                }
            },*/
            workorderNo: {
                validators: {
                    notEmpty: {
                        message: '工单号/WO不能为空'
                    }
                }
            }
        }
    }).on('success.form.bv', function(e) {
    	e.preventDefault();
    	var $form = $(e.target);
    	var bv = $form.data('bootstrapValidator');
    	$.post(contextPath+"/trackinglist/addPreprocessing",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			//showNotice('Success',"添加预处理装配流程跟踪单成功",'success',1000*5);
    			window.location.href=contextPath+"/trackinglist/preprocessingManage";
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加预处理装配流程跟踪单失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
    		$form.bootstrapValidator('disableSubmitButtons', false);
        },'json'); 
    }).on("keypress",function(e) {
    	if (e.which == 13) {
    		return false;
    	}
	});
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/trackinglist/preprocessingManage";
    });
});
