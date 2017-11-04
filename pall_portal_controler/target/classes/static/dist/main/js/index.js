$(document).ready(function () {
	function fixHeight() {
    	var headerHeight = $(".nav-md").height();
    	$("#iframe").attr("height", $(window).height()-80+ "px");
    }
    $(window).resize(function () {
         fixHeight();
    }).resize();
    
});