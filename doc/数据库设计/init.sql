/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2013-4-7 0:36:51                             */
/*==============================================================*/


drop table if exists SYS_AGENT_AUTH;

drop table if exists SYS_AGENT_AUTH_FUNC;

drop table if exists SYS_AUDIT_LOG;

drop table if exists SYS_CODE_COL_RLT;

drop table if exists SYS_CODE_DEF;

drop table if exists SYS_CODE_VALUE;

drop table if exists SYS_DATA_AUTH_TYPE;

drop table if exists SYS_DFLT_DATA_AUTH;

drop table if exists SYS_DOMAIN;

drop table if exists SYS_FUNC;

drop table if exists SYS_JOBFUNC;

drop table if exists SYS_JOBFUNC_FUNC;

drop table if exists SYS_LOG;

drop table if exists SYS_LOG_HIS;

drop table if exists SYS_NOTIFY;

drop table if exists SYS_NOTIFY_ACCEPT;

drop table if exists SYS_NOTIFY_ATTACH;

drop table if exists SYS_NOTIFY_RANGE;

drop table if exists SYS_OP;

drop table if exists SYS_OPRT_TYPE;

drop table if exists SYS_OP_AGENT_RLT;

drop table if exists SYS_OP_DATA_AUTH;

drop table if exists SYS_OP_JOBFUNC;

drop table if exists SYS_OP_MAPPING;

drop table if exists SYS_OP_ORG_RLT;

drop table if exists SYS_OP_ROLE;

drop table if exists SYS_ORG;

drop table if exists SYS_ORG_MAPPING;

drop table if exists SYS_ORG_TYPE;

drop table if exists SYS_PARAM;

drop table if exists SYS_RES;

drop table if exists SYS_ROLE;

/*==============================================================*/
/* Table: SYS_AGENT_AUTH                                        */
/*==============================================================*/
create table SYS_AGENT_AUTH
(
   AGENT_AUTH_ID        int(16) not null auto_increment comment '代理授权ID',
   AUTH_OP_ID           int(16) comment '授权操作员ID',
   AUTHED_OP_ID         int(16) comment '被授权操作员ID（接受授权操作员）',
   AUTH_STATE           tinyint(2) comment '授权状态：1-生效 0-失效',
   AUTH_EFF_DATE        timestamp default '0000-00-00 00:00:00' comment '授权生效时间',
   AUTH_EXP_DATE        timestamp default '0000-00-00 00:00:00' comment '授权失效时间',
   AGENT_AUTH_FUNC_TYPE tinyint(2) comment '代理授权功能类型：0-全部功能 1-指定功能（在代理授权功能表记录）',
   NOTES                varchar(800) comment '备注',
   AUTH_APPR_OP_ID      int(16) comment '授权审批人ID',
   AUTH_APPR_TIME       timestamp default '0000-00-00 00:00:00' comment '授权审批时间',
   AUTH_APPR_STATE      tinyint(2) comment '授权审批状态：1-通过 2-不通过',
   AUTH_APPR_COMMENT    varchar(800) comment '授权审批意见',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (AGENT_AUTH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_AGENT_AUTH comment '记录用户代理授权信息';

/*==============================================================*/
/* Table: SYS_AGENT_AUTH_FUNC                                   */
/*==============================================================*/
create table SYS_AGENT_AUTH_FUNC
(
   AGENT_AUTH_FUNC_ID   int(16) not null auto_increment comment '代理授权功能ID',
   AGENT_AUTH_ID        int(16) not null comment '代理授权ID',
   FUNC_ID              int(16) not null comment '功能ID',
   NOTES                varchar(800) comment '备注',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp comment '修改时间',
   primary key (AGENT_AUTH_FUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_AGENT_AUTH_FUNC comment '记录代理授权可使用的系统功能（只授权指定菜单功能时记录）';

/*==============================================================*/
/* Table: SYS_AUDIT_LOG                                         */
/*==============================================================*/
create table SYS_AUDIT_LOG
(
   AUDIT_LOG_ID         int(16) not null auto_increment comment '系统审计日志ID',
   RESOURCE_KIND        int(6) comment '资源类别（对于应用来说值为“1”）',
   IDR_CREATION_TIME    timestamp default '0000-00-00 00:00:00' comment '消息创建时间',
   IDENTITY_NAME        varchar(80) comment '管理实体名称（用于采集业务处理）',
   RESOURCE_CODE        varchar(30) comment '资源编码（每种应用系统对应一种资源编码）',
   OPERATE_TIME         timestamp default '0000-00-00 00:00:00' comment '操作时间',
   OP_TYPE_ID           varchar(30) comment '操作类型编码(1-CQESOP--10101:统一视图管理_查询 1-CQESOP--10102:统一视图管理_导出EXCEL  ...Notes)',
   OP_TYPE_NAME         varchar(80) comment '操作类型名称（对应操作类型编码的操作名称）',
   OP_LEVEL_ID          tinyint(2) comment '操作级别（审计级别：1-一般 2-重要 3-敏感 4-警告 5-严重）',
   OPERATE_RESULT       tinyint(2) comment '操作结果：0-成功 1-失败',
   OPERATE_CONTENT      varchar(2000) comment '操作内容（4A业务使用）',
   SERVER_ADDRESS       varchar(20) comment '服务端IP地址',
   SERVER_MAC           varchar(20) comment '服务器端mac地址',
   SERVER_PORT          varchar(20) comment '服务器端端口',
   CLIENT_ADDRESS       varchar(20) comment '客户端通信IP地址（用户登录所使用的客户端IP）',
   CLIENT_PORT          varchar(20) comment '客户端端口',
   CLIENT_MAC           varchar(20) comment '客户端mac地址（多个）',
   CLIENT_NETWORK_ADDRESS varchar(200) comment '客户端IP地址（用户客户端上多网卡IP）',
   CLIENT_CPU_SERIAL    varchar(40) comment '客户端CPU序列号',
   SUB_ACCOUNT_NAME     varchar(30) comment '应用从账号（用户登录应用系统使用的账号）',
   MAIN_ACCOUNT_NAME    varchar(40) comment '主账号名称',
   TASK_CODE            varchar(20) comment '该操作对应的工单号',
   MODULE_ID            varchar(20) comment '模块ID',
   MODULE_NAME          varchar(200) comment '模块名称',
   SYNC4A_FLAG          tinyint(2) comment '同步4A标志：0-未同步 1-已同步',
   SYNC4A_TIME          timestamp default '0000-00-00 00:00:00' comment '同步4A时间',
   BANK_APPROVE         varchar(200) comment '金库审批流水号',
   BANK_PROOF           tinyint(2) comment '金库式审计凭证（0-操作需要金库式审计，本次操作没有凭证 1-操作需要金库式审计，本次操作有凭证 2-操作不需要金库式审计 默认值）',
   BANK_FLAG            tinyint(2) comment '金库验证标志： -1-直接关闭窗口，未申请审批 
            0-审批不通过 
            1-审批通过 
            2-超时，允许业务继续访问 
            3-超时，不允许业务继续访问
            4-出现错误或异常（包括数据异常）
            5-未配置策略，允许业务继续访问
            6-未配置策略，不允许继续访问',
   EXT_DATE_01          TIMESTAMP default '0000-00-00 00:00:00',
   EXT_DATE_02          TIMESTAMP default '0000-00-00 00:00:00',
   EXT_NUM_01           int(16),
   EXT_NUM_02           int(16),
   EXT_NUM_03           int(16),
   EXT_NUM_04           int(16),
   EXT_STR_01           varchar(40),
   EXT_STR_02           varchar(40),
   EXT_STR_03           varchar(40),
   EXT_STR_04           varchar(40),
   EXT_STR_05           varchar(40),
   EXT_STR_06           varchar(40),
   primary key (AUDIT_LOG_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_AUDIT_LOG comment '记录审计日志信息';

/*==============================================================*/
/* Table: SYS_CODE_COL_RLT                                      */
/*==============================================================*/
create table SYS_CODE_COL_RLT
(
   CODE_ID              varchar(30) not null comment '代码标识',
   CODE_TAB_NAME        varchar(30) not null comment '代码对应表名',
   CODE_COL_NAME        varchar(30) not null comment '代码对应字段名',
   NOTES                varchar(800) comment '备注',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (CODE_ID, CODE_TAB_NAME, CODE_COL_NAME)
)
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_CODE_COL_RLT comment '定义使用代码的表字段对应信息
（静态数据表）';

/*==============================================================*/
/* Table: SYS_CODE_DEF                                          */
/*==============================================================*/
create table SYS_CODE_DEF
(
   CODE_ID              varchar(30) not null comment '代码标识',
   CODE_KIND            int(6) comment '代码分类',
   CODE_NAME            varchar(80) comment '代码名称',
   CODE_DESC            varchar(400) comment '代码描述',
   CODE_DATA_TYPE       tinyint(2) comment '代码数据类型：1-数值 2-字符',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (CODE_ID)
)
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_CODE_DEF comment '定义系统使用的枚举值代码
（静态数据表）';

/*==============================================================*/
/* Table: SYS_CODE_VALUE                                        */
/*==============================================================*/
create table SYS_CODE_VALUE
(
   CODE_ID              varchar(30) not null comment '代码标识',
   CODE_VALUE           varchar(40) not null comment '代码取值',
   CODE_VALUE_NAME      varchar(80) comment '代码取值名称',
   CODE_VALUE_ALIAS     varchar(80) comment '代码取值别名',
   CODE_VALUE_DESC      varchar(400) comment '代码取值描述',
   CODE_VALUE_ORDER     int(6) comment '代码取值排序',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (CODE_ID, CODE_VALUE)
)
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_CODE_VALUE comment '定义系统使用的枚举值代码含义信息
（静态数据表）';

/*==============================================================*/
/* Table: SYS_DATA_AUTH_TYPE                                    */
/*==============================================================*/
create table SYS_DATA_AUTH_TYPE
(
   DATA_AUTH_TYPE_ID    int(16) not null auto_increment comment '数据权限类型ID',
   DATA_AUTH_TYPE_NAME  varchar(80) comment '数据权限类型名称',
   DATA_AUTH_TYPE_DESC  varchar(400) comment '数据权限类型描述',
   DATA_AUTH_TAB_NAME   varchar(30) comment '数据权限对应表名',
   DATA_AUTH_COL_NAME   varchar(30) comment '数据权限对应字段名',
   AUTH_OBJ_SEL_URL     varchar(200) comment '权限对象选择页面URL',
   DOMAIN_ID            int(16) comment '域ID',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (DATA_AUTH_TYPE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_DATA_AUTH_TYPE comment '定义控制数据权限的对象类型，如组织、区域、员工、产品
（静态数据表）';

/*==============================================================*/
/* Table: SYS_DFLT_DATA_AUTH                                    */
/*==============================================================*/
create table SYS_DFLT_DATA_AUTH
(
   DFLT_DATA_AUTH_ID    int(16) not null auto_increment comment '缺省数据权限规则ID',
   DATA_AUTH_TYPE_ID    int(16) comment '数据权限类型ID',
   RES_ID               int(16) comment '资源ID',
   ROLE_ID              int(16) comment '角色ID',
   DFLT_DATA_AUTH_NAME  varchar(80) comment '缺省数据权限规则名称',
   DFLT_DATA_AUTH_DESC  varchar(400) comment '缺省数据权限规则描述',
   DATA_AUTH_RULE_TYPE  tinyint(2) comment '数据权限规则类型：1-自身数据权限 2-自身及下级数据权限',
   DOMAIN_ID            int(16) comment '域ID',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (DFLT_DATA_AUTH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_DFLT_DATA_AUTH comment '记录对系统资源使用的数据权限类型（缺省数据权限规则）';

/*==============================================================*/
/* Table: SYS_DOMAIN                                            */
/*==============================================================*/
create table SYS_DOMAIN
(
   DOMAIN_ID            int(16) not null auto_increment comment '域ID',
   DOMAIN_CODE          varchar(40) comment '域编码',
   DOMAIN_NAME          varchar(80) comment '域名称',
   DOMAIN_DESC          varchar(400) comment '域描述',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (DOMAIN_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_DOMAIN comment '定义权限域，区分同一系统下不同权限范围
（静态数据表）';

/*==============================================================*/
/* Table: SYS_FUNC                                              */
/*==============================================================*/
create table SYS_FUNC
(
   FUNC_ID              int(16) not null auto_increment comment '功能ID',
   SUP_FUNC_ID          int(16) comment '功能ID',
   OPRT_TYPE_ID         int(16) comment '操作类型ID',
   RES_ID               int(16) comment '资源ID',
   FUNC_TYPE            tinyint(2) comment '功能类别：1-菜单 2-页面 3-按钮 4-工作台 5-组件',
   FUNC_LEVEL           tinyint(2) comment '功能级别：1-一级 2-二级 3-三级 4-四级 ...',
   FUNC_CODE            varchar(80) comment '功能编码',
   FUNC_NAME            varchar(200) comment '功能名称',
   FUNC_DESC            varchar(400) comment '功能描述',
   FUNC_ORDER           int(6) comment '功能排序',
   FUNC_URL             varchar(1000) comment '功能URL',
   FUNC_IMG             varchar(1000) comment '关联图片（包括路径、文件名）',
   FUNC_PARAM           varchar(1000) comment '功能参数',
   IF_DISPLAY           tinyint(2) comment '是否显示：1-显示 2-不显示（定义隐含菜单、页面）',
   IF_COMMENT           tinyint(2) comment '是否可评论：1-可评论 0-不可评论',
   FUNC_HELP_FLAG       tinyint(2) comment '功能帮助标志：1-有帮助 0-无帮助',
   FUNC_HELP_URL        varchar(1000) comment '功能帮助URL',
   DOMAIN_ID            int(16) comment '域ID',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (FUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_FUNC comment '记录系统功能信息，包括菜单、页面、按钮、工作台、组件';

/*==============================================================*/
/* Table: SYS_JOBFUNC                                           */
/*==============================================================*/
create table SYS_JOBFUNC
(
   JOBFUNC_ID           int(16) not null auto_increment comment '职能ID',
   ROLE_ID              int(16) comment '角色ID',
   JOBFUNC_CODE         varchar(40) comment '职能编码',
   JOBFUNC_NAME         varchar(80) comment '职能名称',
   JOBFUNC_DESC         varchar(400) comment '职能描述',
   JOBFUNC_ORDER        int(6) comment '职能排序',
   DOMAIN_ID            int(16) comment '域ID',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (JOBFUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_JOBFUNC comment '记录职能信息，职能是一些系统功能的集合';

/*==============================================================*/
/* Table: SYS_JOBFUNC_FUNC                                      */
/*==============================================================*/
create table SYS_JOBFUNC_FUNC
(
   JOBFUNC_FUNC_ID      int(16) not null auto_increment comment '职能功能ID',
   FUNC_ID              int(16) comment '功能ID',
   JOBFUNC_ID           int(16) comment '职能ID',
   DOMAIN_ID            int(6) comment '域ID',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (JOBFUNC_FUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_JOBFUNC_FUNC comment '记录职能包含的系统功能';

/*==============================================================*/
/* Table: SYS_LOG                                               */
/*==============================================================*/
create table SYS_LOG
(
   LOG_ID               int(16) not null auto_increment comment '系统日志ID',
   LOG_TYPE             tinyint(2) comment '日志类型：1-业务日志（应用主动记录的业务信息） 2-操作日志（自动记录的点击日志） 3-业务操作日志（合并两种日志类型）',
   OP_TYPE              tinyint(2) comment '操作类型：11-登录 12-退出   21-查询（查看） 22-增加 23-修改 24-删除 25-导入（上传） 26-导出（下载）27-审批 28-搜索 29-搜索结果查看',
   RSLT_TYPE            tinyint(2) comment '结果类型：0-成功 1-失败（参数为空等） 2-异常',
   SRC_TYPE             tinyint(2) comment '来源类型：1-本系统 2-外系统',
   OP_ID                int(16) comment '操作员ID',
   OP_NAME              varchar(200) comment '操作员姓名',
   ORG_ID               int(16) comment '组织ID',
   ORG_NAME             varchar(200) comment '组织名称',
   AGENT_FLAG           tinyint(2) comment '代理标志：1-代理 0-非代理',
   AGENT_OP_ID          int(16) comment '代理操作员ID',
   AGENT_OP_NAME        varchar(200) comment '代理操作员姓名',
   OPRT_START_TIME      timestamp default '0000-00-00 00:00:00' comment '操作开始时间',
   OPRT_END_TIME        timestamp default '0000-00-00 00:00:00' comment '操作结束时间',
   OPRT_INTERVAL        int(16) comment '操作时长（秒）',
   OPRT_NAME            varchar(200) comment '操作名称',
   OPRT_DESC            varchar(2000) comment '操作说明',
   OPRT_URL             varchar(400) comment '操作URL',
   OPRT_PARAM           varchar(400) comment '操作参数',
   OPRT_CONTENT         varchar(2000) comment '操作内容（插入修改删除操作的属性值、搜索关键字等）',
   SERVER_ADDRESS       varchar(20) comment '服务端IP地址',
   IP_ADDRESS           varchar(30) comment 'IP地址',
   SESSION_ID           varchar(200) comment '会话ID',
   CONNECT_TYPE         tinyint(2) comment '接入方式：1-WEB接入 2-手机接入',
   MOBILE_NO            varchar(20) comment '手机号',
   FUNC_ID              int(16) comment '功能ID',
   FUNC_NAME            varchar(200) comment '功能名称',
   FUNC_TYPE            tinyint(2) comment '功能类别：1-菜单 2-页面 3-按钮 4-工作台 5-组件',
   OP_OBJ_TYPE          int(6) comment '操作对象类型（操作的业务对象类型：1-需求 2-报表 3-文档 4-指标 5-知识库 6-报表实例 7-需求附件 ）',
   OP_OBJ_ID            int(200) comment '操作对象ID（需求ID、报表ID、报表实例ID、指标ID等、需求附件ID）',
   OP_OBJ_NAME          varchar(200) comment '操作对象名称（需求名称、报表名称、报表实例名称、指标名称、需求附件文档名称）',
   OP_ENT_NAME          varchar(200) comment '操作实体名称（操作实体表名称）',
   OP_ENT_SQL           varchar(2000) comment '操作实体SQL语句（完整SQL语句）',
   OP_ENT_CLAUSE        varchar(800) comment '操作实体条件子句（确定数据记录的标识条件）',
   EXT_DATE_01          timestamp default '0000-00-00 00:00:00',
   EXT_DATE_02          timestamp default '0000-00-00 00:00:00',
   EXT_NUM_01           int(16),
   EXT_NUM_02           int(16),
   EXT_NUM_03           int(16),
   EXT_NUM_04           int(16),
   EXT_STR_01           varchar(40),
   EXT_STR_02           varchar(40),
   EXT_STR_03           varchar(40),
   EXT_STR_04           varchar(40),
   EXT_STR_05           varchar(40),
   EXT_STR_06           varchar(40),
   primary key (LOG_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_LOG comment '记录登录、操作等系统日志信息（包含代理日志）';

/*==============================================================*/
/* Table: SYS_LOG_HIS                                           */
/*==============================================================*/
create table SYS_LOG_HIS
(
   LOG_ID               int(16) not null auto_increment comment '系统日志ID',
   LOG_TYPE             tinyint(2) comment '日志类型：1-业务日志（应用主动记录的业务信息） 2-操作日志（自动记录的点击日志） 3-业务操作日志（合并两种日志类型）',
   OP_TYPE              tinyint(2) comment '操作类型：11-登录 12-退出   21-查询（查看） 22-增加 23-修改 24-删除 25-导入（上传） 26-导出（下载）27-审批 28-搜索 29-搜索结果查看',
   RSLT_TYPE            tinyint(2) comment '结果类型：0-成功 1-失败（参数为空等） 2-异常',
   SRC_TYPE             tinyint(2) comment '来源类型：1-本系统 2-外系统',
   OP_ID                int(16) comment '操作员ID',
   OP_NAME              varchar(200) comment '操作员姓名',
   ORG_ID               int(16) comment '组织ID',
   ORG_NAME             varchar(200) comment '组织名称',
   AGENT_FLAG           tinyint(2) comment '代理标志：1-代理 0-非代理',
   AGENT_OP_ID          int(16) comment '代理操作员ID',
   AGENT_OP_NAME        varchar(200) comment '代理操作员姓名',
   OPRT_START_TIME      timestamp default '0000-00-00 00:00:00' comment '操作开始时间',
   OPRT_END_TIME        timestamp default '0000-00-00 00:00:00' comment '操作结束时间',
   OPRT_INTERVAL        int(16) comment '操作时长（秒）',
   OPRT_NAME            varchar(200) comment '操作名称',
   OPRT_DESC            varchar(2000) comment '操作说明',
   OPRT_URL             varchar(400) comment '操作URL',
   OPRT_PARAM           varchar(400) comment '操作参数',
   OPRT_CONTENT         varchar(2000) comment '操作内容（插入修改删除操作的属性值、搜索关键字等）',
   SERVER_ADDRESS       varchar(20) comment '服务端IP地址',
   IP_ADDRESS           varchar(30) comment 'IP地址',
   SESSION_ID           varchar(200) comment '会话ID',
   CONNECT_TYPE         tinyint(2) comment '接入方式：1-WEB接入 2-手机接入',
   MOBILE_NO            varchar(20) comment '手机号',
   FUNC_ID              int(16) comment '功能ID',
   FUNC_NAME            varchar(200) comment '功能名称',
   FUNC_TYPE            tinyint(2) comment '功能类别：1-菜单 2-页面 3-按钮 4-工作台 5-组件',
   OP_OBJ_TYPE          int(6) comment '操作对象类型（操作的业务对象类型：1-需求 2-报表 3-文档 4-指标 5-知识库 6-报表实例 7-需求附件 ）',
   OP_OBJ_ID            int(200) comment '操作对象ID（需求ID、报表ID、报表实例ID、指标ID等、需求附件ID）',
   OP_OBJ_NAME          varchar(200) comment '操作对象名称（需求名称、报表名称、报表实例名称、指标名称、需求附件文档名称）',
   OP_ENT_NAME          varchar(200) comment '操作实体名称（操作实体表名称）',
   OP_ENT_SQL           varchar(2000) comment '操作实体SQL语句（完整SQL语句）',
   OP_ENT_CLAUSE        varchar(800) comment '操作实体条件子句（确定数据记录的标识条件）',
   EXT_DATE_01          timestamp default '0000-00-00 00:00:00',
   EXT_DATE_02          timestamp default '0000-00-00 00:00:00',
   EXT_NUM_01           int(16),
   EXT_NUM_02           int(16),
   EXT_NUM_03           int(16),
   EXT_NUM_04           int(16),
   EXT_STR_01           varchar(40),
   EXT_STR_02           varchar(40),
   EXT_STR_03           varchar(40),
   EXT_STR_04           varchar(40),
   EXT_STR_05           varchar(40),
   EXT_STR_06           varchar(40),
   primary key (LOG_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_LOG_HIS comment '记录系统日志的历史数据信息（把过期的日志数据从系统日志表转移到此表）';

/*==============================================================*/
/* Table: SYS_NOTIFY                                            */
/*==============================================================*/
create table SYS_NOTIFY
(
   NOTIFY_ID            int(16) not null auto_increment comment '公告ID',
   NOTIFY_TITLE         varchar(200) comment '公告标题',
   NOTIFY_CONTENT       varchar(2000) comment '公告内容',
   NOTIFY_OBJ           varchar(200) comment '公告对象（如公告所属地市、部门）',
   NOTIFY_TYPE          tinyint(2) comment '公告类型：1-公告通知类 2-公共资料类 3-最新动态类 4-知识库公告',
   NOTIFY_DTL_TYPE      int(6) comment '公告明细类型',
   NOTIFY_RANGE         tinyint(2) comment '公告范围：0-全部 1-指定范围',
   NOTIFY_STATE         tinyint(2) comment '公告状态：-1-未发布（草稿） 1-生效（发布） 0-失效',
   EFF_DATE             timestamp default '0000-00-00 00:00:00' comment '生效时间',
   EXP_DATE             timestamp default '0000-00-00 00:00:00' comment '失效时间',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (NOTIFY_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY comment '记录管理员发布的系统公告、最新动态等信息';

/*==============================================================*/
/* Table: SYS_NOTIFY_ACCEPT                                     */
/*==============================================================*/
create table SYS_NOTIFY_ACCEPT
(
   NOTIFY_ID            int(16) not null auto_increment comment '公告ID',
   NOTIFY_ACCEPT_OP_ID  int(16) not null comment '公告接收人ID',
   READ_STATE           tinyint(2) comment '阅读状态：0-未读 1-已读',
   READ_DATE            timestamp default '0000-00-00 00:00:00' comment '阅读时间',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   primary key (NOTIFY_ID, NOTIFY_ACCEPT_OP_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY_ACCEPT comment '记录公告的接收信息';

/*==============================================================*/
/* Table: SYS_NOTIFY_ATTACH                                     */
/*==============================================================*/
create table SYS_NOTIFY_ATTACH
(
   NOTIFY_ATTACH_ID     int(16) not null auto_increment comment '公告附件ID',
   NOTIFY_ID            int(16) comment '公告ID',
   NOTIFY_ATTACH_TYPE   tinyint(2) comment '公告附件类型：0-公用资料 1-学习资料 2-媒体投放物 3-系统帮助',
   NOTIFY_ATTACH_PATH   varchar(200) comment '公告附件路径（存储路径）',
   NOTIFY_ATTACH_NAME   varchar(200) comment '公告附件文件名（存储文件名）',
   NOTIFY_ATTACH_DISP_NAME varchar(200) comment '公告附件显示文件名',
   NOTIFY_ATTACH_DESC   varchar(800) comment '公告附件说明',
   NOTIFY_ATTACH_STATE  tinyint(2) comment '公告附件状态：1-生效 0-失效',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (NOTIFY_ATTACH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY_ATTACH comment '记录公告附件信息';

/*==============================================================*/
/* Table: SYS_NOTIFY_RANGE                                      */
/*==============================================================*/
create table SYS_NOTIFY_RANGE
(
   NOTIFY_ID            int(16) not null auto_increment comment '公告ID',
   NOTIFY_RANGE_TYPE    tinyint(2) not null comment '公告范围类型：1-组织 2-员工',
   NOTIFY_RANGE_OBJ_ID  int(16) not null comment '公告范围对象ID（按公告范围类型记录组织ID或操作员ID）',
   NOTIFY_ORG_EFF_TYPE  tinyint(2) comment '公告组织作用类型：0-只对应本级组织 1-包含各下级组织',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (NOTIFY_ID, NOTIFY_RANGE_TYPE, NOTIFY_RANGE_OBJ_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY_RANGE comment '记录公告发布的范围信息（能接收公告的组织、员工）';

/*==============================================================*/
/* Table: SYS_OP                                                */
/*==============================================================*/
create table SYS_OP
(
   OP_ID                int(16) not null auto_increment comment '操作员ID',
   OP_NAME              varchar(20) comment '操作员姓名',
   OP_CODE              varchar(30) comment '操作员编码',
   MOBILE_NO            varchar(20) comment '手机号',
   EMAIL_ADRESS         varchar(40) comment '电子邮件地址',
   OP_LEVEL             tinyint(2) comment '操作员级别：1-一级（正主管） 2-二级（副主管）  9-普通员工',
   SUP_OP_ID            int(16) comment '上级操作员ID',
   LOGIN_CODE           varchar(30) comment '登录工号',
   LOGIN_PASSWD         varchar(80) comment '登录密码',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   SHORT_NAME           varchar(200) comment '简称',
   ENGLISH_NAME         varchar(200) comment '英文名',
   CARD_TYPE_ID         tinyint(2) comment '证件类型：1-身份证 2-军官证 3-其他,对应sys_static_data表code_type=40108',
   CARD_NO              varchar(40) comment '证件号码',
   BIRTHDAY             date comment '生日',
   MARRY_STATUS         tinyint(2) comment '婚姻状况：1-未婚 2-已婚,对应sys_static_data表code_type=10101',
   GENDER               tinyint(2) comment '性别：1-男 2-女,对应sys_static_data表code_type=40107',
   RELIGION             tinyint(2) comment '宗教信仰',
   NATIONAL_TYPE        tinyint(2) comment '民族',
   EDUCATION_LEVEL      tinyint(2) comment '学历',
   INCOME_LEVEL         tinyint(2) comment '收入',
   POLITICS_FACE        tinyint(2) comment '政治面貌',
   JOB_POSITION         varchar(40) comment '职位',
   JOB_COMPANY          varchar(400) comment '工作单位',
   JOB_DESC             varchar(400) comment '职责说明',
   OFFICE_TEL           varchar(20) comment '办公电话',
   FAX_ID               varchar(20) comment '传真号',
   HOME_TEL             varchar(20) comment '家庭电话',
   WIRELESS_CALL        varchar(20) comment '无限寻呼',
   ALARM_MOBILE_NO      varchar(20) comment '告警手机号',
   FAMILY_INFO          varchar(200) comment '亲属信息',
   CONTACT_ADDRESS      varchar(80) comment '联系地址',
   POSTAL_CODE          int(6) comment '邮政编码',
   SECURITY_ID          varchar(30) comment '社保卡号',
   CAR_NO               varchar(40) comment '车牌号码',
   CHARACTER_DESC       varchar(200) comment '性格特点',
   NOTES                varchar(800) comment '备注',
   RECENT_PASSWORD      varchar(400) comment '最近使用密码',
   RECENT_PASS_TIMES    tinyint(2) comment '最近使用密码次数',
   MIN_PASSWD_LENGTH    tinyint(2) comment '最小密码长度',
   ALLOW_CHANGE_PASSWD  tinyint(2) comment '是否允许修改密码：1-允许 0-不允许',
   ACCT_EFFECT_DATE     timestamp default '0000-00-00 00:00:00' comment '账号生效日期',
   ACCT_EXPIRE_DATE     timestamp default '0000-00-00 00:00:00' comment '账号失效日期',
   MULTI_LOGIN_FLAG     tinyint(2) comment '多重登录标志：1-允许 0-不允许',
   LAST_LOGIN_LOG_ID    int(16) comment '最后一次登录日志',
   TRY_TIMES            int(6) comment '登录尝试次数',
   LOCK_FLAG            tinyint(2) comment '锁定标志：0-未锁定 1-锁定',
   LOGIN_FLAG           tinyint(2) comment '登录标志：0-未登录 1-已登录',
   SUPER_USER_FLAG      tinyint(2) comment '超级用户标志：0-否 1-是',
   PASSWD_VALID_DAYS    int(10) comment '密码有效期（以天为单位）',
   CANCEL_DAYS          int(6) comment '停止时限（以天为单位）,如果到了密码修改时，登陆用户还未修改密码，则过了“停止时限”后，该工号被强制回收，除非用户又修改了密码，才可以再继续使用。',
   PASSWORD_VALID_DATE  timestamp default '0000-00-00 00:00:00' comment '密码生效时间',
   CHG_PASSWD_ALARM_DAYS tinyint(2) comment '密码过期提前通知',
   SMS_CHK_PASSWD       varchar(20) comment '短信校验密码',
   CHKPW_EFFECT_TIME    timestamp default '0000-00-00 00:00:00' comment '校验密码生效时间',
   CHKPW_EXPIRE_TIME    timestamp default '0000-00-00 00:00:00' comment '校验密码失效时间',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OP_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP comment '记录员工及操作员信息（员工姓名、电话等自然信息及操作员工号、密码等系统信息）';

/*==============================================================*/
/* Table: SYS_OPRT_TYPE                                         */
/*==============================================================*/
create table SYS_OPRT_TYPE
(
   OPRT_TYPE_ID         int(16) not null auto_increment comment '操作类型ID',
   OPRT_TYPE_NAME       varchar(80) comment '操作类型名称',
   OPRT_TYPE_DESC       varchar(400) comment '操作类型描述',
   DOMAIN_ID            int(16) comment '域ID',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OPRT_TYPE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OPRT_TYPE comment '定义系统操作类型，如增加、修改、删除、查询、审批
（静态数据表）';

/*==============================================================*/
/* Table: SYS_OP_AGENT_RLT                                      */
/*==============================================================*/
create table SYS_OP_AGENT_RLT
(
   OP_AGENT_RLT_ID      int(16) not null auto_increment comment '操作员代理关系ID',
   OP_A_ID              int(16) comment 'A操作员ID',
   OP_B_ID              int(16) comment 'B操作员ID',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp comment '修改时间',
   primary key (OP_AGENT_RLT_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_AGENT_RLT comment '记录操作员代理关系信息（代理操作员与被代理操作员对应关系，即AB经理对应关系）';

/*==============================================================*/
/* Table: SYS_OP_DATA_AUTH                                      */
/*==============================================================*/
create table SYS_OP_DATA_AUTH
(
   OP_DATA_AUTH_ID      int(16) not null auto_increment comment '操作员数据权限ID',
   FUNC_ID              int(16) comment '功能ID',
   OP_ID                int(16) comment '操作员ID',
   DATA_AUTH_TYPE_ID    int(16) comment '数据权限类型ID',
   ROLE_ID              int(16) comment '角色ID',
   DATA_AUTH_OBJ_ID     varchar(40) comment '数据权限对象ID（按不同数据权限类型记录相应组织ID、操作员ID、产品ID等）',
   DATA_AUTH_OBJ_NAME   varchar(400) comment '数据权限对象名称',
   OP_DATA_AUTH_TYPE    tinyint(2) comment '操作员数据权限类型：1-员工数据权限（不关联系统功能） 2-员工功能数据权限（关联系统功能）',
   DATA_AUTH_RULE_TYPE  tinyint(2) comment '数据权限规则类型：1-自身数据权限 2-自身及下级数据权限',
   DOMAIN_ID            int(16) comment '域ID',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   EFF_DATE             timestamp default '0000-00-00 00:00:00' comment '生效时间',
   EXP_DATE             timestamp default '0000-00-00 00:00:00' comment '失效时间',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OP_DATA_AUTH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_DATA_AUTH comment '记录操作员自身或对某系统功能的非缺省规则的数据权限';

/*==============================================================*/
/* Table: SYS_OP_JOBFUNC                                        */
/*==============================================================*/
create table SYS_OP_JOBFUNC
(
   OP_JOBFUNC_ID        int(16) not null auto_increment comment '操作员职能ID',
   SUP_OP_JOBFUNC_ID    int(16) comment '操作员职能ID',
   OP_ID                int(16) comment '操作员ID',
   JOBFUNC_ID           int(16) comment '职能ID',
   REAUTH_FLAG          tinyint(2) comment '再授权标志：0-不允许再授权 1-允许再授权
            再授权标志：0-不允许再授权 1-允许再授权',
   AUTH_TYPE            tinyint(2) comment '授权类型：1-管理员授权 2-操作员再授权',
   AUTH_EFF_DATE        timestamp default '0000-00-00 00:00:00' comment '授权生效时间',
   AUTH_EXP_DATE        timestamp default '0000-00-00 00:00:00' comment '授权失效时间',
   DOMAIN_ID            int(16) comment '域ID',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OP_JOBFUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_JOBFUNC comment '记录授权给操作员的职能';

/*==============================================================*/
/* Table: SYS_OP_MAPPING                                        */
/*==============================================================*/
create table SYS_OP_MAPPING
(
   OP_MAPPING_ID        int(16) not null auto_increment comment '操作员映射ID',
   OP_ID                int(16) comment '操作员ID',
   BUSI_SYS             int(6) comment '业务系统：1-CRM 2-BI 3-BOSS ',
   EXT_OP_ID            varchar(30) comment '外系统操作员ID',
   EXT_OP_PASSWD        varchar(80) comment '外系统操作员密码',
   EXT_OP_DFLT_FLAG     tinyint(2) comment '外系统工号缺省标志：0-非缺省 1-缺省',
   EXT_SESSION_TOKEN    varchar(80) comment '外系统交互标记',
   EXT_TOKEN_EFF_TIME   timestamp default '0000-00-00 00:00:00' comment '外系统标记生效时间',
   EXT_TOKEN_EXP_TIME   timestamp default '0000-00-00 00:00:00' comment '外系统标记失效时间',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OP_MAPPING_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_MAPPING comment '记录操作员与外系统操作员映射关系数据';

/*==============================================================*/
/* Table: SYS_OP_ORG_RLT                                        */
/*==============================================================*/
create table SYS_OP_ORG_RLT
(
   OP_ORG_RLT_ID        int(16) not null auto_increment comment '操作员组织关系ID',
   OP_ID                int(16) comment '操作员ID',
   ORG_ID               int(16) comment '组织ID',
   DIRECT_FLAG          tinyint(2) comment '直属标志：1-直属 0-非直属',
   ADMIN_FLAG           tinyint(2) comment '管理员标志：1-是 0-否',
   INTF_OP_TYPE         tinyint(2) comment '接口人类型：0-非接口人 1-默认接口人 2-备份接口人',
   INTF_EFF_DATE        timestamp default '0000-00-00 00:00:00' comment '接口人生效时间',
   INTF_EXP_DATE        timestamp default '0000-00-00 00:00:00' comment '接口人失效时间',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OP_ORG_RLT_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_ORG_RLT comment '记录操作员与组织关系信息';

/*==============================================================*/
/* Table: SYS_OP_ROLE                                           */
/*==============================================================*/
create table SYS_OP_ROLE
(
   OP_ROLE_ID           int(16) not null auto_increment comment '操作员角色类型ID',
   ROLE_ID              int(16) comment '角色ID',
   OP_ID                int(16) comment '操作员ID',
   OP_ROLE_DFLT_FLAG    tinyint(2) comment '操作员角色缺省标志：1-缺省 0-非缺省',
   DOMAIN_ID            int(16) comment '域ID',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (OP_ROLE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_ROLE comment '记录员工具有的角色';

/*==============================================================*/
/* Table: SYS_ORG                                               */
/*==============================================================*/
create table SYS_ORG
(
   ORG_ID               int(16) not null auto_increment comment '组织ID',
   SUP_ORG_ID           int(16) comment '组织ID',
   ORG_TYPE             int(16) comment '组织类型',
   ORG_NAME             varchar(200) comment '组织名称',
   ORG_CODE             varchar(30) comment '组织编码',
   ORG_LEVEL            tinyint(2) comment '组织级别：1-一级 2-二级 3-三级 4-四级 ...',
   ORG_LVL_PATH         varchar(400) comment '组织层级路径（从根组织ID到当前组织ID的上下级层级路径串，用#号分隔）',
   DISTRICT_ID          varchar(40) comment '地区编码',
   SHORT_NAME           varchar(200) comment '简称',
   ENGLISH_NAME         varchar(200) comment '英文名',
   MEMBER_NUM           int(6) comment '人数',
   MANAGER_NAME         varchar(40) comment '负责人名称',
   EMAIL_ADRESS         varchar(40) comment '电子邮件地址',
   PHONE_ID             varchar(20) comment '联系电话',
   FAX_ID               varchar(20) comment '传真号',
   ORG_ADDRESS          varchar(400) comment '组织地址',
   CONTACT_NAME         varchar(40) comment '联系人姓名',
   CONTACT_CARD_TYPE    tinyint(2) comment '联人证类型：1-身份证 2-军官证 3-其他,对应sys_static_data表code_type=40108',
   CONTACT_CARD_ID      varchar(40) comment '联系人证件号码',
   CONTACT_BILL_ID      varchar(20) comment '联系人手机',
   POST_PROVINCE        varchar(40) comment '邮寄省',
   POST_CITY            varchar(40) comment '邮寄地市',
   POST_ADDRESS         varchar(400) comment '通信地址',
   POSTAL_CODE          int(6) comment '邮政编码',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (ORG_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ORG comment '记录组织机构信息';

/*==============================================================*/
/* Table: SYS_ORG_MAPPING                                       */
/*==============================================================*/
create table SYS_ORG_MAPPING
(
   ORG_MAPPING_ID       int(16) not null auto_increment comment '组织映射ID',
   ORG_ID               int(16) comment '组织ID',
   BUSI_SYS             int(6) comment '业务系统：1-CRM 2-BI 3-BOSS ',
   EXT_ORG_ID           varchar(30) comment '外系统组织ID',
   EXT_ORG_LEVEL        tinyint(2) comment '外系统组织级别：1-一级 2-二级 3-三级 4-四级 ...',
   EXT_ORG_LVL_PATH     varchar(200) comment '外系统组织层级路径',
   NOTES                varchar(800) comment '备注',
   STATE                tinyint(2) comment '状态：1-正常 0-停用',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (ORG_MAPPING_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ORG_MAPPING comment '记录组织与外系统组织映射关系';

/*==============================================================*/
/* Table: SYS_ORG_TYPE                                          */
/*==============================================================*/
create table SYS_ORG_TYPE
(
   ORG_TYPE             int(16) not null auto_increment comment '组织类型',
   ORG_TYPE_NAME        varchar(80) comment '组织类型名称',
   ORG_TYPE_DESC        varchar(400) comment '组织类型描述',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (ORG_TYPE)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ORG_TYPE comment '定义组织类型，如行政区域、组织部门
（静态数据表）';

/*==============================================================*/
/* Table: SYS_PARAM                                             */
/*==============================================================*/
create table SYS_PARAM
(
   PARAM_ID             int(16) not null auto_increment comment '参数ID',
   PARAM_CODE           varchar(30) comment '参数编码',
   PARAM_KIND           int(6) comment '参数分类',
   PARAM_NAME           varchar(80) comment '参数名称',
   PARAM_DESC           varchar(2000) comment '参数描述',
   PARAM_VALUE          varchar(800) comment '参数取值',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (PARAM_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_PARAM comment '定义系统级参数取值
（静态数据表）';

/*==============================================================*/
/* Table: SYS_RES                                               */
/*==============================================================*/
create table SYS_RES
(
   RES_ID               int(16) not null auto_increment comment '资源ID',
   RES_NAME             varchar(80) comment '资源名称',
   RES_DESC             varchar(400) comment '资源描述',
   SUP_RES_ID           int(16) comment '上级资源ID',
   DOMAIN_ID            int(16) comment '域ID',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (RES_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_RES comment '定义系统管理的资源，如客户、产品、工单、指标
（静态数据表）';

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE
(
   ROLE_ID              int(16) not null auto_increment comment '角色ID',
   ROLE_NAME            varchar(80) comment '角色名称',
   ROLE_DESC            varchar(400) comment '角色描述',
   SUP_ROLE_ID          int(16) comment '上级角色ID',
   DOMAIN_ID            int(16) comment '域ID',
   DATA_STATE           tinyint(2) default 1 comment '数据状态：1-正常 0-删除',
   CREATOR              int(16) comment '创建人',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '创建时间',
   MODIFIER             int(16) comment '修改人',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '修改时间',
   primary key (ROLE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ROLE comment '记录系统的角色，如客户经理、主管经理、业务支撑人员、产品经理等
（静态数据表）';

alter table SYS_AGENT_AUTH_FUNC add constraint FK_SYS_AGTAUTHF_R_AGTAUTH foreign key (AGENT_AUTH_ID)
      references SYS_AGENT_AUTH (AGENT_AUTH_ID) on delete restrict on update restrict;

alter table SYS_CODE_COL_RLT add constraint FK_SYS_CODCOLRLT_R_CODE foreign key (CODE_ID)
      references SYS_CODE_DEF (CODE_ID) on delete restrict on update restrict;

alter table SYS_CODE_VALUE add constraint FK_SYS_CODVAL_R_CODE foreign key (CODE_ID)
      references SYS_CODE_DEF (CODE_ID) on delete restrict on update restrict;

alter table SYS_DFLT_DATA_AUTH add constraint FK_SYS_DFTATH_R_AUTHTYPE foreign key (DATA_AUTH_TYPE_ID)
      references SYS_DATA_AUTH_TYPE (DATA_AUTH_TYPE_ID) on delete restrict on update restrict;

alter table SYS_DFLT_DATA_AUTH add constraint FK_SYS_DFTATH_R_REC foreign key (RES_ID)
      references SYS_RES (RES_ID) on delete restrict on update restrict;

alter table SYS_DFLT_DATA_AUTH add constraint FK_SYS_DFTATH_R_ROLE foreign key (ROLE_ID)
      references SYS_ROLE (ROLE_ID) on delete restrict on update restrict;

alter table SYS_FUNC add constraint FK_SYS_FUNC_R_OPRTTYPE foreign key (OPRT_TYPE_ID)
      references SYS_OPRT_TYPE (OPRT_TYPE_ID) on delete restrict on update restrict;

alter table SYS_FUNC add constraint FK_SYS_FUNC_R_RES foreign key (RES_ID)
      references SYS_RES (RES_ID) on delete restrict on update restrict;

alter table SYS_FUNC add constraint FK_SYS_FUNC_R_SUP foreign key (SUP_FUNC_ID)
      references SYS_FUNC (FUNC_ID) on delete restrict on update restrict;

alter table SYS_JOBFUNC add constraint FK_SYS_JOBFUNC_R_ROLE foreign key (ROLE_ID)
      references SYS_ROLE (ROLE_ID) on delete restrict on update restrict;

alter table SYS_JOBFUNC_FUNC add constraint FK_SYS_JOBFFC_R_FUNC foreign key (FUNC_ID)
      references SYS_FUNC (FUNC_ID) on delete restrict on update restrict;

alter table SYS_JOBFUNC_FUNC add constraint FK_SYS_JOBFFC_R_JOBFUNC foreign key (JOBFUNC_ID)
      references SYS_JOBFUNC (JOBFUNC_ID) on delete restrict on update restrict;

alter table SYS_NOTIFY_ACCEPT add constraint FK_WD_ACCEPT_RLT_NOTIFY foreign key (NOTIFY_ID)
      references SYS_NOTIFY (NOTIFY_ID) on delete restrict on update restrict;

alter table SYS_NOTIFY_ATTACH add constraint FK_WD_ATTACH_RLT_NOTIFY foreign key (NOTIFY_ID)
      references SYS_NOTIFY (NOTIFY_ID) on delete restrict on update restrict;

alter table SYS_NOTIFY_RANGE add constraint FK_WD_RANGE_RLT_NOTIFY foreign key (NOTIFY_ID)
      references SYS_NOTIFY (NOTIFY_ID) on delete restrict on update restrict;

alter table SYS_OP_DATA_AUTH add constraint FK_SYS_OPDTAUTH_R_AUTHTYPE foreign key (DATA_AUTH_TYPE_ID)
      references SYS_DATA_AUTH_TYPE (DATA_AUTH_TYPE_ID) on delete restrict on update restrict;

alter table SYS_OP_DATA_AUTH add constraint FK_SYS_OPDTAUTH_R_FUNC foreign key (FUNC_ID)
      references SYS_FUNC (FUNC_ID) on delete restrict on update restrict;

alter table SYS_OP_DATA_AUTH add constraint FK_SYS_OPDTAUTH_R_OP foreign key (OP_ID)
      references SYS_OP (OP_ID) on delete restrict on update restrict;

alter table SYS_OP_DATA_AUTH add constraint FK_SYS_OPDTAUTH_R_ROLE foreign key (ROLE_ID)
      references SYS_ROLE (ROLE_ID) on delete restrict on update restrict;

alter table SYS_OP_JOBFUNC add constraint FK_SYS_OPJOBF_R_JOBFUNC foreign key (JOBFUNC_ID)
      references SYS_JOBFUNC (JOBFUNC_ID) on delete restrict on update restrict;

alter table SYS_OP_JOBFUNC add constraint FK_SYS_OPJOBF_R_OP foreign key (OP_ID)
      references SYS_OP (OP_ID) on delete restrict on update restrict;

alter table SYS_OP_JOBFUNC add constraint FK_SYS_OPJOBF_R_SUP foreign key (SUP_OP_JOBFUNC_ID)
      references SYS_OP_JOBFUNC (OP_JOBFUNC_ID) on delete restrict on update restrict;

alter table SYS_OP_MAPPING add constraint FK_SYS_OPMAP_R_OP foreign key (OP_ID)
      references SYS_OP (OP_ID) on delete restrict on update restrict;

alter table SYS_OP_ORG_RLT add constraint FK_SYS_OOR_R_OP foreign key (OP_ID)
      references SYS_OP (OP_ID) on delete restrict on update restrict;

alter table SYS_OP_ORG_RLT add constraint FK_SYS_OOR_R_ORG foreign key (ORG_ID)
      references SYS_ORG (ORG_ID) on delete restrict on update restrict;

alter table SYS_OP_ROLE add constraint FK_SYS_OPROLE_R_OP foreign key (OP_ID)
      references SYS_OP (OP_ID) on delete restrict on update restrict;

alter table SYS_OP_ROLE add constraint FK_SYS_OPROLE_R_ROLE foreign key (ROLE_ID)
      references SYS_ROLE (ROLE_ID) on delete restrict on update restrict;

alter table SYS_ORG add constraint FK_SYS_ORG_R_ORGTYPE foreign key (ORG_TYPE)
      references SYS_ORG_TYPE (ORG_TYPE) on delete restrict on update restrict;

alter table SYS_ORG add constraint FK_SYS_ORG_R_SUP foreign key (SUP_ORG_ID)
      references SYS_ORG (ORG_ID) on delete restrict on update restrict;

alter table SYS_ORG_MAPPING add constraint FK_SYS_ORGMAP_R_ORG foreign key (ORG_ID)
      references SYS_ORG (ORG_ID) on delete restrict on update restrict;

