var PreprocessingInspectTable=function(contextPath,ids){
	var preprocessingInspectTable=new Object();
	preprocessingInspectTable.contextPath=contextPath;
	preprocessingInspectTable.ids=ids;
	preprocessingInspectTable.initTable=function(){
		var datatable=$(ids.preprocessingInspectTable).dataTable({ 
			"dom": '<"toolbar">frtip',
			paging:false,
			scrollX: false,
			ordering: false,
			searching: false,
			"info":false,
			language:TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION.language,
			columns: [
	        	 {className : "ellipsis",data:"selfcheckName",title:"自检名称",render : function(data,type, row, meta) {
	        		return "<input type='text' readonly='readonly' class='form-control' name='selfcheckName_"+meta.row+"' value='"+data+"'></input>"+
	        		"<input type='hidden' name='inspectid'  value='"+meta.row+"'></input>";
	            },width:"100px"},
	 	        {className : "ellipsis",data:"selfcheckContent",title:"自检内容",render : function(data,type, row, meta) {
	            	return "<input type='text' readonly='readonly' class='form-control' name='selfcheckContent_"+meta.row+"' value='"+data+"'></input>";
	            },width:"100px"},
	 	        {className : "ellipsis",data:"selfcheckResult",title:"自检结果",render : function(data,type, row, meta) {
	 		          var component="";
	 		          if(data){//不为空
	 		        	  component=component+"<div class='form-group text-left'>";
	 		        	  $.each(data.split("|"), function(index, selfcheckResult){
	 		        		  component=component+"<input type='radio' checked='checked' class='form-control'  name='selfcheckResult"+meta.index+"' value='"+selfcheckResult+"'>&nbsp;&nbsp;"+selfcheckResult+"</input>&nbsp;&nbsp;";
	 		        		});
	 		        	  component=component+"</div>";
	 		        	}else{
	 		        		component=component+"<input type='text' class='form-control' name='selfcheckResult"+meta.index+"' value=''/>";
	 		        	}
	 	          	  return component;
	 	            },"width": "200px"},
	 	        {className : "ellipsis",data:"remarks",title:"备注",render : function(data,type, row, meta) {
	          	  return "<input type='text' class='form-control' name='remarks_"+meta.row+"' value='"+data+"'></input>";
	            },"width": "200px"}
		     ]
	    }).api();
		return datatable;
	}
	preprocessingInspectTable.addPreprocessingInspects=function(datatable,datas){
		datas=eval("(" + datas + ")");
		$.each(datas, function(index, data){
			datatable.row.add(data).draw();
		});
	}
	preprocessingInspectTable.addPreprocssingSettingInspectsPassAjax=function(datatable,psid){
		$.ajax({
			type:'post',
            url:preprocessingInspectTable.contextPath+"/setting/preprocessingInspectDetail",
            data:{"psid":psid},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	preprocessingInspectTable.addPreprocessingInspects(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	preprocessingInspectTable.addPreprocessingInspectsPassAjax=function(datatable,preprocessingID){
		$.ajax({
			type:'post',
            url:preprocessingInspectTable.contextPath+"/trackinglist/preprocessingInspectDetail",
            data:{"preprocessingID":preprocessingID},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	preprocessingInspectTable.addPreprocessingInspects(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	return preprocessingInspectTable;
}