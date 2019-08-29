//jQuery 二级联动
	/**
     * 二级连动
     */
     var iNum;
     var iNum1;
     var shi = [ "石家庄市", "唐山市", "秦皇岛市", "邯郸市", "邢台市", "保定市", "张家口市", "承德市", "沧州市", "廊坊市"];
 	var xian = [ 
 		[ "新华区", "桥西区", "桥东区", "长安区", "裕华区", "石家庄矿区", "藁城市", "鹿泉市", "辛集市", "晋州市", "新乐市", "正定县",
 			"栾城县", "行唐县", "灵寿县", "平山县", "深泽县", "无极县", "赵县", "高邑县", "元氏县", "赞皇县", "井陉县" ], 
		[ "路北区", "路南区", "丰南区", "开平区", "丰润区", "古冶区", "迁西县", "滦县", "滦南县", "玉田县", "乐亭县", "唐海县", "迁安市",
			"遵化市" ],
		["海港区", "山海关区", "北戴河区", "昌黎县", "抚宁县", "卢龙县", "青龙满族自治县"],
		["曲周县"],
		["沙河市"],
		["安国市"],
		["宣化县"],
		["兴隆县"],
		["沧县"],
		["安次县"]
 		];
 	
            $(function(){//当页面加载时在省份菜单下加载省份数组里的内容
                for(var i=0;i<shi.length;i++){
                    $("#shi").append("<option value="+shi[i]+">"+shi[i]+"</option>")
                }
                $("#shi").change(function(){//当省份菜单改变时1-移除除了“请选择”之外的其他项2-得到省份菜单选择项的下标
                    //3-根据得到的下标将对应省份的城市存入数组4-将得到的城市加载在城市菜单下
                    $("#xian").children().not(":eq(0)").remove();
                    iNum=$(this).children("option:selected").index();
                    var xxian=xian[iNum-1];
                    for(var i=0;i<xxian.length;i++){
                        $("#xian").append("<option value="+xxian[i]+">"+xxian[i]+"</option>")
                    }
                });
               
            });
