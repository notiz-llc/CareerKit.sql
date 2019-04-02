USE [career]
GO
/****** Object:  Table [dbo].[position_entity]    Script Date: 4/1/2019 8:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[position_entity](
	[position_id] [int] NOT NULL,
	[entity_id] [int] NOT NULL,
	[category_id] [int] NULL,
	[contact_id] [int] NULL,
	[started] [datetime2](0) NULL,
	[ended] [datetime2](0) NULL,
 CONSTRAINT [PK_position_entity] PRIMARY KEY CLUSTERED 
(
	[position_id] ASC,
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[position_entity]  WITH CHECK ADD  CONSTRAINT [FK_position_entity_category] FOREIGN KEY([category_id])
REFERENCES [dbo].[category] ([category_id])
GO
ALTER TABLE [dbo].[position_entity] CHECK CONSTRAINT [FK_position_entity_category]
GO
ALTER TABLE [dbo].[position_entity]  WITH CHECK ADD  CONSTRAINT [FK_position_entity_contact] FOREIGN KEY([contact_id])
REFERENCES [dbo].[contact] ([contact_id])
GO
ALTER TABLE [dbo].[position_entity] CHECK CONSTRAINT [FK_position_entity_contact]
GO
ALTER TABLE [dbo].[position_entity]  WITH CHECK ADD  CONSTRAINT [FK_position_entity_position] FOREIGN KEY([position_id])
REFERENCES [dbo].[position] ([position_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[position_entity] CHECK CONSTRAINT [FK_position_entity_position]
GO
