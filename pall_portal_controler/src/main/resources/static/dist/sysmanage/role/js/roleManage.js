$(document).ready(function() {
	var contextPath=$("#contextPath").val();
	var $wrapper = $('#div-table-container');
	var $table = $('#datatable');
	var _table = $table.dataTable($.extend(true,
		{pageLength: 10,ordering: false,"sPaginationType":"full_numbers"},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
		{
        ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
            //手动控制遮罩
            $wrapper.spinModal();
            //封装请求参数
            var param = {};
            param.draw = data.draw;
            param.startPageNum = data.start;
            param.pageSize = data.length;
            var formData = $("#queryForm").serializeArray();
            var dataType=""
            formData.forEach(function (e) {
            	dataType = dataType+e.value;
            });
            param["dataType"] = dataType;
            $.ajax({
                    type: "post",
                    url: contextPath+"/role/roleManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	showNotice('Error','<span style="padding-top:5px">用户角色查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
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
                    	showNotice('Error','<span style="padding-top:5px">角色信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
                    	$wrapper.spinModal(false);
                    }
                });
        },
        columns: [
        	TABLE_CONSTANT.DATA_TABLES.COLUMN.CHECKBOX,
        	{className : "ellipsis",data: "roleid",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px"},
            {className : "ellipsis",data: "roleName",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"70px"},
            {className : "ellipsis",data: "pRoleid",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"70px"},
            {className : "ellipsis",data: "pRoleName",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"70px"},
            {className : "ellipsis",data: "rDetail",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px"},
            {className : "td-operation",data: null,render : function(data,type, row, meta) {
            	return "<div class='btn-group'>"+
                "<button id='editRow' data-toggle='tooltip' data-placement='top' title='编辑角色' class='btn btn-xs btn-info' type='button'><i class='ace-icon fa fa-edit bigger-120'></i></button>"+
                "<button id='delRow' data-toggle='tooltip' data-placement='top' title='删除角色' class='btn btn-danger btn-xs' type='button'><i class='ace-icon fa fa-trash-o bigger-120'></i></button>"+
                "<button id='addRightRow' data-toggle='tooltip' data-placement='top' title='添加权限' class='btn btn-success btn-xs' type='button' ><i  class='ace-icon fa fa-plus bigger-120'></i></button>"+
                "</div>";
              }, width : "60px"}
        ],
        "columnDefs": [
            {
              "targets": [1,3],
              "visible": false
            }
          ],
        "drawCallback": function( settings ) {
            //渲染完毕后的回调
            //清空全选状态
            $(":checkbox[name='cb-check-all']",$wrapper).prop('checked', false);
            //默认选中第一行
            $("tbody tr",$table).eq(0).click();
        }
    })).api();
	$("#datatable_length").parent().parent().hide();
	$("#btn-query").click(function(){
		_table.draw();
	});
	$("#btn_refresh").click(function(){
		_table.draw();
	});
	$("#btn-add").click(function(){
		roleManage.addItemInit();
		roleManage.addItemShow();
	});
	$("#btn-delAll").click(function(){
		var arrItemId = [];
        $("tbody :checkbox:checked",$table).each(function(i) {
            var item = _table.row($(this).closest('tr')).data();
            arrItemId.push(item);
        });
        roleManage.deleteItem(arrItemId);
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
        roleManage.currentItem = item;
        roleManage.editItemInit(item);
        roleManage.editItemShow();
    }).on("click","#delRow",function() {
        //点击删除按钮
        var item = _table.row($(this).closest('tr')).data();
        $(this).closest('tr').addClass("active").siblings().removeClass("active");
        roleManage.deleteItem([item]);
    }).on("click","#addRightRow",function() {
    	 var item = _table.row($(this).closest('tr')).data();
         $(this).closest('tr').addClass("active").siblings().removeClass("active");
         roleManage.currentItem = item;
         roleManage.addRightItemShow(item);
    });
	 var roleManage = {
			    currentItem : null,
			    fuzzySearch : true,
			    editItemInit : function(item) {
			        if (!item) {
			            return;
			        }
			       $("#modDataForm").data('bootstrapValidator').resetForm(true);
			       $("#modDataForm [name=roleid]").val(item.roleid);
			       $("#modDataForm [name=roleName]").val(item.roleName);
			       $("#modDataForm [name=rDetail]").val(item.rDetail);
			    },
			    addItemInit : function() {
			    	$("#addDataForm").data('bootstrapValidator').resetForm(true);
			    },
			    addItemShow: function() {
			    	$addModal=$("#addModal");
			    	$addModal.draggable({ 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			    	$addModal.css("overflow", "hidden");
			    	$addModal.css("overflow-y", "auto");
			    	$addModal.modal("show");
			    },
			    editItemShow: function() {
			        $modModal=$("#modModal");
			        $modModal.draggable({ 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			        $modModal.css("overflow", "hidden");
			        $modModal.css("overflow-y", "auto");
			        $modModal.modal("show");
			    },
			    addRightItemShow: function(item) {
			    	var ids={"treeView":"#buttonTreeView"};
				    var buttonTreeMenu = new ButtonTreeMenu(contextPath,ids);
				    buttonTreeMenu.getAjaxTree();
			        $addRightModal=$("#addRightModal");
			        $addRightModal.draggable({ 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			        $addRightModal.css("overflow", "hidden");
			        $addRightModal.css("overflow-y", "auto");
			        $addRightModal.modal("show");
			    },
			    deleteItem : function(selectedItems) {
			        var message;
			        if (selectedItems&&selectedItems.length) {
			            if (selectedItems.length == 1) {
			                message = "确定要删除 '"+selectedItems[0].roleName+"' 吗?";
			 
			            }else{
			                message = "确定要删除选中的"+selectedItems.length+"项记录吗?";
			            }
			            Lobibox.confirm({
			                msg: message,
			                title:Lobibox.base.OPTIONS.title.info,
			                callback: function ($this, type) {
			                    if (type === 'yes') {
			                    	var roleids="";
			                    	$(selectedItems).each(function(i) {
			                    		roleids=roleids+selectedItems[i].roleid+",";
			                        });
			                    	roleids=roleids.substr(roleids,roleids.length-1);
			                    	$.post(contextPath+"/role/delRole",{"roleids":roleids}, function(result) {
			                    		if(result.resultCode==0){
			                    			showNotice('Success',"删除角色成功",'success',1000*5);
			                    			$("#btn_refresh").click();
			                    		}else{
			                    			showNotice('Error','<span style="padding-top:5px">删除角色信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
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