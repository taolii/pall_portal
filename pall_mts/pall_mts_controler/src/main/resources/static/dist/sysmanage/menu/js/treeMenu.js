var TreeMenu = function (contextPath,ids) {
	var treeMenu = new Object();
	treeMenu.pContext=contextPath;
	treeMenu.ids=ids;
	treeMenu.getAjaxTree = function(){
		var param = {};
		$.ajax({
			type:'post',
            contentType:'application/json',
            url:treeMenu.pContext+"/menu/treeMenu",
            data:JSON.stringify(param),
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">菜单查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        	   	$(ids.treeView).show();
        	   	treeMenu.view(result.returnObjects)
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">菜单信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	treeMenu.view=function(treeMenus){
		$(ids.treeView).treeview({
	        data:treeMenu.buildDomTree(treeMenus),         // 数据源
	        showCheckbox: false, //是否显示复选框
	        highlightSelected: true,    //是否高亮选中
	        color: "#000000",
	        backColor: "#FFFFFF",
	        nodeIcon: '',
	        showBorder:ids.showBorder,
	        emptyIcon: '',    //没有子节点的节点图标
	        multiSelect: false,    //多选
	        showTags:true,
	        onNodeSelected: function (event, data) {
	        	if(ids.onNodeSelected){
	        		$(ids.inPMenuid).val(data.id);  
		        	$(ids.inPMenuName).val(data.text);
		        	$(ids.treeView).treeview('remove');
		        	$(ids.treeView).hide();
		        	if(ids.dataForm){
		        		$(ids.dataForm).data('bootstrapValidator').updateStatus(ids.validFileName, 'NOT_VALIDATED', null).validateField(ids.validFileName);
		        	}
	        	}
	        }
	    });
	}
	treeMenu.buildDomTree=function(treeMenus){
		var data = [];  
		var root = "主菜单";
		var obj=[{id:"-1",text:root,nodes:data}];
		function walk(treeMenus, data) {  
			if (!treeMenus) {  
				return;
			}  
			$.each(treeMenus, function() { 
				var obj = {  
					id: this.pmenuInfo.menuid,  
					text:this.pmenuInfo.menuName 
				};  
				if (this.pmenuInfo.leaf==0) {  
					obj.nodes = [];  
					walk(this.subMenuInfos, obj.nodes);  
				}  
				data.push(obj);  
			});  
		}  
		walk(treeMenus, data);  
		return obj;  
	}
	return treeMenu;
}
