USE [career]
GO
/****** Object:  Table [dbo].[certificate]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[certificate](
	[certificate_id] [int] NOT NULL,
	[certificate] [nvarchar](255) NOT NULL,
	[subject] [varchar](50) NULL,
	[organization_id] [int] NULL,
	[issuer] [varchar](50) NULL,
	[issued] [date] NULL,
	[expires] [date] NULL,
	[category_id] [int] NULL,
	[url_id] [int] NULL,
 CONSTRAINT [PK_certificate] PRIMARY KEY CLUSTERED 
(
	[certificate_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
