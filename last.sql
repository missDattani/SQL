USE [YansiViramgama325]
GO
/****** Object:  StoredProcedure [dbo].[Sp_AllInfo]    Script Date: 4/20/2023 4:35:15 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER   PROC [dbo].[Sp_AllInfo] (
	@Firstname VARCHAR(200),
	@Lastname VARCHAR(200),
	@Email VARCHAR(200),
	@UPassword VARCHAR(200),
	@UserType VARCHAR(200),
	@UAddress VARCHAR(200),
	@MobileNO BIGINT,
	@City VARCHAR(200)	,
	@Doctor VARCHAR(200),
	@Nurse VARCHAR(200),
	@Diagnosis VARCHAR(200),
	@TreatmentFee DECIMAL(10,2),
	@DOT DATE,
	@Instruction VARCHAR(200)
)
AS 
BEGIN 
	DECLARE 
	@Country VARCHAR(200),
	@State VARCHAR(200)
	SET @State = (SELECT S.StateName FROM States1 S INNER JOIN City1 C ON C.StateID = S.ID WHERE C.CityName = @City )
	SET @Country = (SELECT C.CountryName FROM Country1 C INNER JOIN City1 CT ON CT.CountryID = C.ID WHERE CT.CityName = @City )
	EXEC SP_InsertUser1 @Firstname,@Lastname,@Email,@UPassword,@UserType,@UAddress,@MobileNO,@Country,@State,@City

	
 
	DECLARE @ID INT,@Patient  VARCHAR(200)
	SET @ID = (SELECT dbo.LAST_INSERT_ID())
	SET @Patient =(SELECT U.Firstname FROM User1 U WHERE U.ID = @ID)
	EXEC SP_TreatmentDetails1 @Patient,@Doctor,@Nurse,@Diagnosis,@TreatmentFee,@DOT,@Instruction
	
	SELECT CONCAT(U.Firstname,' ',U.Lastname),
	@Doctor,@Nurse,dbo.Fn_Medicin_Diagnosis(@Diagnosis),@DOT,
	CONCAT(C.CityName,' ',S.StateName,' ',C1.CountryName),
	@MobileNO,CONCAT('Rs ',@TreatmentFee)
	FROM User1 U 
	INNER JOIN UserType1 UT ON U.UserTypeID = UT.ID 
	INNER JOIN TreatmentDetails1 TD ON U.ID = TD.PatientID 
	INNER JOIN City1 C ON U.CityID = C.ID
	INNER JOIN States1 S ON U.StateID = S.ID
	INNER JOIN Country1 C1 ON U.CountryID = C1.ID

END