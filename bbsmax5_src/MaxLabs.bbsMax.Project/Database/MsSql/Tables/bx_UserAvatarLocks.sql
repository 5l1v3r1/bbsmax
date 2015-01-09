﻿--CREATE TABLE bx_UserAvatarLocks (
	--[UserID]				int											NOT NULL	PRIMARY KEY CONSTRAINT [DF_bx_UserAvatarLocks_UserID]			DEFAULT(0)	
    --,[AvatarLockAt]			datetime									NOT NULL				CONSTRAINT [DF_bx_UserAvatarLocks_AvatarLockAt]		DEFAULT(GETDATE())
    --,[AvatarLockTo]			datetime									NOT NULL				CONSTRAINT [DF_bx_UserAvatarLocks_AvatarLockTo]		DEFAULT(GETDATE())
    --,[AvatarLockReason]		nvarchar(512) COLLATE Chinese_PRC_CI_AS_WS	NOT NULL				CONSTRAINT [DF_bx_UserAvatarLocks_AvatarLockReason]	DEFAULT('')
    --,[OldAvatarSrc]         nvarchar(200) COLLATE Chinese_PRC_CI_AS_WS	NOT NULL				CONSTRAINT [DF_bx_UserAvatarLocks_OldAvatarSrc]		DEFAULT('')
 --)