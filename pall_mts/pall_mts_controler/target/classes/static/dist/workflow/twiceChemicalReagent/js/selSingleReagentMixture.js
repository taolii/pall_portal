$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#div-table-container');
	var $singleReagentMixtureTable = $("#singleReagentMixtureTable").dataTable($.extend(true,
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
            var formData = $("#querySingleReagentMixtureForm").serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                    type: "post",
                    url: contextPath+"/reagent/reagentMixtureSnsManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                    	$wrapper.spinModal(false);
                    }
                });
        },
        columns: [
        	 {className: "td-reagent-radio",title:"选择",width:"20px",data: null,render: function (data, type, row, meta) {
                     return '<input name="select" type="radio" class="ace"><span class="lbl"></span>';
             }},
	        {className : "ellipsis",title:"rmid",data: "rmid",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,"width": "5%"},
	        {className : "ellipsis",title:"reagentsFieldName",data: "reagentsFieldName",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,"width": "5%"},
	        {className : "ellipsis",title:"主试剂",data: "mainReagent",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "30%"},
	        {className : "ellipsis",title:"混合试剂",data: "reagentsName",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "30%"},
	        {className : "ellipsis",title:"试剂编号",data: "reagentsSn",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "30%"}
	     ]
    })).api();
	$("#querySingleReagentMixtureButton").click(function(){
		$singleReagentMixtureTable.draw();
	});
	$("#singleReagentMixtureTable").on("click",".td-reagent-radio",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":radio") && $(":radio",this).trigger("click");
    });
	$("#singleReagentMixtureTable_wrapper").find(".dataTables_length").parent().parent().hide();
	$("#singleReagentMixtureModal").on("shown.bs.modal",function(){
		$.each($.fn.dataTable.tables(true), function(){
			 $(this).DataTable().columns.adjust();
		});
	});
	$("#singleReagentMixtureTable").on("click",".td-radio",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":radio") && $(":radio",this).trigger("click");
    });
	$("#singleReagentMixtureTable").on("change",":radio",function() {
		var item = $singleReagentMixtureTable.row($(this).closest('tr')).data();
		if(!(item.reagentsName && item.reagentsName && item.reagentsSn)){
			showNotice('Error','<span style="padding-top:5px">主试剂、混合试剂、试剂编号不能为空</span>','error',1000*10);
			$(this).prop('checked', false);
			return;
		}
		$($("#addAuxiliaryReagent").val()).parent().parent().find("input").val(item.reagentsSn);
    });
});