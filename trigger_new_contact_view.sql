USE [career]
GO
/****** Object:  Trigger [dbo].[new_contact]    Script Date: 3/29/2019 3:47:05 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
ALTER TRIGGER [dbo].[new_contact]
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
