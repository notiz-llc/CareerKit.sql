USE [career]
GO
/****** Object:  View [dbo].[contact_view]    Script Date: 4/1/2019 8:48:35 PM ******/
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
/****** Object:  Trigger [dbo].[new_contact]    Script Date: 4/1/2019 8:48:37 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE TRIGGER [dbo].[new_contact]
   ON  [dbo].[contact_view]
   INSTEAD OF INSERT
AS 
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @pos TABLE
	(
		position_id int
	)
	DECLARE @e1 TABLE
	(
		entity_id int
	)
	DECLARE @e2 TABLE
	(
		entity_id int
	)
	DECLARE @bco TABLE
	(
		contact_id int
	)
	DECLARE @pco TABLE
	(
		contact_id int
	)
	insert into phone(area_code,country_code,extension,number)
	select personal_area_code,personal_country_code,personal_extension,personal_number
	from inserted;

	insert into phone(area_code,country_code,extension,number)
	select business_area_code, business_country_code, business_extension, business_number
	from inserted;

	insert into address(city,country_id,state_id,street,zip)
	select personal_city,personal_country,personal_state,personal_street,personal_zip
	from inserted

	insert into address(city,country_id,state_id,street,zip)
	select business_city,business_country,business_state,business_street,business_zip
	from inserted

	insert into email(email)
	select personal_email
	from inserted

	insert into email(email)
	select business_email
	from inserted

	insert into url(url)
	select personal_url
	from inserted

	insert into url(url)
	select business_url
	from inserted

	insert into position(position)
	output inserted.position_id into @pos
	select title
	from inserted
	where title is not null

	insert into contact(phone_id,email_id,url_id,address_id)
	output inserted.contact_id into @pco
	select ph1.phone_id,em1.email_id,ur1.url_id,ad1.address_id
	from inserted ii left outer join
		phone ph1 on ph1.area_code = isnull(ii.personal_area_code,ph1.area_code) and ph1.country_code = ii.personal_country_code and ph1.extension = isnull(ii.personal_extension,ph1.extension) and ph1.number = ii.personal_number left outer join
		address ad1 on ad1.city = isnull(ii.personal_city,ad1.city) and ad1.country_id = isnull(ii.personal_country,ad1.country_id) and ad1.state_id = isnull(ii.personal_state,ad1.state_id) and ad1.street = isnull(ii.personal_street,ad1.street) and ad1.zip = isnull(ii.personal_zip,ad1.zip) left outer join
		email em1 on em1.email = ii.personal_email left outer join
		url ur1 on ur1.url = ii.personal_url

	insert into contact(phone_id,email_id,url_id,address_id)
	output inserted.contact_id into @bco
	select  ph2.phone_id,em2.email_id,ur2.url_id,ad2.address_id
	from inserted ii left outer join
		phone ph2 on ph2.area_code = isnull(ii.business_area_code,ph2.area_code) and ph2.country_code = ii.business_country_code and ph2.extension = isnull(ii.business_extension,ph2.extension) and ph2.number = ii.business_number left outer join
		address ad2 on ad2.city = isnull(ii.business_city,ad2.city) and ad2.country_id = isnull(ii.business_country,ad2.country_id) and ad2.state_id = isnull(ii.business_state,ad2.state_id) and ad2.street = isnull(ii.business_street,ad2.street) and ad2.zip = isnull(ii.business_zip,ad2.zip) left outer join
		email em2 on em2.email = ii.business_email left outer join
		url ur2 on ur2.url = ii.business_url

	insert into entity (organization, department)
	output inserted.entity_id into @e2
	select organization, department
	from inserted

	insert into entity (prefix,first_name,middle_name,last_name,suffix,birth_date)
	output inserted.entity_id into @e1
	select prefix,first_name,middle_name,last_name,suffix,birth_date
	from inserted

	insert into position_entity(position_id,entity_id,category_id,contact_id)
	values((select TOP 1 position_id from @pos),(select TOP 1 entity_id from @e1),104,(select TOP 1 contact_id from @bco))

	insert into position_entity(position_id,entity_id,category_id,contact_id)
	values((select TOP 1 position_id from @pos),(select TOP 1 entity_id from @e2),20,(select TOP 1 contact_id from @bco))

	update entity
	set contact_id = (select TOP 1 contact_id from @pco)
	where entity_id = (select TOP 1 entity_id from @e1)

	if (select TOP 1 last_name from inserted) is null
		update entity
		set contact_id = (select TOP 1 contact_id from @bco)
		where entity_id = (select TOP 1 entity_id from @e2)

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
