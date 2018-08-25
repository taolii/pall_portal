$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#preprocessingSettingInspectsContainer');
	var $table = $('#preprocessingSettingInspectsDatatable');
	
	var _table = $table.dataTable({ 
		"dom": '<"toolbar">frtip',
		paging:false,
		scrollX: false,
		ordering: false,
		searching: false,
		"info":false,
		language:TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION.language,
		columns: [
        	{className : "ellipsis",data:"selfcheckName",title:"自检名称",render : function(data,type, row, meta) {
        		return "<input type='text' class='form-control' name='selfcheckName_"+meta.row+"' value='"+data+"'></input>"+
        		"<input type='hidden' name='inspectid'  value='"+meta.row+"'></input>";
            },width:"100px"},
            {className : "ellipsis",data:"selfcheckContent",title:"自检内容",render : function(data,type, row, meta) {
            	return "<input type='text' class='form-control' name='selfcheckContent_"+meta.row+"' value='"+data+"'></input>";
            },width:"100px"},
            {className : "ellipsis",data:"selfcheckResult",title:"自检结果",render : function(data,type, row, meta) {
            	return "<input type='text' class='form-control' name='selfcheckResult_"+meta.row+"' value='"+data+"'></input>";
            },width:"100px"},
            {className : "ellipsis",data:"remarks",title:"备注",render : function(data,type, row, meta) {
            	  return "<input type='text' class='form-control' name='remarks_"+meta.row+"' value='"+data+"'></input>";
             },width:"100px"},
             {className : "ellipsis",data:"operator",title:"操作",render : function(data,type, row, meta) {
                	return "<div class='btn-group'>"+
                    "<button id='delPreprocessingSettingInspects' class='btn btn-white btn-primary' type='button'><i class='fa fa-trash-o'></i></button>"+
                    "</div>";
              },width:"100px"},
        ]
    }).api();
	$("#addPreprocessingSettingInspects").click(function(){
		_table.row.add({"inspectid":"","selfcheckName":"","selfcheckContent":"","selfcheckResult":"","remarks":"","operator":""}).draw();
	});
	var preprocessingSettingInspects=$("#preprocessingSettingInspects").val();
	preprocessingSettingInspects=eval("(" + preprocessingSettingInspects + ")");
	$.each(preprocessingSettingInspects, function(index, preprocessingSettingInspect){
		_table.row.add(preprocessingSettingInspect).draw();
	});
	$table.on("click","#delPreprocessingSettingInspects",function(event) {
		_table.row($(this).closest('tr')).remove().draw();
    });
});
