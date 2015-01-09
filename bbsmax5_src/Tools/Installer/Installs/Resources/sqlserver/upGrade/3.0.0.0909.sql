--- idmax �����ű� ----------------------------------------------------------
IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_Max_Advertisements_AdvertisementCatalogs') BEGIN
	PRINT N'����ɾ�� [Max_Advertisements] �����'
	ALTER TABLE [Max_Advertisements] DROP CONSTRAINT [FK_System_Max_Advertisements_AdvertisementCatalogs]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_Max_Faqs_System_Max_FaqCatalogs') BEGIN
	PRINT N'����ɾ�� [Max_Faqs] �����'
	ALTER TABLE [Max_Faqs] DROP CONSTRAINT [FK_System_Max_Faqs_System_Max_FaqCatalogs]
END
GO



IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_Max_Permissions_PermissionSchemes') BEGIN
	PRINT N'����ɾ�� [System_Max_Permissions] �����'
	ALTER TABLE [System_Max_Permissions] DROP CONSTRAINT [FK_System_Max_Permissions_PermissionSchemes]
END
GO



IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_AdvertisementCatalogs') BEGIN
	PRINT N'����ɾ�� [Max_AdvertisementCatalogs] ��Լ��'
	ALTER TABLE [Max_AdvertisementCatalogs] DROP CONSTRAINT [PK_System_Max_AdvertisementCatalogs]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_System_Max_AdvertisementCatalogs_OrderType') BEGIN
	PRINT N'����ɾ�� [Max_AdvertisementCatalogs] ��Լ��'
	ALTER TABLE [Max_AdvertisementCatalogs] DROP CONSTRAINT [DF_System_Max_AdvertisementCatalogs_OrderType]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_System_Max_AdvertisementCatalogs_CreateDate') BEGIN
	PRINT N'����ɾ�� [Max_AdvertisementCatalogs] ��Լ��'
	ALTER TABLE [Max_AdvertisementCatalogs] DROP CONSTRAINT [DF_System_Max_AdvertisementCatalogs_CreateDate]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_Advertisements') BEGIN
	PRINT N'����ɾ�� [Max_Advertisements] ��Լ��'
	ALTER TABLE [Max_Advertisements] DROP CONSTRAINT [PK_System_Max_Advertisements]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_FaqCatalogs') BEGIN
	PRINT N'����ɾ�� [Max_FaqCatalogs] ��Լ��'
	ALTER TABLE [Max_FaqCatalogs] DROP CONSTRAINT [PK_System_Max_FaqCatalogs]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_Faqs') BEGIN
	PRINT N'����ɾ�� [Max_Faqs] ��Լ��'
	ALTER TABLE [Max_Faqs] DROP CONSTRAINT [PK_System_Max_Faqs]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_Jobs') BEGIN
	PRINT N'����ɾ�� [Max_Jobs] ��Լ��'
	ALTER TABLE [Max_Jobs] DROP CONSTRAINT [PK_System_Max_Jobs]
END
GO

IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_PermissionSchemes') BEGIN
	PRINT N'����ɾ�� [System_Max_PermissionSchemes] ��Լ��'
	ALTER TABLE [System_Max_PermissionSchemes] DROP CONSTRAINT [PK_System_Max_PermissionSchemes]
END
GO


IF EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('IX_System_Max_AdvertisementCatalogs') AND [name]='Max_AdvertisementCatalogs') BEGIN
	PRINT N'����ɾ�� [Max_AdvertisementCatalogs] ������ [IX_System_Max_AdvertisementCatalogs]'
	DROP INDEX [Max_AdvertisementCatalogs].[IX_System_Max_AdvertisementCatalogs]
END
GO


IF EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_Advertisements') AND [name]='IX_System_Max_Advertisements') BEGIN
	PRINT N'����ɾ�� [Max_Advertisements] ������ [IX_System_Max_Advertisements]'
	DROP INDEX [Max_Advertisements].[IX_System_Max_Advertisements]
END
GO


IF EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_FaqCatalogs') AND [name]='IX_System_Max_FaqCatalogs') BEGIN
	PRINT N'����ɾ�� [Max_FaqCatalogs] ������ [IX_System_Max_FaqCatalogs]'
	DROP INDEX [Max_FaqCatalogs].[IX_System_Max_FaqCatalogs]
END
GO


IF EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_Faqs') AND [name]='IX_System_Max_Faqs') BEGIN
	PRINT N'����ɾ�� [Max_Faqs] ������ [IX_System_Max_Faqs]'
	DROP INDEX [Max_Faqs].[IX_System_Max_Faqs]
END
GO


IF EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('System_Max_PermissionSchemes') AND [name]='IX_System_Max_PermissionSchemes') BEGIN
	PRINT N'����ɾ�� [System_Max_PermissionSchemes] ������ [IX_System_Max_PermissionSchemes]'
	DROP INDEX [System_Max_PermissionSchemes].[IX_System_Max_PermissionSchemes]
END
GO


PRINT N'���ڸı� [Max_AdvertisementCatalogs]'
GO
ALTER TABLE [Max_AdvertisementCatalogs] ALTER COLUMN [OrderType] [tinyint] NOT NULL
ALTER TABLE [Max_AdvertisementCatalogs] ALTER COLUMN [CreateDate] [datetime] NOT NULL
GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_Max_AdvertisementCatalogs') BEGIN
	PRINT N'���� [Max_AdvertisementCatalogs] �ϴ������� [PK_Max_AdvertisementCatalogs]'
	ALTER TABLE [Max_AdvertisementCatalogs] ADD CONSTRAINT [PK_Max_AdvertisementCatalogs] PRIMARY KEY CLUSTERED  ([AdvertisementCatalogID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_Max_Advertisements') BEGIN
	PRINT N'���� [Max_Advertisements] �ϴ������� [PK_Max_Advertisements]'
	ALTER TABLE [Max_Advertisements] ADD CONSTRAINT [PK_Max_Advertisements] PRIMARY KEY CLUSTERED  ([AdvertisementID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_Max_FaqCatalogs') BEGIN
	PRINT N'���� [Max_FaqCatalogs] �ϴ������� [PK_Max_FaqCatalogs]'
	ALTER TABLE [Max_FaqCatalogs] ADD CONSTRAINT [PK_Max_FaqCatalogs] PRIMARY KEY CLUSTERED  ([FaqCatalogID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_Max_Faqs') BEGIN
	PRINT N'���� [Max_Faqs] �ϴ������� [PK_Max_Faqs]'
	ALTER TABLE [Max_Faqs] ADD CONSTRAINT [PK_Max_Faqs] PRIMARY KEY CLUSTERED  ([FaqID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_Max_Jobs') BEGIN
	PRINT N'���� [Max_Jobs] �ϴ������� [PK_Max_Jobs]'
	ALTER TABLE [Max_Jobs] ADD CONSTRAINT [PK_Max_Jobs] PRIMARY KEY CLUSTERED  ([JobID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_Max_PermissionSchemes') BEGIN
	PRINT N'���� [System_Max_PermissionSchemes] �ϴ������� [PK_System_Max_PermissionSchemes]'
	ALTER TABLE [System_Max_PermissionSchemes] ADD CONSTRAINT [PK_System_Max_PermissionSchemes] PRIMARY KEY CLUSTERED  ([SchemeID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_FaqCatalogs') AND [name]='IX_SMax_FaqCatalogs') BEGIN
	PRINT N'���ڴ��� [Max_FaqCatalogs] ������ [IX_SMax_FaqCatalogs]'
	CREATE UNIQUE NONCLUSTERED INDEX [IX_SMax_FaqCatalogs] ON [Max_FaqCatalogs] ([SortOrder]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('Max_Faqs') AND [name]='IX_Max_Faqs') BEGIN
	PRINT N'���ڴ��� [Max_Faqs] ������ [IX_Max_Faqs]'
	CREATE UNIQUE NONCLUSTERED INDEX [IX_Max_Faqs] ON [Max_Faqs] ([FaqCatalogID], [SortOrder]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_Max_AdvertisementCatalogs_OrderType') BEGIN
	PRINT N'������ [Max_AdvertisementCatalogs] ���Լ�� DF_Max_AdvertisementCatalogs_OrderType'
	ALTER TABLE [Max_AdvertisementCatalogs] ADD CONSTRAINT [DF_Max_AdvertisementCatalogs_OrderType] DEFAULT ((0)) FOR [OrderType]
END
GO
IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_Max_AdvertisementCatalogs_CreateDate') BEGIN
	PRINT N'������ [Max_AdvertisementCatalogs] ���Լ�� DF_Max_AdvertisementCatalogs_CreateDate'
	ALTER TABLE [Max_AdvertisementCatalogs] ADD CONSTRAINT [DF_Max_AdvertisementCatalogs_CreateDate] DEFAULT (getdate()) FOR [CreateDate]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_Max_Advertisements_AdvertisementCatalogs') BEGIN
	PRINT N'������ [Max_Advertisements] ������'
	ALTER TABLE [Max_Advertisements] ADD CONSTRAINT [FK_Max_Advertisements_AdvertisementCatalogs] FOREIGN KEY ([AdvertisementCatalogID]) REFERENCES [Max_AdvertisementCatalogs] ([AdvertisementCatalogID]) ON DELETE CASCADE ON UPDATE CASCADE
END
GO


--IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_Max_Faqs_FaqCatalogs') BEGIN
	--PRINT N'������ [Max_Faqs] ������'
	--ALTER TABLE [Max_Faqs] ADD CONSTRAINT [FK_Max_Faqs_FaqCatalogs] FOREIGN KEY ([FaqCatalogID]) REFERENCES [Max_FaqCatalogs] ([FaqCatalogID]) ON DELETE CASCADE ON UPDATE CASCADE
--END
--GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_Max_Faqs_FaqCatalogs') BEGIN
	PRINT N'������ [Max_Faqs] ������: FK_Max_Faqs_FaqCatalogs'
	ALTER TABLE [Max_Faqs]  WITH CHECK ADD  CONSTRAINT [FK_Max_Faqs_FaqCatalogs] FOREIGN KEY([FaqCatalogID])
	REFERENCES [Max_FaqCatalogs] ([FaqCatalogID])
	ON UPDATE CASCADE
	ON DELETE CASCADE
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_Max_Permissions_PermissionSchemes') BEGIN
	PRINT N'������ [System_Max_Permissions] ������'
	ALTER TABLE [System_Max_Permissions] ADD CONSTRAINT [FK_System_Max_Permissions_PermissionSchemes] FOREIGN KEY ([SchemeID]) REFERENCES [System_Max_PermissionSchemes] ([SchemeID]) ON DELETE CASCADE ON UPDATE CASCADE
END
GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_ChangeNickNameLogs') AND [name] ='IP') BEGIN
	PRINT N'������[Max_ChangeNickNameLogs]�����:[IP]';
	ALTER TABLE [Max_ChangeNickNameLogs] ADD [IP] [nvarchar] (15) COLLATE Chinese_PRC_CI_AS_WS DEFAULT N'127.0.0.1'
END
GO

IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('Max_PasswordRecoveryLogs') AND [name] ='IP') BEGIN
	PRINT N'������[Max_PasswordRecoveryLogs]�����:[IP]';
	ALTER TABLE [Max_PasswordRecoveryLogs] ADD [IP] [nvarchar] (15) COLLATE Chinese_PRC_CI_AS_WS DEFAULT N'127.0.0.1'
END
GO

-- �ƻ����� --
DELETE [Max_Jobs] 
SET IDENTITY_INSERT [Max_Jobs] ON

INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (1, N'zzbird.Common', N'zzbird.Common.Emails.SendEmailJob', convert(text, N'3' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (2, N'zzbird.Common', N'zzbird.Common.Emails.CheckEmailJob', convert(text, N'15' collate Chinese_PRC_CI_AS), 0, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
INSERT [Max_Jobs] ([JobID], [AssemblyName], [TypeName], [ExecuteTimeString], [TimeType], [IsEnabled], [LastExecuteTime], [IsSystem]) VALUES (3, N'zzbird.Common', N'zzbird.Common.Disk.DeleteTempDirectoryJob',convert(text, N'2,0,0' collate Chinese_PRC_CI_AS), 2, 1, CAST(0xFFFF2E4600000000 AS DateTime), 1)
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
GO

-- �޸�Ĭ�Ϲ����ʾ�ߴ� --
IF EXISTS(SELECT * FROM [Max_Advertisements] WHERE [AdvertisementID]=1 AND CAST([AdvertisementCode] AS VARCHAR(8000))=N'<a href="http://www.bbsmax.com" target="_blank"><img src="$root/Images/A/top_banner.gif" width="422" height="61" title="bbsMax��ʽ��:http://www.bbsmax.com" /></a>')
	UPDATE [Max_Advertisements] SET [AdvertisementCode]=N'<a href="http://www.bbsmax.com" target="_blank"><img src="$root/Images/A/top_banner.gif" width="468" height="60" title="bbsMax��ʽ��:http://www.bbsmax.com" /></a>' WHERE [AdvertisementID]=1;
GO


--- bbsmax �����ű� ----------------------------------------------------------
IF NOT EXISTS(SELECT * FROM syscolumns WHERE [id] =object_id('bbsMax_ThreadManageLogs') AND [name] ='PostUserID')
	ALTER TABLE [bbsMax_ThreadManageLogs] ADD  [PostUserID] [int] NOT NULL CONSTRAINT [DF_bbsMax_ThreadManageLogs_PostUserID] DEFAULT ((0))

GO

IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_bbsMax_Permissions_PermissionSchemes') BEGIN
	PRINT N'����ɾ�� [System_bbsMax_Permissions] �����'
	ALTER TABLE [System_bbsMax_Permissions] DROP CONSTRAINT [FK_System_bbsMax_Permissions_PermissionSchemes]
END
GO


IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_bbsMax_PermissionSchemes') BEGIN
	PRINT N'����ɾ�� [System_bbsMax_PermissionSchemes] ��Լ��'
	ALTER TABLE [System_bbsMax_PermissionSchemes] DROP CONSTRAINT [PK_System_bbsMax_PermissionSchemes]
END
GO


IF EXISTS(SELECT * FROM sysindexes WHERE [id]=object_id('System_bbsMax_PermissionSchemes') AND [name]='IX_System_bbsMax_PermissionSchemes') BEGIN
	PRINT N'����ɾ�� [System_bbsMax_PermissionSchemes] ������ [IX_System_bbsMax_PermissionSchemes]'
	DROP INDEX [System_bbsMax_PermissionSchemes].[IX_System_bbsMax_PermissionSchemes]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='PK_System_bbsMax_PermissionSchemes') BEGIN
	PRINT N'���� [System_bbsMax_PermissionSchemes] �ϴ������� [PK_System_bbsMax_PermissionSchemes]'
	ALTER TABLE [System_bbsMax_PermissionSchemes] ADD CONSTRAINT [PK_System_bbsMax_PermissionSchemes] PRIMARY KEY CLUSTERED  ([SchemeID]) ON [PRIMARY]
END
GO


IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_System_bbsMax_Permissions_PermissionSchemes') BEGIN
	PRINT N'������ [System_bbsMax_Permissions] ������'
	ALTER TABLE [System_bbsMax_Permissions] ADD CONSTRAINT [FK_System_bbsMax_Permissions_PermissionSchemes] FOREIGN KEY ([SchemeID]) REFERENCES [System_bbsMax_PermissionSchemes] ([SchemeID]) ON DELETE CASCADE ON UPDATE CASCADE
END
GO

IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_bbsMax_KeyWord_NewKeyWord') BEGIN
	PRINT N'���ڴ� [bbsMax_Keywords] ɾ��Ĭ��ֵԼ��: DF_bbsMax_KeyWord_NewKeyWord'
	ALTER TABLE [bbsMax_Keywords] DROP CONSTRAINT [DF_bbsMax_KeyWord_NewKeyWord]
END
GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='DF_bbsMax_KeyWord_NewKeyWord') BEGIN
	PRINT N'������ [bbsMax_Keywords]���Ĭ��ֵԼ��: DF_bbsMax_KeyWord_NewKeyWord'
	ALTER TABLE [bbsMax_Keywords] ADD  CONSTRAINT [DF_bbsMax_KeyWord_NewKeyWord]  DEFAULT (('')) FOR [Replacement]
END
GO

--PRINT N'�����޸Ļ���Ĭ�Ϲ�ʽ';
--EXEC [bbsMax_UpdatePointsExpression] N'(CONVERT([bigint],[ExtendedPoints_1],(0))+CONVERT([bigint],[ExtendedPoints_2],(0)))';
--GO

IF EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_bbsMax_Polemizes_bbsMax_Threads') BEGIN
	PRINT N'���ڴ�[bbsMax_Polemizes]��ɾ�����Լ��[FK_bbsMax_Polemizes_bbsMax_Threads]'
	ALTER TABLE [bbsMax_Polemizes] DROP CONSTRAINT [FK_bbsMax_Polemizes_bbsMax_Threads]
END
GO

IF NOT EXISTS(SELECT * FROM sysconstraints WHERE object_name(sysconstraints.constid)='FK_bbsMax_Polemizes_bbsMax_Threads') BEGIN
	PRINT N'������[bbsMax_Polemizes]������Լ��[FK_bbsMax_Polemizes_bbsMax_Threads]'
	ALTER TABLE [bbsMax_Polemizes]  WITH CHECK ADD  CONSTRAINT [FK_bbsMax_Polemizes_bbsMax_Threads] FOREIGN KEY([ThreadID]) REFERENCES [bbsMax_Threads] ([ThreadID]) ON UPDATE CASCADE ON DELETE CASCADE
END
GO