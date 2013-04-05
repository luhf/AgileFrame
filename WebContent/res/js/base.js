/**
 * 公用方法
 */
var _AF={
	/**
	 * ajax
	 */
	ajax:{
		/**
		 * post提交
		 * @param url 路径
		 * @param param 参数
		 * @param dataType 类型
		 * @param callback 回调函数
		 * @example _AF.ajax.post('/xxx/xxx/xxx',{a:1,b:2},'json',function(html){//处理返回结果});
		 */
		post:function(url,param,dataType,callback){
			$.ajax({
				type:'POST',
				url:url,
				dataType:dataType,
				data:param,
				success:callback,
				error:function(html){
					alert("提交数据失败，代码:" +html.status+ "，请稍候再试");
				}
			});
		},
		/**
		 * post提交并刷新页面
		 * @param url 路径
		 * @param param 参数
		 * @param dataType 类型
		 * @example _AF.ajax.post('/xxx/xxx/xxx',{a:1,b:2},'json');
		 */
		post_refresh:function(url,param,dataType,callback){
			$.ajax({
				type:'POST',
				url:url,
				dataType:dataType,
				data:param,
				success:function(html){location.reload();},
				error:function(html){
					alert("提交数据失败，代码:" +html.status+ "，请稍候再试");
				}
			});
		}
	},
	
	/**
	 * cookie
	 */
	cookie:{
		/**
		 * 设置cookie
		 * @param key 键
		 * @param value 值
		 * @param options 选项[有效期,路径,域名,](例如:{expires: 7, path: '/', domain: 'jquery.com', secure: true})
		 * @example _AF.cookie.setCookie('key','value',{expires: 7, path: '/', domain: 'jquery.com', secure: true});
		 */
		setCookie:function(key,value,options){
			$.cookie(key,value,options);
		},
		
		/**
		 * 获取cookie
		 * @param key 键
		 * @return 值
		 * @example _AF.cookie.getCookie('key');
		 */
		getCookie:function(key){
			return $.cookie(key)!==undefined?$.cookie(key):null;
		},
		
		/**
		 * 删除cookie
		 * @param key 键
		 * @param options 选项[有效期必须是-1,路径,域名,安全HTTS](例如:{expires: -1, path: '/', domain: 'jquery.com', secure: true})
		 * @example _AF.cookie.removeCookie('key',{expires: -1, path: '/', domain: 'jquery.com', secure: true});
		 */
		removeCookie:function(key,options){
			$.removeCookie(key,options);
		}
	},
	
	/**
	 * easyui主题
	 */
	theme:{
		/**
		 * 所有主题资源
		 */
		themes:{
			'gray' : '/res/css/themes/gray/easyui.css',
			'black' : '/res/css/themes/black/easyui.css',
			'bootstrap' : '/res/css/themes/bootstrap/easyui.css',
			'blue' : '/res/css/themes/default/easyui.css',
			'metro' : '/res/css/themes/metro/easyui.css'
		},
		/**
		 * 初始化主题
		 */
		init:function(){
			_AF.theme.getCookieTheme();
			var skins = $('.li-skinitem span').click(function() {
				_AF.theme.setCookieTheme(skins, this);
			});
		},
		/**
		 * 设置主题
		 */
		setTheme:function(skin){
			$('#swicth-style').attr('href', _AF.theme.themes[skin]);
		},
		/**
		 * Cookie设置主题
		 * @param skins 所有主题selector
		 * @param current 当前主题
		 */
		setCookieTheme:function(skins,current){
			var $this = $(current);
			if($this.hasClass('cs-skin-on')) return;
			skins.removeClass('cs-skin-on');
			$this.addClass('cs-skin-on');
			var skin = $this.attr('rel');
			_AF.theme.setTheme(skin);
			_AF.cookie.setCookie('cs-skin', skin, {})
		},
		/**
		 * Cookie获取主题
		 */
		getCookieTheme:function(){
			if(_AF.cookie.getCookie('cs-skin')) {
				var skin = _AF.cookie.getCookie('cs-skin');
				_AF.theme.setTheme(skin);
				$this = $('.li-skinitem span[rel='+skin+']');
				$this.addClass('cs-skin-on');
			}
		}
	},
	
	/**
	 * easyui-tabs
	 */
	tabs:{
		/**
		 * 绑定右键菜单
		 */
		init:function(){
			//刷新
			$('#mm-tabupdate').click(function(){
				var currTab = $('#tabs').tabs('getSelected');
				var url = $(currTab.panel('options').content).attr('src');
				if(url != undefined && currTab.panel('options').title != '首页(Home)') {
					$('#tabs').tabs('update',{
						tab:currTab,
						options:{
							content:_AF.tabs.create(url)
						}
					})
				}
			});
			//关闭当前
			$('#mm-tabclose').click(function(){
				var currtab_title = $('#mm').data("currtab");
				$('#tabs').tabs('close',currtab_title);
			});
			//全部关闭
			$('#mm-tabcloseall').click(function(){
				$('.tabs-inner span').each(function(i,n){
					var t = $(n).text();
					if(t != '首页(Home)') {
						$('#tabs').tabs('close',t);
					}
				});
			});
			//关闭除当前之外的TAB
			$('#mm-tabcloseother').click(function(){
				var prevall = $('.tabs-selected').prevAll();
				var nextall = $('.tabs-selected').nextAll();
				if(prevall.length>0){
					prevall.each(function(i,n){
						var t=$('a:eq(0) span',$(n)).text();
						if(t != '首页(Home)') {
							$('#tabs').tabs('close',t);
						}
					});
				}
				if(nextall.length>0) {
					nextall.each(function(i,n){
						var t=$('a:eq(0) span',$(n)).text();
						if(t != '首页(Home)') {
							$('#tabs').tabs('close',t);
						}
					});
				}
				return false;
			});
			//关闭当前右侧的TAB
			$('#mm-tabcloseright').click(function(){
				var nextall = $('.tabs-selected').nextAll();
				if(nextall.length==0){
					_AF.msg.show('系统提示', '右侧没有可关闭的tab页', 'error');
					return false;
				}
				nextall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					if(t != '首页(Home)'){
						$('#tabs').tabs('close',t);
					}
				});
				return false;
			});
			//关闭当前左侧的TAB
			$('#mm-tabcloseleft').click(function(){
				var prevall = $('.tabs-selected').prevAll();
				if(prevall.length==0){
					_AF.msg.show('系统提示', '左侧没有可关闭的tab页', 'error');
					return false;
				}else if(prevall.length==1){
					_AF.msg.show('系统提示', '首页不能被关闭', 'error');
					return false;
				}
				prevall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					if(t != '首页(Home)'){
						$('#tabs').tabs('close',t);
					}
				});
				return false;
			});
		},
		/**
		 * 返回创建的iframe
		 * @param url 页面路径
		 */
		create:function(url){
			var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
			return s;
		},
		
		/**
		 * 创建tabs的iframe
		 */
		add:function(title,url){
			if ($('#tabs').tabs('exists', title)){
				$('#tabs').tabs('select', title);//选中并刷新
				var currTab = $('#tabs').tabs('getSelected');
				var url = $(currTab.panel('options').content).attr('src');
				if(url != undefined && currTab.panel('options').title != '首页(Home)') {
					$('#tabs').tabs('update',{
						tab:currTab,
						options:{
							content:_AF.tabs.create(url)
						}
					})
				}
			} else {
				$('#tabs').tabs('add',{
					title:title,
					content:_AF.tabs.create(url),
					closable:true
				});
			}
			_AF.tabs.close();
		},
		
		/**
		 * tabs关闭
		 */
		close:function(){
			/*双击关闭TAB选项卡*/
			$(".tabs-inner").dblclick(function(){
				var subtitle = $(this).children(".tabs-closable").text();
				$('#tabs').tabs('close',subtitle);
			})
			/*为选项卡绑定右键*/
			$(".tabs-inner").bind('contextmenu',function(e){
				$('#mm').menu('show', {
					left: e.pageX,
					top: e.pageY
				});

				var subtitle =$(this).children(".tabs-closable").text();

				$('#mm').data("currtab",subtitle);
				$('#tabs').tabs('select',subtitle);
				return false;
			});
		}
	},
	
	/**
	 * 初始化导航菜单
	 */
	nav:{
		init:function(){
			$('.cs-navi-menu').click(function() {
				var $this = $(this);
				var href = $this.attr('src');
				var title = $this.text();
				_AF.tabs.add(title, href);
			});
		}
	},
	
	/**
	 * 消息框
	 */
	msg:{
		/**
		 * 弹出信息窗口
		 * @param title 标题
		 * @param msgContent 提示信息
		 * @param msgType 信息类型 [error,info,question,warning]
		 */
		show:function(title, msgContent, msgType){
			$.messager.alert(title, msgContent, msgType);
		}
	}
};