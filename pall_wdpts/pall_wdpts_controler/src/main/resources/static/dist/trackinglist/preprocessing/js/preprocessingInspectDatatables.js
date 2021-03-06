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
	        		 var component="<input type='hidden'  name='selfcheckName_"+meta.row+"' value='"+data+"'></input>"+
	        		"<input type='hidden' name='inspectid'  value='"+meta.row+"'></input>";
			          if(data){//不为空
			        	  $.each(data.split("|"), function(index, selfcheckName){
			        		  component=component+selfcheckName+"<br>";
			        		});
			        	}
			          return "<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+component+"</span>";
	            },width:"100px"},
	 	        {className : "ellipsis",data:"selfcheckContent",title:"自检内容",render : function(data,type, row, meta) {
	 	        	var component="<input type='hidden'  name='selfcheckContent_"+meta.row+"' value='"+data+"'></input>";
			          if(data){//不为空
			        	  $.each(data.split("|"), function(index, selfcheckContent){
			        		  component=component+selfcheckContent+"<br>";
			        		});
			        	}
			          return "<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+component+"</span>";
	            },width:"100px"},
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
	 		        				component=component+"<label class='radio-inline'><input type='radio' checked='checked' name='selfcheckResult_"+meta.row+"' value='"+tempVaule+"'>&nbsp;&nbsp;"+selfcheckResult+"</input></label>";
	 		        			 }else{
	 		        				component=component+"<label class='radio-inline'><input type='radio'  name='selfcheckResult_"+meta.row+"' value='"+tempVaule+"'>&nbsp;&nbsp;"+selfcheckResult+"</input></label>"; 
	 		        			 }
		 		        	});
	 		        	  }else{
	 		        		 component=component+"<input type='text' class='form-control' name='selfcheckResult_"+meta.row+"' value='"+data+"'/>";
	 		        	  }
			        	}else{
			        		component=component+"<input type='text' class='form-control' name='selfcheckResult_"+meta.row+"' value=''/>";
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
	preprocessingInspectTable.addPreprocssingSettingInspectsPassAjax=function(datatable,psid,preprocessingPn){
		$.ajax({
			type:'post',
            url:preprocessingInspectTable.contextPath+"/setting/preprocessingInspectDetail",
            data:{"psid":psid,"preprocessingPn":preprocessingPn},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		if(result.datatablesView.recordsTotal==0){
        	   		showNotice('提示','未查询到匹配信息','success',1000*10);
         	   	   return;
        	   	};
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