$(document).ready(function() {
	$('#queryStartInPutDate').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#queryEndInPutDate').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#queryStartInPutDate').val(currentDate(30));
	$('#queryEndInPutDate').val(currentDate(0));
	var contextPath=$("#contextPath").val();
	var columns_setting=[
    	TABLE_CONSTANT.DATA_TABLES.COLUMN.CHECKBOX
    ];
	var tableFieldBinds=$("#tableFieldBinds").val();
	tableFieldBinds=eval("(" + tableFieldBinds + ")");
	$.each(tableFieldBinds, function(index, tableField){
		var v_visible=true;
		if(tableField.invisible==1){
			v_visible=false;
		}
		if(tableField.fieldName=='reagentMixture'){
			columns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:null,render : function(data,type, row, meta) {
				return "<div id='showDetail' class='action-buttons'><a  href='javascript:void(0)' class='green bigger-140 show-details-btn' title='Show Details'>"+
				"<i class='ace-icon fa fa-angle-double-down'></i>"+
				"<span class='sr-only'>Details</span>"
				"</a></div>";
			},width:"60px","visible":v_visible }) ;  
		}else if(tableField.fieldName=='trayLotNums' ||tableField.fieldName=='tLotNums'||tableField.fieldName=='apsLotNums'||tableField.fieldName=='ocLotNums'
	      || tableField.fieldName=='cleanLotNums'|| tableField.fieldName=='polishLotNums'){
			columns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:tableField.fieldName,render : function(data,type, row, meta) {
				var text=data.substr(0, 10);
				if(data.length>20) text=text+"..";
				return '<span title="' + data + '">' + text+ '</span>';
			},width:"60px","visible":v_visible }) ;
		}else if(tableField.fieldName=='assemblyBoms' || tableField.fieldName=='remark' || tableField.fieldName=='bioBom' || tableField.fieldName=='polishBoms'
			|| tableField.fieldName=='cleanBoms' || tableField.fieldName=='ocBoms' || tableField.fieldName=='apsBoms'){
			columns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:tableField.fieldName,render : function(data,type, row, meta) {
				var text=data.substr(0, 10);
				if(data.length>20) text=text+"..";
				return '<span title="' + data + '">' + text + '</span>';
			},width:"60px","visible":v_visible }) ;
		}else{
			columns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:tableField.fieldName,render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px","visible":v_visible }) ;  
		}
		
	});
	var columns_settingfoot=[
        {className : "td-operation",data: null,render : function(data,type, row, meta) {
        	return "<div class='btn-group'>"+
        	"<button id='copyRow' class='btn btn-xs btn-success' type='button' style='display:none'><i class='ace-icon glyphicon glyphicon-copy bigger-120'></i></button>"+
            "<button id='editRow' class='btn btn-xs btn-info' type='button' style='display:none'><i class='ace-icon fa fa-edit bigger-120'></i></button>"+
            "<button id='delRow' class='btn btn-danger btn-xs' type='button' style='display:none'><i class='ace-icon fa fa-trash-o bigger-120'></i></button>"+
            "</div>";
          }, width : "140px"}
    ];
	columns_setting=columns_setting.concat(columns_settingfoot);
	var $wrapper = $('#div-table-container');
	var $table = $('#datatable');
	$queryForm=$("#queryForm");
	var _table = $table.dataTable($.extend(true,
		{pageLength: 10,scrollX: true,ordering: false,"sPaginationType":"full_numbers"},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
		{
        ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
            //手动控制遮罩
            $wrapper.spinModal();
            //封装请求参数
            var param = {};
            param.draw = data.draw;
            param.startPageNum = data.start;
            param.pageSize = data.length;
            var formData = $queryForm.serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                    type: "post",
                    url: contextPath+"/workflow/chemicalReagentManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>生化镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>生化镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                        $wrapper.spinModal(false);
                    }
                });
        },
        columns:columns_setting ,
        "drawCallback": function( settings ) {
            //渲染完毕后的回调
        	$(":checkbox[name='cb-check-all']","#datatable_wrapper").prop('checked', false);
          //按钮权限初始化
        	manage.initButtonRight();
        }
    })).api();
	$("#datatable_wrapper").find("#datatable_length").parent().parent().hide();
	$("#btn-query").click(function(){
		_table.draw();
	});
	$("#btn_refresh").click(function(){
		_table.draw();
	});
	$("#btn-add").click(function(){
		manage.addItem();
	});
	$("#btn-export").click(function(){
		manage.exportItem();
	});
	$("#btn-delAll").click(function(){
		var arrItemId = [];
        $("tbody :checkbox:checked",$table).each(function(i) {
            var item = _table.row($(this).closest('tr')).data();
            arrItemId.push(item);
        });
        manage.deleteItem(arrItemId);
	});
	$("#datatable_wrapper [name='cb-check-all']").click(function(){
		$(":checkbox",$table).prop("checked",$(this).prop("checked"));
	});
	$table.on("change",":checkbox",function() {
        if ($(this).is("[name='cb-check-all']")) {
            //全选
            $(":checkbox",$table).prop("checked",$(this).prop("checked"));
        }else{
            //一般复选
            var checkbox = $("tbody :checkbox",$table);
            $(":checkbox[name='cb-check-all']",$table).prop('checked', checkbox.length == checkbox.filter(':checked').length);
        }
    }).on("click",".td-checkbox",function(event) {
        //点击单元格即点击复选框
        !$(event.target).is(":checkbox") && $(":checkbox",this).trigger("click");
    }).on("click","#editRow",function() {
        //点击编辑按钮
        var item = _table.row($(this).closest('tr')).data();
        $(this).closest('tr').addClass("active").siblings().removeClass("active");
        
        manage.editItem(item);
    }).on("click","#copyRow",function() {
        //点击编辑按钮
        var item = _table.row($(this).closest('tr')).data();
        $(this).closest('tr').addClass("active").siblings().removeClass("active");
        
        manage.copyItem(item);
    }).on("click","#delRow",function() {
        //点击删除按钮
        var item = _table.row($(this).closest('tr')).data();
        $(this).closest('tr').addClass("active").siblings().removeClass("active");
        manage.deleteItem([item]);
    }).on("click","#showDetail",function() {
    	var item = _table.row($(this).closest('tr')).data();
        manage.showReagentMixtureDetail(item);
	});
	 var manage = {
			    currentItem : null,
			    fuzzySearch : true,
			    editItemInit : function(item) {
			        if (!item) {
			            return;
			        }
			    },
			    addItem: function() {
			    	LoadPage(contextPath+"/workflow/addChemicalReagent");
			    },
			    editItem: function(item) {
			    	LoadPage(contextPath+"/workflow/modChemicalReagent?crID="+item.crID+"&operator=");
			    },
			    copyItem: function(item) {
			    	LoadPage(contextPath+"/workflow/modChemicalReagent?crID="+item.crID+"&operator=copy");
			    },
			    initButtonRight:function(){
			    	var buttonRights=$("#buttonRights").val();
			    	buttonRights=eval("(" + buttonRights + ")");
			    	$.each(buttonRights, function(index, buttonRight){
			    		if("btn-query"==buttonRight.btnEName){
			    			$("#btn-query").show();
			    		}
			    		if("btn-delAll"==buttonRight.btnEName){
			    			$("#btn-delAll").show();
			    		}
			    		if("btn-export"==buttonRight.btnEName){
			    			$("#btn-export").show();
			    		}
			    		if("btn_refresh"==buttonRight.btnEName){
			    			$("#btn_refresh").show();
			    		}
			    		if("btn-add"==buttonRight.btnEName){
			    			$("#btn-add").show();
			    		}
			    		if("copyRow"==buttonRight.btnEName){
			    			$("#datatable #copyRow").each(function(){
			    				$(this).show();
			    			});
			    		}
			    		if("editRow"==buttonRight.btnEName){
			    			$("#datatable #editRow").each(function(){
			    				$(this).show();
			    			});
			    		}
			    		if("delRow"==buttonRight.btnEName){
			    			$("#datatable #delRow").each(function(){
			    				$(this).show();
			    			});
			    		}
			    	});
			    },
			    exportItem:function(){
			    	$wrapper.spinModal();
			    	if($("#queryForm [name=bioPatNum]").val()==''){
			    		$wrapper.spinModal(false);
			    		showNotice('Error','<span style="padding-top:5px">BIO PN#不能为空','error',1000*10);
			    		return;
			    	};
			         $.post(contextPath+"/workflow/exportChemicalReagent",$queryForm.serializeArray(), function(result) {
			        	 if(result.resultCode==0){
			        		 var fileName=encodeURI(result.returnObjects[0].fileName); 
		    	    		 var downUrl = contextPath+'/workflow/excelfileDownload?fileName=' +fileName+"&subDirectory="+result.returnObjects[0].subDirectory;
		    	    		 window.location.href = downUrl;
                    		}else{
                    			showNotice('Error','<span style="padding-top:5px">数据导出失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
                    		}
			        	 $wrapper.spinModal(false);
                     },'json'); 
			    },
			    showReagentMixtureDetail: function(item) {
			    	$("#queryModalForm [name=crID]").val(item.crID);
			    	$reagentMixtureDetailModal=$("#reagentMixtureDetailModal");
			        $reagentMixtureDetailModal.draggable({ handle:".table-header",
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			        $reagentMixtureDetailModal.css("overflow", "hidden");
			        $reagentMixtureDetailModal.css("overflow-y", "auto");
			        $reagentMixtureDetailModal.modal("show");
			        $("#queryModalButton").click();
			    },
			    deleteItem : function(selectedItems) {
			        var message;
			        if (selectedItems&&selectedItems.length) {
			            if (selectedItems.length == 1) {
			                message = "确定要删除选中的"+selectedItems.length+"项记录吗?";
			 
			            }else{
			                message = "确定要删除选中的"+selectedItems.length+"项记录吗?";
			            }
			            Lobibox.confirm({
			                msg: message,
			                title:Lobibox.base.OPTIONS.title.info,
			                callback: function ($this, type) {
			                    if (type === 'yes') {
			                    	var crIDs="";
			                    	$(selectedItems).each(function(i) {
			                    		crIDs=crIDs+selectedItems[i].crID+",";
			                        });
			                    	crIDs=crIDs.substr(crIDs,crIDs.length-1);
			                    	$.post(contextPath+"/workflow/delChemicalReagent",{"crIDs":crIDs}, function(result) {
			                    		if(result.resultCode==0){
			                    			showNotice('Success',"生化镀膜信息删除成功",'success',1000*5);
			                    			$("#btn_refresh").click();
			                    		}else{
			                    			showNotice('Error','<span style="padding-top:5px">生化镀膜信息删除失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
			                    		}
			                        },'json'); 
			                    }
			                }
			            });
			        }else{
			        	showNotice('Info',"请先选中要删除的记录",'info',1000*5);
			        }
			    }
			};
});