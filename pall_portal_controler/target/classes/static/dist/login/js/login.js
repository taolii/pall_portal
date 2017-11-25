$(function() {
    var date = new Date();
    var year = date.getFullYear();
    $(".show-year").html(year+"-"+(year+1));

    //设置高度
    var leftHeight = $(".login-box div.col-md-6:first-child").height();
    $(".login-box div.col-md-6:last-child").height(leftHeight);
});
function reloadcode(contextPath) {
	var verify = document.getElementById('safeCode');  
	verify.setAttribute('src', contextPath+'/getValidCode?it=' + Math.random());/*Math.random()点击验证码图片随机生成  */  
}
function findPwd() {
	var fpAltert=$("#fpAltert").html();
	Lobibox.alert('info', {
        msg: fpAltert,
        title:Lobibox.base.OPTIONS.title.info,
        width:Lobibox.base.OPTIONS.width,
        buttons:{yes:Lobibox.base.OPTIONS.buttons.info}
    });
}  
