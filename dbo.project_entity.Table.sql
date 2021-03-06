USE [career]
GO
/****** Object:  Table [dbo].[project_entity]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_entity](
	[project_id] [int] NOT NULL,
	[entity_id] [int] NOT NULL,
	[category_id] [int] NULL,
	[started] [datetime2](0) NULL,
	[ended] [datetime2](0) NULL,
 CONSTRAINT [PK_project_entity] PRIMARY KEY CLUSTERED 
(
	[project_id] ASC,
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[project_entity]  WITH CHECK ADD  CONSTRAINT [FK_project_entity_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[project_entity] CHECK CONSTRAINT [FK_project_entity_category]
GO
ALTER TABLE [dbo].[project_entity]  WITH CHECK ADD  CONSTRAINT [FK_project_entity_project] FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([project_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[project_entity] CHECK CONSTRAINT [FK_project_entity_project]
GO
