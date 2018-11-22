var MainframeInspectTable=function(contextPath,ids){
	var mainframeInspectTable=new Object();
	mainframeInspectTable.contextPath=contextPath;
	mainframeInspectTable.ids=ids;
	mainframeInspectTable.initTable=function(){
		var datatable=$(ids.mainframeInspectTable).dataTable({ 
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
	 	        	var trs="";
		        	if(data.length>0){
		        		for(var i=0;i<data.length;i++){
		        			if(data.charAt(i)==0){
		        				trs=trs+"<td><input disabled='disabled' name='selfcheckContent_"+meta.row+"_"+(i+1)+"' class='ace ace-switch btn-empty' type='checkbox' value='1'><span class='lbl' data-lbl='ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OFF'></span></td>";
		        			}else{
		        				trs=trs+"<td><input disabled='disabled' name='selfcheckContent_"+meta.row+"_"+(i+1)+"' class='ace ace-switch btn-empty' checked='true' type='checkbox' value='1'><span class='lbl' data-lbl='ON&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;OFF'></span></td>";
		        			}
		        		}
		        	}
		        	return "" +
	            	"<input type='hidden' name='selfcheckContent_"+meta.row+"' value='"+data+"'></input><table style='border:1px'>" +
	            	"<tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td></tr>" +
	            	"<tr>" +
	            	trs
	            	"</tr>" +
	            	"<table>"+
	            			"";
	            },width:"800px"},
	 	        {className : "ellipsis",data:"selfcheckResult",title:"自检结果",render : function(data,type, row, meta) {
		          	  return "<input type='text' readonly='readonly' class='col-xs-12' name='selfcheckResult_"+meta.row+"' value='"+data+"'></input>";
	 	            },"width": "180px"},
	 	        {className : "ellipsis",data:"remarks",title:"备注",render : function(data,type, row, meta) {
	          	  return "<input type='text' class='col-xs-12' name='inspect_remarks_"+meta.row+"' value='"+data+"'></input>";
	            },"width": "180px"}
		     ]
	    }).api();
		return datatable;
	}
	mainframeInspectTable.addMainframeInspects=function(datatable,datas){
		datas=eval("(" + datas + ")");
		$.each(datas, function(index, data){
			datatable.row.add(data).draw();
		});
	}
	mainframeInspectTable.addMainframeSettingInspectsPassAjax=function(datatable,msid,mainframePn){
		$.ajax({
			type:'post',
            url:mainframeInspectTable.contextPath+"/setting/mainframeInspectDetail",
            data:{"msid":msid,"mainframePn":mainframePn},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		if(result.datatablesView.recordsTotal==0){
        	   		//showNotice('提示','未查询到匹配信息','success',1000*10);
         	   	   return;
        	   	};
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	mainframeInspectTable.addMainframeInspects(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	mainframeInspectTable.addMainframeInspectsPassAjax=function(datatable,mainframeID){
		$.ajax({
			type:'post',
            url:mainframeInspectTable.contextPath+"/trackinglist/mainframeInspectDetail",
            data:{"mainframeID":mainframeID},
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        		var datas=JSON.stringify(result.datatablesView.data);
        	   	mainframeInspectTable.addMainframeInspects(datatable,datas);
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	return mainframeInspectTable;
}