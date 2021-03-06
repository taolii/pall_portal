$(document).ready(function() {
	/*$('#addDataForm [name=ptOption]').select2({
		minimumResultsForSearch: -1
		});*/
	
	var contextPath=$("#contextPath").val();
	var ids={"dataForm":"#addDataForm","contextPath":contextPath,"cisternAssembleTable":"#cisternAssemblesDatatable"};
	//装配记录
	var cisternAssembleTable=new CisternAssembleTable(contextPath,ids);
	var cisternAssembleDatatables=cisternAssembleTable.initTable();
	
	/*var modalids={"dataForm":"#addDataForm","modal":"#selcisternSettingModal","wrapper":"#cisternSettingDatatableContainer","cisternSettingDatatable":"#cisternSettingDatatable","queryForm":"#queryCisternSettingForm","assemblesDetail":"#showAssemblesDetail","shutModalButton":"#selcisternSettingButton","contextPath":contextPath,"queryModalButton":"#btn-modal-query"};
	var cisternSettingModal=new CisternSettingModal(contextPath,modalids);
	var modalTables=cisternSettingModal.initModalTable();
	cisternSettingModal.initModalShut(modalTables,cisternAssembleTable,cisternAssembleDatatables);*/
	$('#addFormAssembleTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#addFormProductionTime').datetimepicker({  
        format: 'YYYY-MM-DD HH:mm:ss',  
        locale: moment.locale('zh-cn')  
    });
	
	$("#addCisternPn").on("click",function(){
		/*$selcisternSettingModal=$("#selcisternSettingModal");
        $selcisternSettingModal.draggable({ handle:".table-header",
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
        $selcisternSettingModal.css("overflow", "hidden");
        $selcisternSettingModal.css("overflow-y", "auto");
        $selcisternSettingModal.modal("show");
        $selcisternSettingModal.on("shown.bs.modal",function(){
			$.each($.fn.dataTable.tables(true), function(){
				$(this).DataTable().columns.adjust();
			});
		});*/
		cisternAssembleDatatables.clear().draw();
		cisternAssembleTable.addCisternSettingAssemblesPassAjax(cisternAssembleDatatables,"",$("#cisternSettingCisternPn").val(),ids.dataForm);
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
            /*cisternPn: {
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
    	$.post(contextPath+"/trackinglist/addCistern",  $form.serialize(), function(result) {
    		if(result.resultCode==0){
    			//showNotice('Success',"添加水箱装配流程跟踪单成功",'success',1000*5);
    			window.location.href=contextPath+"/trackinglist/cisternManage";
    		}else{
    			showNotice('Error','<span style="padding-top:5px">添加水箱装配流程跟踪单失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
    		}
    		$form.bootstrapValidator('disableSubmitButtons', false);
        },'json'); 
    }).on("keypress",function(e) {
    	if (e.which == 13) {
    		return false;
    	}
	});
	$("#addBackButton").on("click",function(){
    	window.location.href=contextPath+"/trackinglist/cisternManage";
    });
});
