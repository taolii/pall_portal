$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	$('#addInputLotNum').click(function(){
		manage.platedFilmShow();
		var form=$('#updateForm').val();
        $("#queryForm [name=fixtureAttribute]").val($(form+' [name=fixtureAttribute]').val());
	});
	
	var columns_setting=[
    	TABLE_CONSTANT.DATA_TABLES.COLUMN.CHECKBOX
    ];
	var $wrapper = $('#div-table-container');
	var $table = $('#datatable');
	$platedFilmQueryForm=$("#queryForm");
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
            var formData = $platedFilmQueryForm.serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                    type: "post",
                    url: contextPath+"/workflow/platedFilmManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>化学镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>化学镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                        $wrapper.spinModal(false);
                    }
                });
        },
        columns: [
        	{className: "ellipsis",title:"选择",width:"20px",data: null,render: function (data, type, row, meta) {
                return '<input name="select" type="radio" class="ace"><span class="lbl"></span>';
        	}},
   	        {className : "ellipsis",title:"pfID",data: "pfID",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,"width": "1%"},
   	        {className : "ellipsis",title:"Coating Date",data: "coatingTime",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"Date",data: "pfTime",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"Input LOT#",data: "inputLotNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"Input Qty(pcs)",data: "inputQty",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"Fixture#",data: "fixtureNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"Output LOT#",data: "outputLotNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"Output Qty(pcs)",data: "outputQty",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"PN#",data: "partNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	        {className : "ellipsis",title:"WON#",data: "workOrderNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "10%"},
   	     ]
    })).api();
	$("#datatable_length").parent().parent().hide();
	$("#btn-query").click(function(){
		_table.draw();
	});
	$("#selectPlatedFilmModal").on("shown.bs.modal",function(){
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
	            $(form+' [name=inputLotNum]').val(item.outputLotNum);
	            $(form+' [name=fixtureNum]').val(item.fixtureNum);
	            $(form).data('bootstrapValidator').validateField('inputLotNum');
	            $(form).data('bootstrapValidator').validateField('fixtureNum');
	            $("#selectPlatedFilmModal").modal("hide");
	        });
		}
		
	});
	var manage = {
		    currentItem : null,
		    fuzzySearch : true,
		    platedFilmShow: function() {
		    	$platedFilmModal=$("#selectPlatedFilmModal");
		    	$platedFilmModal.draggable({ 
		    		scroll: true, scrollSensitivity: 100,
		    		cursor: "move"});
		    	$platedFilmModal.css("overflow", "hidden");
		    	$platedFilmModal.css("overflow-y", "auto");
		    	$platedFilmModal.modal("show");
		    }
		};
});