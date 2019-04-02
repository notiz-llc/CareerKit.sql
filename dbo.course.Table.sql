USE [career]
GO
/****** Object:  Table [dbo].[course]    Script Date: 4/1/2019 8:48:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[course](
	[course_id] [int] NOT NULL,
	[Instructor ID] [int] NULL,
	[Persian Title] [nvarchar](255) NULL,
	[English Title] [nvarchar](255) NULL,
	[Category] [nvarchar](255) NULL,
	[20 Scale Grade] [float] NULL,
	[Letter Grade] [nvarchar](255) NULL,
	[4 Scale Grade] [float] NULL,
	[Credit] [float] NULL,
	[Effective Credit] [float] NULL,
	[SSMA_TimeStamp] [timestamp] NOT NULL,
 CONSTRAINT [PK_course] PRIMARY KEY CLUSTERED 
(
	[course_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
