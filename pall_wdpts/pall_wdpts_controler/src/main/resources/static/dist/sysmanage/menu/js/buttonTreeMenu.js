var ButtonTreeMenu = function (contextPath,ids) {
	var buttonTreeMenu = new Object();
	buttonTreeMenu.pContext=contextPath;
	buttonTreeMenu.ids=ids;
	buttonTreeMenu.nodeUncheckedSilent=false;
	buttonTreeMenu.nodeCheckedSilent=false;
	buttonTreeMenu.getAjaxTree = function(){
		var param = {};
		$.ajax({
			type:'post',
            contentType:'application/json',
            url:buttonTreeMenu.pContext+"/menu/getMenuButton",
            data:JSON.stringify(param),
            dataType:"json",
            async:true,
	        success:function (result){
        	   	if (result.resultCode!=0) {
        	   	   showNotice('Error','<span style="padding-top:5px">菜单查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
        	   	   return;
        	   	}
        	   	$(ids.treeView).show();
        	   	buttonTreeMenu.view(result.returnObjects)
           },
           error:function(XMLHttpRequest, textStatus, errorThrown) {
           		var error="status:"+XMLHttpRequest.status+",readyState:"+XMLHttpRequest.readyState+",textStatus:"+textStatus;
           		showNotice('Error','<span style="padding-top:5px">菜单信息查询失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+error+'</span>','error',1000*10);
           }
		});
	}
	buttonTreeMenu.view=function(treeMenus){
		$(ids.treeView).treeview({
	        data:buttonTreeMenu.buildDomTree(treeMenus),         // 数据源
	        showCheckbox: true, //是否显示复选框
	        highlightSelected: true,    //是否高亮选中
	        color: "#000000",
	        backColor: "#FFFFFF",
	        nodeIcon: '',
	        showBorder:ids.showBorder,
	        emptyIcon: '',    //没有子节点的节点图标
	        multiSelect: true,    //多选
	        showTags:true,
	        onNodeChecked:buttonTreeMenu.nodeChecked ,  
	        onNodeUnchecked:buttonTreeMenu.nodeUnchecked,
	        onNodeSelected: function (event, data) {
	        	
	        }
	    });
	}
	buttonTreeMenu.buildDomTree=function(treeMenus){
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
	buttonTreeMenu.nodeUnchecked=function(event, node){  
	    if(buttonTreeMenu.nodeUncheckedSilent)  
	        return;  
	    buttonTreeMenu.nodeUncheckedSilent = true;  
	    buttonTreeMenu.uncheckAllParent(node);  
	    buttonTreeMenu.uncheckAllSon(node);  
	    buttonTreeMenu.nodeUncheckedSilent = false;  
	}
	buttonTreeMenu.nodeChecked=function(event, node){  
	    if(buttonTreeMenu.nodeCheckedSilent){  
	        return;  
	    }  
	    buttonTreeMenu.nodeCheckedSilent = true;  
	    buttonTreeMenu.checkAllParent(node);  
	    buttonTreeMenu.checkAllSon(node);  
	    buttonTreeMenu.nodeCheckedSilent = false;  
	}
	//选中全部父节点  
	buttonTreeMenu.checkAllParent=function(node){  
	    $(ids.treeView).treeview('checkNode',node.nodeId,{silent:true});  
	    var parentNode = $(ids.treeView).treeview('getParent',node.nodeId);  
	    if(!("nodeId" in parentNode)){  
	        return;  
	    }else{  
	    	buttonTreeMenu.checkAllParent(parentNode);  
	    }  
	}  
	//取消全部父节点  
	buttonTreeMenu.uncheckAllParent=function(node){  
	  $(ids.treeView).treeview('uncheckNode',node.nodeId,{silent:true});  
	    var siblings = $(ids.treeView).treeview('getSiblings', node.nodeId);  
	    var parentNode = $(ids.treeView).treeview('getParent',node.nodeId);  
	    if(!("nodeId" in parentNode)) {  
	        return;  
	    }  
	    var isAllUnchecked = true;  //是否全部没选中  
	    for(var i in siblings){  
	        if(siblings[i].state.checked){  
	            isAllUnchecked=false;  
	            break;  
	        }  
	    }  
	    if(isAllUnchecked){  
	    	buttonTreeMenu.uncheckAllParent(parentNode);  
	    }  
	}  
	//级联选中所有子节点  
	buttonTreeMenu.checkAllSon=function(node){  
	    $(ids.treeView).treeview('checkNode',node.nodeId,{silent:true});  
	    if(node.nodes!=null&&node.nodes.length>0){  
	        for(var i in node.nodes){  
	        	buttonTreeMenu.checkAllSon(node.nodes[i]);  
	        }  
	    }  
	}  
	//级联取消所有子节点  
	buttonTreeMenu.uncheckAllSon=function(node){  
	    $(ids.treeView).treeview('uncheckNode',node.nodeId,{silent:true});  
	    if(node.nodes!=null&&node.nodes.length>0){  
	        for(var i in node.nodes){  
	        	buttonTreeMenu.uncheckAllSon(node.nodes[i]);  
	        }  
	    }  
	}  
	return buttonTreeMenu;
}

