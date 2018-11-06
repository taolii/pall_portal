$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#queryStartDeliveryTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$('#queryEndDeliveryTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
	$('#queryStartDeliveryTime').val(currentDate(30));
	$('#queryEndDeliveryTime').val(currentDate(-1));
	var $wrapper = $('#div-table-container');
	$assemblyQueryForm=$("#queryAssemblyModalForm");
	var _assemblyTable = $('#assemblyTable').dataTable($.extend(true,
		{"autoWidth":false,scrollX: true,ordering: false},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
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
        columns: [
       	 {className: "td_assembly_checkbox",title:"<input class='ace' type='checkbox' name='cb-check-all'/><span class='lbl'></span>",width:"20px",data: null,render: function (data, type, row, meta) {
                    return '<input name='+data.trayLotNum+' type="checkbox" class="ace"><span class="lbl"></span>';
            }},
	        {className : "ellipsis",title:"assemblyID",data: "assemblyID",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,"width": "1%"},
	        {className : "ellipsis",title:"DeliveryDate",data: "deliveryTime",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"TRAY#",data: "trayLotNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"Input LOT#",data: "inputLotNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"Input Qty(pcs)",data: "inputQty",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"Fixture#",data: "fixtureNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"Output LOT#",data: "outputLotNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"Output Qty(pcs)",data: "outputQty",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"PN#",data: "partNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	        {className : "ellipsis",title:"WON#",data: "workOrderNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
	     ],
        "drawCallback": function( settings ) {
	        $assemblyPanel=$($("#updateForm").val()+" [id=addAssemblyPanel]");
	        $assemblyPanel.find("input").each(function(){
	    		var cValue=$(this).val();
	    		$(":checkbox","#assemblyTable_wrapper").each(function(){
	    			if($(this).attr("name")=='cb-check-all'){
	    				$(this).prop('checked', false);
	    			}
	    			if($(this).attr("name")==cValue){
	    				$(this).prop('checked', true);
	    			}
	    		});
    		});
        }
    })).api();
	$("#assemblyTable_wrapper").find(".dataTables_length").parent().parent().hide();
	$("#assemblyManageModal").on("shown.bs.modal",function(){
		$.each($.fn.dataTable.tables(true), function(){
			 $(this).DataTable().columns.adjust();
		});
	});
	$("#queryAssemblyModalButton").click(function(){
		_assemblyTable.draw();
	});
	$('#assemblyTable').on("click",".td_assembly_checkbox",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":checkbox") && $(":checkbox",this).trigger("click");
    });
	$("#assemblyTable_wrapper [name='cb-check-all']").click(function(){
		$(":checkbox","#assemblyTable").prop("checked",$(this).prop("checked"));
		$(":checkbox","#assemblyTable").each(function(){
			if (!$(this).is("[name='cb-check-all']")) {
				var item = _assemblyTable.row($(this).closest('tr')).data();
	        	if($(this).is(':checked')){
	        		insertAssembly(item,true);
	        	}else{
	        		insertAssembly(item,false);
	        	}
	        }
		});
	});
	$("#assemblyTable").on("change",":checkbox",function() {
        if ($(this).is("[name='cb-check-all']")) {
            //全选
            $(":checkbox","#assemblyTable").prop("checked",$(this).prop("checked"));
        }else{
        	var item = _assemblyTable.row($(this).closest('tr')).data();
        	if($(this).is(':checked')){
        		insertAssembly(item,true);
        	}else{
        		insertAssembly(item,false);
        	}
        }
    });
	function  insertAssembly(item,ischeck){
		var form=$("#updateForm").val();
		$assemblyPanel=$(form+" [id=addAssemblyPanel]");
		if(!ischeck){
			$assemblyPanel.find("[value='"+item.trayLotNum+"']").parent().parent().parent().parent().remove();
			return;
		}
		
		if($assemblyPanel.find("[value='"+item.trayLotNum+"']").length>0){
        	return;
        }
		$newRow   =$("#assemblyTemplate").clone().removeAttr('id').find('.assembly').html("&nbsp;&nbsp;"+item.trayLotNum).end();
	    $newRow=$newRow.find('input').attr('name','trayLotNum').val(item.trayLotNum).end().
	             on('change', 'input[type=checkbox]', function() {
	            	 if(!$(this).prop('checked')){
	            		 $(this).parent().parent().parent().parent().remove();
	            		 $("#assemblynum").html("("+$assemblyPanel.find('input').length+")");
	            	 }
	    });
	    $assemblyPanel.append($newRow).show();
	    $("#assemblynum").html("("+$assemblyPanel.find('input').length+")");
	}
});