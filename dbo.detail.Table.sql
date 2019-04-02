USE [career]
GO
/****** Object:  Table [dbo].[detail]    Script Date: 4/1/2019 8:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detail](
	[detail_id] [int] NOT NULL,
	[detail] [nchar](10) NULL,
	[category_id] [nchar](10) NULL,
	[time] [datetime2](0) NULL,
 CONSTRAINT [PK_detail] PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
