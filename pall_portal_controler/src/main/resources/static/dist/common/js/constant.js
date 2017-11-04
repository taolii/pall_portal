/*常量*/
var TABLE_CONSTANT = {
        DATA_TABLES : {
            DEFAULT_OPTION : { //DataTables初始化选项
                language: {
                    "sProcessing":   "处理中...",
                    "sLengthMenu":   "",
                    "sZeroRecords":  "没有您要搜索的内容",
                    "sInfo":         "显示 _START_ 到 _END_ 条数据 共 _TOTAL_ 条数据",
                    "sInfoEmpty":    "当前显示第 0 至 0 条数据，共 0条数据",
                    "sInfoFiltered": "(由 _MAX_ 项结果过滤)",
                    "sInfoPostFix":  "",
                    "sSearch":       "搜索:",
                    "sUrl":          "",
                    "sEmptyTable":     "表中数据为空",
                    "sLoadingRecords": "载入中...",
                    "sInfoThousands":  ",",
                    "oPaginate": {
                        "sFirst":    "首页",
                        "sPrevious": "上页",
                        "sNext":     "下页",
                        "sLast":     "末页",
                        "sJump":     "跳转"
                    },
                    "oAria": {
                        "sSortAscending":  ": 以升序排列此列",
                        "sSortDescending": ": 以降序排列此列"
                    }
                },
                
                stripeClasses: ["odd", "even"],//为奇偶行加上样式，兼容不支持CSS伪类的场合
                order: [],          //取消默认排序查询,否则复选框一列会出现小箭头
                processing: false,  //隐藏加载提示,自行处理
                serverSide: true,   //启用服务器端分页
                searching: false    //禁用原生搜索
            },
            COLUMN: {
                CHECKBOX: { //复选框单元格
                	className: "td-checkbox",
                    orderable: false,
                    width: "20px",
                    data: null,
                    render: function (data, type, row, meta) {
                        return '<input type="checkbox" class="iCheck">';
                    }
                }
            },
            RENDER: {   //常用render可以抽取出来，如日期时间、头像等
                ELLIPSIS: function (data, type, row, meta) {
                    data = data;
                    return '<span title="' + data + '">' + data + '</span>';
                }
            }
        }
};
Lobibox.base.OPTIONS = {
		bodyClass       : 'lobibox-open',
		modalClasses : {
		    'error'     : 'lobibox-error',
		    'success'   : 'lobibox-success',
		    'info'      : 'lobibox-info',
		    'warning'   : 'lobibox-warning',
		    'confirm'   : 'lobibox-confirm',
		    'progress'  : 'lobibox-progress',
		    'prompt'    : 'lobibox-prompt',
		    'default'   : 'lobibox-default',
		    'window'    : 'lobibox-window'
		},
		width:"440",
		draggable:true, 
		buttonsAlign: ['left', 'center', 'right'],
		title:{
			success:"成功",
			error:"失败",
			info:"提示"
		},
		buttons: {
		    ok: {
		        'class': 'lobibox-btn lobibox-btn-default',
		        text: '确定',
		        closeOnClick: true
		    },
		    cancel: {
		        'class': 'lobibox-btn lobibox-btn-cancel',
		        text: '确定',
		        closeOnClick: true
		    },
		    yes: {
		        'class': 'lobibox-btn lobibox-btn-yes',
		        text: '确定',
		        closeOnClick: true
		    },
		    no: {
		        'class': 'lobibox-btn lobibox-btn-no',
		        text: '取消',
		        closeOnClick: true
		    },
		    info: {
		        'class': 'lobibox-btn lobibox-btn-no',
		        text: '确定',
		        closeOnClick: true
		    }
		},
		icons: {
		    bootstrap: {
		        confirm: 'glyphicon glyphicon-question-sign',
		        success: 'glyphicon glyphicon-ok-sign',
		        error: 'glyphicon glyphicon-remove-sign',
		        warning: 'glyphicon glyphicon-exclamation-sign',
		        info: 'glyphicon glyphicon-info-sign'
		    },
		    fontAwesome: {
		        confirm: 'fa fa-question-circle',
		        success: 'fa fa-check-circle',
		        error: 'fa fa-times-circle',
		        warning: 'fa fa-exclamation-circle',
		        info: 'fa fa-info-circle'
		    }
		}
};