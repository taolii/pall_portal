$(document).ready(function() {
	$('#queryCoatingTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    });
	$('#queryPfTime').datetimepicker({  
        format: 'YYYY-MM-DD',  
        locale: moment.locale('zh-cn')  
    }); 
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
		columns_setting.push({className : "ellipsis","title":tableField.headline,"defaultContent":"",data:tableField.fieldName,render : TABLE_CONSTANT.DATA_TABLES.RENDER.ELLIPSIS,width:"60px","visible":v_visible }) ;  
	});
	var columns_settingfoot=[
        {className : "td-operation",data: null,render : function(data,type, row, meta) {
        	return "<div class='btn-group'>"+
            "<button id='editRow' class='btn btn-primary btn-xs' type='button'><i class='fa fa-edit'></i></button>"+
            "<button id='delRow' class='btn btn-primary btn-xs' type='button'><i class='fa fa-trash-o'></i></button>"+
            "</div>";
          }, width : "60px"}
    ];
	columns_setting=columns_setting.concat(columns_settingfoot);
	var $wrapper = $('#div-table-container');
	var $table = $('#datatable');
	$addModal=$("#addModal");
	$modModal=$("#modModal");
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
                    url: "/workflow/platedFilmManage",
                    cache : false,  //禁用缓存
                    data: param,    //传入已封装的参数
                    dataType: "json",
                    success: function(result) {
                    	 //异常判断与处理
                        if (result.resultCode!=0) {
                        	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>化学镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>');
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
                    	$(".error").html('<h3><span class="red"><i class="glyphicon glyphicon-remove"></i>化学镀膜信息查询失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>');
                        $wrapper.spinModal(false);
                    }
                });
        },
        columns:columns_setting ,
        "drawCallback": function( settings ) {
            //渲染完毕后的回调
            //清空全选状态
            $(":checkbox[name='cb-check-all']",$wrapper).prop('checked', false);
            //默认选中第一行
            $("tbody tr",$table).eq(0).click();
        }
    })).api();
	$("#datatable_length").hide();
	$("#btn-query").click(function(){
		_table.draw();
	});
	$("#btn_refresh").click(function(){
		_table.draw();
	});
	$("#btn-add").click(function(){
		polishManage.addItemShow();
	});
	$("#btn-export").click(function(){
		polishManage.exportItem();
	});
	$("#btn-delAll").click(function(){
		var arrItemId = [];
        $("tbody :checkbox:checked",$table).each(function(i) {
            var item = _table.row($(this).closest('tr')).data();
            arrItemId.push(item);
        });
        polishManage.deleteItem(arrItemId);
	});
	$("[name='cb-check-all']").click(function(){
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
        polishManage.currentItem = item;
        polishManage.editItemInit(item);
        polishManage.editItemShow();
    }).on("click","#delRow",function() {
        //点击删除按钮
        var item = _table.row($(this).closest('tr')).data();
        $(this).closest('tr').addClass("active").siblings().removeClass("active");
        polishManage.deleteItem([item]);
    });
	 var polishManage = {
			    currentItem : null,
			    fuzzySearch : true,
			    editItemInit : function(item) {
			        if (!item) {
			            return;
			        }			   
			       $("#modDataForm [name=pfID]").val(item.pfID);
			       $("#modDataForm [name=coatingTime]").val(item.coatingTime);
			       $("#modDataForm [name=pfTime]").val(item.pfTime);
			       $("#modDataForm [name=inputLotNum]").val(item.inputLotNum);
			       $("#modDataForm [name=inputQty]").val(item.inputQty);
			       $("#modDataForm [name=fixtureNum]").val(item.fixtureNum);
			       $("#modDataForm [name=apsBottle]").val(item.apsBottle);
			       $("#modDataForm [name=outputLotNum]").val(item.outputLotNum);
			       $("#modDataForm [name=outputQty]").val(item.outputQty);
			       $("#modDataForm [name=scrapQty]").val(item.scrapQty);
			       $("#modDataForm [name=underIQCQty]").val(item.underIQCQty);
			       $("#modDataForm [name=qNum]").val(item.qNum);
			       $("#modDataForm [name=kNum]").val(item.kNum);
			       $("#modDataForm [name=qcUseQty]").val(item.qcUseQty);
			       $("#modDataForm [name=underIQCQty]").val(item.underIQCQty);
			       $("#modDataForm [name=toHUBQty]").val(item.toHUBQty);
			       $("#modDataForm [name=remainQty]").val(item.remainQty);
			       $("#modDataForm [name=apsCondition]").val(item.apsCondition);
			       $("#modDataForm [name=partNum]").val(item.partNum);
			       $("#modDataForm [name=workOrderNum]").val(item.workOrderNum);
			    },
			    addItemShow: function() {
			    	$addModal.draggable({ 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			    	$addModal.css("overflow", "hidden");
			    	$addModal.css("overflow-y", "auto");
			    	$addModal.modal("show");
			    },
			    editItemShow: function() {
			    	$modModal.draggable({ 
			    		scroll: true, scrollSensitivity: 100,
			    		cursor: "move"});
			    	$modModal.css("overflow", "hidden");
			    	$modModal.css("overflow-y", "auto");
			    	$modModal.modal("show");
			    },
			    exportItem:function(){
			         $.post("/workflow/exportPlatedFilm",$queryForm.serializeArray(), function(result) {
			        	 if(result.resultCode==0){
			        		 var fileName=encodeURI(result.returnObjects[0].fileName); 
		    	    		 var downUrl = '/workflow/excelfileDownload?fileName=' +fileName+"&subDirectory="+result.returnObjects[0].subDirectory;
		    	    		 window.location.href = downUrl;
                    		}else{
                    			Lobibox.alert('error', {
                                    msg: '<span class="red">导出数据失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
                                    title:Lobibox.base.OPTIONS.title.error,
                                    width:Lobibox.base.OPTIONS.width,
                                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
                                });
                    		}
                     },'json'); 
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
			                    	var pfIDs="";
			                    	$(selectedItems).each(function(i) {
			                    		pfIDs=pfIDs+selectedItems[i].pfID+",";
			                        });
			                    	pfIDs=pfIDs.substr(pfIDs,pfIDs.length-1);
			                    	$.post("/workflow/delPlatedFilm",{"pfIDs":pfIDs}, function(result) {
			                    		if(result.resultCode==0){
			                    			Lobibox.alert('success', {
			                                    msg: "<h3><span class='green'>化学镀膜信息删除成功</span>",
			                                    title:Lobibox.base.OPTIONS.title.success,
			                                    width:Lobibox.base.OPTIONS.width,
			                                    buttons:{yes:Lobibox.base.OPTIONS.buttons.yes}
			                                });
			                    			$("#btn_refresh").click();
			                    		}else{
			                    			Lobibox.alert('error', {
			                                    msg: '<span class="red">化学镀膜信息删除失败,详情如下:</span><br/><span class="red icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>',
			                                    title:Lobibox.base.OPTIONS.title.error,
			                                    width:Lobibox.base.OPTIONS.width,
			                                    buttons:{yes:Lobibox.base.OPTIONS.buttons.cancel}
			                                });
			                    		}
			                        },'json'); 
			                    }
			                }
			            });
			        }else{
			        	Lobibox.alert('info', {
			    	        msg: "请先选中要删除的记录",
			    	        title:Lobibox.base.OPTIONS.title.info,
			    	        width:Lobibox.base.OPTIONS.width,
			    	        buttons:{yes:Lobibox.base.OPTIONS.buttons.info}
			    	    });
			        }
			    }
			};
});