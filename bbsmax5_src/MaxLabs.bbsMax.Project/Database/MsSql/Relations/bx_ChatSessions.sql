﻿EXEC bx_Drop 'FK_bx_ChatSessions_UserID';

ALTER TABLE [bx_ChatSessions]  WITH CHECK ADD  CONSTRAINT [FK_bx_ChatSessions_UserID] FOREIGN KEY([UserID])
REFERENCES [bx_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE