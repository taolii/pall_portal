$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addInputLotNum').click(function(){
		manage.polishShow();
		$("#btn-query").click();
	});
	$('#queryPickingTime').datetimepicker({  
        format: 'YYYY-MM-DD',
        locale: moment.locale('zh-cn')  
    }); 
	$('#queryStartPolishTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')
    });
	$('#queryEndPolishTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#queryStartPolishTime').val(currentDate(30));
	$('#queryEndPolishTime').val(currentDate(-1));
	var columns_setting=[TABLE_CONSTANT.DATA_TABLES.COLUMN.RADIO];
	var tableFieldBinds=$("#tableFieldBinds").val();
	tableFieldBinds=eval("(" + tableFieldBinds + ")");
	$.each(tableFieldBinds, function(index, tableField){
		var v_visible=true;
		if(tableField.invisible==1){
			v_visible=false;
		}
		columns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:tableField.fieldName,render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"80px","visible":v_visible }) ;  
	});
	var $wrapper = $('#div-table-container');
	var $table = $('#datatable');
	var _table = $table.dataTable($.extend(true,
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
            var formData = $("#queryForm").serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                type: "post",
                url: contextPath+"/workflow/polishManage",
                cache : false,  //禁用缓存
                data: param,    //传入已封装的参数
                dataType: "json",
                success: function(result) {
                	 //异常判断与处理
                    if (result.resultCode!=0) {
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>抛光信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>抛光信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                    $wrapper.spinModal(false);
                }
            });
        },
        columns:columns_setting
    })).api();
	$("#datatable_wrapper").find(".dataTables_length").parent().parent().hide();
	$("#btn-query").click(function(){
		_table.draw();
	});
	$table.on("click",".td-radio",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":radio") && $(":radio",this).trigger("click");
    });
	$("#polishModal").on("shown.bs.modal",function(){
		$.each($.fn.dataTable.tables(true), function(){
			 $(this).DataTable().columns.adjust();
		});
	});
	$('#selButton').click(function(){
		var radios=$("tbody :radio:checked",$table);
		if(radios.length<=0){
			showNotice('Error','请选择一条记录','error',1000*2);
		}else{
			$(radios).each(function(i) {
				var item = _table.row($(this).closest('tr')).data();
				var form=$('#updateForm').val();
				
	            $(form+' [name=inputLotNum]').val(item.polishLotNum);
	           
	            $(form+' [name=fixtureNumber]').val(item.fixtureNumber);
	            $(form+' [name=inputQty]').val(item.outputQty);
	            $("#polishModal").modal("hide");
	        });
		}
		
	});
	 var manage = {
			    currentItem : null,
			    fuzzySearch : true,
			    polishShow: function() {
			    	$polishModal=$("#polishModal");
			    	$polishModal.draggable({handle:".table-header", 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			    	$polishModal.css("overflow", "hidden");
			    	$polishModal.css("overflow-y", "auto");
			    	$polishModal.modal("show");
			    }
			};
});