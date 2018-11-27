$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#mainframeSettingInspectsContainer');
	var $table = $('#mainframeSettingInspectsDatatable');
	
	var _table = $table.dataTable({ 
		"dom": '<"toolbar">frtip',
		paging:false,
		scrollX: false,
		ordering: false,
		"bAutoWidth": false,
		searching: false,
		"info":false,
		language:TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION.language,
		columns: [
        	{className : "ellipsis",data:"selfcheckName",title:"自检名称",render : function(data,type, row, meta) {
        		return "<input type='text' class='col-xs-12' name='selfcheckName_"+meta.row+"' value='"+data+"'></input>"+
        		"<input type='hidden' name='inspectid'  value='"+meta.row+"'></input>";
            },width:"120px"},
            {className : "center",data:"selfcheckContent",title:"自检内容",render : function(data,type, row, meta) {
            	var trs="";
            	if(data.length==0){
            		data="00000000";
            	}
	        	if(data.length>0){
	        		for(var i=0;i<data.length;i++){
	        			if(data.charAt(i)==0){
	        				trs=trs+"<td><input name='selfcheckContent_"+meta.row+"_"+(i+1)+"' class='ace ace-switch ace-switch-4 btn-rotate' type='checkbox' value='1'><span class='lbl'></span></td>";
	        			}else{
	        				trs=trs+"<td><input name='selfcheckContent_"+meta.row+"_"+(i+1)+"' class='ace ace-switch ace-switch-4 btn-rotate' checked='true' type='checkbox' value='1'><span class='lbl'></span></td>";
	        			}
	        		}
	        	}
	        	return "" +
            	"<table>" +
            	"<tr><td>1</td><td>2</td><td>3</td><td>4</td><td>5</td><td>6</td><td>7</td><td>8</td></tr>" +
            	"<tr>" +
            	trs
            	"</tr>" +
            	"<table>"+
            			"";
            },width:"500px"},
            {className : "ellipsis",data:"selfcheckResult",title:"自检结果",render : function(data,type, row, meta) {
            	return "<input type='text' class='col-xs-12' name='selfcheckResult_"+meta.row+"' value='"+data+"'></input>";
            },width:"120px"},
            {className : "ellipsis",data:"remarks",title:"备注",render : function(data,type, row, meta) {
            	  return "<input type='text' class='col-xs-12' name='inspect_remarks_"+meta.row+"' value='"+data+"'></input>";
             },width:"120px"},
             {className : "ellipsis",data:"operator",title:"操作",render : function(data,type, row, meta) {
                	return "<div class='btn-group'>"+
                    "<button id='delMainframeSettingInspects' class='btn btn-white btn-primary' type='button'><i class='fa fa-trash-o'></i></button>"+
                    "</div>";
              },width:"30px"},
        ]
    }).api();
	$("#addMainframeSettingInspects").click(function(){
		_table.clear();
		_table.row.add({"inspectid":"","selfcheckName":"","selfcheckContent":"","selfcheckResult":"","remarks":"","operator":""}).draw();
	});
	var mainframeSettingInspects=$("#mainframeSettingInspects").val();
	mainframeSettingInspects=eval("(" + mainframeSettingInspects + ")");
	$.each(mainframeSettingInspects, function(index, mainframeSettingInspect){
		_table.row.add(mainframeSettingInspect).draw();
	});
	$table.on("click","#delMainframeSettingInspects",function(event) {
		_table.row($(this).closest('tr')).remove().draw();
    });
});
