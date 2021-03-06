USE [career]
GO
/****** Object:  Table [dbo].[course_entity]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course_entity](
	[course_id] [int] NOT NULL,
	[entity_id] [int] NOT NULL,
	[category_id] [int] NULL,
	[contact_id] [int] NULL,
	[certificate_id] [int] NULL,
	[started] [datetime2](0) NULL,
	[ended] [datetime2](0) NULL,
 CONSTRAINT [PK_course_entity] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC,
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[course_entity]  WITH CHECK ADD  CONSTRAINT [FK_course_entity_category] FOREIGN KEY([contact_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[course_entity] CHECK CONSTRAINT [FK_course_entity_category]
GO
ALTER TABLE [dbo].[course_entity]  WITH CHECK ADD  CONSTRAINT [FK_course_entity_certificate] FOREIGN KEY([certificate_id])
REFERENCES [dbo].[certificate] ([certificate_id])
GO
ALTER TABLE [dbo].[course_entity] CHECK CONSTRAINT [FK_course_entity_certificate]
GO
ALTER TABLE [dbo].[course_entity]  WITH CHECK ADD  CONSTRAINT [FK_course_entity_contact] FOREIGN KEY([contact_id])
REFERENCES [dbo].[contact] ([contact_id])
GO
ALTER TABLE [dbo].[course_entity] CHECK CONSTRAINT [FK_course_entity_contact]
GO
ALTER TABLE [dbo].[course_entity]  WITH CHECK ADD  CONSTRAINT [FK_course_entity_course] FOREIGN KEY([course_id])
REFERENCES [dbo].[course] ([course_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[course_entity] CHECK CONSTRAINT [FK_course_entity_course]
GO
