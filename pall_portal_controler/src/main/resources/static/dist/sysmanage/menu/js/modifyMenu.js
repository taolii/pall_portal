$(document).ready(function() {
	var dataForm='#modDataForm';
	var contextPath=$("#contextPath").val();
	var table="#tree";
	var modal="#modModal";
	$("#modPmenuName").click(function(){
		var ids={"treeView":"#treeview","inPMenuid":"#modPmenuid","inPMenuName":"#modPmenuName","validFileName":"pmenuName","dataForm":dataForm};
	    var treeMenu = new TreeMenu(contextPath,ids);
	    treeMenu.getAjaxTree();
	});
	 $(dataForm).bootstrapValidator({
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
	    	$.post(contextPath+"/menu/modMenu",  $form.serialize(), function(result) {
	    		if(result.resultCode==0){
	    			showNotice('Success',"修改菜单成功",'success',1000*5);
	    			$(dataForm).data('bootstrapValidator').resetForm(true);
	    			$(modal).modal("hide");
	    			$(table).bootstrapTable('updateRow', {index: $(dataForm+" [name=updateIndex").val(), row: result.returnObjects[0]});
	    			//$(table).bootstrapTable('refresh',{silent: true});
	    		}else{
	    			$(dataForm).bootstrapValidator('disableSubmitButtons', false); 
	    			showNotice('Error','<span style="padding-top:5px">修改菜单失败,详情如下:</span><br/><span class="icon-exclamation-sign"><i class="glyphicon glyphicon-play"></i>'+result.resultMsg+'</span>','error',1000*10);
	            }
	        },'json'); 
	    }).on('error.form.bv', function(e, data) {
	    	//$(addDataForm).bootstrapValidator('disableSubmitButtons', false);  
	    });
});
