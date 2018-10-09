var MainframeAssembleTable=function(contextPath,ids){
	var mainframeAssembleTable=new Object();
	mainframeAssembleTable.contextPath=contextPath;
	mainframeAssembleTable.ids=ids;
	mainframeAssembleTable.initTable=function(){
		var datatable=$(ids.mainframeAssembleTable).dataTable({ 
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
		        	  var datas=data.split("|");
 		        	  if(datas && datas.length>=2){
 		        		 var checkedIndex=0;
 		        		 $.each(datas, function(index, serialNoRecord){
 		        			 if(index==0){
 		        				var temps=serialNoRecord.split('_');
 		        				if(temps.length>=2){
 	 		        				 checkedIndex=temps[0];
 	 		        				data=data.substr(temps[0].length+1,data.length);
 	 		        				serialNoRecord=serialNoRecord.substr(temps[0].length+1,serialNoRecord.length);
 	 		        			 }
 		        			  }
 		        			 var tempVaule=index+"_"+data;
 		        			 if(checkedIndex==index){
 		        				component=component+"<label class='radio-inline'><input type='radio' checked='checked' name='serialNoRecord_"+meta.row+"' value='"+tempVaule+"'>&nbsp;&nbsp;"+serialNoRecord+"</input></label>";
 		        			 }else{
 		        				component=component+"<label class='radio-inline'><input type='radio'  name='serialNoRecord_"+meta.row+"' value='"+tempVaule+"'>&nbsp;&nbsp;"+serialNoRecord+"</input></label>"; 
 		        			 }
	 		        	});
 		        	  }else{
 		        		 component=component+"<input type='text' class='form-control' name='serialNoRecord_"+meta.row+"' value='"+data+"'/>";
 		        	  }
		        	}else{
		        		component=component+"<input type='text' class='form-control' name='serialNoRecord_"+meta.row+"' value=''/>";
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
	mainframeAssembleTable.addMainframeAssembles=function(datatable,datas){
		datas=eval("(" + datas + ")");
		$.each(datas, function(index, data){
			datatable.row.add(data).draw();
		});
	}
	mainframeAssembleTable.addPreprocssingSettingAssemblesPassAjax=function(datatable,msid){
		$.ajax({
			type:'post',
            url:mainframeAssembleTable.contextPath+"/setting/mainframeAssembleDetail",
            data:{"msid":msid},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	mainframeAssembleTable.addMainframeAssembles(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	mainframeAssembleTable.addMainframeAssemblesPassAjax=function(datatable,mainframeID){
		$.ajax({
			type:'post',
            url:mainframeAssembleTable.contextPath+"/trackinglist/mainframeAssembleDetail",
            data:{"mainframeID":mainframeID},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	mainframeAssembleTable.addMainframeAssembles(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	return mainframeAssembleTable;
}