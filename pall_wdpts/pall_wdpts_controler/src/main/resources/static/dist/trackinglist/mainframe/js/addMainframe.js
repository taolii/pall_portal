$(document).ready(function() {
	/*$('#addDataForm [name=ptOption]').select2({
		minimumResultsForSearch: -1
		});*/
	
	var contextPath=$("#contextPath").val();
	var ids={"dataForm":"#addDataForm","contextPath":contextPath,"mainframeAssembleTable":"#mainframeAssemblesDatatable","mainframeInspectTable":"#mainframeInspectsDatatable"};
	//装配记录
	var mainframeAssembleTable=new MainframeAssembleTable(contextPath,ids);
	var mainframeAssembleDatatables=mainframeAssembleTable.initTable();
	//送检记录
	var mainframeInspectTable=new MainframeInspectTable(contextPath,ids);
	var mainframeInspectDatatables=mainframeInspectTable.initTable();
	
	/*var modalids={"dataForm":"#addDataForm","modal":"#selmainframeSettingModal","wrapper":"#mainframeSettingDatatableContainer","mainframeSettingDatatable":"#mainframeSettingDatatable","queryForm":"#queryMainframeSettingForm","assemblesDetail":"#showAssemblesDetail","inspectsDetail":"#showInspectsDetail","shutModalButton":"#selmainframeSettingButton","contextPath":contextPath,"queryModalButton":"#btn-modal-query"};
	var mainframeSettingModal=new MainframeSettingModal(contextPath,modalids);
	var modalTables=mainframeSettingModal.initModalTable();
	mainframeSettingModal.initModalShut(modalTables,mainframeAssembleTable,mainframeAssembleDatatables,mainframeInspectTable,mainframeInspectDatatables);*/
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
	$("#addMainframePn").on("click",function(){
		/*$selmainframeSettingModal=$("#selmainframeSettingModal");
        $selmainframeSettingModal.draggable({ handle:".table-header",
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
        $selmainframeSettingModal.css("overflow", "hidden");
        $selmainframeSettingModal.css("overflow-y", "auto");
        $selmainframeSettingModal.modal("show");
        $selmainframeSettingModal.on("shown.bs.modal",function(){
			$.each($.fn.dataTable.tables(true), function(){
				$(this).DataTable().columns.adjust();
			});
		});*/
		mainframeAssembleDatatables.clear().draw();
		mainframeInspectDatatables.clear().draw();
		mainframeAssembleTable.addMainframeSettingAssemblesPassAjax(mainframeAssembleDatatables,"",$("#mainframeSettingMainframePn").val(),ids.dataForm);
		
		mainframeInspectTable.addMainframeSettingInspectsPassAjax(mainframeInspectDatatables,"",$("#mainframeSettingMainframePn").val());
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
            /*mainframePn: {
                validators: {
                    notEmpty: {
                        message: '型号/PN不能为空'
                    }
                }
            },*/
            serialNo: {
                validators: {
                    notEmpty: {
                        message: '序列号/Serial No不能为空'
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
    	$.post(contextPath+"/trackinglist/addMainframe",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			//showNotice('Success',"添加主机装配流程跟踪单成功",'success',1000*5);
    			window.location.href=contextPath+"/trackinglist/mainframeManage";
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加主机装配流程跟踪单失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
    		$form.bootstrapValidator('disableSubmitButtons', false);
        },'json'); 
    }).on("keypress",function(e) {
    	if (e.which == 13) {
    		return false;
    	}
	});
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/trackinglist/mainframeManage";
    });
});
