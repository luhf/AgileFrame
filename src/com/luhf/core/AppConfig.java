package com.luhf.core;

import com.jfinal.config.Constants;
import com.jfinal.config.Handlers;
import com.jfinal.config.Interceptors;
import com.jfinal.config.JFinalConfig;
import com.jfinal.config.Plugins;
import com.jfinal.config.Routes;
import com.jfinal.core.JFinal;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.ext.interceptor.NoUrlPara;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.druid.DruidPlugin;
import com.jfinal.plugin.druid.DruidStatViewHandler;
import com.luhf.bean.Nav;
import com.luhf.bean.User;
import com.luhf.controller.IndexController;
import com.luhf.controller.UserController;

/**
 * API引导式配置
 * @author luhf
 * @date 2013-3-30 下午4:07:26
 */
public class AppConfig extends JFinalConfig{

	protected final Logger logger=Logger.getLogger(getClass());

	/**
	 * 配置常量
	 */
	@Override
	public void configConstant(Constants me){
		//加载配置文件
		loadPropertyFile("jdbc.properties");
		//设置开发模式
		me.setDevMode(getPropertyToBoolean("devMode",false));
		//设置基本视图路径
		me.setBaseViewPath("/ftl");
		me.setError404View("/404.html");
		me.setError500View("/500.html");
	}

	/**
	 * 配置路由
	 */
	@Override
	public void configRoute(Routes me){
		me.add("/",IndexController.class);
		me.add("/user",UserController.class);
	}

	/**
	 * 配置插件
	 */
	@Override
	public void configPlugin(Plugins me){
		// 配置Druid数据库连接池插件
		DruidPlugin druidPlugin=new DruidPlugin(getProperty("jdbcUrl"),getProperty("user"),getProperty("password").trim());
		me.add(druidPlugin);

		// 配置ActiveRecord插件
		ActiveRecordPlugin arp=new ActiveRecordPlugin(druidPlugin);
		me.add(arp);

		// 配置Mapping
		arp.addMapping("user",User.class);
		arp.addMapping("nav",Nav.class);
	}

	/**
	 * 配置全局拦截器
	 */
	@Override
	public void configInterceptor(Interceptors me){
		// 配置没有url访问404
		me.add(new NoUrlPara());
	}

	/**
	 * 配置处理器
	 */
	@Override
	public void configHandler(Handlers me){
		//配置上下文路径
		me.add(new ContextPathHandler("root"));
		//druid数据数据库连接池页面查看路径
		me.add(new DruidStatViewHandler("/druid"));
	}

	/**
	 * 应用启动后
	 */
	@Override
	public void afterJFinalStart(){
		logger.debug("应用正常启动...");
	}

	/**
	 * 应用停止前
	 */
	@Override
	public void beforeJFinalStop(){
		logger.debug("应用正常停止...");
	}

	/**
	 * 建议使用 JFinal 手册推荐的方式启动项目 运行此 main
	 * 方法可以启动项目，此main方法可以放置在任意的Class类定义中，不一定要放于此
	 */
	public static void main(String[] args){
		JFinal.start("WebContent",80,"/",5);
	}

}
