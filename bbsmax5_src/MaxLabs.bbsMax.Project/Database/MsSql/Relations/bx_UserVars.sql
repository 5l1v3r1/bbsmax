﻿EXEC bx_Drop 'FK_bx_UserVars_UserID';

ALTER TABLE [bx_UserVars]  WITH CHECK ADD  CONSTRAINT [FK_bx_UserVars_UserID] FOREIGN KEY([UserID])
REFERENCES [bx_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE