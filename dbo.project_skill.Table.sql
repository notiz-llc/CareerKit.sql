USE [career]
GO
/****** Object:  Table [dbo].[project_skill]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[project_skill](
	[project_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
	[category_id] [int] NULL,
	[happened] [datetime2](0) NULL,
 CONSTRAINT [PK_project_skill] PRIMARY KEY CLUSTERED 
(
	[project_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[project_skill]  WITH CHECK ADD  CONSTRAINT [FK_project_skill_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[project_skill] CHECK CONSTRAINT [FK_project_skill_category]
GO
ALTER TABLE [dbo].[project_skill]  WITH CHECK ADD  CONSTRAINT [FK_project_skill_project] FOREIGN KEY([project_id])
REFERENCES [dbo].[project] ([project_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[project_skill] CHECK CONSTRAINT [FK_project_skill_project]
GO
ALTER TABLE [dbo].[project_skill]  WITH CHECK ADD  CONSTRAINT [FK_project_skill_skill] FOREIGN KEY([skill_id])
REFERENCES [dbo].[skill] ([skill_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[project_skill] CHECK CONSTRAINT [FK_project_skill_skill]
GO
