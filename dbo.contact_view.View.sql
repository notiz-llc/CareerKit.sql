USE [career]
GO
/****** Object:  View [dbo].[contact_view]    Script Date: 4/1/2019 8:35:06 PM ******/
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
