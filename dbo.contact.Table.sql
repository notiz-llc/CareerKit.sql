USE [career]
GO
/****** Object:  Table [dbo].[contact]    Script Date: 4/1/2019 8:35:06 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[contact](
	[contact_id] [int] IDENTITY(1,1) NOT NULL,
	[email_id] [int] NULL,
	[url_id] [int] NULL,
	[phone_id] [int] NULL,
	[address_id] [int] NULL,
 CONSTRAINT [PK_contact] PRIMARY KEY CLUSTERED 
(
	[contact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_address] FOREIGN KEY([address_id])
REFERENCES [dbo].[address] ([address_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_address]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_email] FOREIGN KEY([email_id])
REFERENCES [dbo].[email] ([email_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_email]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_phone] FOREIGN KEY([phone_id])
REFERENCES [dbo].[phone] ([phone_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_phone]
GO
ALTER TABLE [dbo].[contact]  WITH CHECK ADD  CONSTRAINT [FK_contact_url] FOREIGN KEY([url_id])
REFERENCES [dbo].[url] ([url_id])
ON UPDATE SET NULL
ON DELETE SET NULL
GO
ALTER TABLE [dbo].[contact] CHECK CONSTRAINT [FK_contact_url]
GO
