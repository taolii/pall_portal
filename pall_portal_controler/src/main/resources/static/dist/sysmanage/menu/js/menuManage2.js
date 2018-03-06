$(function () {
	//初始化事件操作
	var operManage=new OperManage($("#contextPath").val(),"#tree");
	//1.初始化Table
	var ids={"table":"#tree","wrapper":"#div-table-container","toolbar":"#toolbar","expandIcon":"glyphicon glyphicon-minus",};
    var oTable = new TableInit(operManage,$("#contextPath").val(),ids);
    oTable.Init();
    //2.初始化事件触发器
    var eventTrigger = new EventTrigger();
    eventTrigger.Init(oTable);
});

var TableInit = function (operManage,contextPath,ids) {
	var oTableInit = new Object();
	oTableInit.pContext=contextPath;
	oTableInit.ids=ids;
	oTableInit.operManage=operManage;
	oTableInit.Init = function () {
		$(oTableInit.ids.table).bootstrapTable({
			toolbar: oTableInit.ids.toolbar,
			url: oTableInit.pContext+"/menu/menuManage",
			treeView: true,
            treeId: "menuid",
            treePId:"pmenuid",
            treeField: "menuName",
            treeLeafField:"leaf",
			method: 'post',
			contentType:'application/json',
			dataType:'JSON',
			queryParamsType:'limit',
			queryParams: oTableInit.queryParams,  
			sidePagination:'server',
			pagination: false,
			idField: "menuid",
			uniqueId:"menuid",
	        clickToSelect: false,
	        showColumns:false,
	        showRefresh:true,
	        striped: false,
	        collapseIcon: "glyphicon glyphicon-plus",//折叠样式
	        expandIcon: oTableInit.ids.expandIcon,
	        buttonsClass:"btn btn-primary",
	        columns: [
	        	{class: "ellipsis",field: "menuName",align:"center"},
	        	{class: "ellipsis",field: "parentId",formatter: function(data, row, index) {
	            	if(row.pmenuid==null || row.pmenuid==-1){
	            		return null
	            	} else{
	            		return row.pmenuid
	            	};
	            }},
	            {class: "ellipsis",field: "pmenuid",formatter: function(data, row, index) {
	            	if(row.pmenuid==null || row.pmenuid==-1){
	            		return null
	            	} else{
	            		return row.pmenuid
	            	};
	            }},
	        	{class: "ellipsis",field: "menuid",align:"center",visible:false},
	            {class: "ellipsis",field: "menuIcon",align:"left"},
	            {class: "ellipsis",field: "menuUrl",align:"left"},
	            {class: "ellipsis",field: "leaf",align:"center",formatter: function(data, row, index) {
	            	return data==1?'<i class="fa fa-leaf"></i>':'<i class="fa fa-folder"></i>';
	            }},
	            {class: "ellipsis",field: "disabled",align:"center",formatter: function(data, row, index) {
	            	return data==1?'<i class="fa fa-toggle-off"></i>':'<i class="fa fa-toggle-on"></i>';
	            }},
	            {class: "ellipsis",field: "sort",align:"center"},
	            {class: "ellipsis",field: "description",align:"center"},
	            {class:"td-operation",align:"center",events:operateEvents,
	            	formatter: oTableInit.fnAddOperation, width : "80px"
	            }
	        ],
	        responseHandler:function (result) {
	        	if (result.resultCode!=0) {
	            	showNotice('Error','<span style="padding-top:5px">菜单查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
	            	$(oTableInit.ids.wrapper).spinModal(false);
	            	return ;
	            }
	        	var returnData = {};
	            returnData.rows = result.datatablesView.data;
	            return returnData;
	        },
	        onLoadSuccess: function(result){  //加载成功时执行  
	        	
	        },  
	        onLoadError: function(status){  //加载失败时执行  
	        	var error="status:"+status;
	        	showNotice('Error','<span style="padding-top:5px">菜单信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
	        }  
	    });
	}
	oTableInit.queryParams = function (params) {
		var temp = {    
				startPageNum: params.pageNumber,    
				pageSize: params.pageSize };
		temp["pMenuid"] = '-1';
	    return temp;
	};
	oTableInit.fnGetSubMenu=function(nTr, pMenuid,pSpans) {
		var addRowIndex=nTr.rowIndex;
		var param = {};
        param["pMenuid"] = pMenuid;
        $.ajax({
               type:'post',
               contentType:'application/json',
               url:oTableInit.pContext+"/menu/menuManage",
               data:JSON.stringify(param),
               dataType:"json",
               async:true,
               beforeSend:function(xhr){//信息加载中
            	   $(oTableInit.ids.wrapper).spinModal(true);
               },
               success:function (result){
            	   	if (result.resultCode!=0){
            	   	   showNotice('Error','<span style="padding-top:5px">子菜单查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
            	   	   $(oTableInit.ids.wrapper).spinModal(false);
            	   	   return;
            	   	}
            	   	var datas = result.datatablesView.data;
            	   	$.each(datas,function(i, data){
           				$(oTableInit.ids.table).bootstrapTable('insertRow', {index: addRowIndex+i, row: data});
           			});
            	   	//遍历表格，将所有存在子节点的父节点添加parent样式
            	   $.each(pSpans,function(){
            		   var pSpan=$(oTableInit.ids.table).find("tr td:nth-child(1) span[menuid="+$(this).attr("menuid")+"]");
            		   if(typeof($(pSpan).attr("class"))=="undefined"){
            			   $(pSpan).attr("class","parent");
               			}else{
               				$(pSpan).addClass("parent");
               			}
            		   if($(this).parent().parent().find(":checkbox").is(':checked')){
            			   $(oTableInit.ids.table).find("tr td:nth-child(1) span[pmenuid="+$(this).attr("menuid")+"]").each(function(){
                        	   $(this).parent().parent().find(":checkbox").prop("checked","checked");
                           });
            		   }
            	   });
            	   $(oTableInit.ids.wrapper).spinModal(false);
               },
               error:function(XMLHttpRequest, textStatus, errorThrown) {
               	var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
               	showNotice('Error','<span style="padding-top:5px">菜单信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
               	$(oTableInit.ids.wrapper).spinModal(false);
               }
           });
	}
	oTableInit.fnAddOperation=function(value,row,index){
		return [
            '<button id="editRow" class="btn btn-primary btn-xs" type="button"><i class="fa fa-edit"></i></button>',
            '<button id="delRow" class="btn btn-primary btn-xs" type="button"><i class="fa fa-trash-o"></i></button>'
            ].join("");
	}
	/*
	 * 按钮绑定事件
	 */
	window.operateEvents={
		"click #editRow":function(e,value,row,index){
			//编辑操作
			oTableInit.operManage.showEditItemModal(true,"#modDataForm",row,"#modModal",index);
		},"click #delRow":function(e,value,row,index){
			//删除操作
			oTableInit.operManage.delItem(row,index);
		}
	}
	return oTableInit;
}
/*
 * 事件操作
 */
var EventTrigger = function () {
    var oInit = new Object();
    oInit.Init = function (oTable) {
    $(oTable.ids.toolbar).on("click","#btn-add",function(e) {
    	oTable.operManage.showAddItemModal(false,"#addDataForm",null,"#addModal");
    });
    $(oTable.ids.table).on("click",'tr td:nth-child(1)',function(e) {
    	alert("dfd");
    	if(icon.hasClass(oTable.ids.expandIcon)){
            
        }else{
        	
        }
    	var nTr = $(this).parents('tr')[0];
    	var menuid=$(this).find('span').attr("menuid");
    	var row=$(oTable.ids.table).bootstrapTable('getRowByUniqueId', menuid);
    	if($(this).find('span').hasClass("parent")){
    		$(this).find('span').removeClass("parent");
    		var pSpans=$(oTable.ids.table).find("tr td:nth-child(1) span.parent");
    		var spans=$(oTable.ids.table).find("tr td:nth-child(1) span[pmenuid="+menuid+"]");
    		$.each(spans,function(){
    			$(oTable.ids.table).bootstrapTable('removeByUniqueId', $(this).attr("menuid"));
    		});
    		$.each(pSpans,function(){
     		   var pSpan=$(oTable.ids.table).find("tr td:nth-child(1) span[menuid="+$(this).attr("menuid")+"]");
     		   if(!pSpan){return;}
     		   if(typeof($(pSpan).attr("class"))=="undefined"){
     			   	$(pSpan).attr("class","parent");
        		}else{
        			$(pSpan).addClass("parent");
        		}
     	   });
    	}else{
    		if(typeof($(this).find('span').attr("class"))=="undefined"){
    			$(this).find('span').attr("class","parent");
    		}else{
    			$(this).find('span').addClass("parent");
    		}
    		if(row.leaf!=1){
    			var pSpans=$(oTable.ids.table).find("tr td:nth-child(1) span.parent");
    			oTable.fnGetSubMenu(nTr,menuid,pSpans);
        	}
    	}
     }).
     on('check.bs.table', function (e, row,ele) {
       $(oTable.ids.table).find("tr td:nth-child(1) span[pmenuid="+row.menuid+"]").each(function(){
    	   $(this).parent().parent().find(":checkbox").prop("checked","checked");
       });
     }).
     on('uncheck.bs.table', function (e, row,ele) {
    	$(oTable.ids.table).find("tr td:nth-child(1) span[pmenuid="+row.menuid+"]").each(function(){
     	   $(this).parent().parent().find(":checkbox").prop("checked","");
        });
     });
    }
    return oInit;
};

var OperManage = function (contextPath,table) {
    var operManage = new Object();
    operManage.showModal=function(modal){
    	$modal=$(modal);
    	$modal.draggable({ 
    		scroll: true, scrollSensitivity: 100,
    		cursor: "move"});
    	$modal.css("overflow", "hidden");
    	$modal.css("overflow-y", "auto");
    	$modal.modal("show");
    	$modal=$(modal);
    	$modal.modal("show");
    }
    operManage.getMenuName = function(dataForm,pmenuid){
		var param = {};
		param.menuid=pmenuid;
		$.ajax({
			type:'post',
            contentType:'application/json',
            url:contextPath+"/menu/findMenuById",
            data:JSON.stringify(param),
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">菜单查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        	   	if(result.returnObjects!=null){
        	   		$(dataForm+" [name=pmenuName]").val(result.returnObjects[0].menuName);
        	   	}
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">菜单信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
    /*
     * 表单对象公共初始化
     */
    operManage.formInit=function(dataForm,item){
        $(dataForm+" [name=menuName]").val(item.menuName);
        $(dataForm+" [name=menuIcon]").val(item.menuIcon);
        $(dataForm+" [name=menuUrl]").val(item.menuUrl);
        $(dataForm+" [name=leaf]").val(item.leaf);
        $(dataForm+" [name=disabled]").val(item.disabled);
        $(dataForm+" [name=pmenuid]").val(item.pmenuid);
        $(dataForm+" [name=sort]").val(item.sort);
        $(dataForm+" [name=description]").val(item.description);
        if(item.pmenuid=='-1'){
        	$(dataForm+" [name=pmenuName]").val("主菜单");
        }else{
        	//根据父菜单id获取菜单名称
            operManage.getMenuName(dataForm,item.pmenuid);
        }
    }
    /*
     * 表单对象公共重置
     */
    operManage.formReset=function(dataForm){
    	$(dataForm).data('bootstrapValidator').resetForm(true);
    }
    /*
     * 表单对象新增初始化
     */
    operManage.addItemInit = function (dataForm,item) {
    	
    }
    /*
     * 表单对象对话框展示
     */
    operManage.showAddItemModal=function(isInit,dataForm,item,modal) {
    	operManage.formReset(dataForm);
    	if(isInit){
    		operManage.addItemInit(dataForm,item);
    	}
    	operManage.showModal(modal);
    }
    /*
     * 表单对象编辑初始化
     */
    operManage.editItemInit = function (dataForm,item,index) {
    	operManage.formInit(dataForm,item);
    	 $(dataForm+" [name=menuid]").val(item.menuid);
    	 $(dataForm+" [name=updateIndex").val(index);
    }
    /*
     * 表单对象编辑对话框展示
     */
    operManage.showEditItemModal = function (isInit,dataForm,item,modal,index) {
    	operManage.formReset(dataForm);
    	if(isInit){
    		operManage.editItemInit(dataForm,item,index);
    	}
    	operManage.showModal(modal);
    }
    /*
     * 数据记录删除
     */
    operManage.delItem= function (items,index) {
    	if (item&&item.length) {
            if (item.length == 1) {
                message = "确定要删除 '"+items[0].menuName+"' 吗?";
 
            }else{
                message = "确定要删除选中的"+items.length+"项记录吗?";
            }
            Lobibox.confirm({
                msg: message,
                title:Lobibox.base.OPTIONS.title.info,
                callback: function ($this, type) {
                    if (type === 'yes') {
                    	var menuids="";
                    	$(items).each(function(i) {
                    		menuids=menuids+menuids[i].menuid+",";
                        });
                    	menuids=menuids.substr(menuids,menuids.length-1);
                    	$.post(contextPath+"/menu/delMenu",{"menuids":menuids}, function(result) {
                    		if(result.resultCode==0){
                    			showNotice('Success',"删除菜单成功",'success',1000*5);
                    			$(table).bootstrapTable('refresh',{silent: true});
                    		}else{
                    			showNotice('Error','<span style="padding-top:5px">删除菜单信息失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
		                    }
                        },'json'); 
                    }
                }
            });
        }else{
        	showNotice('Info',"请先选中要删除的记录",'info',1000*5);
        }
    }
    return operManage;
};
