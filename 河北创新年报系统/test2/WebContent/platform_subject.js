
/**
 * platform_subject.js
 */
/**
     * 三级连动
     */
     var iNum;
     var iNum1;
     var Big_class = [ "哲学","经济学","法学","教育学","文学"];
 	var Middle_class = [ 
 		[ "哲学" ], 
		[ "理论经济学", "应用经济学"],
		["法学","政治学","社会学"],
		["教育学","心理学"],
		["中国语言文学"]
 		];
 	var Small_class = [
 			[ 
 				["中国哲学","外国哲学","逻辑学","伦理学","美学","宗教学","科学技术哲学"]
 			],
 			[ 
 				["政治经济学","经济思想史","经济史","西方经济学","世界经济"],
				[ "国民经济学", "区域经济学","财政学","金融学","产业经济学"]
 			],
 			[
 				["法学理论","法律史","宪法学与行政法学","刑法学"],
				["政治学理论","中外政治制度","国际政治","国际关系"],
				["人类学","民俗学","民族学","中国少数民族史"]
 			],
 			[
 				["教育史","比较教育学","学前教育学","高等教育学"],
				["基础心理学","应用心理学"]
 			],
 			[
 				["文艺学"]
 			]
 			];
            $(function(){//当页面加载时在省份菜单下加载省份数组里的内容
                for(var i=0;i<Big_class.length;i++){
                    $("#Big_subject").append("<option vlaue="+Big_class[i]+">"+Big_class[i]+"</option>")
                }
                $("#Big_subject").change(function(){//当省份菜单改变时1-移除除了“请选择”之外的其他项2-得到省份菜单选择项的下标
                    //3-根据得到的下标将对应省份的城市存入数组4-将得到的城市加载在城市菜单下
                    $("#Middle_subject").children().not(":eq(0)").remove();
                    $("#Small_subject").children().not(":eq(0)").remove();
                    iNum=$(this).children("option:selected").index();
                    var MMiddle_class=Middle_class[iNum-1];
                    for(var i=0;i<MMiddle_class.length;i++){
                        $("#Middle_subject").append("<option vlaue="+MMiddle_class[i]+">"+MMiddle_class[i]+"</option>")
                    }
                });
                $("#Middle_subject").change(function(){//当城市菜单改变时1-移除除了“请选择”之外的其它选项2-得到省份菜单选择项的下标和城市菜单选择项的下标
                    //3-根据得到的下标将对应县城存入数组4-将得到的县加载在县菜单下
                    $("#Small_subject").children().not(":eq(0)").remove();
                    iNum1=$(this).children("option:selected").index();
                    var SSmall_class=Small_class[iNum-1][iNum1-1];
                    for(var i=0;i<SSmall_class.length;i++){
                        $("#Small_subject").append("<option vlaue="+SSmall_class[i]+">"+SSmall_class[i]+"</option>")
                    }
                });
            });
