package com.luhf.controller;

import com.jfinal.core.Controller;
import com.jfinal.log.Logger;
import com.jfinal.plugin.activerecord.Page;
import com.luhf.bean.User;

public class UserController extends Controller{

	protected final Logger logger=Logger.getLogger(getClass());

	public void index(){
		Page<User> page=User.dao.paginate(getParaToInt("page",1),getParaToInt("rows",10),"select *","from user order by id asc");
		setAttr("total",page.getTotalRow());
		setAttr("rows",page.getList());
		renderJson();
	}

}
