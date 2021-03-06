USE [career]
GO
/****** Object:  View [dbo].[contact_view]    Script Date: 4/2/2019 7:47:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[contact_view]
AS
SELECT        ee.entity_id, iif(ee.last_name IS NULL, ee.organization, aff.organization) AS organization, iif(ee.last_name IS NULL, ee.department, aff.department) AS department, iif(ee.last_name IS NULL, NULL, aff.position) AS title, ee.prefix, ee.first_name, ee.middle_name, ee.last_name, 
                         ee.suffix, ee.birth_date, p.country_code AS personal_country_code, p.area_code AS personal_area_code, p.number AS personal_number, p.extension AS personal_extension, em.email AS personal_email, 
                         a.street AS personal_street, a.city AS personal_city, a.state_id AS personal_state, a.country_id AS personal_country, a.zip AS personal_zip, u.url AS personal_url, pp.country_code AS business_country_code, 
                         pp.area_code AS business_area_code, pp.number AS business_number, pp.extension AS business_extension, eemm.email AS business_email, aa.street AS business_street, aa.city AS business_city, 
                         aa.state_id AS business_state, aa.country_id AS business_country, aa.zip AS business_zip, uu.url AS business_url
FROM            dbo.entity AS ee LEFT OUTER JOIN
                             (SELECT        pe1.entity_id, po.position, e.organization, e.department, pe1.contact_id, ROW_NUMBER() OVER (PARTITION BY pe1.entity_id
                               ORDER BY pe1.started DESC) AS r
FROM            dbo.position_entity AS pe1 INNER JOIN
                         dbo.position_entity AS pe2 ON pe1.position_id = pe2.position_id INNER JOIN
                         dbo.entity AS e ON pe2.entity_id = e.entity_id inner join
						 dbo.position as po on pe1.position_id = po.position_id
WHERE        (pe1.category_id = 104) AND (pe2.category_id = 20) AND (e.organization IS NOT NULL)) AS aff ON ee.entity_id = aff.entity_id LEFT OUTER JOIN
dbo.contact AS c ON ee.contact_id = c.contact_id LEFT OUTER JOIN
dbo.contact AS cc ON aff.contact_id = cc.contact_id LEFT OUTER JOIN
dbo.phone AS p ON c.phone_id = p.phone_id LEFT OUTER JOIN
dbo.phone AS pp ON cc.phone_id = pp.phone_id LEFT OUTER JOIN
dbo.email AS em ON c.email_id = em.email_id LEFT OUTER JOIN
dbo.email AS eemm ON cc.email_id = eemm.email_id LEFT OUTER JOIN
dbo.address AS a ON c.address_id = a.address_id LEFT OUTER JOIN
dbo.address AS aa ON cc.address_id = aa.address_id LEFT OUTER JOIN
dbo.url AS u ON c.url_id = u.url_id LEFT OUTER JOIN
dbo.url AS uu ON cc.url_id = uu.url_id
WHERE        aff.r = 1 OR
                         aff.r IS NULL
GO
/****** Object:  Trigger [dbo].[new_contact_view]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Hanif Tiznobake
-- Create date: 04/01/2019
-- Description:	Distributes new entity/contact data between relevant tables.
-- =============================================
CREATE TRIGGER [dbo].[new_contact_view]
   ON  [dbo].[contact_view]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	declare @temp TABLE
	([temp_id] int NOT NULL
      ,[organization] varchar(50) NULL
      ,[department] varchar(50) NULL
      ,[title] varchar(50) NULL
      ,[prefix] varchar(50) NULL
      ,[first_name] varchar(50) NULL
      ,[middle_name] varchar(50) NULL
      ,[last_name] varchar(50) NULL
      ,[suffix] varchar(50) NULL
      ,[birth_date] datetime2(0) NULL
      ,[personal_country_code] int NULL
      ,[personal_area_code] int NULL
      ,[personal_number] int NULL
      ,[personal_extension] int NULL
      ,[personal_email] varchar(50) NULL
      ,[personal_street] varchar(255) NULL
      ,[personal_city] varchar(50) NULL
      ,[personal_state] char(2) NULL
      ,[personal_country] char(2) NULL
      ,[personal_zip] varchar(50) NULL
      ,[personal_url] varchar(Max) NULL
      ,[business_country_code] int NULL
      ,[business_area_code] int NULL
      ,[business_number] int NULL
      ,[business_extension] int NULL
      ,[business_email] varchar(50) NULL
      ,[business_street] varchar(255) NULL
      ,[business_city] varchar(50) NULL
      ,[business_state] char(2) NULL
      ,[business_country] char(2) NULL
      ,[business_zip] varchar(50) NULL
      ,[business_url] varchar(Max) NULL
	)
	INSERT into @temp(temp_id,
	[organization]
      ,[department]
      ,[title]
      ,[prefix]
      ,[first_name]
      ,[middle_name]
      ,[last_name]
      ,[suffix]
      ,[birth_date]
      ,[personal_country_code]
      ,[personal_area_code]
      ,[personal_number]
      ,[personal_extension]
      ,[personal_email]
      ,[personal_street]
      ,[personal_city]
      ,[personal_state]
      ,[personal_country]
      ,[personal_zip]
      ,[personal_url]
      ,[business_country_code]
      ,[business_area_code]
      ,[business_number]
      ,[business_extension]
      ,[business_email]
      ,[business_street]
      ,[business_city]
      ,[business_state]
      ,[business_country]
      ,[business_zip]
      ,[business_url])
	select ROW_NUMBER() OVER (ORDER BY organization, last_name) as temp_id,
	[organization]
      ,[department]
      ,[title]
      ,[prefix]
      ,[first_name]
      ,[middle_name]
      ,[last_name]
      ,[suffix]
      ,[birth_date]
      ,[personal_country_code]
      ,[personal_area_code]
      ,[personal_number]
      ,[personal_extension]
      ,[personal_email]
      ,[personal_street]
      ,[personal_city]
      ,[personal_state]
      ,[personal_country]
      ,[personal_zip]
      ,[personal_url]
      ,[business_country_code]
      ,[business_area_code]
      ,[business_number]
      ,[business_extension]
      ,[business_email]
      ,[business_street]
      ,[business_city]
      ,[business_state]
      ,[business_country]
      ,[business_zip]
      ,[business_url] from inserted

	DECLARE @pos TABLE
	(
		temp_id int,
		position_id int
	)
	DECLARE @e1 TABLE
	(
		temp_id int,
		entity_id int
	)
	DECLARE @e2 TABLE
	(
		temp_id int,
		entity_id int
	)
	DECLARE @bco TABLE
	(
		temp_id int,
		contact_id int
	)
	DECLARE @pco TABLE
	(
		temp_id int,
		contact_id int
	)

	insert into phone(area_code,country_code,extension,number)
	select personal_area_code,personal_country_code,personal_extension,personal_number
	from @temp

	insert into phone(area_code,country_code,extension,number)
	select business_area_code, business_country_code, business_extension, business_number
	from @temp;

	insert into address(city,country_id,state_id,street,zip)
	select personal_city,personal_country,personal_state,personal_street,personal_zip
	from @temp

	insert into address(city,country_id,state_id,street,zip)
	select business_city,business_country,business_state,business_street,business_zip
	from @temp

	insert into email(email)
	select personal_email
	from @temp

	insert into email(email)
	select business_email
	from @temp

	insert into url(url)
	select personal_url
	from @temp

	insert into url(url)
	select business_url
	from @temp

	insert into position(temp_id,position)
	output inserted.temp_id, inserted.position_id into @pos(temp_id,position_id)
	select temp_id, title
	from @temp

	insert into contact(temp_id,phone_id,email_id,url_id,address_id)
	output inserted.temp_id, inserted.contact_id into @pco
	select ii.temp_id, ph1.phone_id,em1.email_id,ur1.url_id,ad1.address_id
	from @temp ii left outer join
		phone ph1 on isnull(ii.personal_area_code,-1)=isnull(ph1.area_code,-1) and isnull(ph1.country_code,-1) = isnull(ii.personal_country_code,-1) and isnull(ph1.extension,-1) = isnull(ii.personal_extension,-1) and ph1.number = ii.personal_number left outer join
		address ad1 on isnull(ad1.city,-1) = isnull(ii.personal_city,-1) and ad1.country_id = ii.personal_country and isnull(ad1.state_id,-1) = isnull(ii.personal_state,-1) and isnull(ad1.street,-1) = isnull(ii.personal_street,-1) and isnull(ad1.zip,-1) = isnull(ii.personal_zip,-1) left outer join
		email em1 on em1.email = ii.personal_email left outer join
		url ur1 on ur1.url = ii.personal_url

	insert into contact(temp_id,phone_id,email_id,url_id,address_id)
	output inserted.temp_id, inserted.contact_id into @bco
	select ii.temp_id, ph2.phone_id,em2.email_id,ur2.url_id,ad2.address_id
	from @temp ii left outer join
		phone ph2 on isnull(ph2.area_code,-1) = isnull(ii.business_area_code,-1) and isnull(ph2.country_code,-1) = isnull(ii.business_country_code,-1) and isnull(ph2.extension,-1) = isnull(ii.business_extension,-1) and ph2.number = ii.business_number left outer join
		address ad2 on isnull(ad2.city,-1) = isnull(ii.business_city,-1) and ad2.country_id = ii.business_country and isnull(ad2.state_id,-1) = isnull(ii.business_state,-1) and isnull(ad2.street,-1) = isnull(ii.business_street,-1) and isnull(ad2.zip,-1) = isnull(ii.business_zip,-1) left outer join
		email em2 on em2.email = ii.business_email left outer join
		url ur2 on ur2.url = ii.business_url

	insert into entity (temp_id,organization, department)
	output inserted.temp_id, inserted.entity_id into @e2
	select t.temp_id, organization, department
	from @temp t

	insert into entity (temp_id,prefix,first_name,middle_name,last_name,suffix,birth_date, contact_id)
	output inserted.temp_id, inserted.entity_id into @e1
	select t.temp_id, prefix,first_name,middle_name,last_name,suffix,birth_date, p.contact_id
	from @temp t left outer join @pco p on t.temp_id = p.temp_id 

	insert into position_entity(position_id,entity_id,category_id,contact_id)
	select p.position_id, e.entity_id, 104, b.contact_id from @pos p inner join @e2 e on p.temp_id = e.temp_id left outer join @bco b on p.temp_id = b.temp_id
	
	insert into position_entity(position_id,entity_id,category_id,contact_id)
	select p.position_id, e.entity_id, 20, b.contact_id from @pos p inner join @e1 e on p.temp_id = e.temp_id left outer join @bco b on p.temp_id = b.temp_id


END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'contact_view'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'contact_view'
GO
