package com.luhf.controller;

import com.jfinal.core.Controller;
import com.jfinal.log.Logger;

/**
 * 首页控制器
 * @author luhf
 * @date 2013-3-30 下午4:11:08
 */
public class IndexController extends Controller{
	
	protected final Logger logger = Logger.getLogger(getClass());
	
	public void index(){
		setAttr("title","首页");
		setAttr("keywords","开源,开源软件,开源网站,开源社区,开源中国社区,java开源,perl开源,python开源,ruby开源,php开源,开源项目,开源代码");
		setAttr("description","开源中国 www.oschina.net 是目前中国最大的开源技术社区。我们传播开源的理念，推广开源项目，为 IT 开发者提供了一个发现、使用、并交流开源技术的平台。目前开源中国社区已收录超过两万款开源软件。");
		render("index.html");
	}
	
}
