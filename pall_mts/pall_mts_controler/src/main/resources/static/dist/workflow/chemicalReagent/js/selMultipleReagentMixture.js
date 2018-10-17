$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#div-table-container');
	var $multipleReagentMixtureTable = $("#multipleReagentMixtureTable").dataTable($.extend(true,
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
            var formData = $("#queryMultipleReagentMixtureForm").serializeArray();
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
        	 {className: "td-reagent-checkbox",title:"<input class='ace' type='checkbox' name='cb-check-all'/><span class='lbl'></span>","width": "15%",data: null,render: function (data, type, row, meta) {
                     return '<input name='+data.reagentsFieldName+'_'+data.srmid+' type="checkbox" class="ace"><span class="lbl"></span>';
             }},
	        {className : "ellipsis",title:"srmid",data: "srmid",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,"width": "15%"},
	        {className : "ellipsis",title:"reagentsFieldName",data: "reagentsFieldName",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,"width": "15%"},
	        {className : "ellipsis",title:"配置时间",data: "configTime",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "15%"},
	        {className : "ellipsis",title:"LOT#",data: "lotNum",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "15%"},
	        {className : "ellipsis",title:"主试剂",data: "mainReagent",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "15%"},
	        {className : "ellipsis",title:"混合试剂",data: "reagentsName",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "15%"},
	        {className : "ellipsis",title:"试剂编号",data: "reagentsSn",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "15%"}
	     ],
	     "drawCallback": function( settings ) {
		        $(":checkbox[name='cb-check-all']","#multipleReagentMixtureTable_wrapper").prop('checked', false);
		    	$chemicalReagentPanel=$($("#updateForm").val()+" [id=addChemicalReagentPanel]");
		    	$chemicalReagentPanel.find("input").each(function(){
		    		var cname=$(this).attr("name");
		    		$(":checkbox","#multipleReagentMixtureTable_wrapper").each(function(){
		    			if($(this).attr("name")=='cb-check-all'){
		    				$(this).prop('checked', false);
		    			}
		    			if($(this).attr("name")==cname){
		    				$(this).prop('checked', true);
		    			}
		    		});
	    		});
		     }
    })).api();
	$("#queryMultipleReagentMixtureButton").click(function(){
		$multipleReagentMixtureTable.draw();
	});
	$("#multipleReagentMixtureTable").on("click",".td-reagent-checkbox",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":checkbox") && $(":checkbox",this).trigger("click");
    });
	$("#multipleReagentMixtureTable_wrapper").find(".dataTables_length").parent().parent().hide();
	$("#multipleReagentMixtureModal").on("shown.bs.modal",function(){
		$.each($.fn.dataTable.tables(true), function(){
			 $(this).DataTable().columns.adjust();
		});
	});
	$("[name='cb-check-all']").click(function(){
		$(":checkbox","#multipleReagentMixtureTable").prop("checked",$(this).prop("checked"));
		$(":checkbox","#multipleReagentMixtureTable").each(function(){
			if (!$(this).is("[name='cb-check-all']")) {
				var item = $multipleReagentMixtureTable.row($(this).closest('tr')).data();
	        	if($(this).is(':checked')){
	        		if(!(item.reagentsName && item.reagentsName && item.reagentsSn)){
	        			$(this).prop('checked', false);
	        		}else{
	        			insertReagentMixture(item,true);
	        		}
	        	}else{
	        		insertReagentMixture(item,false);
	        	}
	        }
		});
	});
	$("#multipleReagentMixtureTable").on("change",":checkbox",function() {
        if ($(this).is("[name='cb-check-all']")) {
            //全选
            $(":checkbox","#multipleReagentMixtureTable").prop("checked",$(this).prop("checked"));
        }else{
        	var item = $multipleReagentMixtureTable.row($(this).closest('tr')).data();
        	if($(this).is(':checked')){
        		if(!(item.reagentsName && item.reagentsName && item.reagentsSn)){
        			showNotice('Error','<span style="padding-top:5px">主试剂、混合试剂、试剂编号不能为空</span>','error',1000*10);
        			$(this).prop('checked', false);
        			return;
        		}
        		insertReagentMixture(item,true);
        	}else{
        		insertReagentMixture(item,false);
        	}
        }
    });
	function  insertReagentMixture(item,ischeck){
		var form=$("#updateForm").val();
		$chemicalReagentPanel=$(form+" [id=addChemicalReagentPanel]");
		if(!ischeck){
			$chemicalReagentPanel.find("[name='"+item.reagentsFieldName+"_"+item.srmid+"']").parent().parent().parent().remove();
			return;
		}
		if($chemicalReagentPanel.find("[name='"+item.reagentsFieldName+"_"+item.srmid+"']").length>0){
        	return;
        }
		$newRow   =$("#reagentPanelTemplate").clone().removeAttr('id').find('.reagentPanel').html(item.mainReagent+"|"+item.reagentsName).end();
	    $newRow=$newRow.find('input').attr('name', item.reagentsFieldName+"_"+item.srmid).end();
	    $newRow=$newRow.find('input').val(item.reagentsSn).end().
	             on('click', '.removeButton', function() {
	                $(this).parent().parent().remove();
	    });
		$chemicalReagentPanel.append($newRow).show();
	}
});