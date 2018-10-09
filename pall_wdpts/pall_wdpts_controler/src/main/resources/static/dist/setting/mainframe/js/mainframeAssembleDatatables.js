$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#mainframeSettingAssemblesContainer');
	var $table = $('#mainframeSettingAssemblesDatatable');
	var _table = $table.dataTable({ 
		"dom": '<"toolbar">frtip',
		paging:false,
		scrollX: false,
		ordering: false,
		searching: false,
		"bAutoWidth": false,
		"info":false,
		language:TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION.language,
        columns: [
        	{className : "ellipsis",data:"componentName",title:"组件名称",render : function(data,type, row, meta) {
            	return "<div  class='form-group'><input type='text' class='form-control'  name='componentName_"+meta.row+"' value='"+data+"'></input>"+
            	 "<input type='hidden' name='assembleid'  value='"+meta.row+"'></input></div>";;
            },width:"300px"},
            {className : "ellipsis",data:"componentNo",title:"组件型号",render : function(data,type, row, meta) {
            	return "<div  class='form-group'><input type='text' class='form-control'  name='componentNo_"+meta.row+"' value='"+data+"'></input></div>";
            },width:"300px"},
            {className : "ellipsis",data:"serialNoRecord",title:"序列号记录",render : function(data,type, row, meta) {
            	return "<div  class='form-group'><input type='text' class='form-control' name='serialNoRecord_"+meta.row+"' value='"+data+"'></input></div>";
            },width:"300px"},
            {className : "ellipsis",data:"remarks",title:"备注",render : function(data,type, row, meta) {
            	return "<div  class='form-group'><input type='text' class='form-control' name='remarks_"+meta.row+"' value='"+data+"'></input></div>";
             },width:"300px"},
             {className : "ellipsis",data:"operator",title:"操作",render : function(data,type, row, meta) {
                	return "<div class='btn-group'>"+
                    "<button id='delMainframeSettingAssembles' class='btn btn-white btn-primary ' type='button'><i class='fa fa-trash-o'></i></button>"+
                    "</div>";
              },width:"100px"},
        ]
    }).api();
	$("#addMainframeSettingAssembles").click(function(){
		_table.row.add({"assembleid":"","componentName":"","componentNo":"","serialNoRecord":"","remarks":"","operator":""}).draw();
	});
	var mainframeSettingAssembles=$("#mainframeSettingAssembles").val();
	mainframeSettingAssembles=eval("(" + mainframeSettingAssembles + ")");
	$.each(mainframeSettingAssembles, function(index, mainframeSettingAssemble){
		_table.row.add(mainframeSettingAssemble).draw();
	});
	$table.on("click","#delMainframeSettingAssembles",function(event) {
		_table.row($(this).closest('tr')).remove().draw();
    });
});
