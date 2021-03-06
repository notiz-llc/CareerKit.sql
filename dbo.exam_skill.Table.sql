USE [career]
GO
/****** Object:  Table [dbo].[exam_skill]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam_skill](
	[exam_id] [int] NOT NULL,
	[skill_id] [int] NOT NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_exam_skill] PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC,
	[skill_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[exam_skill]  WITH CHECK ADD  CONSTRAINT [FK_exam_skill_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[exam_skill] CHECK CONSTRAINT [FK_exam_skill_category]
GO
ALTER TABLE [dbo].[exam_skill]  WITH CHECK ADD  CONSTRAINT [FK_exam_skill_exam] FOREIGN KEY([exam_id])
REFERENCES [dbo].[exam] ([exam_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exam_skill] CHECK CONSTRAINT [FK_exam_skill_exam]
GO
ALTER TABLE [dbo].[exam_skill]  WITH CHECK ADD  CONSTRAINT [FK_exam_skill_skill] FOREIGN KEY([skill_id])
REFERENCES [dbo].[skill] ([skill_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exam_skill] CHECK CONSTRAINT [FK_exam_skill_skill]
GO
