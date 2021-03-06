SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[WorkItems](
	[WorkItemID] [int] IDENTITY(1,1) NOT NULL,
	[BindingKey] [nvarchar](1000) NOT NULL,
	[InnerMessage] [varbinary](max) NOT NULL,
	[TextData] [nvarchar](max) NULL,
 CONSTRAINT [PK_WorkItems] PRIMARY KEY CLUSTERED 
(
	[WorkItemId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[WorkItemStatus](
	[WorkItemID] [int] NOT NULL,
	[Status] [tinyint] NULL,
	[WakeTime] [datetime] NULL,
	[ClientID] [tinyint] NULL,
	[PurgeDate] [smalldatetime] NULL,
 CONSTRAINT [PK_workItemStatus] PRIMARY KEY CLUSTERED 
(
	[WorkItemID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

/****** Object:  Index [IX_workStatus_purgeDate]    Script Date: 11/25/2011 15:44:52 ******/
CREATE NONCLUSTERED INDEX [IX_workItemStatus_purgeDate] ON [dbo].[WorkItemStatus] 
(
	[PurgeDate] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO

/****** Object:  Index [IX_workStatus_status_wakeTime]    Script Date: 11/25/2011 15:44:52 ******/
CREATE NONCLUSTERED INDEX [IX_workItemStatus_status_wakeTime] ON [dbo].[WorkItemStatus] 
(
	[Status] ASC,
	[WakeTime] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[WorkItemStatus]  WITH CHECK ADD  CONSTRAINT [FK_WorkItemStatus_WorkItems] FOREIGN KEY([WorkItemID])
REFERENCES [dbo].[WorkItems] ([WorkItemID])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[WorkItemStatus] CHECK CONSTRAINT [FK_WorkItemStatus_WorkItems]
GO

