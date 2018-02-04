$(document).ready(function() {
	var addDataForm='#addDataForm';
	var contextPath=$("#contextPath").val();
	var tree="#tree";
	var addModal=$("#addModal");
	$("#addPmenuName").click(function(){
		var ids={"treeView":"#treeview","inPMenuid":"#addPmenuid","inPMenuName":"#addPmenuName","validFileName":"pmenuName","dataForm":addDataForm};
	    var treeMenu = new TreeMenu(contextPath,ids);
	    treeMenu.getAjaxTree();
	});
	 $(addDataForm).bootstrapValidator({
	        message: 'This value is not valid',
	        container: 'tooltip',
	        feedbackIcons: {
	            valid: 'glyphicon glyphicon-ok',
	            invalid: 'glyphicon glyphicon-remove',
	            validating: 'glyphicon glyphicon-refresh'
	        },
	        fields: {
	        	pmenuName: {
	                 container: '.pmenuName'
	             },
	             menuName: {
	                 container: '.menuName'
	             },
	             sort: {
	                 container: '.sort'
	             },
	             description: {
	            	 container: '.description'
	             }
	        }
	    }).on('success.form.bv', function(e) {
	    	e.preventDefault();
	    	var $form = $(e.target);
	    	var bv = $form.data('bootstrapValidator');
	    	$.post(contextPath+"/menu/addMenu",  $form.serialize(), function(result) {
	    		if(result.resultCode==0){
	    			showNotice('Success',"添加菜单成功",'success',1000*5);
	    			$form.data('bootstrapValidator').resetForm(true);
	    			addModal.modal("hide");
	    			$(tree).bootstrapTable('refresh',{silent: true});
	    		}else{
	    			$(addDataForm).bootstrapValidator('disableSubmitButtons', false); 
	    			showNotice('Error','<span style="padding-top:5px">添加菜单失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
	            }
	        },'json'); 
	    }).on('error.form.bv', function(e, data) {
	    	//$(addDataForm).bootstrapValidator('disableSubmitButtons', false);  
	    });
});
