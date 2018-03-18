$(function() {
    var date = new Date();
    var year = date.getFullYear();
    $(".show-year").html(year+"-"+(year+1));
});
function reloadcode(contextPath) {
	var verify = document.getElementById('safeCode');  
	verify.setAttribute('src', contextPath+'/getValidCode?it=' + Math.random());/*Math.random()点击验证码图片随机生成  */  
}
function findPwd() {
	var fpAltert=$("#fpAltert").html();
	//showNotice(Lobibox.base.OPTIONS.title.info,fpAltert,'info',1000*5);
	
	Lobibox.alert('info', {
        msg: fpAltert,
        title:Lobibox.base.OPTIONS.title.info,
        width:Lobibox.base.OPTIONS.width,
        buttons:{yes:Lobibox.base.OPTIONS.buttons.info}
    });
}  
