$(document).ready(function() {
	var ids={"contextPath":"#contextPath","datatable":"#datatable","tableContainer":"#div-table-container","queryForm":"#queryForm"}
	var contextPath=$(ids.contextPath).val();
	var $wrapper = $(ids.tableContainer);
	var $table = $(ids.datatable);
	var _table = $table.dataTable($.extend(true,
		{pageLength: 10,ordering: false,scrollX: true,"sPaginationType":"full_numbers"},TABLE_CONSTANT.DATA_TABLES.DEFAULT_OPTION,
		{
        ajax : function(data, callback, settings) {//ajax配置为function,手动调用异步查询
            //手动控制遮罩
            $wrapper.spinModal();
            //封装请求参数
            var param = {};
            param.draw = data.draw;
            param.startPageNum = data.start;
            param.pageSize = data.length;
            var formData = $(ids.queryForm).serializeArray();
            formData.forEach(function (e) {
                param[e.name] = e.value;
            });
            $.ajax({
                    type: "post",
                    url: contextPath+"/user/userManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	showNotice('Error','<span style="padding-top:5px">用户信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
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
                    	showNotice('Error','<span style="padding-top:5px">用户信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
                    	$wrapper.spinModal(false);
                    }
                });
        },
        columns: [
        	TABLE_CONSTANT.DATA_TABLES.COLUMN.CHECKBOX,
        	{className : "ellipsis",data: "operatorid",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,"visible":false,width:"80px"},
            {className : "ellipsis",data: "account",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"80px"},
            {className : "ellipsis",data: "name",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"80px"},
            {className : "ellipsis",data: "sex",render : function(data,type, row, meta) {
            		if(data=='1'){
	            		return '<span class="label label-sm label-pink arrowed arrowed-right">女</span>';
	            	}else{
	            		return '<span class="label label-sm label-primary arrowed arrowed-right">男</span>';
	            	};
            	},width:"80px"
            },
            {className : "ellipsis",data: "position",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"80px"},
            {className : "ellipsis",data: "mobile",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"80px"},
            {className : "ellipsis",data: "email",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"180px"},
            {data : "operatorType",render : function(data,type, row, meta) {
                return data==1?'系统管理员':'普通用户';},width:"80px"
            },
            {className : "ellipsis",data : "createTime",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"120px"},
            {className : "ellipsis",data : "updateTime",render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"120px"},
            {className : "td-operation",data: null,render : function(data,type, row, meta) {
            	return "<div class='btn-group'>"+
                "<a id='editRow' class='btn btn-info btn-xs' type='button' data-toggle='tooltip' data-placement='bottom' title='修改'><i class='ace-icon fa fa-pencil bigger-120'></i></a>"+
                "<a id='editPwdRow' class='btn btn-success btn-xs' type='button' data-toggle='tooltip' data-placement='bottom' title='密码修改'><i class='ace-icon fa fa-key bigger-120'></i></a>"+
                "<a id='delRow' class='btn btn-danger btn-xs' type='button' data-toggle='tooltip' data-placement='bottom' title='删除'><i class='ace-icon fa fa-trash-o bigger-120'></i></a>"+
                "</div>";
              }, width : "100px"}
        ],
        "drawCallback": function( settings ) {
            //渲染完毕后的回调
            $(":checkbox[name='cb-check-all']","#datatable_wrapper").prop('checked', false);
        }
    })).api();
	$("#datatable_wrapper").find(".dataTables_length").parent().parent().hide();
	$("#btn-query").click(function(){
		_table.draw();
	});
	$("#btn_refresh").click(function(){
		_table.draw();
	});
	$("#btn-add").click(function(){
		userManage.addItemShow();
	});
	$("#btn-delAll").click(function(){
		var arrItemId = [];
        $("tbody :checkbox:checked",$table).each(function(i) {
            var item = _table.row($(this).closest('tr')).data();
            arrItemId.push(item);
        });
        userManage.deleteItem(arrItemId);
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
        userManage.editItemShow(item);
    }).on("click","#editPwdRow",function() {
            //点击编辑按钮
            var item = _table.row($(this).closest('tr')).data();
            $(this).closest('tr').addClass("active").siblings().removeClass("active");
            userManage.currentItem = item;
            userManage.editPwdItemInit(item);
            userManage.editPwdItemShow();
    }).on("click","#delRow",function() {
        //点击删除按钮
        var item = _table.row($(this).closest('tr')).data();
        $(this).closest('tr').addClass("active").siblings().removeClass("active");
        userManage.deleteItem([item]);
    });
	 var userManage = {
			    currentItem : null,
			    fuzzySearch : true,
			    editPwdItemInit : function(item) {
			        if (!item) {
			            return;
			        }
			       $("#modPwdDataForm [name=operatorid]").val(item.operatorid);
			       $("#modPwdDataForm [name=account]").val(item.account);
			    },
			    addItemShow: function() {
			    	LoadPage(contextPath+"/user/addUser");
			    },
			    editItemShow: function(item) {
			    	LoadPage(contextPath+"/user/modUser?operatorid="+item.operatorid);
			    },
			    editPwdItemShow: function() {
			    	$modUserPwdModal=$("#modUserPwdModal");
			        $modUserPwdModal.draggable({ 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			        $modUserPwdModal.css("overflow", "hidden");
			        $modUserPwdModal.css("overflow-y", "auto");
			        $modUserPwdModal.modal("show");
			    },
			    deleteItem : function(selectedItems) {
			        var message;
			        if (selectedItems&&selectedItems.length) {
			            if (selectedItems.length == 1) {
			                message = "确定要删除 '"+selectedItems[0].account+"' 吗?";
			 
			            }else{
			                message = "确定要删除选中的"+selectedItems.length+"项记录吗?";
			            }
			            Lobibox.confirm({
			                msg: message,
			                title:Lobibox.base.OPTIONS.title.info,
			                callback: function ($this, type) {
			                    if (type === 'yes') {
			                    	var operatorids="";
			                    	$(selectedItems).each(function(i) {
			                    		operatorids=operatorids+selectedItems[i].operatorid+",";
			                        });
			                    	operatorids=operatorids.substr(operatorids,operatorids.length-1);
			                    	$.post(contextPath+"/user/delUser",{"operatorids":operatorids}, function(result) {
			                    		if(result.resultCode==0){
			                    			showNotice('Success',"删除用户成功",'success',1000*5);
			                    			$("#btn_refresh").click();
			                    		}else{
			                    			showNotice('Error','<span style="padding-top:5px">删除用户失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
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