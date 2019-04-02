USE [career]
GO
/****** Object:  Table [dbo].[entity]    Script Date: 4/1/2019 8:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[entity](
	[entity_id] [int] IDENTITY(1,1) NOT NULL,
	[contact_id] [int] NULL,
	[organization] [varchar](50) NULL,
	[department] [varchar](50) NULL,
	[prefix] [varchar](50) NULL,
	[first_name] [varchar](50) NULL,
	[middle_name] [varchar](50) NULL,
	[last_name] [varchar](50) NULL,
	[suffix] [varchar](50) NULL,
	[birth_date] [datetime2](0) NULL,
 CONSTRAINT [PK_entity] PRIMARY KEY CLUSTERED 
(
	[entity_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_entity] UNIQUE NONCLUSTERED 
(
	[organization] ASC,
	[department] ASC,
	[last_name] ASC,
	[first_name] ASC,
	[middle_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[entity]  WITH CHECK ADD  CONSTRAINT [CK_entity] CHECK  (([organization] IS NULL OR [last_name] IS NULL))
GO
ALTER TABLE [dbo].[entity] CHECK CONSTRAINT [CK_entity]
GO
