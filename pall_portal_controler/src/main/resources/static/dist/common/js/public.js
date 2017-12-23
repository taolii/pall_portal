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