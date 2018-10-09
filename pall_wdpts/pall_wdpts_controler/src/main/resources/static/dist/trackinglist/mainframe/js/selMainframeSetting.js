var MainframeSettingModal=function(contextPath,ids){
	var mainframeSettingModal=new Object();
	mainframeSettingModal.contextPath=contextPath;
	mainframeSettingModal.ids=ids;
	mainframeSettingModal.initModalTable=function(){
		var $wrapper = $(ids.wrapper);
		var $table = $(ids.mainframeSettingDatatable);
		$queryForm=$(ids.queryForm);
		var datatables = $table.dataTable($.extend(true,
			{pageLength: 10,"bAutoWidth": false,scrollX: true,ordering: false,"sPaginationType":"full_numbers"},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
			{
	        ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
	            //手动控制遮罩
	            $wrapper.spinModal();
	            //封装请求参数
	            var param = {};
	            param.draw = data.draw;
	            param.startPageNum = data.start;
	            param.pageSize = data.length;
	            var formData = $queryForm.serializeArray();
	            formData.forEach(function (e) {
	                param[e.name] = e.value;
	            });
	            $.ajax({
	                    type: "post",
	                    url: contextPath+"/setting/mainframeSetting",
	                    cache : false,  //禁用缓存
	                    data: param,    //传入已封装的参数
	                    dataType: "json",
	                    success: function(result) {
	                    	 //异常判断与处理
	                        if (result.resultCode!=0) {
	                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>主机装配配置查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
	                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>主机装配配置查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
	                        $wrapper.spinModal(false);
	                    }
	                });
	        },
	        columns: [
	        	{className: "td-radio",title:"选择",width:"60px",data: null,render: function (data, type, row, meta) {
	                return '<input name="select" type="radio" class="ace"><span class="lbl"></span>';
	        	}},
	        	{className : "ellipsis",data: "msid",title:"配置ID",visible:false,render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px"},
	            {className : "ellipsis",data: "mainframePn",title:"料号/PN",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"220px"},
	            {className : "ellipsis",data: null,title:"装配记录/Manufacture Record",render : function(data,type, row, meta) {
	            	return "<div id='showAssemblesDetail' class='action-buttons'><a  href='javascript:void(0)' class='green bigger-140 show-details-btn' title='Show Details'>"+
					"<i class='ace-icon fa fa-angle-double-down'></i>"+
					"<span class='sr-only'>Details</span>"
					"</a></div>";
	            },visible:false,width:"80px"},
	            {className : "ellipsis",data: null,visible:false,title:"送检人员记录/Self Inspection Records",render : function(data,type, row, meta) {
	            	  return "<div id='showInspectsDetail' class='action-buttons'><a  href='javascript:void(0)' class='green bigger-140 show-details-btn' title='Show Details'>"+
						"<i class='ace-icon fa fa-angle-double-down'></i>"+
						"<span class='sr-only'>Details</span>"
						"</a></div>";
	             },width:"80px",visible:false},
	             {className : "ellipsis",data: "operatorName",title:"操作员",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"180px"}
	        ]
	    })).api();
		$(ids.mainframeSettingDatatable+"_wrapper").find(".dataTables_length").parent().parent().hide();
		$(ids.mainframeSettingDatatable).on("click",ids.assemblesDetail,function() {
	    	var item = _table.row($(this).closest('tr')).data();
	    	$(ids.queryForm+" [name=msid]").val(item.msid);
	    	$mainframeAssembleDetailModal=$(ids.modal);
	        $mainframeAssembleDetailModal.draggable({ handle:".table-header",
	    		scroll: true, scrollSensitivity: 100,
	    		cursor: "move"});
	        $mainframeAssembleDetailModal.css("overflow", "hidden");
	        $mainframeAssembleDetailModal.css("overflow-y", "auto");
	        $mainframeAssembleDetailModal.modal("show");
	        modalDataTables.draw();
		}).on("click",ids.inspectsDetail,function() {
	    	var item = _table.row($(this).closest('tr')).data();
	    	$(ids.queryForm+" [name=msid]").val(item.msid);
	    	$mainframeInspectDetailModal=$(ids.modal);
	        $mainframeInspectDetailModal.draggable({ handle:".table-header",
	    		scroll: true, scrollSensitivity: 100,
	    		cursor: "move"});
	        $mainframeInspectDetailModal.css("overflow", "hidden");
	        $mainframeInspectDetailModal.css("overflow-y", "auto");
	        $mainframeInspectDetailModal.modal("show");
	        modalDataTables.draw();
		}).on("click",".td-radio",function(event) {
	        //点击单元格即点击复选框
	        !$(event.target).is(":radio") && $(":radio",this).trigger("click");
	    });
		return datatables;
	}
	mainframeSettingModal.initModalShut=function(modalDataTables,mainframeAssembleTable,mainframeAssembleDatatables,mainframeInspectTable,mainframeInspectDatatables){
		$(ids.shutModalButton).click(function(){
			var radios=$("tbody :radio:checked",$(ids.mainframeSettingDatatable));
			if(radios.length<=0){
				showNotice('Error','请选择一条记录','error',1000*2);
			}else{
				$(radios).each(function(i) {
					var item = modalDataTables.row($(this).closest('tr')).data();
					$(ids.dataForm+" [name=msid]").val(item.msid);
					$(ids.dataForm+" [name=mainframePn]").val(item.mainframePn);
					$(ids.modal).modal("hide");
					mainframeAssembleDatatables.clear().draw();
					mainframeInspectDatatables.clear().draw();
					mainframeAssembleTable.addPreprocssingSettingAssemblesPassAjax(mainframeAssembleDatatables,item.msid);
					mainframeInspectTable.addPreprocssingSettingInspectsPassAjax(mainframeInspectDatatables,item.msid);
		        });
			}
		});
		$(ids.queryModalButton).click(function(){
			modalDataTables.draw();
		});
	}
	return mainframeSettingModal;
}