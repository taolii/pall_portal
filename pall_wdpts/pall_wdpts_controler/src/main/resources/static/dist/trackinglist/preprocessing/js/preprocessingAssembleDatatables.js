var PreprocessingAssembleTable=function(contextPath,ids){
	var preprocessingAssembleTable=new Object();
	preprocessingAssembleTable.contextPath=contextPath;
	preprocessingAssembleTable.ids=ids;
	preprocessingAssembleTable.initTable=function(){
		var datatable=$(ids.preprocessingAssembleTable).dataTable({ 
			"dom": '<"toolbar">frtip',
			paging:false,
			scrollX: false,
			ordering: false,
			searching: false,
			"info":false,
			language:TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION.language,
			columns: [
	        	{className : "ellipsis",data:"componentName",title:"组件名称",render : function(data,type, row, meta) {
	        		var component="<input type='hidden'  name='componentName_"+meta.row+"' value='"+data+"'></input>"+
	           	 "<input type='hidden' name='assembleid'  value='"+meta.row+"'></input>";
			          if(data){//不为空
			        	  $.each(data.split("|"), function(index, componentName){
			        		  component=component+componentName+"<br>";
			        		});
			        	}
			          return "<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+component+"</span>";
	           },width:"100px"},
		        {className : "ellipsis",data:"componentNo",title:"组件型号",render : function(data,type, row, meta) {
		        	var component="<input type='hidden'  name='componentNo_"+meta.row+"' value='"+data+"'></input>";
	            	if(data){//不为空
			        	 
			        	  $.each(data.split("|"), function(index, componentNo){
			        		  component=component+componentNo+"<br>";
			        		});
			        	 
			        	}
	            	return "<span data-toggle='tooltip' data-placement='bottom' title='"+data+"'>"+component+"</span>";
	            },width:"100px"},
		        {className : "ellipsis",data:"serialNoRecord",title:"序列号记录",render : function(data,type, row, meta) {
		          var component="";
		          if(data){//不为空
		        	 
		        	  $.each(data.split("|"), function(index, serialNoRecord){
		        		  component=component+"<label class='radio-inline'><input type='radio' checked='checked' name='serialNoRecord"+meta.row+"' value='"+serialNoRecord+"'>&nbsp;&nbsp;"+serialNoRecord+"</input></label>";
		        		});
		        	  
		        	}else{
		        		component=component+"<input type='text' class='form-control' name='serialNoRecord"+meta.row+"' value=''/>";
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
	preprocessingAssembleTable.addPreprocessingAssembles=function(datatable,datas){
		datas=eval("(" + datas + ")");
		$.each(datas, function(index, data){
			datatable.row.add(data).draw();
		});
	}
	preprocessingAssembleTable.addPreprocssingSettingAssemblesPassAjax=function(datatable,psid){
		$.ajax({
			type:'post',
            url:preprocessingAssembleTable.contextPath+"/setting/preprocessingAssembleDetail",
            data:{"psid":psid},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	preprocessingAssembleTable.addPreprocessingAssembles(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	preprocessingAssembleTable.addPreprocessingAssemblesPassAjax=function(datatable,preprocessingID){
		$.ajax({
			type:'post',
            url:preprocessingAssembleTable.contextPath+"/trackinglist/preprocessingAssembleDetail",
            data:{"preprocessingID":preprocessingID},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	preprocessingAssembleTable.addPreprocessingAssembles(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	return preprocessingAssembleTable;
}