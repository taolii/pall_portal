$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#div-table-container');
	var $detailTable = $("#preprocessingInspectDetailTable").dataTable($.extend(true,
		{"dom": '<"toolbar">frtip',"bAutoWidth": false,paging:false,scrollX: false,ordering: false,searching: false,"info":false},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
		{
        ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
            //手动控制遮罩
        	$wrapper.spinModal();
            //封装请求参数
            var param = {};
            param.draw = data.draw;
            param.startPageNum = data.start;
            param.pageSize = data.length;
            var formData = $("#preprocessingInspectDetailForm").serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                    type: "post",
                    url: contextPath+"/setting/preprocessingInspectDetail",
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
        	{className : "ellipsis",data:"selfcheckName",title:"自检名称",render : function(data,type, row, meta) {
        		var component="";
  	          	if(data){//不为空
  	        	  $.each(data.split("|"), function(index, selfcheckName){
  	        		  component=component+selfcheckName+"<br>";
  	        		});
  	        	}
  	          return "<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+component+"</span>";
            },"width": "100px"},
	        {className : "ellipsis",data:"selfcheckContent",title:"自检内容",render : function(data,type, row, meta) {
        		var component="";
  	          	if(data){//不为空
  	        	  $.each(data.split("|"), function(index, selfcheckContent){
  	        		  component=component+selfcheckContent+"<br>";
  	        		});
  	        	}
  	          return "<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+component+"</span>";
            },"width": "100px"},
	        {className : "ellipsis",data:"selfcheckResult",title:"自检结果",render : function(data,type, row, meta) {
	        	var component="";
		          if(data){//不为空
		        	  var datas=data.split("|");
		        	  if(datas && datas.length>=2){
		        		 var checkedIndex=0;
		        		 $.each(datas, function(index, selfcheckResult){
		        			 if(index==0){
		        				var temps=selfcheckResult.split('_');
		        				if(temps.length>=2){
	 		        				 checkedIndex=temps[0];
	 		        				data=data.substr(temps[0].length+1,data.length);
	 		        				selfcheckResult=selfcheckResult.substr(temps[0].length+1,selfcheckResult.length);
	 		        			 }
		        			  }
		        			 var tempVaule=index+"_"+data;
		        			 if(checkedIndex==index){
		        				component=component+"<label class='radio-inline' title='"+selfcheckResult+"' ><input type='radio' checked='checked'  name='selfcheckResult_"+meta.row+"' value='"+tempVaule+"'>&nbsp;&nbsp;"+selfcheckResult+"</input></label>";
		        			 }else{
		        				component=component+"<label class='radio-inline' title='"+selfcheckResult+"'><input type='radio'   name='selfcheckResult_"+meta.row+"' value='"+tempVaule+"'>&nbsp;&nbsp;"+selfcheckResult+"</input></label>"; 
		        			 }
	 		        	});
		        	  }else{
		        		 component="<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+data+"</span>"
		        	  }
		        	}else{
		        		component="<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+data+"</span>"
		        	}
	          return component;
	            },"width": "200px"},
	        {className : "ellipsis",data:"remarks",title:"备注",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"width": "100px"}
	     ]
    })).api();
	$("#preprocessingInspectDetailButton").click(function(){
		$detailTable.draw();
	});
	$("#preprocessingInspectDetailModal").on("shown.bs.modal",function(){
		$.each($.fn.dataTable.tables(true), function(){
			 $(this).DataTable().columns.adjust();
		});
	});
});