USE [career]
GO
/****** Object:  Table [dbo].[exam_detail]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam_detail](
	[exam_id] [int] NOT NULL,
	[detail_id] [int] NOT NULL,
	[category_id] [int] NULL,
 CONSTRAINT [PK_exam_detail] PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC,
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[exam_detail]  WITH CHECK ADD  CONSTRAINT [FK_exam_detail_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[exam_detail] CHECK CONSTRAINT [FK_exam_detail_category]
GO
ALTER TABLE [dbo].[exam_detail]  WITH CHECK ADD  CONSTRAINT [FK_exam_detail_detail] FOREIGN KEY([detail_id])
REFERENCES [dbo].[detail] ([detail_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exam_detail] CHECK CONSTRAINT [FK_exam_detail_detail]
GO
ALTER TABLE [dbo].[exam_detail]  WITH CHECK ADD  CONSTRAINT [FK_exam_detail_exam] FOREIGN KEY([exam_id])
REFERENCES [dbo].[exam] ([exam_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[exam_detail] CHECK CONSTRAINT [FK_exam_detail_exam]
GO
