USE Terrorism
GO
/****** Object:  StoredProcedure [dbo].[insertManyToMany2]     ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--Creati o procedura stocata ce insereaza date pentru entitati ce se afla într-o relatie m-n.
--Daca o operatie de inserare esueaza va trebui sa se pastreze cât mai mult posibil din ceea
--ce s-a modificat pâna în acel moment. De exemplu, daca se incearca inserarea unei carti
--si a autorilor acesteia, iar autorii au fost inserati cu succes însa apare o problema la
--inserarea cartii, atunci sa se faca roll-back la inserarea de carte însa autorii acesteia sa
--ramâna în baza de date. (nota: 5)

create PROCEDURE insertManyToMany_2
(
	@foodName varChar(50)='pizza',
	@foodPrice float='30',
	@foodType varchar(50)='desert',
	@providerName varchar(50)='Bogdan',
	@providerPrice int='20',
	@providerCountry varchar(50)='Romania',
	@time int=1
)
AS 
BEGIN
	DECLARE @id_food int
	DECLARE @id_provider int	
	DECLARE @error_id int
	DECLARE @error_code int = 0 /*
								  1- if we cannot insert the provider
								  2- if we cannot insert the food*/
	DECLARE @error_chain varchar(200)=''


    BEGIN TRY


		-- First validate the input
		SET @error_id = dbo.checkFormatName(@foodName);
		if( @error_id = 0)
			SET @error_chain += 'Name format is wrong; ';
		
		SET @error_id = dbo.checkFormatName(@providerName);
		if( @error_id = 0)
			SET @error_chain += 'Name format is wrong; ';

		if LEN(@error_chain) > 0
		BEGIN
			RAISERROR(@error_chain,17,1);
		END

        BEGIN TRAN;
		-- Modify database.
			BEGIN TRY
				INSERT INTO Mancare(Nume,Pret,Tip) VALUES (@foodName,@foodPrice,@foodType);
				SET @id_food = IDENT_CURRENT( 'dbo.Mancare' );
			END TRY
			BEGIN CATCH
				RAISERROR('Cannot perform insert into the food table',17,1);
			END CATCH
			
			SAVE TRANSACTION InsertProviderSave

			BEGIN TRY
				INSERT INTO Furnizori([Nume Furnizor],[Pret furnizor],Tara) VALUES (@providerName,@providerPrice,@providerCountry);
				SET @id_provider = IDENT_CURRENT( 'dbo.Furnizori' );
			END TRY
			
			BEGIN CATCH
				SET @error_code = 1
				RAISERROR('Cannot perform insert into provider table',17,1);
			END CATCH

			SAVE TRANSACTION InsertFoodProviderSave

			BEGIN TRY
				INSERT INTO [Furnizor-Mancare](MancareId,FurnizorId) VALUES (@id_food,@id_provider);
			END TRY
			BEGIN CATCH
				SET @error_code = 2
				RAISERROR('Cannot perform insert into food-provider table',17,1);
			END CATCH
		

		
        COMMIT TRANSACTION
		print('The transaction succeded!')

	END TRY

	BEGIN CATCH
	
	
			if @@TRANCOUNT > 0
			BEGIN
				IF (@error_code = 1)
				BEGIN
					-- Cannot perform the second insert
					-- we roll back to that point, but we 
					-- keep the changes for the first insert
					ROLLBACK TRANSACTION InsertProviderSave
					exec usp_GetErrorInfo
					commit TRANSACTION
				END
				ELSE IF (@error_code =2 )
				BEGIN
					-- Cannot perform the third insert
					-- we roll back to that point, but we 
					-- keep the changes for the first and second insert
					ROLLBACK TRANSACTION InsertFoodProviderSave
					exec usp_GetErrorInfo 
					commit TRANSACTION
				END
				ELSE 
					BEGIN
					
					exec usp_GetErrorInfo
					ROLLBACK TRANSACTION 
					commit TRANSACTION
					
					END
			END

			ELSE

			-- An validation error occurred; must print them all
			BEGIN
				exec usp_GetErrorInfo
				
			END
		END CATCH
	
END