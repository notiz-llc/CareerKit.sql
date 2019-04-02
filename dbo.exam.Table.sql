USE [career]
GO
/****** Object:  Table [dbo].[exam]    Script Date: 4/1/2019 8:48:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[exam](
	[exam_id] [int] NOT NULL,
	[exam] [nvarchar](255) NOT NULL,
	[date] [datetime2](0) NULL,
	[detai] [nvarchar](255) NULL,
	[total] [float] NULL,
	[1] [float] NULL,
	[2] [float] NULL,
	[3] [float] NULL,
	[4] [float] NULL,
 CONSTRAINT [PK_exam] PRIMARY KEY CLUSTERED 
(
	[exam_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
