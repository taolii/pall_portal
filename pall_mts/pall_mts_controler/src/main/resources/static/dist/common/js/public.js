function logout(contextPath){
	 Lobibox.confirm({
        msg: "您确认要退出系统吗？",
        title:Lobibox.base.OPTIONS.title.info,
        callback: function ($this, type) {
            if (type === 'yes') {
                window.location.href=contextPath+"/logout";
            }
        }
    });
}
function currentTime(){ 
    var d=new Date(),str=''; 
    str+=d.getFullYear()+'年'; 
    str+=d.getMonth() + 1+'月'; 
    str+=d.getDate()+'日'; 
    str+=d.getHours()+'时'; 
    str+=d.getMinutes()+'分'; 
    str+= d.getSeconds()+'秒'; 
    return str; 
};
function currentDate(num){ 
    var now =new Date();
    var d =new Date(now.getTime() - num * 24 * 3600 * 1000);
    str=''; 
    str+=d.getFullYear()+'-';
    if(Number(d.getMonth())<9){
    	str+='0'+(d.getMonth()+1)+'-'; 
    }else{
    	str+=d.getMonth() +1+'-'; 
    }
    if(Number(d.getDate())<10){
    	str+='0'+d.getDate(); 
    }else{
    	str+=d.getDate(); 
    }
    return str; 
};
function LoadPage(url) {
	$.ajax({
        url: url,
        cache: false,
        success: function(html){
        	$(".main-content").html(html);
        	var submenu=$("#menu_nav .submenu").find(".active");
            if(submenu){
            	if($("#breadcrumbs .homemenu")){
        			$("#breadcrumbs .homemenu").html($(submenu).parents("ul").parent("li").find("span").html());
        		}
        		if($("#breadcrumbs .submenumenu")){
        			$("#breadcrumbs .submenumenu").html($(submenu).find("span").html());
        			$("#breadcrumbs .submenumenu").attr('href',$(submenu).find("a").attr("href"));
        		}
            }
        }
    });
  return true;
}
function showNotice(title, text, type, delay) {
	if(!type)type='info';
	if(!delay)delay=1000*10;
	new PNotify({
		title: title,
		text: text,
		type:type,
		delay:delay,
		hide:true, //是否自动关闭
		mouse_reset:true,   //鼠标悬浮的时候，时间重置
		/*history:{
			 history:true,
			 menu:true,
			 fixed:true,
			 maxonscreen:Infinity ,
			 labels: {redisplay: "历史消息", all: "显示全部", last: "最后一个"}
		},
		buttons:{
			closer:true,
			closer_hover:false,
			sticker_hover:true,
			//labels: {close: "Close", stick: "Stick"}
		},*/
		styling: 'bootstrap3'
	});
}