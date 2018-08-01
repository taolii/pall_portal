$(document).ready(function() {
	var ids={"contextPath":"#contextPath","dataForm":"#addRightDataForm","treeView":"#buttonTreeView","submitButton":"#addRightButton"};
	var contextPath=$(ids.contextPath).val();
	$(ids.submitButton).on("click",function(){
		var nodes=$(ids.treeView).treeview('getSelected',-1);
	    alert(nodes);
	    alert(nodes.length);

    });
});
