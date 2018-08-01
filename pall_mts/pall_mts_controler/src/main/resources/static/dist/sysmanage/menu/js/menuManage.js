$(function () {
	//初始化事件操作
    var ids={"dataForm":'#dataForm',"treeView":"#menutree","context_menu":'#context-menu',"menuPanelID":'#menuinfo',"menuPanelTile":'#menuinfoTitle',"showBorder":false,"onNodeSelected":false};
    var oMenu = new Menu($("#contextPath").val(),ids);
    oMenu.Init();
    oMenu.contextmenuInit();
});
var Menu= function (contextPath,ids) {
	var oMenu = new Object();
	oMenu.pContext=contextPath;
	oMenu.ids=ids;
	oMenu.treeMenu;
	oMenu.Init = function () {
		//初始化树形菜单
		oMenu.treeMenu = new TreeMenu(oMenu.pContext,ids);
		oMenu.treeMenu.getAjaxTree();
		//初始化菜单操作对象
		oMenu.operManage=new OperManage(oMenu.pContext);
	}
	oMenu.contextmenuInit=function(){
		$(ids.treeView).contextmenu({
			  target:ids.context_menu, 
			  before: function(e,context) {
				  var node=$(ids.treeView).treeview('getNode', $(e.target).attr("data-nodeid"));
				  $(ids.dataForm+" [name=data-nodeid]").val(node.id);
			  },
			  onItem: function(context,e) {
				  var stroperator = $(e.target).attr("operator");                
				  if(stroperator=='add'){
					  $(ids.menuPanelTile).html($(e.target).text());
					  $(ids.menuPanelID).show();
					  $(ids.dataForm+" [name=opertype]").val(stroperator);
					  oMenu.operManage.getMenu(ids.dataForm,$(ids.dataForm+" [name=data-nodeid]").val(),true);
				  }else if(stroperator=='mod'){
					  $(ids.menuPanelTile).html($(e.target).text());
					  $(ids.menuPanelID).show();
					  $(ids.dataForm+" [name=opertype]").val(stroperator);
					  oMenu.operManage.getMenu(ids.dataForm,$(ids.dataForm+" [name=data-nodeid]").val(),false);
				  }else if(stroperator=='del'){
					  oMenu.operManage.delItem($(ids.dataForm+" [name=data-nodeid]").val(),oMenu.treeMenu);
				  }else{
					  showNotice('Error','<span style="padding-top:5px">不支持的操作</span>','error',1000*10);
				  }
			  }
		});
	}
	return oMenu;
}
var OperManage= function (contextPath) {
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
    operManage.getMenu = function(dataForm,pmenuid,isAdd){
		var param = {};
		param.menuid=pmenuid;
		if(pmenuid==-1){
			$(dataForm+" [name=pmenuid]").val(-1);
			$(dataForm+" [name=pmenuName]").val("主菜单");
			return ;
		}
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
        	   		if(isAdd){
        	   			if(result.returnObjects[0].menuid=='-1'){
            	        	$(dataForm+" [name=pmenuName]").val("主菜单");
            	        }else{
            	        	$(dataForm+" [name=pmenuName]").val(result.returnObjects[0].menuName);
            	        }
        	   			$(dataForm+" [name=pmenuid]").val(result.returnObjects[0].menuid);
        	   			$(dataForm+" [name=menuid]").val("0");
        	   			$(dataForm+" [name=menuName]").val("");
            	        $(dataForm+" [name=menuIcon]").val("");
            	        $(dataForm+" [name=menuUrl]").val("");
            	        $(dataForm+" [name=leaf]").removeAttr("checked");
            	        $(dataForm+" [name=disabled]").removeAttr("checked");
            	        //$(dataForm+" [name=sort]").val("");
            	        $(dataForm+" [name=description]").val("");
        	   		}else{
        	   			if(result.returnObjects[0].pmenuid=='-1'){
            	        	$(dataForm+" [name=pmenuName]").val("主菜单");
            	        }else{
            	        	$(dataForm+" [name=pmenuName]").val(result.returnObjects[0].pmenuName);
            	        }
        	   			$(dataForm+" [name=pmenuid]").val(result.returnObjects[0].pmenuid);
        	   			$(dataForm+" [name=menuid]").val(result.returnObjects[0].menuid);
        	   			$(dataForm+" [name=menuName]").val(result.returnObjects[0].menuName);
            	        $(dataForm+" [name=menuIcon]").val(result.returnObjects[0].menuIcon);
            	        $(dataForm+" [name=menuUrl]").val(result.returnObjects[0].menuUrl);
            	        if(result.returnObjects[0].leaf==1){
            	        	$(dataForm+" [name=leaf]").attr("checked","checked");
            	        }else{
            	        	$(dataForm+" [name=leaf]").removeAttr("checked");
            	        }
            	        if(result.returnObjects[0].disabled==1){
            	        	$(dataForm+" [name=disabled]").attr("checked","checked");;
            	        }else{
            	        	$(dataForm+" [name=disabled]").removeAttr("checked");
            	        }
            	        $(dataForm+" [name=pmenuid]").val(result.returnObjects[0].pmenuid);
            	        $(dataForm+" [name=sort]").val(result.returnObjects[0].sort);
            	        $(dataForm+" [name=description]").val(result.returnObjects[0].description);
        	   		}
        	   	}
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">菜单信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
    /*
     * 数据记录删除
     */
    operManage.delItem= function (menuid,treeMenu) {
    	if (menuid) {
    		message = "确定要删除 吗?";
            Lobibox.confirm({
                msg: message,
                title:Lobibox.base.OPTIONS.title.info,
                callback: function ($this, type) {
                    if (type === 'yes') {
                    	var menuids=menuid;
                    	$.post(contextPath+"/menu/delMenu",{"menuids":menuids}, function(result) {
                    		if(result.resultCode==0){
                    			showNotice('Success',"删除菜单成功",'success',1000*5);
                    			treeMenu.getAjaxTree();
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
