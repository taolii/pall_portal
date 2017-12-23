$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var init=true;
	$('#queryDeliveryTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	var assemblycolumns_setting=[
    	TABLE_CONSTANT.DATA_TABLES.COLUMN.CHECKBOX
    ];
	
	var assemblyTableFieldBinds=$("#assemblyTableFieldBinds").val();
	assemblyTableFieldBinds=eval("(" + assemblyTableFieldBinds + ")");
	$.each(assemblyTableFieldBinds, function(index, tableField){
		var v_visible=true;
		if(tableField.invisible==1||tableField.invisible==3){
			v_visible=false;
		}
		assemblycolumns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:tableField.fieldName,render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px","visible":v_visible }) ;  
	});
	var assemblycolumns_settingfoot=[
        {className : "td-operation",data: null,render : function(data,type, row, meta) {
        	return "";
          }, width : "60px","visible":false}
    ];
	assemblycolumns_setting=assemblycolumns_setting.concat(assemblycolumns_settingfoot);
	$assemblyDatatable= $('#assemblyDatatable');
	var $wrapper = $('#div-table-container');
	$assemblyQueryForm=$("#assemblyQueryForm");
	var _assemblyTable = $assemblyDatatable.dataTable($.extend(true,
		{pageLength: 10,scrollX: true,ordering: false,"sPaginationType":"full_numbers"},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
		{
        ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
            //手动控制遮罩
        	$wrapper.spinModal();
            //封装请求参数
            var param = {};
            param.draw = data.draw;
            param.startPageNum = data.start;
            param.pageSize = data.length;
            var formData = $assemblyQueryForm.serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                    type: "post",
                    url: contextPath+"/workflow/assemblyManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>组装信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
                        	$wrapper.spinModal(false);
                        	return ;
                        }
                        //封装返回数据，这里仅演示了修改属性名
                        var returnData = {};
                        returnData.draw = result.datatablesView.draw;//这里直接自行返回了draw计数器,应该由后台返回
                        returnData.recordsTotal = result.datatablesView.recordsTotal;
                        returnData.recordsFiltered =result.datatablesView.recordsTotal;
                        returnData.data = result.datatablesView.data;
                        //关闭遮罩
                        $wrapper.spinModal(false);
                        //调用DataTables提供的callback方法，代表数据已封装完成并传回DataTables进行渲染
                        //此时的数据需确保正确无误，异常判断应在执行此回调前自行处理完毕
                        callback(returnData);
                        
                    },
                    error: function(XMLHttpRequest, textStatus, errorThrown) {
                    	var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>组装信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                    	$wrapper.spinModal(false);
                    }
                });
        },
        columns:assemblycolumns_setting ,
        "drawCallback": function( settings ) {
            //渲染完毕后的回调
            //清空全选状态
        	$(":checkbox[name='a-cb-check-all']").prop('checked', false);
            $(":checkbox[name='a-cb-check-all']",$assemblyDatatable).prop('checked', false);
            if(!init){
            	$assemblyOutputLotNumPanel=$("#"+chemicalReagentform+" [id=assemblyOutputLotNum]").find(".panel-body");
            	$(":checkbox",$assemblyDatatable).each(function(){
            		var item = _assemblyTable.row($(this).closest('tr')).data();
            		var check=false;
            		if (!$(this).is("[name='a-cb-check-all']")) {
                		$assemblyOutputLotNumPanel.find(":checked").each(function(){
                			if(item.outputLotNum==$(this).val()){
                				check=true;
                				return;
                			}
                		});
            		}
            		if(check){
            			$(this).prop('checked', true);
            		}
                });
            }
            //默认选中第一行
            $("tbody tr",$assemblyDatatable).eq(0).click();
        }
    })).api();
	$("#datatable_length").hide();
	$checkTemplate = $('#checkTemplate');
	$("[name='a-cb-check-all']").click(function(){
		$(":checkbox",$assemblyDatatable).prop("checked",$(this).prop("checked"));
		$(":checkbox",$assemblyDatatable).each(function(){
			if (!$(this).is("[name='a-cb-check-all']")) {
				var item = _assemblyTable.row($(this).closest('tr')).data();
	        	if($(this).is(':checked')){
	        		insertAssemblyOutputLotNum(item,true);
	        	}else{
	        		insertAssemblyOutputLotNum(item,false);
	        	}
	        }
		});
	});
	$assemblyDatatable.on("change",":checkbox",function() {
        if ($(this).is("[name='a-cb-check-all']")) {
            //全选
            $(":checkbox",$assemblyDatatable).prop("checked",$(this).prop("checked"));
        }else{
            //一般复选
        	var item = _assemblyTable.row($(this).closest('tr')).data();
        	if($(this).closest('tr').find('input').is(':checked')){
        		insertAssemblyOutputLotNum(item,true);
        	}else{
        		insertAssemblyOutputLotNum(item,false);
        	}
   		 	var checkbox = $("tbody :checkbox",$assemblyDatatable);
   		 	$(":checkbox[name='a-cb-check-all']",$assemblyDatatable).prop('checked', checkbox.length == checkbox.filter(':checked').length);
        }
    }).on("click",".td-checkbox",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":checkbox") && $(":checkbox",this).trigger("click");
    });
	$("#addAssemblyButton").click(function(){
		$("#"+chemicalReagentModal).modal("show");
		$('#assemblyManageModal').modal("hide");
	});
	$("#shutAssemblyButton").click(function(){
		$("#"+chemicalReagentModal).modal("show");
		$('#assemblyManageModal').modal("hide");
	});
	$("#assemblyBtn-query").click(function(){
		_assemblyTable.draw();
		init=false;
	});
	function  insertAssemblyOutputLotNum(item,ischeck){
		$assemblyOutputLotNumPanel=$("#"+chemicalReagentform+" [id=assemblyOutputLotNum]").find(".panel-body");
		if(!ischeck){
			$assemblyOutputLotNumPanel.find("[value='"+item.outputLotNum+"']").parent().parent().parent().remove();
			return;
		}
		if($assemblyOutputLotNumPanel.find("[value='"+item.outputLotNum+"']").length>0){
        	return;
        }
		$newRow=$checkTemplate.clone().removeAttr('id').find('input').val(item.outputLotNum).end().
        	on('click', '.removeButton', function() {
                $(this).parent().parent().remove();
            });
		$assemblyOutputLotNumPanel.each(function(){
        	$(this).append($newRow).show();
		});
	}
});