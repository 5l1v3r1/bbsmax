--���ļ��� 2.3 �汾�� 3.0.0.0730 �������ű�(sql server ��)
--���룺 utf-8


---------------------������ idmax ��������ű�(���������������)

IF OBJECT_ID ( 'Max_ChangePasswordLogs', 'U' ) IS NOT NULL
DROP TABLE [Max_ChangePasswordLogs]

GO

IF OBJECT_ID ( 'Max_ErrorPasswordLogs', 'U' ) IS NOT NULL
DROP TABLE [Max_ErrorPasswordLogs]

GO

IF OBJECT_ID ( 'Max_LinkedApplications', 'U' ) IS NOT NULL
DROP TABLE [Max_LinkedApplications]

GO

IF OBJECT_ID ( 'System_Max_Faqs', 'U' ) IS NOT NULL
DROP TABLE [System_Max_Faqs]

GO

IF OBJECT_ID ( 'System_Max_FaqCatalogs', 'U' ) IS NOT NULL
DROP TABLE [System_Max_FaqCatalogs]

GO

IF OBJECT_ID ( 'System_Max_Jobs', 'U' ) IS NOT NULL
DROP TABLE [System_Max_Jobs]

GO

IF OBJECT_ID ( 'System_Max_Urls', 'U' ) IS NOT NULL
DROP TABLE [System_Max_Urls]

GO

IF OBJECT_ID ( 'Max_UserSignInLogs', 'U' ) IS NOT NULL
DROP TABLE [Max_UserSignInLogs]

GO

IF OBJECT_ID ( 'Max_SignInLog', 'U' ) IS NOT NULL
DROP TABLE [Max_SignInLog]

GO

IF OBJECT_ID ( 'Max_FaqCatalogs', 'U' ) IS NULL
CREATE TABLE [Max_FaqCatalogs](
	[FaqCatalogID] [int] IDENTITY(1,1) NOT NULL,
	[FaqCatalogName] [nvarchar](50) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_System_Max_FaqCatalogs] PRIMARY KEY CLUSTERED 
(
	[FaqCatalogID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_FaqCatalogs') AND [name]='IX_System_Max_FaqCatalogs')
CREATE UNIQUE NONCLUSTERED INDEX [IX_System_Max_FaqCatalogs] ON [Max_FaqCatalogs] 
(
	[SortOrder] ASC
) ON [PRIMARY]

GO

IF OBJECT_ID ( 'Max_Faqs', 'U' ) IS NULL
CREATE TABLE [Max_Faqs](
	[FaqID] [int] IDENTITY(1,1) NOT NULL,
	[FaqCatalogID] [int] NOT NULL,
	[FaqTitle] [nvarchar](500) COLLATE Chinese_PRC_CI_AS NOT NULL,
	[FaqContent] [ntext] COLLATE Chinese_PRC_CI_AS NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_System_Max_Faqs] PRIMARY KEY CLUSTERED 
(
	[FaqID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_Faqs') AND [name]='IX_System_Max_Faqs')
CREATE UNIQUE NONCLUSTERED INDEX [IX_System_Max_Faqs] ON [Max_Faqs]
(
	[FaqCatalogID] ASC,
	[SortOrder] ASC
) ON [PRIMARY]

GO

IF OBJECT_ID ( 'Max_Jobs', 'U' ) IS NULL
CREATE TABLE [Max_Jobs](
	[JobID] [int] IDENTITY(1,1) NOT NULL,
	[AssemblyName] [nvarchar](128) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[TypeName] [nvarchar](128) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[ExecuteTimeString] [varchar](400) COLLATE Chinese_PRC_CI_AS NOT NULL CONSTRAINT [DF_Max_Jobs_ExecuteTimeString]  DEFAULT (''),
	[TimeType] [tinyint] NOT NULL,
	[IsEnabled] [bit] NOT NULL,
	[LastExecuteTime] [datetime] NOT NULL CONSTRAINT [DF_Max_Jobs_LastExecuteTime]  DEFAULT ('1753-01-01 00:00:00'),
	[IsSystem] [bit] NOT NULL,
 CONSTRAINT [PK_System_Max_Jobs] PRIMARY KEY CLUSTERED
(
	[JobID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

IF OBJECT_ID ( 'Max_Urls', 'U' ) IS NULL
CREATE TABLE [Max_Urls](
	[UrlID] [int] IDENTITY(1,1) NOT NULL,
	[Url] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[FriendlyUrl] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[DefaultValues] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NOT NULL CONSTRAINT [DF_Max_Urls_DefaultValues]  DEFAULT (''),
	[FriendlyUrlOnly] [bit] NOT NULL CONSTRAINT [DF_Max_Urls_FriendlyUrlOnly]  DEFAULT ((0))
) ON [PRIMARY]

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_Max_ActivationSerials_Serial')
ALTER TABLE [Max_ActivationSerials] ADD CONSTRAINT [DF_Max_ActivationSerials_Serial] DEFAULT (newid()) FOR [Serial]

GO

IF EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_ValidateCodes') AND [name] ='CodeLanguage')
ALTER TABLE [Max_ValidateCodes] DROP COLUMN [CodeLanguage]

GO

IF EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_ValidateCodes') AND [name] ='CodeContent')
ALTER TABLE [Max_ValidateCodes] DROP COLUMN [CodeContent]

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_UserProfiles') AND [name] ='ShortSignature')
ALTER TABLE [Max_UserProfiles] ADD [ShortSignature] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NOT NULL CONSTRAINT [DF_Max_UserProfiles_ShortSignature] DEFAULT ('')

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_UserProfiles') AND [name] ='Invisible')
ALTER TABLE [Max_UserProfiles] ADD [Invisible] [bit] NOT NULL CONSTRAINT [DF_Max_UserProfiles_Invisible] DEFAULT ((0))

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_ValidateCodes') AND [name] ='AssemblyName')
ALTER TABLE [Max_ValidateCodes] ADD [AssemblyName] [nvarchar](64) COLLATE Chinese_PRC_CI_AS_WS NOT NULL CONSTRAINT [DF_Max_ValidateCodes_AssemblyName] DEFAULT ('')

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_ValidateCodes') AND [name] ='ClassName')
ALTER TABLE [Max_ValidateCodes] ADD [ClassName] [nvarchar](64) COLLATE Chinese_PRC_CI_AS_WS NOT NULL CONSTRAINT [DF_Max_ValidateCodes_ClassName] DEFAULT ('')

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_bbsMax_ThreadManageLogs_Reason')
ALTER TABLE [bbsMax_ThreadManageLogs] ADD CONSTRAINT [DF_bbsMax_ThreadManageLogs_Reason] DEFAULT ('') FOR [REASON]

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_Max_ValidateCodes_CodeName')
ALTER TABLE [Max_ValidateCodes] ADD  CONSTRAINT [DF_Max_ValidateCodes_CodeName]  DEFAULT ('') FOR [CodeName]

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_Max_ValidateCodes_Copyright')
ALTER TABLE [Max_ValidateCodes] ADD  CONSTRAINT [DF_Max_ValidateCodes_Copyright]  DEFAULT ('') FOR [Copyright]

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_Max_SystemMessages')
ALTER TABLE [Max_SystemMessages] ADD  CONSTRAINT [PK_Max_SystemMessages] PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
) ON [PRIMARY]

GO


---------------------������ bbsmax ��������ű�
IF NOT OBJECT_ID('System_bbsMax_Advertisements', 'U') IS NULL
DROP TABLE [System_bbsMax_Advertisements]

GO

IF NOT OBJECT_ID('System_bbsMax_AdvertisementCatalogs', 'U') IS NULL
DROP TABLE [System_bbsMax_AdvertisementCatalogs]

GO

IF NOT OBJECT_ID('System_bbsMax_Faqs', 'U') IS NULL
DROP TABLE [System_bbsMax_Faqs]

GO

IF NOT OBJECT_ID('System_bbsMax_FaqCatalogs', 'U') IS NULL
DROP TABLE [System_bbsMax_FaqCatalogs]

GO

IF NOT OBJECT_ID('System_bbsMax_Jobs', 'U') IS NULL
DROP TABLE [System_bbsMax_Jobs]

GO

IF NOT OBJECT_ID('System_bbsMax_Urls', 'U') IS NULL
DROP TABLE [System_bbsMax_Urls]

GO
IF OBJECT_ID('bbsMax_Judgements', 'U') IS NULL
CREATE TABLE [bbsMax_Judgements](
	[JudgementID] [int] IDENTITY(1,1) NOT NULL,
	[JudgementDescription] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NULL CONSTRAINT [DF__bbsMax_Ju__Judge__1ED998B2]  DEFAULT (''),
	[JudgementLogoUrl] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NULL CONSTRAINT [DF__bbsMax_Ju__Judge__1FCDBCEB]  DEFAULT (''),
 CONSTRAINT [PK_bbsMax_Judgements] PRIMARY KEY CLUSTERED 
(
	[JudgementID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

IF OBJECT_ID('bbsMax_Polemizes', 'U') IS NULL
CREATE TABLE [bbsMax_Polemizes](
	[ThreadID] [int] NOT NULL,
	[AgreeViewPoint] [ntext] COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[AgreeCount] [int] NOT NULL CONSTRAINT [DF_bbsMax_Polemizes_AgreeCount]  DEFAULT ((0)),
	[AgainstViewPoint] [ntext] COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[AgainstCount] [int] NOT NULL CONSTRAINT [DF_bbsMax_Polemizes_AgainstCount]  DEFAULT ((0)),
	[NeutralCount] [int] NOT NULL CONSTRAINT [DF_bbsMax_Polemizes_NeutralCount]  DEFAULT ((0)),
	[ExpiresDate] [datetime] NOT NULL CONSTRAINT [DF_bbsMax_Polemizes_ExpiresDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_Polemizes] PRIMARY KEY CLUSTERED 
(
	[ThreadID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

IF OBJECT_ID('bbsMax_PolemizeUsers', 'U') IS NULL
CREATE TABLE [bbsMax_PolemizeUsers](
	[ThreadID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[ViewPointType] [tinyint] NOT NULL,
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_bbsMax_PolemizeUsers_CreateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_bbsMax_PolemizeUsers] PRIMARY KEY CLUSTERED 
(
	[ThreadID] ASC,
	[UserID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

IF OBJECT_ID('bbsMax_QuestionUsers', 'U') IS NULL
CREATE TABLE [bbsMax_QuestionUsers](
	[ThreadID] [int] NOT NULL,
	[UserID] [int] NOT NULL,
	[BestPostIsUseful] [bit] NOT NULL CONSTRAINT [DF_bbsMax_QuestionUsers_IsUseful]  DEFAULT ((0)),
 CONSTRAINT [PK_bbsMax_QuestionUsers] PRIMARY KEY CLUSTERED 
(
	[ThreadID] ASC,
	[UserID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('System_bbsMax_PermissionSchemes') AND [name] ='ParentID')
ALTER TABLE [System_bbsMax_PermissionSchemes] ADD [ParentID] [int] NOT NULL CONSTRAINT [DF_System_bbsMax_PermissionSchemes_ParentID]  DEFAULT ((0))

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_Posts') AND [name] ='ParentID')
ALTER TABLE [bbsMax_Posts] ADD [ParentID] [int] NULL

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_Questions') AND [name] ='BestPostID')
ALTER TABLE [bbsMax_Questions] ADD [BestPostID] [int] NOT NULL CONSTRAINT [DF_bbsMax_Questions_BestPostID]  DEFAULT ((0))

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_Questions') AND [name] ='UsefulCount')
ALTER TABLE [bbsMax_Questions] ADD [UsefulCount] [int] NOT NULL CONSTRAINT [DF_bbsMax_Questions_UsefulCount]  DEFAULT ((0))

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_Questions') AND [name] ='UnusefulCount')
ALTER TABLE [bbsMax_Questions] ADD [UnusefulCount] [int] NOT NULL CONSTRAINT [DF_bbsMax_Questions_UnusefulCount]  DEFAULT ((0))

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_ShieldUserLogs') AND [name] ='Reason')
ALTER TABLE [bbsMax_ShieldUserLogs] ADD [Reason] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NOT NULL CONSTRAINT [DF_bbsMax_ShieldUserLogs_Reason]  DEFAULT ('')

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_ThreadManageLogs') AND [name] ='ThreadSubject')
ALTER TABLE [bbsMax_ThreadManageLogs] ADD [ThreadSubject] [nvarchar](256) COLLATE Chinese_PRC_CI_AS_WS NOT NULL CONSTRAINT [DF_bbsMax_ThreadManageLogs_ThreadSubject]  DEFAULT ('')

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_Threads') AND [name] ='UpdateSortOrder')
ALTER TABLE [bbsMax_Threads] ADD [UpdateSortOrder] [bit] NOT NULL CONSTRAINT [DF_bbsMax_Threads_UpdateSortOrder]  DEFAULT ((1))

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_Threads') AND [name] ='JudgementID')
ALTER TABLE [bbsMax_Threads] ADD [JudgementID] [int] NULL CONSTRAINT [DF_bbsMax_Threads_JudgementID]  DEFAULT ((0))

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_bbsMax_Polemizes_bbsMax_Threads')
ALTER TABLE [bbsMax_Polemizes]  WITH CHECK ADD  CONSTRAINT [FK_bbsMax_Polemizes_bbsMax_Threads] FOREIGN KEY([ThreadID])
REFERENCES [bbsMax_Threads] ([ThreadID])

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_bbsMax_PolemizeUsers_bbsMax_Threads')
ALTER TABLE [bbsMax_PolemizeUsers]  WITH CHECK ADD  CONSTRAINT [FK_bbsMax_PolemizeUsers_bbsMax_Threads] FOREIGN KEY([ThreadID])
REFERENCES [bbsMax_Threads] ([ThreadID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_bbsMax_QuestionUsers_bbsMax_Questions')
ALTER TABLE [bbsMax_QuestionUsers]  WITH CHECK ADD  CONSTRAINT [FK_bbsMax_QuestionUsers_bbsMax_Questions] FOREIGN KEY([ThreadID])
REFERENCES [bbsMax_Questions] ([ThreadID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO




---------------------������ idMax ���ݿ�Ĭ�����ݵ������ű�

/****** ����:  Table [Max_FaqCatalogs] ******/
DELETE FROM [Max_FaqCatalogs];
SET IDENTITY_INSERT [Max_FaqCatalogs] ON
INSERT [Max_FaqCatalogs] ([FaqCatalogID], [FaqCatalogName], [SortOrder]) VALUES (1, N'��������', 0)
INSERT [Max_FaqCatalogs] ([FaqCatalogID], [FaqCatalogName], [SortOrder]) VALUES (2, N'���ù���', 1)
INSERT [Max_FaqCatalogs] ([FaqCatalogID], [FaqCatalogName], [SortOrder]) VALUES (3, N'�������� ', 2)
SET IDENTITY_INSERT [Max_FaqCatalogs] OFF

/****** ����:  Table [Max_Faqs] ******/
DELETE FROM [Max_Faqs];
SET IDENTITY_INSERT [Max_Faqs] ON
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (1, 1, N'ע�ᡢ��½', N'ע�᷽�����������û��ע�ᣬ�����ο�״̬�����̳�ģ���ͷ�����������Կ���������δ����¼ &nbsp;ע�ᡱ�������������ע�ᡱ����д��Ӧ����Ϣ���Ϳ������ע���ˡ�<BR>��վ�����õĲ�ͬ���ο͵������ʹ����̳��Ȩ�޻��ܵ��ܶ����ƣ������ϲ�������̳������������ע�ᡣ<BR>��½������������Ѿ�ע���˸���̳����������վ��ҳͷ���ĵ�½ģ����е�½��Ҳ������ҳ��ͷ���������������½���������½ҳ����е�½���������οͷ��ʵ�ҳ�棬Ҳ���е�½��ʾҳ����֡�', 0)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (2, 1, N'��������', N'������������룬���ڵ�½ҳ�������һ����롱 �������û�����ϵͳ���Զ��������뵽������Ч�����С�', 1)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (3, 1, N'��Ӻͱ༭��������', N'������롰�û����ġ��µġ����������޸ġ����Ϳ��Զ��Լ���������Ϣ�����޸��ˡ�', 2)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (4, 1, N'ѡ����', N'������롰�û����ġ��µġ�ѡ�����á����ڸ���Ŀ���С�ѡ���񡱵�ѡ��������б���ѡ��ϲ���ķ�񣬵�����ύ����ť���Ϳ�����', 3)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (5, 1, N'�����ʼ�', N'������롰�û����ġ��µġ�ѡ�����á����ҵ����Ƿ�����ʼ�����ѡ�񡰽����ʼ�����������ύ����', 4)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (6, 2, N'�ղع���', N'�������Ķ�ҳ�棬���Կ�������ӡ |&nbsp; �ղ����� ����������ղ����⡱�󣬿����ڡ��û����ġ��µġ��ղؼС��￴���ղص����⣬ͬʱ���Զ��ղص�������з������', 0)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (7, 2, N'����Ϣ����', N'����ͨ�����ҵĶ��š����ж��ŷ��͡�', 1)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (8, 3, N'��������', N'�������б�ҳ��������Ķ�ҳ�棬���Կ�����������ͼ�꣬������ɽ�������������ҳ�棬���û�з���Ȩ�ޣ�������ʾ��û��Ȩ��!�����֡�<BR>����ò���������ȫ�ķ������ܣ�Ҳ�����������б�ҳ��ײ��Ŀ��ٷ���ģ����з���������', 0)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (9, 3, N'����ظ�', N'�������Ķ�ҳ�������ظ�����ť����ظ�ҳ��ظ���������Ҳ������ҳ���·��Ŀ��ٷ��������лظ���', 1)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (10, 3, N'���ù���', N'����Ҫ���õ�����¥���ϵ�����ã��������õ�ǰ¥�����ݣ�Ҳ������Wind Code����������ã�����Ҫ���õ����ݷ���[quote] ��Ҫ���õ�����[/quote]�м伴�ɡ�', 2)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (11, 3, N'�����ϴ�', N'�ڷ���ҳ���µĸ����ϴ�����������ť���ϴ���Ч��׺���͵ĸ�����ͬʱ������������Ը����������������������ظ�������Ҫ������ֵ��', 3)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (12, 3, N'�ҵ�����', N'�ڡ��û����ġ��ġ��ҵ����⡱�£����Բ鿴�ҵ����⣬�ҵĻظ����ҵľ������ҵ�ͶƱ���ҵĽ��׵�', 4)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (13, 2, N'��������', N'����������ġ����������ӽ�������ҳ�棬������ҳ���£�����ͨ���ؼ��ʻ��û������������⡢�ظ��Լ��������������������򼶱�ͬ�͸���̳���ò�ͬ������Ȩ�޿��ܻ��ܵ����ơ�', 2)
INSERT [Max_Faqs] ([FaqID], [FaqCatalogID], [FaqTitle], [FaqContent], [SortOrder]) VALUES (14, 2, N'Rss����', N'�����ṩ�˼������õ�Rss���ġ���ҳ�ġ�����ͼ�ꡱ������ҳ���µġ�����ͼ�ꡱ�Ͱ��ҳ���µġ�����ͼ�ꡱ��', 3)
SET IDENTITY_INSERT [Max_Faqs] OFF

/****** ����:  Table [Max_Jobs] ******/
DELETE FROM [Max_Jobs];
SET IDENTITY_INSERT [Max_Jobs] ON
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (1, N'zzbird.Common', N'zzbird.Common.Emails.SendEmailJob', convert(text, N'3' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (2, N'zzbird.Common', N'zzbird.Common.Emails.CheckEmailJob', convert(text, N'15' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (4, N'zzbird.Common', N'zzbird.Common.Disk.DeleteFileJob', convert(text, N'5' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (5, N'zzbird.Common', N'zzbird.Common.Disk.DeleteTempJob', convert(text, N'300' collate Chinese_PRC_CI_AS), 0, 1, CAST(0x000099610100CE30 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (6, N'zzbird.Common', N'zzbird.Common.Jobs.ClearExpiresDataJob', convert(text, N'3,0,0' collate Chinese_PRC_CI_AS), 2, 1, CAST(0x00009AE800AF6996 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (7, N'zzbird.Common', N'zzbird.Common.Users.DeleteIsNotActiveUser', convert(text, N'3600' collate Chinese_PRC_CI_AS), 0, 1, CAST(0x0000996B012282B4 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (8, N'zzbird.Common', N'zzbird.Common.Update.AutoUpdateFileJob', convert(text, N'0,1,0|4,0,0' collate Chinese_PRC_CI_AS), 6, 1, CAST(0x00009AE800AF69AD AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (9, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.CheckExpiresPollAndQuestionJob', convert(text, N'300' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (10, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.SaveOnlineUserJob', convert(text, N'60' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (11, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.UpdateForumDataJob', convert(text, N'10800' collate Chinese_PRC_CI_AS), 0, 1, CAST(0x000099CC00A22E5C AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (12, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.UpdateThreadViewsJob', convert(text, N'10' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (13, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.GetKeywordsFromServerJob', convert(text, N'0,1,0|4,0,0' collate Chinese_PRC_CI_AS), 6, 1, CAST(0x00009AE800AF6B9B AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (14, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.ResetTodayPostsJob', convert(text, N'0,0,1' collate Chinese_PRC_CI_AS), 2, 1, CAST(0x00009AE800AF6A89 AS DateTime), 0)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (15, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.BaiduPageOpJop', convert(text, N'3600' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (16, N'zzbird.bbsMax.Core', N'zzbird.bbsMax.ClearExpiresData', convert(text, N'3600' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
SET IDENTITY_INSERT [Max_Jobs] OFF

/****** ����:  Table [Max_Urls] ******/
DELETE FROM [Max_Urls];
SET IDENTITY_INSERT [Max_Urls] ON
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (1, N'ShowForum.aspx?codename={a}&ThreadCatalogID={0}&page={1}', N'{a}/catalog-{0}-{1}.aspx', N'page=1', 0)
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (2, N'Post.aspx?codename={a}', N'{a}/Post.aspx', N'', 0)
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (3, N'ShowThread.aspx?codename={a}&ThreadID={0}&page={1}&listpage={2}', N'{a}/thread-{0}-{1}-{2}.aspx', N'page=1&listpage=1', 0)
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (4, N'ShowForum.aspx?codename={a}&action={b}&page={0}', N'{a}/{b}-{0}.aspx', N'action=list&page=1', 0)
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (5, N'Archiver_Default.aspx', N'Archiver/Default.aspx', N'', 0)
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (6, N'Archiver_ShowForum.aspx?codename={a}&page={0}', N'Archiver/{a}/list-{0}.aspx', N'page=1', 0)
INSERT [Max_Urls] ([UrlID], [Url], [FriendlyUrl], [DefaultValues], [FriendlyUrlOnly]) VALUES (7, N'Archiver_ShowThread.aspx?codename={a}&ThreadID={0}&page={1}', N'Archiver/{a}/thread-{0}-{1}.aspx', N'page=1', 0)
SET IDENTITY_INSERT [Max_Urls] OFF


/****** ����:  Table [System_Max_PermissionSchemes]    �ű�����: 07/29/2008 22:17:45 ******/
DELETE FROM [System_Max_PermissionSchemes];
SET IDENTITY_INSERT [System_Max_PermissionSchemes] ON
INSERT [System_Max_PermissionSchemes] ([SchemeID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (2, convert(text, N'zzbird.Common.Permissions.CommonPermission' collate Chinese_PRC_CI_AS), N'Default User permission scheme', N'Default User permission scheme', CAST(0x000098B9002DC44C AS DateTime))
INSERT [System_Max_PermissionSchemes] ([SchemeID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (1, convert(text, N'zzbird.Common.Permissions.ManagePermission' collate Chinese_PRC_CI_AS), N'idMax Mangement Scheme', N'idMax Mangement Scheme', CAST(0x0000994B00E96286 AS DateTime))
SET IDENTITY_INSERT [System_Max_PermissionSchemes] OFF

/****** ����:  Table [System_Max_Permissions]    �ű�����: 07/29/2008 22:17:45 ******/
DELETE FROM [System_Max_Permissions];
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 1, N'AllowManageSettings:1;AllowManageSetting:1;AllowManageAnnouncements:1;AllowManageLinks:1;AllowManageIPs:1;AllowManageKeywords:1;AllowManageAjaxSetting:1;AllowManageOnlineUserList:1;AllowManageValidateCodes:1;AllowManageUrls:1;AllowManageThemes:1;AllowManageLanguages:1;AllowManageFaqs:1;AllowManageJobs:1;AllowManageSuperVariables:1;AllowManageSendSystemMessages:1;AllowManageSendEmails:1;AllowManageForums:1;AllowManageThreadCatalog:1;AllowManageShieldedUsers:1;AllowManageThreadJudgement:1;AllowManagePostIndexAlias:1;AllowManagePosts:1;AllowManageUpdateForumsData:1;AllowManageCommonPermissions:1;AllowManageCommonPermissions_Roles:7;AllowManageForumPermissionSchemes:1;AllowManageForumPermissionSchemes_Roles:7;AllowManageManagePermissions:1;AllowManageUsers:1;AllowUpdateUserCurrencies:1;AllowManageRoles:1;AllowManageRoles_Roles:7;AllowManageExtendedUserProfileFields:1;AllowManageMedals:1;AllowManageInviteRegisters:1;AllowManageDisk:1;AllowManageDefaultEmoticons:1;AllowManageMessages:1;AllowManageFavorites:1;AllowManageContacts:1;AllowManagePointSetting:1;AllowManagePointLevels:1;AllowManagePointSchemes:1;AllowManagePointSchemes_Roles:7;AllowManageUpdateUserPoints:1;AllowManageLogsForShow:1;AllowManageLogForShow:1;AllowViewStats:1;AllowManageStats:1;AllowManageLogsForDelete:1;AllowManageLogForDelete:1;AllowManageAdvertisements:1;AllowSignIn:1;AllowManageCurrencyFields:1;AllowManageUserEmoticons:1;AllowManageBackRestoreDataBase:1;AllowManageUpdate:1;AllowManageModerators:1|11111111111111111111111111000000110000001111100000011111111111100000011111111111111')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 2, N'AllowManageSettings:1;AllowManageSetting:1;AllowManageAnnouncements:1;AllowManageLinks:1;AllowManageIPs:1;AllowManageKeywords:1;AllowManageAjaxSetting:1;AllowManageOnlineUserList:1;AllowManageValidateCodes:1;AllowManageUrls:1;AllowManageThemes:1;AllowManageLanguages:1;AllowManageFaqs:1;AllowManageJobs:1;AllowManageSuperVariables:1;AllowManageSendSystemMessages:1;AllowManageSendEmails:1;AllowManageForums:1;AllowManageThreadCatalog:1;AllowManageShieldedUsers:1;AllowManageThreadJudgement:1;AllowManagePostIndexAlias:1;AllowManagePosts:1;AllowManageUpdateForumsData:1;AllowManageCommonPermissions:1;AllowManageCommonPermissions_Roles:16;AllowManageForumPermissionSchemes:1;AllowManageForumPermissionSchemes_Roles:16;AllowManageManagePermissions:1;AllowManageUsers:1;AllowUpdateUserCurrencies:1;AllowManageRoles:1;AllowManageRoles_Roles:16;AllowManageExtendedUserProfileFields:1;AllowManageMedals:1;AllowManageInviteRegisters:1;AllowManageDisk:1;AllowManageDefaultEmoticons:1;AllowManageMessages:1;AllowManageFavorites:1;AllowManageContacts:1;AllowManagePointSetting:1;AllowManagePointLevels:1;AllowManagePointSchemes:1;AllowManagePointSchemes_Roles:16;AllowManageUpdateUserPoints:1;AllowManageLogsForShow:1;AllowManageLogForShow:1;AllowViewStats:1;AllowManageStats:1;AllowManageLogsForDelete:1;AllowManageLogForDelete:1;AllowManageAdvertisements:1;AllowSignIn:1;AllowManageCurrencyFields:1;AllowManageUserEmoticons:1;AllowManageBackRestoreDataBase:1;AllowManageUpdate:1;AllowManageModerators:1|1111111110111111111111111-1,0,3,4,5,6,7,81-1,0,3,4,5,6,7,80111-1,0,3,4,5,6,7,811111111111-1,0,3,4,5,6,7,811111001111001')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, -1, N'SignIn:1;SignInFailedCountInOneDay:3;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:3;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:6;MaxAvatarWidth:3;MaxAvatarHeight:3;SignatureMaxLength:3;SignatureMaxHeight:3;SignatureFormat:8;SendMessage:1;MessageCount:3;MessageSubjectLengthLimit:4;MessageContentLengthLimit:6;MessageFormat:8;AllowContact:1;ContactCount:4;AllowEmoticon:1;EmoticonCount:3;EmoticonFileSize:8;SingleEmoticonFileSize:6;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:7;MaxUploadEmoticonsOneTime:2;AllowDisk:1;DiskSize:9;SingleFileSize:7;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:1;MaxUploadFilesOneTime:2;AllowFavorite:1;FavoriteLinkCount:4|199919991011101111536001201203001200110000011002~802~400001100000110001300209715202048001152428801011048576003145728111*1011000')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 0, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:0;MaxAvatarWidth:0;MaxAvatarHeight:0;SignatureMaxLength:0;SignatureMaxHeight:0;SignatureFormat:8;SendMessage:1;MessageCount:0;MessageSubjectLengthLimit:4;MessageContentLengthLimit:6;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:0;SingleEmoticonFileSize:0;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:0;MaxUploadEmoticonsOneTime:0;AllowDisk:1;DiskSize:0;SingleFileSize:0;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|000000100000010000002~802~400000100000000000000')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 1, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:8;MaxAvatarWidth:3;MaxAvatarHeight:3;SignatureMaxLength:5;SignatureMaxHeight:7;SignatureFormat:8;SendMessage:1;MessageCount:5;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:10;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:9;SingleEmoticonFileSize:7;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:8;MaxUploadEmoticonsOneTime:6;AllowDisk:1;DiskSize:11;SingleFileSize:10;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:9;AllowFavorite:1;FavoriteLinkCount:0|0011004100010485760150150100001000000111111110100000~00~0111111110100000000005242880002097152002097152050000001073741824010485760001111000000000')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 2, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:6;MaxAvatarWidth:3;MaxAvatarHeight:3;SignatureMaxLength:4;SignatureMaxHeight:3;SignatureFormat:8;SendMessage:1;MessageCount:4;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:10;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:9;SingleEmoticonFileSize:7;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:8;MaxUploadEmoticonsOneTime:4;AllowDisk:1;DiskSize:11;SingleFileSize:8;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|00100041000819200140140100030011111111010000~00~011111111010000000000314572800209715200209715201000010737418240524288001110')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 3, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:6;MaxAvatarWidth:3;MaxAvatarHeight:3;SignatureMaxLength:3;SignatureMaxHeight:3;SignatureFormat:8;SendMessage:1;MessageCount:3;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:9;SingleEmoticonFileSize:7;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:8;MaxUploadEmoticonsOneTime:3;AllowDisk:1;DiskSize:10;SingleFileSize:8;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|000000410003072001301305001500111100003000~00~001111111001048576001048576002097152050001073741824314572801110')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 4, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:6;MaxAvatarWidth:3;MaxAvatarHeight:3;SignatureMaxLength:3;SignatureMaxHeight:3;SignatureFormat:8;SendMessage:1;MessageCount:3;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:8;SingleEmoticonFileSize:6;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:8;MaxUploadEmoticonsOneTime:3;AllowDisk:1;DiskSize:9;SingleFileSize:8;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|000000310003072001301305001500111000002000~00~001110000008388608051200000104857603000524288000209715200000')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 5, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:1;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:9;MaxAvatarWidth:3;MaxAvatarHeight:3;SignatureMaxLength:3;SignatureMaxHeight:3;SignatureFormat:8;SendMessage:1;MessageCount:3;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:8;SingleEmoticonFileSize:0;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:8;MaxUploadEmoticonsOneTime:3;AllowDisk:1;DiskSize:9;SingleFileSize:8;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|000000200003145728001301305001500111000002000~00~001110000005242880000104857601000314572800104857600000')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 6, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:0;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:0;MaxAvatarWidth:0;MaxAvatarHeight:0;SignatureMaxLength:0;SignatureMaxHeight:0;SignatureFormat:8;SendMessage:1;MessageCount:3;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:8;SingleEmoticonFileSize:0;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:8;MaxUploadEmoticonsOneTime:0;AllowDisk:1;DiskSize:9;SingleFileSize:0;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|00000000000010000002000~00~0011100000052428800001048576003145728000000')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 7, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:0;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:0;MaxAvatarWidth:0;MaxAvatarHeight:0;SignatureMaxLength:0;SignatureMaxHeight:0;SignatureFormat:8;SendMessage:1;MessageCount:0;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:0;SingleEmoticonFileSize:0;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:0;MaxUploadEmoticonsOneTime:0;AllowDisk:1;DiskSize:0;SingleFileSize:0;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|00002222220010000000~00~000100000220020002')
INSERT [System_Max_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 8, N'SignIn:1;SignInFailedCountInOneDay:0;PasswordRecovery:1;PasswordRecoveryFailedCountInOneDay:0;ChangePassword:1;ChangeNickName:1;AllowShowUserList:1;AllowShowUserProfile:1;AllowShowIpFields:0;AllowShowUserSourceTrack:1;SelectAvatar:1;RemoteAvatar:1;UploadAvatar:1;MaxAvatarLength:0;MaxAvatarWidth:0;MaxAvatarHeight:0;SignatureMaxLength:0;SignatureMaxHeight:0;SignatureFormat:8;SendMessage:1;MessageCount:0;MessageSubjectLengthLimit:3;MessageContentLengthLimit:3;MessageFormat:8;AllowContact:1;ContactCount:0;AllowEmoticon:1;EmoticonCount:0;EmoticonFileSize:0;SingleEmoticonFileSize:0;AllowImportEmoticons:1;AllowExportEmoticons:1;EmoticonEipCfcSize:0;MaxUploadEmoticonsOneTime:0;AllowDisk:1;DiskSize:0;SingleFileSize:0;AllowZip:1;AllowUnzip:1;AllowUnrar:1;AllowFileExtensions:0;MaxUploadFilesOneTime:0;AllowFavorite:1;FavoriteLinkCount:0|22222222220010000020~00~000100000222220002')

/****** ����:  Table [Max_ValidateCodes]    �ű�����: 07/29/2008 22:17:45 ******/
DELETE FROM [Max_ValidateCodes];
SET IDENTITY_INSERT [Max_ValidateCodes] ON
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (43, N'��������(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style1', N'maxlab', 4)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (44, N'������(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style2', N'maxlab', 1)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (45, N'��������(Ť��)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style3', N'maxlab', 6)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (46, N'GIF��������', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style4', N'maxlab', 9)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (47, N'GIF��˸����(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style5', N'maxlab', 7)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (52, N'������(Ť��)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style6', N'maxlab', 3)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (53, N'������ת(��)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style7', N'maxlab', 12)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (54, N'����(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style8', N'maxlab', 10)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (55, N'2�꼶����(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style9', N'maxlab', 13)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (56, N'������(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style10', N'maxlab', 2)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (57, N'��������(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style11', N'maxlab', 5)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (58, N'GIF��˸����(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style12', N'maxlab', 8)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (59, N'����(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style13', N'maxlab', 11)
INSERT [Max_ValidateCodes] ([CodeID], [CodeName], [AssemblyName], [ClassName], [Copyright], [SortOrder]) VALUES (60, N'2�꼶����(��ɫ)', N'zzbird.Common', N'zzbird.Common.ValidateCodes.Style14', N'maxlab', 14)
SET IDENTITY_INSERT [Max_ValidateCodes] OFF

/****** ����:  Table [Max_DefaultEmoticons]    �ű�����: 07/29/2008 22:17:45 ******/
DELETE FROM [Max_DefaultEmoticons] WHERE [EmoticonID]<=135 OR ([EmoticonID]>=1420 AND [EmoticonID]<=1524);

IF EXISTS(SELECT * FROM [Max_DefaultEmoticons] WHERE [SortOrder]<=135)
BEGIN
	UPDATE [Max_DefaultEmoticons] SET [SortOrder]=[SortOrder]+135
END

SET IDENTITY_INSERT [Max_DefaultEmoticons] ON
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (1, N'', N'0.gif', 1)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (2, N'', N'1.gif', 2)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (3, N'', N'2.gif', 3)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (4, N'', N'3.gif', 4)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (5, N'', N'4.gif', 5)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (6, N'', N'5.gif', 6)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (7, N'', N'6.gif', 7)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (8, N'', N'7.gif', 8)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (9, N'', N'8.gif', 9)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (10, N'', N'9.gif', 10)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (11, N'', N'10.gif', 11)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (12, N'', N'11.gif', 12)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (13, N'', N'12.gif', 13)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (14, N'', N'13.gif', 14)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (15, N'', N'14.gif', 15)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (16, N'', N'15.gif', 16)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (17, N'', N'16.gif', 17)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (18, N'', N'17.gif', 18)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (19, N'', N'18.gif', 19)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (20, N'', N'19.gif', 20)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (21, N'', N'20.gif', 21)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (22, N'', N'21.gif', 22)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (23, N'', N'22.gif', 23)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (24, N'', N'23.gif', 24)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (25, N'', N'24.gif', 25)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (26, N'', N'25.gif', 26)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (27, N'', N'26.gif', 27)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (28, N'', N'27.gif', 28)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (29, N'', N'28.gif', 29)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (30, N'', N'29.gif', 30)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (31, N'', N'30.gif', 31)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (32, N'', N'31.gif', 32)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (33, N'', N'32.gif', 33)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (34, N'', N'33.gif', 34)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (35, N'', N'34.gif', 35)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (36, N'', N'35.gif', 36)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (37, N'', N'36.gif', 37)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (38, N'', N'37.gif', 38)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (39, N'', N'38.gif', 39)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (40, N'', N'39.gif', 40)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (41, N'', N'40.gif', 41)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (42, N'', N'41.gif', 42)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (43, N'', N'42.gif', 43)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (44, N'', N'43.gif', 44)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (45, N'', N'44.gif', 45)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (46, N'', N'45.gif', 46)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (47, N'', N'46.gif', 47)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (48, N'', N'47.gif', 48)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (49, N'', N'48.gif', 49)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (50, N'', N'49.gif', 50)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (51, N'', N'50.gif', 51)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (52, N'', N'51.gif', 52)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (53, N'', N'52.gif', 53)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (54, N'', N'53.gif', 54)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (55, N'', N'54.gif', 55)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (56, N'', N'55.gif', 56)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (57, N'', N'56.gif', 57)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (58, N'', N'57.gif', 58)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (59, N'', N'58.gif', 59)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (60, N'', N'59.gif', 60)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (61, N'', N'60.gif', 61)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (62, N'', N'61.gif', 62)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (63, N'', N'62.gif', 63)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (64, N'', N'63.gif', 64)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (65, N'', N'64.gif', 65)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (66, N'', N'65.gif', 66)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (67, N'', N'66.gif', 67)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (68, N'', N'67.gif', 68)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (69, N'', N'68.gif', 69)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (70, N'', N'69.gif', 70)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (71, N'', N'70.gif', 71)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (72, N'', N'71.gif', 72)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (73, N'', N'72.gif', 73)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (74, N'', N'73.gif', 74)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (75, N'', N'74.gif', 75)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (76, N'', N'75.gif', 76)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (77, N'', N'76.gif', 77)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (78, N'', N'77.gif', 78)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (79, N'', N'78.gif', 79)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (80, N'', N'79.gif', 80)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (81, N'', N'80.gif', 81)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (82, N'', N'81.gif', 82)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (83, N'', N'82.gif', 83)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (84, N'', N'83.gif', 84)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (85, N'', N'84.gif', 85)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (86, N'', N'85.gif', 86)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (87, N'', N'86.gif', 87)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (88, N'', N'87.gif', 88)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (89, N'', N'88.gif', 89)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (90, N'', N'89.gif', 90)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (91, N'', N'90.gif', 91)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (92, N'', N'91.gif', 92)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (93, N'', N'92.gif', 93)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (94, N'', N'93.gif', 94)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (95, N'', N'94.gif', 95)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (96, N'', N'95.gif', 96)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (97, N'', N'96.gif', 97)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (98, N'', N'97.gif', 98)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (99, N'', N'98.gif', 99)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (100, N'', N'99.gif', 100)

print 'Processed 100 total records'
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (101, N'', N'100.gif', 101)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (102, N'', N'101.gif', 102)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (103, N'', N'102.gif', 103)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (104, N'', N'103.gif', 104)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (105, N'', N'104.gif', 105)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (106, N'', N'105.gif', 106)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (107, N'', N'106.gif', 107)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (108, N'', N'107.gif', 108)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (109, N'', N'108.gif', 109)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (110, N'', N'109.gif', 110)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (111, N'', N'110.gif', 111)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (112, N'', N'111.gif', 112)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (113, N'', N'112.gif', 113)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (114, N'', N'113.gif', 114)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (115, N'', N'114.gif', 115)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (116, N'', N'115.gif', 116)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (117, N'', N'116.gif', 117)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (118, N'', N'117.gif', 118)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (119, N'', N'118.gif', 119)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (120, N'', N'119.gif', 120)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (121, N'', N'120.gif', 121)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (122, N'', N'121.gif', 122)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (123, N'', N'122.gif', 123)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (124, N'', N'123.gif', 124)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (125, N'', N'124.gif', 125)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (126, N'', N'125.gif', 126)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (127, N'', N'126.gif', 127)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (128, N'', N'127.gif', 128)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (129, N'', N'128.gif', 129)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (130, N'', N'129.gif', 130)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (131, N'', N'130.gif', 131)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (132, N'', N'131.gif', 132)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (133, N'', N'132.gif', 133)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (134, N'', N'133.gif', 134)
INSERT [Max_DefaultEmoticons] ([EmoticonID], [Shortcut], [FileName], [SortOrder]) VALUES (135, N'', N'134.gif', 135)
SET IDENTITY_INSERT [Max_DefaultEmoticons] OFF


UPDATE [Max_Medals] SET [LogoUrl] = N'/Images/' + [LogoUrl] WHERE [LogoUrl]<>'' AND [LogoUrl] NOT LIKE N'/Images/%' AND [LogoUrl] NOT LIKE N'http://%';
UPDATE [Max_Roles] SET [LogoUrl] = N'/Images/' + [LogoUrl] WHERE [LogoUrl]<>''AND [LogoUrl] NOT LIKE N'/Images/%' AND [LogoUrl] NOT LIKE N'http://%';

UPDATE [System_Max_Settings] SET [SettingValue] = N'' WHERE [SettingKey] = 'DefaultAvaparOfMan';
UPDATE [System_Max_Settings] SET [SettingValue] = N'' WHERE [SettingKey] = 'DefaultAvaparOfWoMan';
UPDATE [System_Max_Settings] SET [SettingValue] = N'/Images/SystemAvatars/notset.gif' WHERE [SettingKey] = 'DefaultAvaparOfNotSetSex';
UPDATE [System_Max_Settings] SET [SettingValue] = N'����:<br/><br/>$nickname&nbsp;����������&nbsp;$bbsname!<br/><br/>�����Ը���������,�������µ�ַ(���Ƶ��������ַ��)��ʼע���ʺ�:<br/>$url<br/><br/>==========================================================<br/>$bbsname<br/>$bbsurl' WHERE CAST([SettingValue] AS NVARCHAR) = N'������ע���ַ $url' AND [SettingKey] = 'InviteEmailContent';
UPDATE [System_Max_Settings] SET [SettingValue] = N'$nickname ���������� $bbsname' WHERE CAST([SettingValue] AS NVARCHAR) = N'����$username����������룬����ϧ��' AND [SettingKey] = 'InviteEmailTitle';
UPDATE [System_Max_Settings] SET [SettingValue] = N'$nickame&nbsp;��ã�<br/><br/>��������ĵ�ַ������ĵ�ַ���뵽�������ַ�����ȡ�����������<font color="#002500">(ע�⣺�����û�н��й�ȡ������������벻Ҫ���������)</font><br/><br/><br/>$url<br/>(����ַ��24Сʱ����Ч)<br/><br/>==========================================================<br/>$bbsname<br/>$bbsurl<br/>' WHERE CAST([SettingValue] AS NVARCHAR) = N'<P>$userName ��ã�</P>
<P>��������ĵ�ַ������ĵ�ַ���뵽�������ַ�����ȡ���������</P>
<P>$url</P>' AND [SettingKey] = 'ReturnPassWordMessageContent';
UPDATE [System_Max_Settings] SET [SettingValue] = N'�һ� $nickname �� $bbsname ������' WHERE CAST([SettingValue] AS NVARCHAR) = N'bbsMax��̳�һ�����' AND [SettingKey] = 'ReturnPassWordMessageTitle';
UPDATE [System_Max_Settings] SET [SettingValue] = N'$nickname:<br/><br/>��ϲ���Ѿ���&nbsp;$bbsname&nbsp;ע��ɹ�!����������ע����Ϣ,�����Ʊ���:<br/><br/>�����ʺ�:<font color="#f00000">$username</font><br/><br/>��������:<font color="#f00000">$password</font><br/><br/>==========================================================<br/>$bbsname<br/>$bbsurl' WHERE CAST([SettingValue] AS NVARCHAR) = N'<P>��ӭ����bbsmax�ٷ���̳ </P>
<P>����ʺ�:<FONT color=#f00000>$username</FONT> </P>
<P>����ǳ�:<FONT color=#f00000>$nickname</FONT></P>' AND [SettingKey] = 'WelcomeContent';
UPDATE [System_Max_Settings] SET [SettingValue] = N'$nickname,��л���� $bbsname ע�ᣡ' WHERE CAST([SettingValue] AS NVARCHAR) = N'$nickname,��л����ע�ᣡ' AND [SettingKey] = 'WelcomeSubject';
UPDATE [System_Max_Settings] SET [SettingValue] = N'Enabled' WHERE CAST([SettingValue] AS NVARCHAR) <> N'Enabled' AND [SettingKey] = 'DefaultMessagesPopupWindow' AND [Catalog]=N'GlobalSetting';

-----  bbsMax �������� --------------------------------------------------------------------------------------

/******  [bbsMax_Judgements]  ******/
DELETE FROM [bbsMax_Judgements];
SET IDENTITY_INSERT [bbsMax_Judgements] ON
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (1, N'��ҫ��', N'/Images/Judgements/jd7.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (2, N'��ţ��', N'/Images/Judgements/jd8.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (3, N'�Բ���', N'/Images/Judgements/jd5.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (4, N'YY��', N'/Images/Judgements/jd10.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (5, N'ԭ����', N'/Images/Judgements/jd9.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (6, N'������', N'/Images/Judgements/jd6.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (7, N'��', N'/Images/Judgements/jd4.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (8, N'NB!', N'/Images/Judgements/jd1.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (9, N'OMG', N'/Images/Judgements/jd2.gif')
INSERT [bbsMax_Judgements] ([JudgementID], [JudgementDescription], [JudgementLogoUrl]) VALUES (10, N'��', N'/Images/Judgements/jd3.gif')
SET IDENTITY_INSERT [bbsMax_Judgements] OFF

DELETE FROM [System_bbsMax_Permissions]
DELETE FROM [System_bbsMax_PermissionSchemes]

SET IDENTITY_INSERT [System_bbsMax_PermissionSchemes] ON
DELETE FROM [System_bbsMax_PermissionSchemes];
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (2, 0, convert(text, N'zzbird.bbsMax.BBSManagePermission' collate Chinese_PRC_CI_AS), N'bbsMax Mangement Scheme', N'bbsMax Mangement Scheme', CAST(0x0000998A00FE8B01 AS DateTime))
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (1, 0, convert(text, N'zzbird.bbsMax.ForumPermission' collate Chinese_PRC_CI_AS), N'��ͨ���Ȩ�޷���', N'bbsmaxĬ�ϵİ���Ȩ�޷���,һ��İ��Ӧ��ѡ��˷���', CAST(0x000098C200729556 AS DateTime))
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (4, 0, convert(text, N'zzbird.bbsMax.ForumPermission' collate Chinese_PRC_CI_AS), N'���۰��Ȩ�޷���', N'ֻ���ɰ��������߼�����Ա�������⣬�����û�ֻ�ܻظ���', CAST(0x0000998B01099ABB AS DateTime))
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (5, 0, convert(text, N'zzbird.bbsMax.ForumPermission' collate Chinese_PRC_CI_AS), N'��֤���Ȩ�޷���', N'ֻ�д�ʼ�ˣ�����Ա����������֤�û����ܽ���', CAST(0x000099F5009A2DFE AS DateTime))
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (6, 0, convert(text, N'zzbird.bbsMax.ForumPermission' collate Chinese_PRC_CI_AS), N'ֻ�����Ȩ�޷���', N'ֻ�а��������߼��û����ܿ��Է�������ͨ�û�ֻ�ܲ鿴��', CAST(0x000099F5009CA743 AS DateTime))
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (7, 0, convert(text, N'zzbird.bbsMax.ForumPermission' collate Chinese_PRC_CI_AS), N'��˰��Ȩ�޷���', N'�������¼�����û�(��������)��������ͻظ�����Ҫ��ˡ�', CAST(0x000099F500C53AA2 AS DateTime))
INSERT [System_bbsMax_PermissionSchemes] ([SchemeID], [ParentID], [PermissionType], [SchemeName], [Description], [CreateDate]) VALUES (8, 0, convert(text, N'zzbird.bbsMax.ForumPermission' collate Chinese_PRC_CI_AS), N'���а�����Ȩ�޷���', N'��3.0 beta1����ʱû�����ã��¸��汾����Ϊ�������������з������Ӵ˼̳У�������������ظ�Ȩ��', CAST(0x000099F500C64AA6 AS DateTime))
SET IDENTITY_INSERT [System_bbsMax_PermissionSchemes] OFF

/****** ����:  Table [System_bbsMax_Permissions]    �ű�����: 07/29/2008 23:11:40 ******/
DELETE FROM [System_bbsMax_Permissions];
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, -1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:6;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:4;DeleteOwnThreads:1;DeleteOwnThreadsInterval:4;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11015513153600011111011111432000112592000114~802~10000011111111003600036001110000000000000000000000001-1~1-10~10*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 0, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11005503153600010000000000002592000004~802~1000001100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:7;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001000000010000000000~02~*01111111011100011000000111111111111111111111111-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 2, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:18;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001000000010000000000~02~*0111111101110001-1,0,2,3,4,5,6,7,8111111111111111111111111-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 3, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:16;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:6;MarkingLimit_Point2:8;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001000000010000000000~02~*0010000001110001-1,0,3,4,5,6,7,8111111111111111111111111-10~10-100~100*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 4, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:14;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000010000000000~02~*0010000001110000-1,0,4,5,6,7,8111111111101111111111110-5~5-50~50*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 5, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~00010000000000000000000000000000000000000-2~2-20~20*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 6, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~000100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 7, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (1, 8, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 1, N'AllowBBSManage:1;AllowManageSetting:1;AllowManageOnlineUserList:1;AllowManageLinks:1;AllowManageAnnouncements:1;AllowManageKeywords:1;AllowManagePostIndexAlias:1;AllowManageValidateSetting:1;AllowManageForums:1;AllowManageModerators:1;AllowManageForumPermissionSchemes:1;AllowManageForumPermissionSchemes_Roles:7;AllowManageBBSManagePermissions:1;AllowManageShieldedUsers:1;AllowManagePointSetting:1;AllowManagePointLevels:1;AllowManagePointSchemes:1;AllowManageUpdateUserPoints:1;AllowManagePointSchemes_Roles:7;AllowManageLogForShow:1;AllowManageLogForDelete:1;AllowManageStats:1;AllowManageThreadCatalog:1;AllowManageThreadJudgement:1|111111111111000000111111100000011111')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (2, 2, N'AllowBBSManage:1;AllowManageSetting:1;AllowManageOnlineUserList:1;AllowManageLinks:1;AllowManageAnnouncements:1;AllowManageKeywords:1;AllowManagePostIndexAlias:1;AllowManageValidateSetting:1;AllowManageForums:1;AllowManageModerators:1;AllowManageForumPermissionSchemes:1;AllowManageForumPermissionSchemes_Roles:16;AllowManageBBSManagePermissions:1;AllowManageShieldedUsers:1;AllowManagePointSetting:1;AllowManagePointLevels:1;AllowManagePointSchemes:1;AllowManageUpdateUserPoints:1;AllowManagePointSchemes_Roles:16;AllowManageLogForShow:1;AllowManageLogForDelete:1;AllowManageStats:1;AllowManageThreadCatalog:1;AllowManageThreadJudgement:1|11111111111-1,0,3,4,5,6,7,8011110-1,0,3,4,5,6,7,810111')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, -1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:6;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:4;DeleteOwnThreads:1;DeleteOwnThreadsInterval:4;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11015513153600010111000110432000012592000114~802~10000011111111003600036000000000000000000000000000001-1~1-10~10*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 0, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11005503153600010000000000002592000004~802~1000001100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:7;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001010101111100110010~00~001111111011111111000000111111111111111111111111-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 2, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:18;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001010101111100110010~00~00111111101111111-1,0,2,3,4,5,6,7,8111111111111111111111111-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 3, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:16;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:6;MarkingLimit_Point2:8;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001010101111100110010~00~00010000001111111-1,0,3,4,5,6,7,8111111111111111111111111-10~10-100~100*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 4, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:14;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000010101111100110010~00~00010000001111110-1,0,4,5,6,7,8111111111101111111111110-5~5-50~50*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 5, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000100000000000~00~00010000000000000000000000000000000000000-2~2-20~20*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 6, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~000100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 7, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (4, 8, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, -1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:6;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:4;DeleteOwnThreads:1;DeleteOwnThreadsInterval:4;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|10005503153600000000000010432000002592000104~802~10000011111111003600036000000000000000000000000000001-1~1-10~10*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 0, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|00005503153600000000000000002592000004~802~1000001100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:7;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|011111111111110111010~00~001111111010111111000000111111111111111111111111-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 2, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:18;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|011111111111110111010~00~00111111101011111-1,0,2,3,4,5,6,7,8111111111111111111111111-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 3, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:16;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:6;MarkingLimit_Point2:8;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|011111111111110111010~00~00010000001011111-1,0,3,4,5,6,7,8111111111111111111111111-10~10-100~100*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 4, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:14;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|010111111111110111010~00~00010000001011110-1,0,4,5,6,7,8111111111101111111111110-5~5-50~50*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 5, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~00010000000000000000000000000000000000000-2~2-20~20*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 6, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|010111111111110111010~00~000100000000011100000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 7, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (5, 8, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, -1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:6;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:4;DeleteOwnThreads:1;DeleteOwnThreadsInterval:4;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11015503153600010000000010432000002592000104~802~10000011111111003600036000000000000000000000000000000-1~1-10~10*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 0, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11005503153600010000000000002592000004~802~1000001100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:7;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001010111111110111010~00~001111111010111111000000111111111111111111111110-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 2, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:18;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001010111111110111010~00~00111111101011111-1,0,2,3,4,5,6,7,8111111111111111111111110-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 3, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:16;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:6;MarkingLimit_Point2:8;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001010111111110111010~00~00010000001011111-1,0,3,4,5,6,7,8111111111111111111111110-10~10-100~100*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 4, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:14;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000010111111110111010~00~00010000001011110-1,0,4,5,6,7,8111111111101111111111110-5~5-50~50*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 5, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~00010000000000000000000000000000000000000-2~2-20~20*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 6, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~000100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 7, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (6, 8, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, -1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:6;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:4;DeleteOwnThreads:1;DeleteOwnThreadsInterval:4;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11015513153600011100011111432000112592000114~802~10000011111111003600036001110000000000000000000000000-1~1-10~10*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 0, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:1;CreatePostInterval:1;RankThread:1;UpdateThreadSortOrderInterval:8;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:7;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:4;PostContentLengthLimit:7;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|11005503153600010000000000002592000004~802~1000001100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 1, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:7;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001000001110000000000~00~001111111010100011000000111111111111111111111110-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 2, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:18;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:8;MarkingLimit_Point2:10;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001000001110000000000~00~00111111101010001-1,0,2,3,4,5,6,7,8111111111111111111111110-100~100-1000~1000*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 3, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:16;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:6;MarkingLimit_Point2:8;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|001000001110000000000~00~00010000001010001-1,0,3,4,5,6,7,8111111111111111111111110-10~10-100~100*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 4, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:14;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000001110000000000~00~00010000001010000-1,0,4,5,6,7,8111111111101111111111110-5~5-50~50*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 5, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:4;MarkingLimit_Point2:6;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~00010000000000000000000000000000000000000-2~2-20~20*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 6, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000000000000000000000~00~000100000000000000000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 7, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')
INSERT [System_bbsMax_Permissions] ([SchemeID], [RoleID], [PermissionItems]) VALUES (7, 8, N'DisplayInList:1;VisitForum:1;SigninForumWithoutPassword:1;ViewValuedThread:1;CreateThreadInterval:0;CreatePostInterval:0;RankThread:1;UpdateThreadSortOrderInterval:0;ViewThread:1;CreateThread:1;ReplyThread:1;CreateThreadWithoutApprove:1;ReplyWithoutApprove:1;ViewPollDetail:1;CreatePoll:1;Vote:1;AddAttachment:1;ViewAttachment:1;CreateQuestion:1;QuestionValidDays:0;CreatePolemize:1;CanPolemize:1;PolemizeValidDays:0;PostEnableSignature:1;PostEnableReplyNotice:1;PostSubjectLengthLimit:3;PostContentLengthLimit:3;PostFormat:8;DisplayContent:1;SetOwnThreadsLock:1;RecycleAndRestoreOwnThreads:1;RecycleOwnThreadsInterval:0;DeleteOwnThreads:1;DeleteOwnThreadsInterval:0;UpdateOwnThread:1;DeleteOwnPosts:1;UpdateOwnPost:1;ManageNoRequireModerator:1;MangageRolesThreads:0;UpdateThreads:1;DeleteThreads:1;JudgementThreads:1;SetThreadsRecycled:1;UpdatePosts:1;DeletePosts:1;SetPostShield:1;MoveThreads:1;SetThreadsStick:1;SetThreadNotUpdateSortOrder:1;SetThreadsGlobalStick:1;ApproveThreads:1;ApprovePosts:1;JoinThreads:1;SplitThread:1;SetThreadsSubjectStyle:1;SetThreadsLock:1;SetThreadsUp:1;SetThreadsValued:1;SetUserShield:1;UpdateForumReadme:1;AlwaysViewContents:1;FinalAnyQuestion:1;MarkingNoRequireModerator:1;MarkingLimit_Point1:3;MarkingLimit_Point2:3;MarkingLimit_Point3:3;MarkingLimit_Point4:3;MarkingLimit_Point5:3;MarkingLimit_Point6:3;MarkingLimit_Point7:3;MarkingLimit_Point8:3|000020222202220222020~00~000100000222222200000000000000000000000000~00~0*~0*~0*~0*~0*~00~0')


IF NOT EXISTS(SELECT * FROM [System_bbsMax_Settings] WHERE [SettingKey] = N'CommendThreadEmailContent')
	INSERT [System_bbsMax_Settings] ([Catalog], [SettingKey], [SettingValue], [UpdateDate]) VALUES (N'BBSSetting', N'CommendThreadEmailContent', N'����,����$nickname�����Ƽ�������<br/>���ӱ���:$subject<br/>���ӵ�ַ:<a href="$url">$url</a><br/>�Ƽ�����:$reason', CAST(0x00009AE800BE23D2 AS DateTime))
IF NOT EXISTS(SELECT * FROM [System_bbsMax_Settings] WHERE [SettingKey] = N'CommendThreadEmailSubject')
	INSERT [System_bbsMax_Settings] ([Catalog], [SettingKey], [SettingValue], [UpdateDate]) VALUES (N'BBSSetting', N'CommendThreadEmailSubject', N'���ĺ���$nickname�����Ƽ�һƪ���£�', CAST(0x00009AE7010CEDCF AS DateTime))

UPDATE [System_bbsMax_Settings] SET [SettingValue] = N'���������Ѿ�������Ա����<br />���ӱ���:$subject<br />���ӵ�ַ:$url<br />������:$admin<br />����:$action<br />ԭ��:$reson' WHERE CAST([SettingValue] AS NVARCHAR) = N'���������Ѿ�������Ա����
���ӵ�ַ:$url ' AND [SettingKey] = N'ThreadManagerMessageContent';
UPDATE [System_bbsMax_Settings] SET [SettingValue] = N'$nickname,���������Ѿ�������Ա����' WHERE CAST([SettingValue] AS NVARCHAR) = N'���������Ѿ�������Ա����' AND [SettingKey] = N'ThreadManagerMessageSubject';
UPDATE [System_bbsMax_Settings] SET [SettingValue] = N'True' WHERE [SettingKey] = N'DisplaySideBar' AND [Catalog]=N'BBSSetting' AND CAST([SettingValue] AS NVARCHAR) <> 'True';

update [bbsMax_Threads] set SortOrder  = CAST('11'+substring(cast(SortOrder as varchar(16)),3,16) as bigint) where SortOrder > 1200000000000000 and SortOrder < 2000000000000000
update [bbsMax_Threads] set SortOrder  = CAST('21'+substring(cast(SortOrder as varchar(16)),3,16) as bigint) where SortOrder > 2200000000000000 and SortOrder < 3000000000000000
update [bbsMax_Threads] set SortOrder  = CAST('31'+substring(cast(SortOrder as varchar(16)),3,16) as bigint) where SortOrder > 3200000000000000 and SortOrder < 4000000000000000
update [bbsMax_Threads] set SortOrder  = CAST('41'+substring(cast(SortOrder as varchar(16)),3,16) as bigint) where SortOrder > 4200000000000000 and SortOrder < 5000000000000000
update [bbsMax_Threads] set SortOrder  = CAST('51'+substring(cast(SortOrder as varchar(16)),3,16) as bigint) where SortOrder > 5200000000000000 

/*** bbsMax_links ***/
Update [bbsMax_Links] SET LogoUrl = replace(LogoUrl ,N'logo/',N'/Images/Logos/')  WHERE [LogoUrl]<>'' AND [LogoUrl] NOT LIKE N'/Images/%' AND [LogoUrl] NOT LIKE N'http://%';

/*** bbsMax_PointLevels ***/
UPDATE [bbsMax_PointLevels] SET LogoUrl = N'/Images/'+LogoUrl  WHERE [LogoUrl]<>'' AND [LogoUrl] NOT LIKE N'/Images/%' AND [LogoUrl] NOT LIKE N'http://%';

/*** bbsMax_RolesInOnline***/
UPDATE [bbsMax_RolesInOnline] SET LogoUrl = N'/Images/'+LogoUrl  WHERE [LogoUrl]<>'' AND [LogoUrl] NOT LIKE N'/Images/%' AND [LogoUrl] NOT LIKE N'http://%';

UPDATE [bbsMax_Threads] SET [JudgementID]=1 WHERE [ThreadID]=1;
UPDATE [bbsMax_Posts] SET [Content] = N'��ӭʹ��&nbsp;bbsmax&nbsp;����л�������ǵ�֧�֣��������Ǽ��������Ķ�����<br/><br/>bbsmax&nbsp;&nbsp;��ǰ����&nbsp;nowboard����һ���汾������&nbsp;2002&nbsp;�꣬���й�����Ļ���&nbsp;.net&nbsp;����̳ϵͳ��<br/>��&nbsp;bbsmax&nbsp;2.0&nbsp;��ʼ������������ȫ��д�Ĵ�����Ѿ���չ��Ϊ�ǳ�ǿ�����̳ϵͳ����&nbsp;bbsmax&nbsp;3.0&nbsp;������Ϊ&nbsp;bbsmax&nbsp;����̱��汾��<br/><br/>�������ʹ���ϵ����ʣ���ӭ��ϵ���ǣ�<br/><br/>�ٷ���վ&nbsp;<a href="http://www.bbsmax.com/">http://www.bbsmax.com</a><br/><br/><div align="right">bbsmax&nbsp;�����Ŷ�<br/></div>',[ContentFormat]=4 WHERE [PostID]=1;

-----  bbsMax �������� ���� ------------

-----  ��洦��             ------------
IF OBJECT_ID ( 'System_Max_Advertisements', 'U' ) IS NOT NULL BEGIN
	IF OBJECT_ID ( 'Tem_Max_Advertisements', 'U' ) IS NOT NULL
		DROP TABLE [Tem_Max_Advertisements]
	CREATE TABLE [Tem_Max_Advertisements](
	[AdvertisementID] [int] IDENTITY(1,1) NOT NULL,
	[AdvertisementName] [nvarchar](100) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[AdvertisementCatalogID] [int] NOT NULL,
	[AdvertisementType] [tinyint] NOT NULL,
	[AdvertisementCode] [ntext] COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[IsEnable] [bit] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL DEFAULT (getdate()),
	[EnabledDate] [datetime] NOT NULL DEFAULT (getdate()),
	[ExpiresDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL
	) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

	SET IDENTITY_INSERT [Tem_Max_Advertisements] ON
		INSERT [Tem_Max_Advertisements] ([AdvertisementID], [AdvertisementName], [AdvertisementCatalogID], [AdvertisementType], [AdvertisementCode], [IsEnable], [CreateDate], [EnabledDate], [ExpiresDate], [SortOrder]) SELECT [AdvertisementID], [AdvertisementName], [AdvertisementCatalogID], [AdvertisementType], [AdvertisementCode], [IsEnable], [CreateDate], [EnabledDate], [ExpiresDate], [SortOrder] FROM [System_Max_Advertisements];
	SET IDENTITY_INSERT [Tem_Max_Advertisements] OFF
	DROP TABLE [System_Max_Advertisements]
END

IF OBJECT_ID('System_Max_AdvertisementCatalogs', 'U') IS NOT NULL BEGIN
	IF OBJECT_ID ( 'Tem_Max_AdvertisementCatalogs', 'U' ) IS NOT NULL
		DROP TABLE [Tem_Max_AdvertisementCatalogs]
	CREATE TABLE [Tem_Max_AdvertisementCatalogs](
	[AdvertisementCatalogID] [int] IDENTITY(1,1) NOT NULL,
	[CatalogKey] [nvarchar](64) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[CatalogName] [nvarchar](128) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[OrderType] [tinyint] NOT NULL DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL  DEFAULT (getdate())
	) ON [PRIMARY]

	SET IDENTITY_INSERT [Tem_Max_AdvertisementCatalogs] ON
		INSERT INTO [Tem_Max_AdvertisementCatalogs]([AdvertisementCatalogID], [CatalogKey], [CatalogName], [OrderType], [CreateDate]) SELECT [AdvertisementCatalogID], [CatalogKey], [CatalogName], [OrderType], [CreateDate] FROM [System_Max_AdvertisementCatalogs];
	SET IDENTITY_INSERT [Tem_Max_AdvertisementCatalogs] OFF
	DROP TABLE [System_Max_AdvertisementCatalogs]
END

IF OBJECT_ID ( 'Max_AdvertisementCatalogs', 'U' ) IS NULL
CREATE TABLE [Max_AdvertisementCatalogs](
	[AdvertisementCatalogID] [int] IDENTITY(1,1) NOT NULL,
	[CatalogKey] [nvarchar](64) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[CatalogName] [nvarchar](128) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[OrderType] [tinyint] NOT NULL CONSTRAINT [DF_System_Max_AdvertisementCatalogs_OrderType]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_System_Max_AdvertisementCatalogs_CreateDate]  DEFAULT (getdate()),
 CONSTRAINT [PK_System_Max_AdvertisementCatalogs] PRIMARY KEY CLUSTERED 
(
	[AdvertisementCatalogID] ASC
) ON [PRIMARY]
) ON [PRIMARY]

GO

IF OBJECT_ID ( 'Max_Advertisements', 'U' ) IS NULL
CREATE TABLE [Max_Advertisements](
	[AdvertisementID] [int] IDENTITY(1,1) NOT NULL,
	[AdvertisementName] [nvarchar](100) COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[AdvertisementCatalogID] [int] NOT NULL,
	[AdvertisementType] [tinyint] NOT NULL,
	[AdvertisementCode] [ntext] COLLATE Chinese_PRC_CI_AS_WS NOT NULL,
	[IsEnable] [bit] NOT NULL CONSTRAINT [DF_System_Max_Advertisements_IsEnable]  DEFAULT ((0)),
	[CreateDate] [datetime] NOT NULL CONSTRAINT [DF_System_Max_Advertisements_CreateDate]  DEFAULT (getdate()),
	[EnabledDate] [datetime] NOT NULL CONSTRAINT [DF_System_Max_Advertisements_EnabledDate]  DEFAULT (getdate()),
	[ExpiresDate] [datetime] NOT NULL,
	[SortOrder] [int] NOT NULL,
 CONSTRAINT [PK_System_Max_Advertisements] PRIMARY KEY CLUSTERED 
(
	[AdvertisementID] ASC
) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO

IF OBJECT_ID('Tem_Max_AdvertisementCatalogs', 'U') IS NOT NULL BEGIN
	DELETE FROM [Max_AdvertisementCatalogs];
	SET IDENTITY_INSERT [Max_AdvertisementCatalogs] ON
		INSERT INTO [Max_AdvertisementCatalogs]([AdvertisementCatalogID], [CatalogKey], [CatalogName], [OrderType], [CreateDate]) SELECT [AdvertisementCatalogID], [CatalogKey], [CatalogName], [OrderType], [CreateDate] FROM [Tem_Max_AdvertisementCatalogs];
	SET IDENTITY_INSERT [Max_AdvertisementCatalogs] OFF
	DROP TABLE [Tem_Max_AdvertisementCatalogs]
END

IF OBJECT_ID ( 'Tem_Max_Advertisements', 'U' ) IS NOT NULL BEGIN
	DELETE FROM [Max_Advertisements];
	SET IDENTITY_INSERT [Max_Advertisements] ON
		INSERT [Max_Advertisements] ([AdvertisementID], [AdvertisementName], [AdvertisementCatalogID], [AdvertisementType], [AdvertisementCode], [IsEnable], [CreateDate], [EnabledDate], [ExpiresDate], [SortOrder]) SELECT [AdvertisementID], [AdvertisementName], [AdvertisementCatalogID], [AdvertisementType], [AdvertisementCode], [IsEnable], [CreateDate], [EnabledDate], [ExpiresDate], [SortOrder] FROM [Tem_Max_Advertisements];
	SET IDENTITY_INSERT [Max_Advertisements] OFF
	DROP TABLE [Tem_Max_Advertisements]
END

/****** ����:  Table [Max_AdvertisementCatalogs] ******/
IF NOT EXISTS(SELECT * FROM [Max_AdvertisementCatalogs] WHERE [CatalogKey]='topBanner')
	INSERT [Max_AdvertisementCatalogs] ([CatalogKey], [CatalogName], [OrderType], [CreateDate]) VALUES (N'topBanner', N'ҳ�涥��Banner', 1, CAST(0x0000998A00BBEA12 AS DateTime))
IF NOT EXISTS(SELECT * FROM [Max_AdvertisementCatalogs] WHERE [CatalogKey]='bottomBanner')
	INSERT [Max_AdvertisementCatalogs] ([CatalogKey], [CatalogName], [OrderType], [CreateDate]) VALUES (N'bottomBanner', N'ҳ��ײ�Banner', 1, CAST(0x0000998A00BC0381 AS DateTime))
IF NOT EXISTS(SELECT * FROM [Max_AdvertisementCatalogs] WHERE [CatalogKey]='toptext')
	INSERT [Max_AdvertisementCatalogs] ([CatalogKey], [CatalogName], [OrderType], [CreateDate]) VALUES (N'toptext', N'ҳ���ϲ����ֹ���', 1, CAST(0x000098D3003BA96F AS DateTime))
IF NOT EXISTS(SELECT * FROM [Max_AdvertisementCatalogs] WHERE [CatalogKey]='postAD')
	INSERT [Max_AdvertisementCatalogs] ([CatalogKey], [CatalogName], [OrderType], [CreateDate]) VALUES (N'postAD', N'����¥�����', 2, CAST(0x0000996001225818 AS DateTime))
IF NOT EXISTS(SELECT * FROM [Max_AdvertisementCatalogs] WHERE [CatalogKey]='threadAD')
	INSERT [Max_AdvertisementCatalogs] ([CatalogKey], [CatalogName], [OrderType], [CreateDate]) VALUES (N'threadAD', N'�����ڹ��', 1, CAST(0x0000996001225818 AS DateTime))

GO

/****** ����:  Table [Max_Advertisements] ******/
UPDATE [Max_Advertisements] SET [AdvertisementCode]=N'<a href="http://www.bbsmax.com" target="_blank"><img src="$root/Images/A/top_banner.gif" width="422" height="61" title="bbsMax��ʽ��:http://www.bbsmax.com" /></a>' WHERE CAST([AdvertisementCode] AS NVARCHAR)=N'<a href="http://www.bbsmax.com" target="_blank"><img src="$commonimages/top_banner.gif" width="422px" height="61px" title="bbsMax��ʽ��:http://www.bbsmax.com" border="0px" /></a>' AND [AdvertisementID]=1;
	
GO

---- insert CONSTRAINT,INDEX
IF NOT EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_AdvertisementCatalogs') AND [name]='IX_System_Max_AdvertisementCatalogs')
CREATE UNIQUE NONCLUSTERED INDEX [IX_System_Max_AdvertisementCatalogs] ON [Max_AdvertisementCatalogs] 
(
	[CatalogKey] ASC
)ON [PRIMARY]

GO

IF NOT EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_Advertisements') AND [name]='IX_System_Max_Advertisements')
CREATE UNIQUE NONCLUSTERED INDEX [IX_System_Max_Advertisements] ON [Max_Advertisements] 
(
	[SortOrder] ASC,
	[AdvertisementCatalogID] ASC
) ON [PRIMARY]

GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_Max_Advertisements_AdvertisementCatalogs')
ALTER TABLE [Max_Advertisements]  WITH CHECK ADD  CONSTRAINT [FK_System_Max_Advertisements_AdvertisementCatalogs] FOREIGN KEY([AdvertisementCatalogID])
REFERENCES [Max_AdvertisementCatalogs] ([AdvertisementCatalogID])
ON UPDATE CASCADE
ON DELETE CASCADE

GO
------   ��洦����� ------------

--- �������Ĳ���
IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_Max_InviteSerials_ToEmail')
ALTER TABLE [Max_InviteSerials] ADD CONSTRAINT [DF_Max_InviteSerials_ToEmail] DEFAULT ('') FOR [ToEmail]

GO

IF EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_InviteSerials') AND [name] ='IsAccept')
ALTER TABLE [Max_InviteSerials] DROP COLUMN [IsAccept]

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_InviteSerials') AND [name] ='ID')
ALTER TABLE [Max_InviteSerials] ADD [ID] [int] IDENTITY(1,1) NOT NULL

GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_InviteSerials') AND [name] ='Status')
ALTER TABLE [Max_InviteSerials] ADD [Status] [tinyint] CONSTRAINT [DF_Max_InviteSerials_Status] DEFAULT ((0))

GO

--���������뿪ʼ
IF OBJECT_ID ( 'Max_UserInvites', 'U' ) IS NOT NULL 
BEGIN
	DECLARE cs_ui CURSOR FOR SELECT UserID FROM Max_UserInvites FOR READ ONLY
	DECLARE @uid INT
	DECLARE @sn INT
	OPEN cs_ui
	FETCH NEXT FROM cs_ui INTO @uid
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @sn = SpareInviteCount FROM Max_UserInvites WHERE UserID=@uid
		WHILE @sn>0
		BEGIN
			EXEC('INSERT INTO Max_InviteSerials(UserID,ExpiresDate) VALUES('+@uid+',DATEADD(day, 30, getdate()))')
			SET @sn=@sn-1
		END
		FETCH NEXT FROM cs_ui INTO @uid
	END

	CLOSE cs_ui
	DEALLOCATE cs_ui
END
--�������������

IF OBJECT_ID ( 'Max_UserInvites', 'U' ) IS NOT NULL
DROP TABLE [Max_UserInvites]

GO
--- �����Ĳ���