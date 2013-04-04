$(function() {
	_AF.nav.initNav();//初始化导航菜单
	_AF.tabs.initTab();//绑定右键菜单事件
	_AF.theme.initTheme();//初始化切换主题
});
var _AF={
	
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
		 * 初始化主题
		 */
		initTheme:function(){
			var themes = {
				'gray' : '/res/css/themes/gray/easyui.css',
				'black' : '/res/css/themes/black/easyui.css',
				'bootstrap' : '/res/css/themes/bootstrap/easyui.css',
				'blue' : '/res/css/themes/default/easyui.css',
				'metro' : '/res/css/themes/metro/easyui.css'
			};
			_AF.theme.cookieTheme(themes);
			var skins = $('.li-skinitem span').click(function() {
				_AF.theme.setTheme(skins, this, themes);
			});
		},
		/**
		 * 设置主题
		 * @param skins 所有主题selector
		 * @param current 当前主题
		 * @param themes 所有主题资源
		 */
		setTheme:function(skins,current,themes){
			var $this = $(current);
			if($this.hasClass('cs-skin-on')) return;
			skins.removeClass('cs-skin-on');
			$this.addClass('cs-skin-on');
			var skin = $this.attr('rel');
			$('#swicth-style').attr('href', themes[skin]);
			_AF.cookie.setCookie('cs-skin', skin, {})
		},
		/**
		 * 从cookie中获取并设置主题
		 * @param themes 所有主题资源
		 */
		cookieTheme:function(themes){
			if(_AF.cookie.getCookie('cs-skin')) {
				var skin = _AF.cookie.getCookie('cs-skin');
				$('#swicth-style').attr('href', themes[skin]);
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
		 * 返回创建的iframe
		 * @param url 页面路径
		 */
		createFrame:function(url){
			var s = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
			return s;
		},
		
		/**
		 * 创建tabs的iframe
		 */
		addTab:function(title,url){
			if ($('#tabs').tabs('exists', title)){
				$('#tabs').tabs('select', title);//选中并刷新
				var currTab = $('#tabs').tabs('getSelected');
				var url = $(currTab.panel('options').content).attr('src');
				if(url != undefined && currTab.panel('options').title != '首页(Home)') {
					$('#tabs').tabs('update',{
						tab:currTab,
						options:{
							content:_AF.tabs.createFrame(url)
						}
					})
				}
			} else {
				$('#tabs').tabs('add',{
					title:title,
					content:_AF.tabs.createFrame(url),
					closable:true
				});
			}
			_AF.tabs.tabClose();
		},
		
		/**
		 * tabs关闭
		 */
		tabClose:function(){
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
		},
		
		/**
		 * 绑定右键菜单
		 */
		initTab:function(){
			//刷新
			$('#mm-tabupdate').click(function(){
				var currTab = $('#tabs').tabs('getSelected');
				var url = $(currTab.panel('options').content).attr('src');
				if(url != undefined && currTab.panel('options').title != '首页(Home)') {
					$('#tabs').tabs('update',{
						tab:currTab,
						options:{
							content:_AF.tabs.createFrame(url)
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
					//msgShow('系统提示','后边没有啦~~','error');
					alert('后边没有啦~~');
					return false;
				}
				nextall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					$('#tabs').tabs('close',t);
				});
				return false;
			});
			//关闭当前左侧的TAB
			$('#mm-tabcloseleft').click(function(){
				var prevall = $('.tabs-selected').prevAll();
				if(prevall.length==0){
					alert('到头了，前边没有啦~~');
					return false;
				}
				prevall.each(function(i,n){
					var t=$('a:eq(0) span',$(n)).text();
					$('#tabs').tabs('close',t);
				});
				return false;
			});
		}
	},
	
	/**
	 * 初始化导航菜单
	 */
	nav:{
		initNav:function(){
			$('.cs-navi-menu').click(function() {
				var $this = $(this);
				var href = $this.attr('src');
				var title = $this.text();
				_AF.tabs.addTab(title, href);
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