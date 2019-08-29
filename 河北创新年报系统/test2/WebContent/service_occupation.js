/**
 * 三级连动
 */
 var iNum;
        var iNum1;
        var Big_classs = [ "农、林、牧、渔业", "采矿业","制造业","电力、热力、燃气及水生产和供应业","建筑业" ];
    	var Middle_classs = [ 
    		[ "农业", "林业", "畜牧业", "渔业", "农、林、牧、渔专业及辅助性活动" ], 
    		[ "煤炭开采和洗选业", "石油和天然气开采业", "黑色金属矿采选业", "有色金属矿采选业","非金属矿采选业" ],
    		["农副食品加工业"],
    		["电力、热力生产和供应业"]
    		];
    	var Small_classs = [
    			[ 
    				[ "谷物种植", "豆类、油料和薯类种植","棉、麻、糖、烟草种植"," 蔬菜、食用菌及园艺作物种植","水果种植","坚果、含油果、香料和饮料作物种植","中药材种植","草种植及割草" ],
    				[ "豆类种植", "油料种植","薯类种植" ], 
    				[ "林木育种和育苗", "造林和更新","森林经营、管护和改培","木材和竹材采运","林产品采集","牲畜饲养", "家禽饲养","狩猎和捕捉动物","其他畜牧业" ],
    			    [ " 水产养殖", "水产捕捞" ],
    			    ["农业专业及辅助性活动","林业专业及辅助性活动","畜牧专业及辅助性活动"," 渔业专业及辅助性活动"]
    			],
    			[ 
    				["烟煤和无烟煤开采洗选","褐煤开采洗选","其他煤炭采选"]
    				[ "石油开采", "天然气开采" ], 
    				[ " 铁矿采选" ], 
    				[ " 常用有色金属矿采选" ], 
    				[ "房屋建筑业" ] 
    			],
    			[
    				["谷物磨制"]
    			],
    			[
    				["电力生产"]
    			],
    			[
    				["住宅房屋建筑"]
    			]
    			];
        $(function(){//当页面加载时在省份菜单下加载省份数组里的内容
            for(var i=0;i<Big_classs.length;i++){
                $("#selBig").append("<option vlaue='"+Big_classs[i]+"'>"+Big_classs[i]+"</option>")
            }
            $("#selBig").change(function(){//当省份菜单改变时1-移除除了“请选择”之外的其他项2-得到省份菜单选择项的下标
                //3-根据得到的下标将对应省份的城市存入数组4-将得到的城市加载在城市菜单下
                $("#selMiddle").children().not(":eq(0)").remove();
                $("#selSmall").children().not(":eq(0)").remove();
                iNum=$(this).children("option:selected").index();
                var MMiddle_classs=Middle_classs[iNum-1];
                for(var i=0;i<MMiddle_classs.length;i++){
                    $("#selMiddle").append("<option value="+MMiddle_classs[i]+">"+MMiddle_classs[i]+"</option>")
                }
            });
            $("#selMiddle").change(function(){//当城市菜单改变时1-移除除了“请选择”之外的其它选项2-得到省份菜单选择项的下标和城市菜单选择项的下标
                //3-根据得到的下标将对应县城存入数组4-将得到的县加载在县菜单下
                $("#selSmall").children().not(":eq(0)").remove();
                iNum1=$(this).children("option:selected").index();
                var SSmall_classs=Small_classs[iNum-1][iNum1-1];
                for(var i=0;i<SSmall_classs.length;i++){
                    $("#selSmall").append("<option vlaue="+SSmall_classs[i]+">"+SSmall_classs[i]+"</option>")
                }
            });
        });
