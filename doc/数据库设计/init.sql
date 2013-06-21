/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     2013-4-16 0:52:26                            */
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
   AGENT_AUTH_ID        int(16) not null auto_increment comment '������ȨID',
   AUTH_OP_ID           int(16) comment '��Ȩ����ԱID',
   AUTHED_OP_ID         int(16) comment '����Ȩ����ԱID��������Ȩ����Ա��',
   AUTH_STATE           tinyint(2) comment '��Ȩ״̬��1-��Ч 0-ʧЧ',
   AUTH_EFF_DATE        timestamp default '0000-00-00 00:00:00' comment '��Ȩ��Чʱ��',
   AUTH_EXP_DATE        timestamp default '0000-00-00 00:00:00' comment '��ȨʧЧʱ��',
   AGENT_AUTH_FUNC_TYPE tinyint(2) comment '������Ȩ�������ͣ�0-ȫ������ 1-ָ�����ܣ��ڴ�����Ȩ���ܱ��¼��',
   NOTES                varchar(800) comment '��ע',
   AUTH_APPR_OP_ID      int(16) comment '��Ȩ������ID',
   AUTH_APPR_TIME       timestamp default '0000-00-00 00:00:00' comment '��Ȩ����ʱ��',
   AUTH_APPR_STATE      tinyint(2) comment '��Ȩ����״̬��1-ͨ�� 2-��ͨ��',
   AUTH_APPR_COMMENT    varchar(800) comment '��Ȩ�������',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (AGENT_AUTH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_AGENT_AUTH comment '��¼�û�������Ȩ��Ϣ';

/*==============================================================*/
/* Table: SYS_AGENT_AUTH_FUNC                                   */
/*==============================================================*/
create table SYS_AGENT_AUTH_FUNC
(
   AGENT_AUTH_FUNC_ID   int(16) not null auto_increment comment '������Ȩ����ID',
   AGENT_AUTH_ID        int(16) not null comment '������ȨID',
   FUNC_ID              int(16) not null comment '����ID',
   NOTES                varchar(800) comment '��ע',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (AGENT_AUTH_FUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_AGENT_AUTH_FUNC comment '��¼������Ȩ��ʹ�õ�ϵͳ���ܣ�ֻ��Ȩָ���˵�����ʱ��¼��';

/*==============================================================*/
/* Table: SYS_AUDIT_LOG                                         */
/*==============================================================*/
create table SYS_AUDIT_LOG
(
   AUDIT_LOG_ID         int(16) not null auto_increment comment 'ϵͳ�����־ID',
   RESOURCE_KIND        int(6) comment '��Դ��𣨶���Ӧ����˵ֵΪ��1����',
   IDR_CREATION_TIME    timestamp default '0000-00-00 00:00:00' comment '��Ϣ����ʱ��',
   IDENTITY_NAME        varchar(80) comment '����ʵ����ƣ����ڲɼ�ҵ���?',
   RESOURCE_CODE        varchar(30) comment '��Դ���루ÿ��Ӧ��ϵͳ��Ӧһ����Դ���룩',
   OPERATE_TIME         timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   OP_TYPE_ID           varchar(30) comment '�������ͱ���(1-CQESOP--10101:ͳһ��ͼ����_��ѯ 1-CQESOP--10102:ͳһ��ͼ����_����EXCEL  ...Notes)',
   OP_TYPE_NAME         varchar(80) comment '����������ƣ���Ӧ�������ͱ���Ĳ�����ƣ�',
   OP_LEVEL_ID          tinyint(2) comment '����������Ƽ���1-һ�� 2-��Ҫ 3-���� 4-���� 5-���أ�',
   OPERATE_RESULT       tinyint(2) comment '�������0-�ɹ� 1-ʧ��',
   OPERATE_CONTENT      varchar(2000) comment '�������ݣ�4Aҵ��ʹ�ã�',
   SERVER_ADDRESS       varchar(20) comment '�����IP��ַ',
   SERVER_MAC           varchar(20) comment '��������mac��ַ',
   SERVER_PORT          varchar(20) comment '�������˶˿�',
   CLIENT_ADDRESS       varchar(20) comment '�ͻ���ͨ��IP��ַ���û���¼��ʹ�õĿͻ���IP��',
   CLIENT_PORT          varchar(20) comment '�ͻ��˶˿�',
   CLIENT_MAC           varchar(20) comment '�ͻ���mac��ַ�������',
   CLIENT_NETWORK_ADDRESS varchar(200) comment '�ͻ���IP��ַ���û��ͻ����϶���IP��',
   CLIENT_CPU_SERIAL    varchar(40) comment '�ͻ���CPU���к�',
   SUB_ACCOUNT_NAME     varchar(30) comment 'Ӧ�ô��˺ţ��û���¼Ӧ��ϵͳʹ�õ��˺ţ�',
   MAIN_ACCOUNT_NAME    varchar(40) comment '���˺����',
   TASK_CODE            varchar(20) comment '�ò�����Ӧ�Ĺ�����',
   MODULE_ID            varchar(20) comment 'ģ��ID',
   MODULE_NAME          varchar(200) comment 'ģ�����',
   SYNC4A_FLAG          tinyint(2) comment 'ͬ��4A��־��0-δͬ�� 1-��ͬ��',
   SYNC4A_TIME          timestamp default '0000-00-00 00:00:00' comment 'ͬ��4Aʱ��',
   BANK_APPROVE         varchar(200) comment '���������ˮ��',
   BANK_PROOF           tinyint(2) comment '���ʽ���ƾ֤��0-������Ҫ���ʽ��ƣ����β���û��ƾ֤ 1-������Ҫ���ʽ��ƣ����β�����ƾ֤ 2-��������Ҫ���ʽ��� Ĭ��ֵ��',
   BANK_FLAG            tinyint(2) comment '�����֤��־�� -1-ֱ�ӹرմ��ڣ�δ�������� 
            0-����ͨ�� 
            1-����ͨ�� 
            2-��ʱ������ҵ�������� 
            3-��ʱ��������ҵ��������
            4-���ִ�����쳣����������쳣��
            5-δ���ò��ԣ�����ҵ��������
            6-δ���ò��ԣ�������������',
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

alter table SYS_AUDIT_LOG comment '��¼�����־��Ϣ';

/*==============================================================*/
/* Table: SYS_CODE_COL_RLT                                      */
/*==============================================================*/
create table SYS_CODE_COL_RLT
(
   CODE_ID              varchar(30) not null comment '�����ʶ',
   CODE_TAB_NAME        varchar(30) not null comment '�����Ӧ����',
   CODE_COL_NAME        varchar(30) not null comment '�����Ӧ�ֶ���',
   NOTES                varchar(800) comment '��ע',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (CODE_ID, CODE_TAB_NAME, CODE_COL_NAME)
)
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_CODE_COL_RLT comment '����ʹ�ô���ı��ֶζ�Ӧ��Ϣ
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_CODE_DEF                                          */
/*==============================================================*/
create table SYS_CODE_DEF
(
   CODE_ID              varchar(30) not null comment '�����ʶ',
   CODE_KIND            int(6) comment '�������',
   CODE_NAME            varchar(80) comment '�������',
   CODE_DESC            varchar(400) comment '��������',
   CODE_DATA_TYPE       tinyint(2) comment '����������ͣ�1-��ֵ 2-�ַ�',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (CODE_ID)
)
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_CODE_DEF comment '����ϵͳʹ�õ�ö��ֵ����
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_CODE_VALUE                                        */
/*==============================================================*/
create table SYS_CODE_VALUE
(
   CODE_ID              varchar(30) not null comment '�����ʶ',
   CODE_VALUE           varchar(40) not null comment '����ȡֵ',
   CODE_VALUE_NAME      varchar(80) comment '����ȡֵ���',
   CODE_VALUE_ALIAS     varchar(80) comment '����ȡֵ����',
   CODE_VALUE_DESC      varchar(400) comment '����ȡֵ����',
   CODE_VALUE_ORDER     int(6) comment '����ȡֵ����',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (CODE_ID, CODE_VALUE)
)
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_CODE_VALUE comment '����ϵͳʹ�õ�ö��ֵ���뺬����Ϣ
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_DATA_AUTH_TYPE                                    */
/*==============================================================*/
create table SYS_DATA_AUTH_TYPE
(
   DATA_AUTH_TYPE_ID    int(16) not null auto_increment comment '���Ȩ������ID',
   DATA_AUTH_TYPE_NAME  varchar(80) comment '���Ȩ���������',
   DATA_AUTH_TYPE_DESC  varchar(400) comment '���Ȩ����������',
   DATA_AUTH_TAB_NAME   varchar(30) comment '���Ȩ�޶�Ӧ����',
   DATA_AUTH_COL_NAME   varchar(30) comment '���Ȩ�޶�Ӧ�ֶ���',
   AUTH_OBJ_SEL_URL     varchar(200) comment 'Ȩ�޶���ѡ��ҳ��URL',
   DOMAIN_ID            int(16) comment '��ID',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (DATA_AUTH_TYPE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_DATA_AUTH_TYPE comment '����������Ȩ�޵Ķ������ͣ�����֯������Ա������Ʒ
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_DFLT_DATA_AUTH                                    */
/*==============================================================*/
create table SYS_DFLT_DATA_AUTH
(
   DFLT_DATA_AUTH_ID    int(16) not null auto_increment comment 'ȱʡ���Ȩ�޹���ID',
   DATA_AUTH_TYPE_ID    int(16) comment '���Ȩ������ID',
   RES_ID               int(16) comment '��ԴID',
   ROLE_ID              int(16) comment '��ɫID',
   DFLT_DATA_AUTH_NAME  varchar(80) comment 'ȱʡ���Ȩ�޹������',
   DFLT_DATA_AUTH_DESC  varchar(400) comment 'ȱʡ���Ȩ�޹�������',
   DATA_AUTH_RULE_TYPE  tinyint(2) comment '���Ȩ�޹������ͣ�1-�������Ȩ�� 2-���?�¼����Ȩ��',
   DOMAIN_ID            int(16) comment '��ID',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (DFLT_DATA_AUTH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_DFLT_DATA_AUTH comment '��¼��ϵͳ��Դʹ�õ����Ȩ�����ͣ�ȱʡ���Ȩ�޹���';

/*==============================================================*/
/* Table: SYS_DOMAIN                                            */
/*==============================================================*/
create table SYS_DOMAIN
(
   DOMAIN_ID            int(16) not null auto_increment comment '��ID',
   DOMAIN_CODE          varchar(40) comment '�����',
   DOMAIN_NAME          varchar(80) comment '�����',
   DOMAIN_DESC          varchar(400) comment '������',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (DOMAIN_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_DOMAIN comment '����Ȩ�������ͬһϵͳ�²�ͬȨ�޷�Χ
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_FUNC                                              */
/*==============================================================*/
create table SYS_FUNC
(
   FUNC_ID              int(16) not null auto_increment comment '����ID',
   SUP_FUNC_ID          int(16) comment '����ID',
   OPRT_TYPE_ID         int(16) comment '��������ID',
   RES_ID               int(16) comment '��ԴID',
   FUNC_TYPE            tinyint(2) comment '�������1-�˵� 2-ҳ�� 3-��ť 4-����̨ 5-���',
   FUNC_LEVEL           tinyint(2) comment '���ܼ���1-һ�� 2-���� 3-�� 4-�ļ� ...',
   FUNC_CODE            varchar(80) comment '���ܱ���',
   FUNC_NAME            varchar(200) comment '�������',
   FUNC_DESC            varchar(400) comment '��������',
   FUNC_ORDER           int(6) comment '��������',
   FUNC_URL             varchar(1000) comment '����URL',
   FUNC_IMG             varchar(1000) comment '����ͼƬ������·�����ļ���',
   FUNC_PARAM           varchar(1000) comment '���ܲ���',
   IF_DISPLAY           tinyint(2) comment '�Ƿ���ʾ��1-��ʾ 2-����ʾ�����������˵���ҳ�棩',
   IF_COMMENT           tinyint(2) comment '�Ƿ�����ۣ�1-������ 0-��������',
   FUNC_HELP_FLAG       tinyint(2) comment '���ܰ����־��1-�а��� 0-�ް���',
   FUNC_HELP_URL        varchar(1000) comment '���ܰ���URL',
   DOMAIN_ID            int(16) comment '��ID',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (FUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_FUNC comment '��¼ϵͳ������Ϣ�������˵���ҳ�桢��ť������̨�����';

/*==============================================================*/
/* Table: SYS_JOBFUNC                                           */
/*==============================================================*/
create table SYS_JOBFUNC
(
   JOBFUNC_ID           int(16) not null auto_increment comment 'ְ��ID',
   ROLE_ID              int(16) comment '��ɫID',
   JOBFUNC_CODE         varchar(40) comment 'ְ�ܱ���',
   JOBFUNC_NAME         varchar(80) comment 'ְ�����',
   JOBFUNC_DESC         varchar(400) comment 'ְ������',
   JOBFUNC_ORDER        int(6) comment 'ְ������',
   DOMAIN_ID            int(16) comment '��ID',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (JOBFUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_JOBFUNC comment '��¼ְ����Ϣ��ְ����һЩϵͳ���ܵļ���';

/*==============================================================*/
/* Table: SYS_JOBFUNC_FUNC                                      */
/*==============================================================*/
create table SYS_JOBFUNC_FUNC
(
   JOBFUNC_FUNC_ID      int(16) not null auto_increment comment 'ְ�ܹ���ID',
   FUNC_ID              int(16) comment '����ID',
   JOBFUNC_ID           int(16) comment 'ְ��ID',
   DOMAIN_ID            int(6) comment '��ID',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (JOBFUNC_FUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_JOBFUNC_FUNC comment '��¼ְ�ܰ��ϵͳ����';

/*==============================================================*/
/* Table: SYS_LOG                                               */
/*==============================================================*/
create table SYS_LOG
(
   LOG_ID               int(16) not null auto_increment comment 'ϵͳ��־ID',
   LOG_TYPE             tinyint(2) comment '��־���ͣ�1-ҵ����־��Ӧ��������¼��ҵ����Ϣ�� 2-������־���Զ���¼�ĵ����־�� 3-ҵ�������־���ϲ�������־���ͣ�',
   OP_TYPE              tinyint(2) comment '�������ͣ�11-��¼ 12-�˳�   21-��ѯ���鿴�� 22-���� 23-�޸� 24-ɾ�� 25-���루�ϴ��� 26-���������أ�27-���� 28-���� 29-�������鿴',
   RSLT_TYPE            tinyint(2) comment '������ͣ�0-�ɹ� 1-ʧ�ܣ�����Ϊ�յȣ� 2-�쳣',
   SRC_TYPE             tinyint(2) comment '��Դ���ͣ�1-��ϵͳ 2-��ϵͳ',
   OP_ID                int(16) comment '����ԱID',
   OP_NAME              varchar(200) comment '����Ա����',
   ORG_ID               int(16) comment '��֯ID',
   ORG_NAME             varchar(200) comment '��֯���',
   AGENT_FLAG           tinyint(2) comment '�����־��1-���� 0-�Ǵ���',
   AGENT_OP_ID          int(16) comment '�������ԱID',
   AGENT_OP_NAME        varchar(200) comment '�������Ա����',
   OPRT_START_TIME      timestamp default '0000-00-00 00:00:00' comment '������ʼʱ��',
   OPRT_END_TIME        timestamp default '0000-00-00 00:00:00' comment '��������ʱ��',
   OPRT_INTERVAL        int(16) comment '����ʱ�����룩',
   OPRT_NAME            varchar(200) comment '�������',
   OPRT_DESC            varchar(2000) comment '����˵��',
   OPRT_URL             varchar(400) comment '����URL',
   OPRT_PARAM           varchar(400) comment '��������',
   OPRT_CONTENT         varchar(2000) comment '�������ݣ������޸�ɾ�����������ֵ�������ؼ��ֵȣ�',
   SERVER_ADDRESS       varchar(20) comment '�����IP��ַ',
   IP_ADDRESS           varchar(30) comment 'IP��ַ',
   SESSION_ID           varchar(200) comment '�ỰID',
   CONNECT_TYPE         tinyint(2) comment '���뷽ʽ��1-WEB���� 2-�ֻ����',
   MOBILE_NO            varchar(20) comment '�ֻ��',
   FUNC_ID              int(16) comment '����ID',
   FUNC_NAME            varchar(200) comment '�������',
   FUNC_TYPE            tinyint(2) comment '�������1-�˵� 2-ҳ�� 3-��ť 4-����̨ 5-���',
   OP_OBJ_TYPE          int(6) comment '�����������ͣ�������ҵ��������ͣ�1-���� 2-���� 3-�ĵ� 4-ָ�� 5-֪ʶ�� 6-����ʵ�� 7-���󸽼� ��',
   OP_OBJ_ID            int(200) comment '��������ID������ID������ID������ʵ��ID��ָ��ID�ȡ����󸽼�ID��',
   OP_OBJ_NAME          varchar(200) comment '����������ƣ�������ơ�������ơ�����ʵ����ơ�ָ����ơ����󸽼��ĵ���ƣ�',
   OP_ENT_NAME          varchar(200) comment '����ʵ����ƣ�����ʵ�����ƣ�',
   OP_ENT_SQL           varchar(2000) comment '����ʵ��SQL��䣨����SQL��䣩',
   OP_ENT_CLAUSE        varchar(800) comment '����ʵ�������Ӿ䣨ȷ����ݼ�¼�ı�ʶ������',
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

alter table SYS_LOG comment '��¼��¼��������ϵͳ��־��Ϣ���������־��';

/*==============================================================*/
/* Table: SYS_LOG_HIS                                           */
/*==============================================================*/
create table SYS_LOG_HIS
(
   LOG_ID               int(16) not null auto_increment comment 'ϵͳ��־ID',
   LOG_TYPE             tinyint(2) comment '��־���ͣ�1-ҵ����־��Ӧ��������¼��ҵ����Ϣ�� 2-������־���Զ���¼�ĵ����־�� 3-ҵ�������־���ϲ�������־���ͣ�',
   OP_TYPE              tinyint(2) comment '�������ͣ�11-��¼ 12-�˳�   21-��ѯ���鿴�� 22-���� 23-�޸� 24-ɾ�� 25-���루�ϴ��� 26-���������أ�27-���� 28-���� 29-�������鿴',
   RSLT_TYPE            tinyint(2) comment '������ͣ�0-�ɹ� 1-ʧ�ܣ�����Ϊ�յȣ� 2-�쳣',
   SRC_TYPE             tinyint(2) comment '��Դ���ͣ�1-��ϵͳ 2-��ϵͳ',
   OP_ID                int(16) comment '����ԱID',
   OP_NAME              varchar(200) comment '����Ա����',
   ORG_ID               int(16) comment '��֯ID',
   ORG_NAME             varchar(200) comment '��֯���',
   AGENT_FLAG           tinyint(2) comment '�����־��1-���� 0-�Ǵ���',
   AGENT_OP_ID          int(16) comment '�������ԱID',
   AGENT_OP_NAME        varchar(200) comment '�������Ա����',
   OPRT_START_TIME      timestamp default '0000-00-00 00:00:00' comment '������ʼʱ��',
   OPRT_END_TIME        timestamp default '0000-00-00 00:00:00' comment '��������ʱ��',
   OPRT_INTERVAL        int(16) comment '����ʱ�����룩',
   OPRT_NAME            varchar(200) comment '�������',
   OPRT_DESC            varchar(2000) comment '����˵��',
   OPRT_URL             varchar(400) comment '����URL',
   OPRT_PARAM           varchar(400) comment '��������',
   OPRT_CONTENT         varchar(2000) comment '�������ݣ������޸�ɾ�����������ֵ�������ؼ��ֵȣ�',
   SERVER_ADDRESS       varchar(20) comment '�����IP��ַ',
   IP_ADDRESS           varchar(30) comment 'IP��ַ',
   SESSION_ID           varchar(200) comment '�ỰID',
   CONNECT_TYPE         tinyint(2) comment '���뷽ʽ��1-WEB���� 2-�ֻ����',
   MOBILE_NO            varchar(20) comment '�ֻ��',
   FUNC_ID              int(16) comment '����ID',
   FUNC_NAME            varchar(200) comment '�������',
   FUNC_TYPE            tinyint(2) comment '�������1-�˵� 2-ҳ�� 3-��ť 4-����̨ 5-���',
   OP_OBJ_TYPE          int(6) comment '�����������ͣ�������ҵ��������ͣ�1-���� 2-���� 3-�ĵ� 4-ָ�� 5-֪ʶ�� 6-����ʵ�� 7-���󸽼� ��',
   OP_OBJ_ID            int(200) comment '��������ID������ID������ID������ʵ��ID��ָ��ID�ȡ����󸽼�ID��',
   OP_OBJ_NAME          varchar(200) comment '����������ƣ�������ơ�������ơ�����ʵ����ơ�ָ����ơ����󸽼��ĵ���ƣ�',
   OP_ENT_NAME          varchar(200) comment '����ʵ����ƣ�����ʵ�����ƣ�',
   OP_ENT_SQL           varchar(2000) comment '����ʵ��SQL��䣨����SQL��䣩',
   OP_ENT_CLAUSE        varchar(800) comment '����ʵ�������Ӿ䣨ȷ����ݼ�¼�ı�ʶ������',
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

alter table SYS_LOG_HIS comment '��¼ϵͳ��־����ʷ�����Ϣ���ѹ��ڵ���־��ݴ�ϵͳ��־��ת�Ƶ��˱?';

/*==============================================================*/
/* Table: SYS_NOTIFY                                            */
/*==============================================================*/
create table SYS_NOTIFY
(
   NOTIFY_ID            int(16) not null auto_increment comment '����ID',
   NOTIFY_TITLE         varchar(200) comment '�������',
   NOTIFY_CONTENT       varchar(2000) comment '��������',
   NOTIFY_OBJ           varchar(200) comment '��������繫���������С����ţ�',
   NOTIFY_TYPE          tinyint(2) comment '�������ͣ�1-����֪ͨ�� 2-���������� 3-���¶�̬�� 4-֪ʶ�⹫��',
   NOTIFY_DTL_TYPE      int(6) comment '������ϸ����',
   NOTIFY_RANGE         tinyint(2) comment '���淶Χ��0-ȫ�� 1-ָ����Χ',
   NOTIFY_STATE         tinyint(2) comment '����״̬��-1-δ�������ݸ壩 1-��Ч�������� 0-ʧЧ',
   EFF_DATE             timestamp default '0000-00-00 00:00:00' comment '��Чʱ��',
   EXP_DATE             timestamp default '0000-00-00 00:00:00' comment 'ʧЧʱ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (NOTIFY_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY comment '��¼����Ա������ϵͳ���桢���¶�̬����Ϣ';

/*==============================================================*/
/* Table: SYS_NOTIFY_ACCEPT                                     */
/*==============================================================*/
create table SYS_NOTIFY_ACCEPT
(
   NOTIFY_ID            int(16) not null auto_increment comment '����ID',
   NOTIFY_ACCEPT_OP_ID  int(16) not null comment '���������ID',
   READ_STATE           tinyint(2) comment '�Ķ�״̬��0-δ�� 1-�Ѷ�',
   READ_DATE            timestamp default '0000-00-00 00:00:00' comment '�Ķ�ʱ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   primary key (NOTIFY_ID, NOTIFY_ACCEPT_OP_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY_ACCEPT comment '��¼����Ľ�����Ϣ';

/*==============================================================*/
/* Table: SYS_NOTIFY_ATTACH                                     */
/*==============================================================*/
create table SYS_NOTIFY_ATTACH
(
   NOTIFY_ATTACH_ID     int(16) not null auto_increment comment '���渽��ID',
   NOTIFY_ID            int(16) comment '����ID',
   NOTIFY_ATTACH_TYPE   tinyint(2) comment '���渽�����ͣ�0-�������� 1-ѧϰ���� 2-ý��Ͷ���� 3-ϵͳ����',
   NOTIFY_ATTACH_PATH   varchar(200) comment '���渽��·�����洢·����',
   NOTIFY_ATTACH_NAME   varchar(200) comment '���渽���ļ���洢�ļ���',
   NOTIFY_ATTACH_DISP_NAME varchar(200) comment '���渽����ʾ�ļ���',
   NOTIFY_ATTACH_DESC   varchar(800) comment '���渽��˵��',
   NOTIFY_ATTACH_STATE  tinyint(2) comment '���渽��״̬��1-��Ч 0-ʧЧ',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (NOTIFY_ATTACH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY_ATTACH comment '��¼���渽����Ϣ';

/*==============================================================*/
/* Table: SYS_NOTIFY_RANGE                                      */
/*==============================================================*/
create table SYS_NOTIFY_RANGE
(
   NOTIFY_ID            int(16) not null auto_increment comment '����ID',
   NOTIFY_RANGE_TYPE    tinyint(2) not null comment '���淶Χ���ͣ�1-��֯ 2-Ա��',
   NOTIFY_RANGE_OBJ_ID  int(16) not null comment '���淶Χ����ID�������淶Χ���ͼ�¼��֯ID�����ԱID��',
   NOTIFY_ORG_EFF_TYPE  tinyint(2) comment '������֯�������ͣ�0-ֻ��Ӧ������֯ 1-����¼���֯',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (NOTIFY_ID, NOTIFY_RANGE_TYPE, NOTIFY_RANGE_OBJ_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_NOTIFY_RANGE comment '��¼���淢���ķ�Χ��Ϣ���ܽ��չ������֯��Ա����';

/*==============================================================*/
/* Table: SYS_OP                                                */
/*==============================================================*/
create table SYS_OP
(
   OP_ID                int(16) not null auto_increment comment '����ԱID',
   OP_NAME              varchar(20) comment '����Ա����',
   OP_CODE              varchar(30) comment '����Ա����',
   MOBILE_NO            varchar(20) comment '�ֻ��',
   EMAIL_ADRESS         varchar(40) comment '�����ʼ���ַ',
   OP_LEVEL             tinyint(2) comment '����Ա����1-һ���������ܣ� 2-�����������ܣ�  9-��ͨԱ��',
   SUP_OP_ID            int(16) comment '�ϼ�����ԱID',
   LOGIN_CODE           varchar(30) comment '��¼����',
   LOGIN_PASSWD         varchar(80) comment '��¼����',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   SHORT_NAME           varchar(200) comment '���',
   ENGLISH_NAME         varchar(200) comment 'Ӣ����',
   CARD_TYPE_ID         tinyint(2) comment '֤�����ͣ�1-���֤ 2-���֤ 3-����,��Ӧsys_static_data��code_type=40108',
   CARD_NO              varchar(40) comment '֤������',
   BIRTHDAY             date comment '����',
   MARRY_STATUS         tinyint(2) comment '����״����1-δ�� 2-�ѻ�,��Ӧsys_static_data��code_type=10101',
   GENDER               tinyint(2) comment '�Ա�1-�� 2-Ů,��Ӧsys_static_data��code_type=40107',
   RELIGION             tinyint(2) comment '�ڽ�����',
   NATIONAL_TYPE        tinyint(2) comment '����',
   EDUCATION_LEVEL      tinyint(2) comment 'ѧ��',
   INCOME_LEVEL         tinyint(2) comment '����',
   POLITICS_FACE        tinyint(2) comment '������ò',
   JOB_POSITION         varchar(40) comment 'ְλ',
   JOB_COMPANY          varchar(400) comment '������λ',
   JOB_DESC             varchar(400) comment 'ְ��˵��',
   OFFICE_TEL           varchar(20) comment '�칫�绰',
   FAX_ID               varchar(20) comment '�����',
   HOME_TEL             varchar(20) comment '��ͥ�绰',
   WIRELESS_CALL        varchar(20) comment '����Ѱ��',
   ALARM_MOBILE_NO      varchar(20) comment '�澯�ֻ��',
   FAMILY_INFO          varchar(200) comment '������Ϣ',
   CONTACT_ADDRESS      varchar(80) comment '��ϵ��ַ',
   POSTAL_CODE          int(6) comment '��������',
   SECURITY_ID          varchar(30) comment '�籣����',
   CAR_NO               varchar(40) comment '���ƺ���',
   CHARACTER_DESC       varchar(200) comment '�Ը��ص�',
   NOTES                varchar(800) comment '��ע',
   RECENT_PASSWORD      varchar(400) comment '���ʹ������',
   RECENT_PASS_TIMES    tinyint(2) comment '���ʹ���������',
   MIN_PASSWD_LENGTH    tinyint(2) comment '��С���볤��',
   ALLOW_CHANGE_PASSWD  tinyint(2) comment '�Ƿ������޸����룺1-���� 0-������',
   ACCT_EFFECT_DATE     timestamp default '0000-00-00 00:00:00' comment '�˺���Ч����',
   ACCT_EXPIRE_DATE     timestamp default '0000-00-00 00:00:00' comment '�˺�ʧЧ����',
   MULTI_LOGIN_FLAG     tinyint(2) comment '���ص�¼��־��1-���� 0-������',
   LAST_LOGIN_LOG_ID    int(16) comment '���һ�ε�¼��־',
   TRY_TIMES            int(6) comment '��¼���Դ���',
   LOCK_FLAG            tinyint(2) comment '���־��0-δ�� 1-��',
   LOGIN_FLAG           tinyint(2) comment '��¼��־��0-δ��¼ 1-�ѵ�¼',
   SUPER_USER_FLAG      tinyint(2) comment '�����û���־��0-�� 1-��',
   PASSWD_VALID_DAYS    int(10) comment '������Ч�ڣ�����Ϊ��λ��',
   CANCEL_DAYS          int(6) comment 'ֹͣʱ�ޣ�����Ϊ��λ��,����������޸�ʱ����½�û���δ�޸����룬����ˡ�ֹͣʱ�ޡ��󣬸ù��ű�ǿ�ƻ��գ�����û����޸������룬�ſ����ټ���ʹ�á�',
   PASSWORD_VALID_DATE  timestamp default '0000-00-00 00:00:00' comment '������Чʱ��',
   CHG_PASSWD_ALARM_DAYS tinyint(2) comment '���������ǰ֪ͨ',
   SMS_CHK_PASSWD       varchar(20) comment '����У������',
   CHKPW_EFFECT_TIME    timestamp default '0000-00-00 00:00:00' comment 'У��������Чʱ��',
   CHKPW_EXPIRE_TIME    timestamp default '0000-00-00 00:00:00' comment 'У������ʧЧʱ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP comment '��¼Ա��������Ա��Ϣ��Ա������绰����Ȼ��Ϣ������Ա���š������ϵͳ��Ϣ��';

/*==============================================================*/
/* Table: SYS_OPRT_TYPE                                         */
/*==============================================================*/
create table SYS_OPRT_TYPE
(
   OPRT_TYPE_ID         int(16) not null auto_increment comment '��������ID',
   OPRT_TYPE_NAME       varchar(80) comment '�����������',
   OPRT_TYPE_DESC       varchar(400) comment '������������',
   DOMAIN_ID            int(16) comment '��ID',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OPRT_TYPE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OPRT_TYPE comment '����ϵͳ�������ͣ������ӡ��޸ġ�ɾ���ѯ������
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_OP_AGENT_RLT                                      */
/*==============================================================*/
create table SYS_OP_AGENT_RLT
(
   OP_AGENT_RLT_ID      int(16) not null auto_increment comment '����Ա�����ϵID',
   OP_A_ID              int(16) comment 'A����ԱID',
   OP_B_ID              int(16) comment 'B����ԱID',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_AGENT_RLT_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_AGENT_RLT comment '��¼����Ա�����ϵ��Ϣ���������Ա�뱻�������Ա��Ӧ��ϵ����AB�����Ӧ��ϵ��';

/*==============================================================*/
/* Table: SYS_OP_DATA_AUTH                                      */
/*==============================================================*/
create table SYS_OP_DATA_AUTH
(
   OP_DATA_AUTH_ID      int(16) not null auto_increment comment '����Ա���Ȩ��ID',
   FUNC_ID              int(16) comment '����ID',
   OP_ID                int(16) comment '����ԱID',
   DATA_AUTH_TYPE_ID    int(16) comment '���Ȩ������ID',
   ROLE_ID              int(16) comment '��ɫID',
   DATA_AUTH_OBJ_ID     varchar(40) comment '���Ȩ�޶���ID������ͬ���Ȩ�����ͼ�¼��Ӧ��֯ID������ԱID����ƷID�ȣ�',
   DATA_AUTH_OBJ_NAME   varchar(400) comment '���Ȩ�޶������',
   OP_DATA_AUTH_TYPE    tinyint(2) comment '����Ա���Ȩ�����ͣ�1-Ա�����Ȩ�ޣ�������ϵͳ���ܣ� 2-Ա���������Ȩ�ޣ�����ϵͳ���ܣ�',
   DATA_AUTH_RULE_TYPE  tinyint(2) comment '���Ȩ�޹������ͣ�1-�������Ȩ�� 2-���?�¼����Ȩ��',
   DOMAIN_ID            int(16) comment '��ID',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   EFF_DATE             timestamp default '0000-00-00 00:00:00' comment '��Чʱ��',
   EXP_DATE             timestamp default '0000-00-00 00:00:00' comment 'ʧЧʱ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_DATA_AUTH_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_DATA_AUTH comment '��¼����Ա������ĳϵͳ���ܵķ�ȱʡ��������Ȩ��';

/*==============================================================*/
/* Table: SYS_OP_JOBFUNC                                        */
/*==============================================================*/
create table SYS_OP_JOBFUNC
(
   OP_JOBFUNC_ID        int(16) not null auto_increment comment '����Աְ��ID',
   SUP_OP_JOBFUNC_ID    int(16) comment '����Աְ��ID',
   OP_ID                int(16) comment '����ԱID',
   JOBFUNC_ID           int(16) comment 'ְ��ID',
   REAUTH_FLAG          tinyint(2) comment '����Ȩ��־��0-����������Ȩ 1-��������Ȩ
            ����Ȩ��־��0-����������Ȩ 1-��������Ȩ',
   AUTH_TYPE            tinyint(2) comment '��Ȩ���ͣ�1-����Ա��Ȩ 2-����Ա����Ȩ',
   AUTH_EFF_DATE        timestamp default '0000-00-00 00:00:00' comment '��Ȩ��Чʱ��',
   AUTH_EXP_DATE        timestamp default '0000-00-00 00:00:00' comment '��ȨʧЧʱ��',
   DOMAIN_ID            int(16) comment '��ID',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_JOBFUNC_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_JOBFUNC comment '��¼��Ȩ�����Ա��ְ��';

/*==============================================================*/
/* Table: SYS_OP_MAPPING                                        */
/*==============================================================*/
create table SYS_OP_MAPPING
(
   OP_MAPPING_ID        int(16) not null auto_increment comment '����Աӳ��ID',
   OP_ID                int(16) comment '����ԱID',
   BUSI_SYS             int(6) comment 'ҵ��ϵͳ��1-CRM 2-BI 3-BOSS ',
   EXT_OP_ID            varchar(30) comment '��ϵͳ����ԱID',
   EXT_OP_PASSWD        varchar(80) comment '��ϵͳ����Ա����',
   EXT_OP_DFLT_FLAG     tinyint(2) comment '��ϵͳ����ȱʡ��־��0-��ȱʡ 1-ȱʡ',
   EXT_SESSION_TOKEN    varchar(80) comment '��ϵͳ�������',
   EXT_TOKEN_EFF_TIME   timestamp default '0000-00-00 00:00:00' comment '��ϵͳ�����Чʱ��',
   EXT_TOKEN_EXP_TIME   timestamp default '0000-00-00 00:00:00' comment '��ϵͳ���ʧЧʱ��',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_MAPPING_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_MAPPING comment '��¼����Ա����ϵͳ����Աӳ���ϵ���';

/*==============================================================*/
/* Table: SYS_OP_ORG_RLT                                        */
/*==============================================================*/
create table SYS_OP_ORG_RLT
(
   OP_ORG_RLT_ID        int(16) not null auto_increment comment '����Ա��֯��ϵID',
   OP_ID                int(16) comment '����ԱID',
   ORG_ID               int(16) comment '��֯ID',
   DIRECT_FLAG          tinyint(2) comment 'ֱ����־��1-ֱ�� 0-��ֱ��',
   ADMIN_FLAG           tinyint(2) comment '����Ա��־��1-�� 0-��',
   INTF_OP_TYPE         tinyint(2) comment '�ӿ������ͣ�0-�ǽӿ��� 1-Ĭ�Ͻӿ��� 2-���ݽӿ���',
   INTF_EFF_DATE        timestamp default '0000-00-00 00:00:00' comment '�ӿ�����Чʱ��',
   INTF_EXP_DATE        timestamp default '0000-00-00 00:00:00' comment '�ӿ���ʧЧʱ��',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_ORG_RLT_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_ORG_RLT comment '��¼����Ա����֯��ϵ��Ϣ';

/*==============================================================*/
/* Table: SYS_OP_ROLE                                           */
/*==============================================================*/
create table SYS_OP_ROLE
(
   OP_ROLE_ID           int(16) not null auto_increment comment '����Ա��ɫ����ID',
   ROLE_ID              int(16) comment '��ɫID',
   OP_ID                int(16) comment '����ԱID',
   OP_ROLE_DFLT_FLAG    tinyint(2) comment '����Ա��ɫȱʡ��־��1-ȱʡ 0-��ȱʡ',
   DOMAIN_ID            int(16) comment '��ID',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (OP_ROLE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_OP_ROLE comment '��¼Ա�����еĽ�ɫ';

/*==============================================================*/
/* Table: SYS_ORG                                               */
/*==============================================================*/
create table SYS_ORG
(
   ORG_ID               int(16) not null auto_increment comment '��֯ID',
   SUP_ORG_ID           int(16) comment '��֯ID',
   ORG_TYPE             int(16) comment '��֯����',
   ORG_NAME             varchar(200) comment '��֯���',
   ORG_CODE             varchar(30) comment '��֯����',
   ORG_LEVEL            tinyint(2) comment '��֯����1-һ�� 2-���� 3-�� 4-�ļ� ...',
   ORG_LVL_PATH         varchar(400) comment '��֯�㼶·�����Ӹ���֯ID����ǰ��֯ID�����¼��㼶·��������#�ŷָ���',
   DISTRICT_ID          varchar(40) comment '�������',
   SHORT_NAME           varchar(200) comment '���',
   ENGLISH_NAME         varchar(200) comment 'Ӣ����',
   MEMBER_NUM           int(6) comment '����',
   MANAGER_NAME         varchar(40) comment '���������',
   EMAIL_ADRESS         varchar(40) comment '�����ʼ���ַ',
   PHONE_ID             varchar(20) comment '��ϵ�绰',
   FAX_ID               varchar(20) comment '�����',
   ORG_ADDRESS          varchar(400) comment '��֯��ַ',
   CONTACT_NAME         varchar(40) comment '��ϵ������',
   CONTACT_CARD_TYPE    tinyint(2) comment '����֤���ͣ�1-���֤ 2-���֤ 3-����,��Ӧsys_static_data��code_type=40108',
   CONTACT_CARD_ID      varchar(40) comment '��ϵ��֤������',
   CONTACT_BILL_ID      varchar(20) comment '��ϵ���ֻ�',
   POST_PROVINCE        varchar(40) comment '�ʼ�ʡ',
   POST_CITY            varchar(40) comment '�ʼĵ���',
   POST_ADDRESS         varchar(400) comment 'ͨ�ŵ�ַ',
   POSTAL_CODE          int(6) comment '��������',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (ORG_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ORG comment '��¼��֯����Ϣ';

/*==============================================================*/
/* Table: SYS_ORG_MAPPING                                       */
/*==============================================================*/
create table SYS_ORG_MAPPING
(
   ORG_MAPPING_ID       int(16) not null auto_increment comment '��֯ӳ��ID',
   ORG_ID               int(16) comment '��֯ID',
   BUSI_SYS             int(6) comment 'ҵ��ϵͳ��1-CRM 2-BI 3-BOSS ',
   EXT_ORG_ID           varchar(30) comment '��ϵͳ��֯ID',
   EXT_ORG_LEVEL        tinyint(2) comment '��ϵͳ��֯����1-һ�� 2-���� 3-�� 4-�ļ� ...',
   EXT_ORG_LVL_PATH     varchar(200) comment '��ϵͳ��֯�㼶·��',
   NOTES                varchar(800) comment '��ע',
   STATE                tinyint(2) comment '״̬��1-�� 0-ͣ��',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (ORG_MAPPING_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ORG_MAPPING comment '��¼��֯����ϵͳ��֯ӳ���ϵ';

/*==============================================================*/
/* Table: SYS_ORG_TYPE                                          */
/*==============================================================*/
create table SYS_ORG_TYPE
(
   ORG_TYPE             int(16) not null auto_increment comment '��֯����',
   ORG_TYPE_NAME        varchar(80) comment '��֯�������',
   ORG_TYPE_DESC        varchar(400) comment '��֯��������',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (ORG_TYPE)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ORG_TYPE comment '������֯���ͣ�������������֯����
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_PARAM                                             */
/*==============================================================*/
create table SYS_PARAM
(
   PARAM_ID             int(16) not null auto_increment comment '����ID',
   PARAM_CODE           varchar(30) comment '�������',
   PARAM_KIND           int(6) comment '�������',
   PARAM_NAME           varchar(80) comment '�������',
   PARAM_DESC           varchar(2000) comment '��������',
   PARAM_VALUE          varchar(800) comment '����ȡֵ',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (PARAM_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_PARAM comment '����ϵͳ������ȡֵ
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_RES                                               */
/*==============================================================*/
create table SYS_RES
(
   RES_ID               int(16) not null auto_increment comment '��ԴID',
   RES_NAME             varchar(80) comment '��Դ���',
   RES_DESC             varchar(400) comment '��Դ����',
   SUP_RES_ID           int(16) comment '�ϼ���ԴID',
   DOMAIN_ID            int(16) comment '��ID',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (RES_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_RES comment '����ϵͳ�������Դ����ͻ�����Ʒ��������ָ��
����̬��ݱ?';

/*==============================================================*/
/* Table: SYS_ROLE                                              */
/*==============================================================*/
create table SYS_ROLE
(
   ROLE_ID              int(16) not null auto_increment comment '��ɫID',
   ROLE_NAME            varchar(80) comment '��ɫ���',
   ROLE_DESC            varchar(400) comment '��ɫ����',
   SUP_ROLE_ID          int(16) comment '�ϼ���ɫID',
   DOMAIN_ID            int(16) comment '��ID',
   DATA_STATE           tinyint(2) default 1 comment '���״̬��1-�� 0-ɾ��',
   CREATOR              int(16) comment '������',
   CREATE_DATE          timestamp default '0000-00-00 00:00:00' comment '����ʱ��',
   MODIFIER             int(16) comment '�޸���',
   MODIFY_DATE          timestamp default '0000-00-00 00:00:00' comment '�޸�ʱ��',
   primary key (ROLE_ID)
)
auto_increment = 10000
checksum = 1
charset = utf8
collate = utf8_general_ci
engine = InnoDB
delay_key_write = 1
row_format = dynamic;

alter table SYS_ROLE comment '��¼ϵͳ�Ľ�ɫ����ͻ����?���ܾ��?ҵ��֧����Ա����Ʒ�����
����̬��ݱ?';

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

