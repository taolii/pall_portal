$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#div-table-container');
	var $table = $('#datatable');
	$queryForm=$("#queryForm");
	var _table = $table.dataTable($.extend(true,
		{pageLength: 10,scrollX: true,"bAutoWidth": false,ordering: false,"sPaginationType":"full_numbers"},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
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
                    url: contextPath+"/setting/cisternSetting",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>水箱装配配置查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>水箱装配配置查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                        $wrapper.spinModal(false);
                    }
                });
        },
        columns: [
        	 {className: "ellipsis",title:"<input class='ace' type='checkbox' name='cb-check-all'/><span class='lbl'></span>",width:"20px",data: null,render: function (data, type, row, meta) {
                 return '<input  type="checkbox" class="ace"><span class="lbl"></span>';
        	 }},
        	{className : "ellipsis",data: "csid",title:"配置ID",visible:false,render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px"},
            {className : "ellipsis",data: "cisternPn",title:"料号/PN",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"190px"},
            {className : "ellipsis",data: null,title:"装配记录/Manufacture Record",render : function(data,type, row, meta) {
            	return "<div id='showAssemblesDetail' class='action-buttons'><a  href='javascript:void(0)' class='green bigger-140 show-details-btn' title='Show Details'>"+
				"<i class='ace-icon fa fa-angle-double-down'></i>"+
				"<span class='sr-only'>Details</span>"
				"</a></div>";
            },width:"160px"},
             {className : "ellipsis",data: "operatorName",title:"操作员",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"160px"},
             {className : "ellipsis",data: null,title:"操作",render : function(data,type, row, meta) {
                	return "<div class='btn-group'>"+
                	"<button id='copyRow' class='btn btn-primary btn-xs' type='button' ><i class='glyphicon glyphicon-copy'></i></button>"+
                    "<button id='editRow' class='btn btn-primary btn-xs' type='button'><i class='fa fa-edit'></i></button>"+
                    "<button id='delRow' class='btn btn-primary btn-xs' type='button'><i class='fa fa-trash-o'></i></button>"+
                    "</div>";
              },width:"160px"},
        ],
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
    }).on("click","#showAssemblesDetail",function() {
    	var item = _table.row($(this).closest('tr')).data();
        manage.showAssemblesDetail(item);
	});
	 var manage = {
	    currentItem : null,
	    fuzzySearch : true,
	    addItem: function() {
	    	LoadPage(contextPath+"/setting/addCisternSetting");
	    },
	    copyItem: function(item) {
	    	LoadPage(contextPath+"/setting/modCisternSetting?csid="+item.csid+"&operator=copy");
	    },
	    editItem: function(item) {
	    	LoadPage(contextPath+"/setting/modCisternSetting?csid="+item.csid+"&operator=");
	    },
	    initButtonRight:function(){
	    	var buttonRights=$("#buttonRights").val();
	    	buttonRights=eval("(" + buttonRights + ")");
	    	$.each(buttonRights, function(index, buttonRight){
	    	});
	    },
	    showAssemblesDetail: function(item) {
	    	$("#cisternAssembleDetailForm [name=csid]").val(item.csid);
	    	$cisternAssembleDetailModal=$("#cisternAssembleDetailModal");
	        $cisternAssembleDetailModal.draggable({ handle:".table-header",
	    		scroll: true, scrollSensitivity: 100,
	    		cursor: "move"});
	        $cisternAssembleDetailModal.css("overflow", "hidden");
	        $cisternAssembleDetailModal.css("overflow-y", "auto");
	        $cisternAssembleDetailModal.modal("show");
	        $("#cisternAssembleDetailButton").click();
	        
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
	                    	var csids="";
	                    	$(selectedItems).each(function(i) {
	                    		csids=csids+selectedItems[i].csid+",";
	                        });
	                    	csids=csids.substr(csids,csids.length-1);
	                    	$.post(contextPath+"/setting/delCisternSetting",{"csids":csids}, function(result) {
	                    		if(result.resultCode==0){
	                    			showNotice('Success',"水箱装配配置删除成功",'success',1000*5);
	                    			$("#btn_refresh").click();
	                    		}else{
	                    			showNotice('Error','<span style="padding-top:5px">水箱装配配置删除失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
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