﻿--/*
--用户表与最近访客表的视图
--*/
--CREATE VIEW bx_UserVisitors
--AS
--SELECT u.Gender, u.Points, u.TotalFriends,u.TotalViews,v.*
--FROM dbo.bx_Users u INNER JOIN
      --dbo.bx_Visitors v ON u.ID = v.VisitorUserID 
--GO
