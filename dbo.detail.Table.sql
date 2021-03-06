USE [career]
GO
/****** Object:  Table [dbo].[detail]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[detail](
	[detail_id] [int] NOT NULL,
	[detail] [nchar](10) NULL,
	[category_id] [nchar](10) NULL,
	[time] [datetime2](0) NULL,
	[temp_id] [int] NULL,
 CONSTRAINT [PK_detail] PRIMARY KEY CLUSTERED 
(
	[detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[detail] ADD  CONSTRAINT [DF_detail_time]  DEFAULT (getdate()) FOR [time]
GO
