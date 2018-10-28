USE Terrorism
GO
/****** Object:  StoredProcedure [dbo].[insertManyToMany1]  ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Creati o procedura stocata ce insereaza date pentru entitati ce se afla într-o relatie m-n.--Daca o operatie de inserare esueaza, trebuie facut roll-back pe întreaga procedura stocata. (nota: 3)

create PROCEDURE insertManyToMany
(
	@terroristName varChar(50)='ter',
	@terroristBirthDay date='01-Jan-00 12:00:00 AM',
	@terroristCountry varchar(50)='co',
	
	@incidentCountry varchar(50)='ntry',
	@incidentCity varchar(50)='cty'
)
AS
BEGIN

	DECLARE @id_terrorist int
	DECLARE @id_incident int
	DECLARE @error_id int
	DECLARE @error_chain varchar(200)=''

	BEGIN TRY
		
		SET @error_id = dbo.checkFormatName(@terroristName);
		if( @error_id = 0)
			SET @error_chain += 'Name format is wrong; ';
		
		PRINT(@error_chain);
		if LEN(@error_chain) > 0
		BEGIN
			
			RAISERROR(@error_chain,17,1);
		END

		BEGIN TRAN
			INSERT INTO Terrorists(name,birth_date,country) VALUES (@terroristName,@terroristBirthDay,@terroristCountry);
			SET @id_terrorist = IDENT_CURRENT( 'dbo.Terrorists' );
			INSERT INTO Incidents(country,city) VALUES (@incidentCountry,@incidentCity);
			SET @id_incident = IDENT_CURRENT( 'dbo.Incidents' );
			INSERT INTO Attacks(terrorist_id,incident_id) VALUES (@id_terrorist,@id_incident);
			print('The transaction succeded!');
	    COMMIT TRAN
		
	END TRY

	
	BEGIN CATCH
		IF @@TRANCOUNT > 0
			ROLLBACK TRAN
			exec usp_GetErrorInfo
END CATCH
END