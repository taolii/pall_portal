$(document).ready(function () {
	function fixHeight() {
    	var headerHeight = $(".nav-md").height();
    	$("#indexFrame").attr("height", $(window).height()-40+ "px");
    }
    function iFrameHeight() {
		var ifm= document.getElementById("indexFrame");  
		var subWeb = document.frames ? document.frames["indexFrame"].document : ifm.contentDocument;
		var browser_height=$(document).height()<$('body').height()?$('body').height():$(document).height();
		if(ifm != null && subWeb != null) {
			ifm.height = browser_height-80;  
			ifm.width = subWeb.body.scrollWidth;  
		} 
	}
    $(window).resize(function () {
    	iFrameHeight();
    }).resize();
});