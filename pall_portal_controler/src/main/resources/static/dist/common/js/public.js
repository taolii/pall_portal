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
