USE [career]
GO
/****** Object:  StoredProcedure [dbo].[AddEntity]    Script Date: 4/2/2019 7:47:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddEntity]
	-- Add the parameters for the stored procedure here
	@entity varchar(50), 
	@columns varchar(50),
	@values varchar (Max)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @sql varchar(Max)
	DECLARE @where varchar(Max)
	DECLARE @ID int
	DECLARE @i int
	DECLARE @l int
	SET @i = 1
	SET @l = (LEN(@columns) - LEN(REPLACE(@columns,':::','')))/3 + 1
	SET @where = ''

	-- Add the T-SQL statements to compute the return value here
	SET @sql = 'INSERT INTO [' + @entity + '(s)] ([' + REPLACE(@columns,':::','],[')+'])'+
			   ' SELECT ' + REPLACE(@values,':::',',') + ' EXCEPT SELECT [' + REPLACE(@columns,':::','],[') + '] FROM [' + @entity + '(s)]'
	EXEC(@sql)
	
	WHILE @i<=@l
	BEGIN
		IF @i<@l
		BEGIN
			SET @where=@where + '[' + (SELECT left(@columns,charindex(':::',@columns)-1) + ']=' + left(@values,charindex(':::',@values)-1) + ' AND ')
			SET @columns=right(@columns,len(@columns) - charindex(':::',@columns)-2)
			SET @values=right(@values,len(@values) - charindex(':::',@values)-2)
		END
		ELSE
		BEGIN
			SET @where=@where + '[' + @columns + ']=' + @values
		END
		SET @i=@i+1
	END
	SET @sql = 'SELECT [' + @entity + ' ID] FROM [' + @entity + '(s)] WHERE ' + @where 
	EXEC(@sql)

END
GO
