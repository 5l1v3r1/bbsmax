﻿EXEC bx_Drop 'FK_bx_ChatMessages_UserID';

ALTER TABLE [bx_ChatMessages]  WITH CHECK ADD  CONSTRAINT [FK_bx_ChatMessages_UserID] FOREIGN KEY([UserID])
REFERENCES [bx_Users] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE