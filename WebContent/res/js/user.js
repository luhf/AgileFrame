$(function(){
	initDataGrid();
});

//动态加载datagrid
function initDataGrid(){
	var _datagrid=$('#datagrid');
	_datagrid.datagrid({
		url:'/user',
		striped:true,
		singleSelect:true,
		height:310,
		width:427,
		columns:[[
			{field:'id',title:'用户ID',width:50},
			{field:'username',title:'登陆名称',width:90},
			{field:'password',title:'登陆密码',width:282},
		]],
		pagination:true
	});
}