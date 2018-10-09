select h.*,i.roleid from(select f.*,concat(g.menuid,g.btncname) ss from t_ums_right f,t_ums_menu_button g  where f.RIGHTTYPE=2 and g.btnid=f.DATAID)h
,(select f.ROLEID,replace(replace(replace(replace(f.ROLENAME,'DSP装配流程_','401'),'水箱装配流程_','402'),'主机装配流程_','404'),'预处理装配流程_','403') ss from t_ums_role f)i where h.ss=i.ss;
