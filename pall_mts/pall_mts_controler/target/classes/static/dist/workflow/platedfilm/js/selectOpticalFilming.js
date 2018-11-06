$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var manage = {
	    currentItem : null,
	    fuzzySearch : true,
	    opticalFilmingShow: function() {
	    	$opticalFilmingModal=$("#opticalFilmingModal");
	    	$opticalFilmingModal.draggable({handle:".table-header", 
	    		scroll: true, scrollSensitivity: 100,
	    		cursor: "move"});
	    	$opticalFilmingModal.css("overflow", "hidden");
	    	$opticalFilmingModal.css("overflow-y", "auto");
	    	$opticalFilmingModal.modal("show");
	    }
	};
	$('#queryStartOptTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#queryEndOptTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#queryStartOptTime').val(currentDate(30));
	$('#queryEndOptTime').val(currentDate(-1));
	$('#addInputLotNum').click(function(){
		manage.opticalFilmingShow();
		$("#btn-query").click();
	});
	var columns_setting=[
    	TABLE_CONSTANT.DATA_TABLES.COLUMN.RADIO
    ];
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
	$queryForm=$("#queryForm");
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
                url: contextPath+"/workflow/opticalFilmingManage",
                cache : false,  //禁用缓存
                data: param,    //传入已封装的参数
                dataType: "json",
                success: function(result) {
                	 //异常判断与处理
                    if (result.resultCode!=0) {
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>光学镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>光学镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
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
	$("#opticalFilmingModal").on("shown.bs.modal",function(){
		$.each($.fn.dataTable.tables(true), function(){
			 $(this).DataTable().columns.adjust();
		});
	});
	$table.on("click",".td-radio",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":radio") && $(":radio",this).trigger("click");
    });
	$('#selButton').click(function(){
		var radios=$("tbody :radio:checked",$table);
		if(radios.length<=0){
			showNotice('Error','请选择一条记录','error',1000*2);
		}else{
			$(radios).each(function(i) {
				var item = _table.row($(this).closest('tr')).data();
				var form=$('#updateForm').val();
				if(item.outputLotNum.length<8){
					showNotice('Error','OutputLot#字符长度少于8位,请修改后选择','error',1000*2);
					return;
				}
	            $(form+' [name=inputLotNum]').val(item.outputLotNum);
	            $(form+' [name=fixtureNum]').val(item.fixtureNum);
	            $(form+' [name=inputQty]').val(item.outputQty);
	            $("#opticalFilmingModal").modal("hide");
	        });
		}
	});
});