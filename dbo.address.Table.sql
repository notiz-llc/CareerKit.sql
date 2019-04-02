USE [career]
GO
/****** Object:  Table [dbo].[address]    Script Date: 4/1/2019 8:48:35 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[address](
	[address_id] [int] IDENTITY(1,1) NOT NULL,
	[street] [varchar](255) NULL,
	[city] [varchar](50) NULL,
	[state_id] [char](2) NULL,
	[country_id] [char](2) NULL,
	[zip] [varchar](50) NULL,
 CONSTRAINT [PK_address] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_address] UNIQUE NONCLUSTERED 
(
	[country_id] ASC,
	[state_id] ASC,
	[city] ASC,
	[zip] ASC,
	[street] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[address]  WITH CHECK ADD  CONSTRAINT [FK_address_country] FOREIGN KEY([country_id])
REFERENCES [dbo].[country] ([country_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[address] CHECK CONSTRAINT [FK_address_country]
GO
/****** Object:  Trigger [dbo].[new_address]    Script Date: 4/1/2019 8:48:36 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[new_address]
   ON  [dbo].[address]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for trigger here
	INSERT INTO address (city, country_id, state_id, street, zip)
	SELECT i.city, i.country_id, i.state_id, i.street, i.zip
	FROM dbo.address a right outer join
		inserted i on a.city = i.city and a.country_id = i.country_id and a.state_id =i.state_id and a.street =i.street and a.zip =i.zip
	WHERE a.address_id is null
END
GO
ALTER TABLE [dbo].[address] ENABLE TRIGGER [new_address]
GO
