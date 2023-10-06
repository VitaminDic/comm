USE [RETAILRISK_LOS]
GO

/****** Object:  StoredProcedure [dbo].[SP_RMD_LOS_RP_SECURED_DUC]    Script Date: 06/10/2023 6:48:31 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================
-- Author:		duclhm
-- Create date: 29 sep 2023
-- Description: Rejection reason for Secured product
-- EXEC RETAILRISK_LOS.DBO.SP_RMD_LOS_RP_SECURED_DUC ;
-- =============================================
/*

SELECT '123456789' AS TEST
INTO RETAILRISK_LOS.DBO.DANHTNX_TABLEA
;
SELECT *
FROM RETAILRISK_LOS.DBO.DANHTNX_TABLEA
;
-- CHECK ETL
SELECT *
FROM [RETAILRISK_LOS].[dbo].[LOG_ETL_PROCESS]
WHERE  object_name like '%SP_DANHTNX_TABLEA%'
and start_process_dttm > cast(getdate() -0 as date)
--where end_process_dttm is null and start_process_dttm > cast(getdate() -0 as date)
order by start_process_dttm desc
;


*/

--ALTER PROCEDURE [dbo].[SP_RMD_LOS_RP_SECURED_DUC]

AS
	
BEGIN	
	SET NOCOUNT ON;
	

BEGIN TRY	
	Declare @v_Log_ID INT,
			@v_Counts_SRC int,
			@v_Counts_DEST int
			;
		    
	----------- Log Begin
	Set @v_Log_ID  = NEXT VALUE FOR [RETAILRISK_LOS].dbo.SEQ_LOG_ETL_PROCESS;
	INSERT INTO [RETAILRISK_LOS].[dbo].[LOG_ETL_PROCESS] ([LOG_ID],[OBJECT_NAME]) 
		   SELECT @v_Log_ID  AS PROCESS_ID,OBJECT_NAME(@@PROCID) 				  
    ;

	-------------------------------UPDATE STATUS REJECTION REASONS AGAIN----------------------------------------------
	--ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD CALCULATED NVARCHAR(10)
	/*UPDATE DBO.RMD_LOS_RP_SECURED_DUC
	SET CALCULATED = 1
	WHERE BI_APPSSTATUS in ('APPROVED','CANCEL')

	UPDATE DBO.RMD_LOS_RP_SECURED_DUC
	SET CALCULATED = 1
	WHERE (BI_APPSSTATUS = 'REJECTED'
			   AND CREATION_DATE <= GETDATE() - 8)
	

	DELETE FROM RMD_LOS_RP_SECURED_DUC WHERE CALCULATED IS NULL
	DELETE FROM RMD_LOS_RP_SECURED_DUC WHERE BI_APPSSTATUS='PROCESSING';*/
	-------------------------------UPDATE STATUS REJECTION REASONS AGAIN END----------------------------------------------
	--PREPARE DATA
	--TRUNCATE TABLE [RETAILRISK].DBO.RMD_LOS_RP_SECURED_DUC
	--DROP TABLE RMD_LOS_RP_SECURED_DUC_FINAL

	/*
	CREATE TABLE RMD_LOS_RP_SECURED_DUC_ALL
	(
	   APP_ID NVARCHAR(100)
      ,APP_NO NVARCHAR(100)
      ,CREATION_DATE NVARCHAR(100)
      ,CREATION_MONTH NVARCHAR(100)
      ,BI_APPSSTATUS NVARCHAR(100)
	  ,CREATED_BY NVARCHAR(100)
      ,BRANCH_NAME NVARCHAR(100)
	  ,CHANNEL_ID NVARCHAR(100)
	  ,DAO NVARCHAR(100)
	  ,DAO_NAME NVARCHAR(100)
	  ,SALE_CODE NVARCHAR(100)
	  ,PRODUCT_NAME NVARCHAR(100)
	  ,PRODUCT_GROUP NVARCHAR(100)
	  ,BI_PRODUCTNAME NVARCHAR(100)
	  ,PROMOTION_CODE NVARCHAR(100)
	  ,FULL_NAME NVARCHAR(100)
	  ,ID_NO NVARCHAR(100)
	  ,REGION NVARCHAR(100)
      ,BI_REGION NVARCHAR(100)
      ,CPC_REGION NVARCHAR(100)
	)

	CREATE TABLE RMD_LOS_RP_SECURED_DUC
	(APP_ID NVARCHAR(100)
	   ,APP_NO NVARCHAR(100)
	  ,PRODUCT NVARCHAR(100)
      ,CREATION_DATE NVARCHAR(100)
      ,CREATION_MONTH NVARCHAR(100)
      ,BI_APPSSTATUS NVARCHAR(100)
	  ,CREATED_BY NVARCHAR(100)
      ,BRANCH_NAME NVARCHAR(100)
	  ,CHANNEL_ID NVARCHAR(100)
	  ,DAO NVARCHAR(100)
	  ,DAO_NAME NVARCHAR(100)
	  ,SALE_CODE NVARCHAR(100)
	  ,PRODUCT_NAME NVARCHAR(100)
	  ,PRODUCT_GROUP NVARCHAR(100)
	  ,BI_PRODUCTNAME NVARCHAR(100)
	  ,PROMOTION_CODE NVARCHAR(100)
	  ,FULL_NAME NVARCHAR(100)
	  ,ID_NO NVARCHAR(100)
	  ,REGION NVARCHAR(100)
      ,BI_REGION NVARCHAR(100)
      ,CPC_REGION NVARCHAR(100)
	  ,G1_NEW NVARCHAR(100)
	  ,G2_NEW NVARCHAR(100)
	)*/
	
	delete from RMD_LOS_RP_SECURED_DUC where creation_date >= '2023-01-01'

	--alter table RMD_LOS_RP_SECURED_DUC add MARKED NUMERIC
	/*UPDATE RMD_LOS_RP_SECURED_DUC 
	SET MARKED = 1    
	WHERE MARKED is null*/

	TRUNCATE TABLE RMD_LOS_RP_SECURED_DUC
	INSERT INTO RMD_LOS_RP_SECURED_DUC (
	   APP_ID
      ,APP_NO
      ,BI_APPSSTATUS
	  ,CREATED_BY
	  ,DAO
	  ,DAO_NAME
	  ,SALE_CODE
	  ,FULL_NAME
	  ,ID_NO 
	  ,CIF
	  ,BI_PRODUCTNAME,
		   PRODUCT_GROUP,
		   PRODUCT_NAME,	
		   WORKFLOW,
		   PORTFOLIO,
		   CREATION_MONTH,
		   WEEK,
		   CREATION_DATE, 
		   CREATION_PERIOD, 
		   CPC_REGION,
		   BI_REGION,
		   BRANCH_NAME,
		   CHANNEL_ID,
		   PROMOTION_CODE,
		   PRD_CUSTOMER_TYPE,
		   SEGMENT_GROUP,
		   PRODUCT,
		   SCORE_COLOR, 
		   DATA_SOURCE,
		   PRIORITY_1_DESC,
		   PRIORITY_2_DESC,
		   CONTRACT_NO,
		   APPROVED_AMT
	)
  SELECT APP_ID
      ,APP_NO
      ,BI_APPSSTATUS
	  ,CREATED_BY
	  ,DAO
	  ,DAO_NAME
	  ,SALE_CODE
	  ,FULL_NAME
	  ,ID_NO 
	  ,CIF
	  ,CASE WHEN BI_PRODUCTNAME ='06. Overdraft' THEN '06. Overdraft'  
		when BI_PRODUCTNAME IS NULL AND PRODUCT_GROUP = 'Retail Universal Product' THEN 'Universal' 
		when BI_PRODUCTNAME IS NULL AND PRODUCT_GROUP ='Comm Credit Card Auto Approval' THEN '15. Comm Credit Card'
		ELSE BI_PRODUCTNAME
		END BI_PRODUCTNAME,
		   PRODUCT_GROUP,
		   PRODUCT_NAME,	
		   WORKFLOW,
		   PORTFOLIO,
		   CREATION_MONTH,
		   CASE
			 WHEN DAY(CREATION_DATE) >= 01 AND DAY(CREATION_DATE) <= 07 THEN
			 CONCAT(CREATION_MONTH,'-W1')
			 WHEN DAY(CREATION_DATE) >= 08 AND DAY(CREATION_DATE) <= 15 THEN
			  CONCAT(CREATION_MONTH,'-W2')
			 WHEN DAY(CREATION_DATE) >= 16 AND DAY(CREATION_DATE) <= 23 THEN
			  CONCAT(CREATION_MONTH,'-W3')
			 ELSE
			  CONCAT(CREATION_MONTH,'-W4')
		   END WEEK,
		   CREATION_DATE, 
		   CASE 
			WHEN YEAR(CREATION_date) < YEAR(GETDATE()) THEN
				CASE	WHEN MONTH(CREATION_date)  IN (1,2,3) THEN CONCAT(YEAR(CREATION_date),'-Q1')
						WHEN MONTH(CREATION_date)  IN (4,5,6) THEN CONCAT(YEAR(CREATION_date),'-Q2')
						WHEN MONTH(CREATION_date)  IN (7,8,9) THEN CONCAT(YEAR(CREATION_date),'-Q3')
						ELSE CONCAT(YEAR(CREATION_date) ,'-Q4') END
			WHEN EOMONTH(CREATION_date)  <= EOMONTH(GETDATE(),-1) THEN CREATION_MONTH
			WHEN DAY(CREATION_date)  >= 01 AND DAY(CREATION_date)  <=07 THEN CONCAT(CREATION_MONTH,'-W1')
			WHEN DAY(CREATION_date)  >= 08 AND DAY(CREATION_date)  <=15 THEN CONCAT(CREATION_MONTH,'-W2')
			WHEN DAY(CREATION_date)  >= 16 AND DAY(CREATION_date)  <=23 THEN CONCAT(CREATION_MONTH,'-W3')
				ELSE CONCAT(CREATION_MONTH,'-W4') END CREATION_PERIOD, 
		   CPC_REGION,
		   BI_REGION,
		   BRANCH_NAME,
		   CHANNEL_ID,
		   PROMOTION_CODE,
		   CUSTOMER_SEGMENT AS PRD_CUSTOMER_TYPE,
		   SEGMENT_GROUP,
		   CASE
				 WHEN  BI_PRODUCTNAME = '01. Auto Loan' THEN 'Auto Loan' 
				 WHEN  BI_PRODUCTNAME = '02. Consumption Loan' THEN 'Consumption Loan'  
				 WHEN  BI_PRODUCTNAME = '03. Home Loan' THEN 'Home Loan'  
				 WHEN  BI_PRODUCTNAME = '05. Household Business' THEN 'Household Business'  
				 WHEN  BI_PRODUCTNAME = '06. Overdraft' THEN 'OD' 
				 WHEN  BI_PRODUCTNAME = '06. Overdraft'  AND PORTFOLIO ='Retail Unsecured' THEN 'OD - Unsecured' 
				 WHEN  BI_PRODUCTNAME = '06. Overdraft'  AND PORTFOLIO ='Retail Secured' THEN 'OD - Secured' 
				 WHEN  BI_PRODUCTNAME = '06. Overdraft'  AND PRODUCT_GROUP ='Retail Unsecured Overdraft Online' THEN 'OD - Online' 
				 WHEN  BI_PRODUCTNAME = '10. UPL' THEN 'UPL' 
				 WHEN  BI_PRODUCTNAME = '12. Credit Card' THEN 'CC'  
				 WHEN  BI_PRODUCTNAME = '13. HH_SEC' THEN 'Household Secured' 
				 WHEN  BI_PRODUCTNAME = '14. HH_UNSEC' THEN 'Household Unsecured' 
				 WHEN  PRODUCT_GROUP ='Retail Universal Product' THEN 'Retail Universal Product' 
				 WHEN  PRODUCT_GROUP = 'Comm Credit Card Auto Approval' THEN 'Comm CC'
				 END AS PRODUCT,
			SCORE_COLOR, 
			DATA_SOURCE,
		   PRIORITY_1_DESC,
		   PRIORITY_2_DESC,
		   CONTRACT_NO,
		   APPROVED_AMT
  --INTO [RETAILRISK].DBO.RMD_LOS_RP_SECURED_DUC
  FROM RETAILRISK.dbo.RMD_MASTER_DATA_LAST with (nolock)
 WHERE [SOURCE_SYSTEM] IN ('LOS')
 --AND WORKFLOW = 'Manual'
 AND creation_date >= '2023-01-01'
 AND COALESCE(CREATED_BY, '0') not in ('thuynt57', 'tunglt19','hanhnt8','lytt1','hungvm4','hangvk','chanlnv')
 AND UPPER(COALESCE(SALE_CODE, '0')) not like 'RR%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%RISK%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%TEST%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%TES%'
 AND COALESCE(CUST_NAME,'NULL') not like '%TEST%'
 AND (PRODUCT_NAME IN 
 (
'A2 - Auto Loan',
'Consumption Loan Against Car',
'Loan for New Car',
'Loan for Used Car',
'Refinancing Loan for New Car',
'Refinancing Loan for Used Car',
N'Vay mua ô tô',
'A2 - Consumption Loan',
'Consumption loan for Car purpose',
'Consumption loan for Home Purpose',
'Consumption loan for Home Renovation',
'Consumption loan for Other Purpose',
'Instant Home Loan Without Ownership Certificate ',
'Personal Loan for Normal Customer',
'Personal Loan for Priority Customer',
'Personal Loan for Retired Customer',
'Personal Loan for VP Bank Staff ',
N'Vay ??u t?, kinh doanh ch?ng khoán',
N'Vay ??u t?, kinh doanh khác',
N'Vay tiêu dùng',
'A2 - HomeLoan',
'Home Loan for Home Renovation',
'Home Loan With Ownership Certificate',
'Home Loan Without Ownership Certificate',
'Refinancing Home Loan With Ownership Certificate',
'Refinancing Home Loan Without Ownership Certificate',
N'Vay mua nhà',
'A2 - Household Business Loan',
'Fixed Asset Acquisition',
'Overdraft Household Business',
'Working Capital in Credit Limit ',
'Working capital in installment',
'Overdraft Consumption Purpose',
N'THAU CHI BAO DAM BANG QUYEN TS PHAT SINH TU HDLD',
N'THAU CHI BAO DAM BANG QUYEN TS PHAT SINH TU HDLD B',
'Vay th?u chi có Tài s?n ??m b?o',
'Household Secured Kiosk',
'Household Secured Real Estate'
 ) or PRODUCT_GROUP in ('Retail Auto Loan',
'Retail Consumption Loan',
'Retail Home Loan',
'Retail Household',
'Retail Overdraft Consumption',
'Retail Preapproved Secured Loan',
N'Tái th?m ??nh KHCN có TS?B'))

 /* and app_no not in (select app_no from RMD_LOS_RP_SECURED_DUC 
								where CREATION_DATE >= getdate() - 31 and MARKED = 1)*/

delete from RMD_LOS_RP_SECURED_DUC 
where DATA_SOURCE = 'DFSECPREAPPROVED' 
 and PRODUCT_NAME is null 
 and CREATION_DATE >= '2023-03-01' 

 INSERT INTO RMD_LOS_RP_SECURED_DUC (
	   APP_ID
      ,APP_NO
      ,BI_APPSSTATUS
	  ,CREATED_BY
	  ,DAO
	  ,DAO_NAME
	  ,SALE_CODE
	  ,FULL_NAME
	  ,ID_NO 
	  ,CIF
	  ,BI_PRODUCTNAME,
		   PRODUCT_GROUP,
		   PRODUCT_NAME,	
		   WORKFLOW,
		   PORTFOLIO,
		   CREATION_MONTH,
		   WEEK,
		   CREATION_DATE, 
		   CREATION_PERIOD, 
		   CPC_REGION,
		   BI_REGION,
		   BRANCH_NAME,
		   CHANNEL_ID,
		   PROMOTION_CODE,
		   PRD_CUSTOMER_TYPE,
		   SEGMENT_GROUP,
		   PRODUCT,
		   SCORE_COLOR, 
			DATA_SOURCE,
		   PRIORITY_1_DESC,
		   PRIORITY_2_DESC,
		   CONTRACT_NO,
		   APPROVED_AMT
	)
  SELECT APP_ID
      ,APP_NO
      ,BI_APPSSTATUS
	  ,CREATED_BY
	  ,DAO
	  ,DAO_NAME
	  ,SALE_CODE
	  ,FULL_NAME
	  ,ID_NO 
	  ,CIF
	  ,CASE WHEN BI_PRODUCTNAME ='06. Overdraft' THEN '06. Overdraft'  
		when BI_PRODUCTNAME IS NULL AND PRODUCT_GROUP = 'Retail Universal Product' THEN 'Universal' 
		when BI_PRODUCTNAME IS NULL AND PRODUCT_GROUP ='Comm Credit Card Auto Approval' THEN '15. Comm Credit Card'
		ELSE BI_PRODUCTNAME
		END BI_PRODUCTNAME,
		   PRODUCT_GROUP,
		   PRODUCT_NAME,	
		   WORKFLOW,
		   PORTFOLIO,
		   CREATION_MONTH,
		   CASE
			 WHEN DAY(CREATION_DATE) >= 01 AND DAY(CREATION_DATE) <= 07 THEN
			 CONCAT(CREATION_MONTH,'-W1')
			 WHEN DAY(CREATION_DATE) >= 08 AND DAY(CREATION_DATE) <= 15 THEN
			  CONCAT(CREATION_MONTH,'-W2')
			 WHEN DAY(CREATION_DATE) >= 16 AND DAY(CREATION_DATE) <= 23 THEN
			  CONCAT(CREATION_MONTH,'-W3')
			 ELSE
			  CONCAT(CREATION_MONTH,'-W4')
		   END WEEK,
		   CREATION_DATE, 
		   CASE 
			WHEN YEAR(CREATION_date) < YEAR(GETDATE()) THEN
				CASE	WHEN MONTH(CREATION_date)  IN (1,2,3) THEN CONCAT(YEAR(CREATION_date),'-Q1')
						WHEN MONTH(CREATION_date)  IN (4,5,6) THEN CONCAT(YEAR(CREATION_date),'-Q2')
						WHEN MONTH(CREATION_date)  IN (7,8,9) THEN CONCAT(YEAR(CREATION_date),'-Q3')
						ELSE CONCAT(YEAR(CREATION_date) ,'-Q4') END
			WHEN EOMONTH(CREATION_date)  <= EOMONTH(GETDATE(),-1) THEN CREATION_MONTH
			WHEN DAY(CREATION_date)  >= 01 AND DAY(CREATION_date)  <=07 THEN CONCAT(CREATION_MONTH,'-W1')
			WHEN DAY(CREATION_date)  >= 08 AND DAY(CREATION_date)  <=15 THEN CONCAT(CREATION_MONTH,'-W2')
			WHEN DAY(CREATION_date)  >= 16 AND DAY(CREATION_date)  <=23 THEN CONCAT(CREATION_MONTH,'-W3')
				ELSE CONCAT(CREATION_MONTH,'-W4') END CREATION_PERIOD, 
		   CPC_REGION,
		   BI_REGION,
		   BRANCH_NAME,
		   CHANNEL_ID,
		   PROMOTION_CODE,
		   CUSTOMER_SEGMENT AS PRD_CUSTOMER_TYPE,
		   SEGMENT_GROUP,
		   CASE
				 WHEN  PRIORITY_2_DESC IN ('Nhom 1 (Paid-off)') THEN 'Special secured - Nhom 1 (Paid-off)' 
				 WHEN  PRIORITY_2_DESC IN ('Nhom 2 (Top-up)') THEN 'Special secured - Nhom 2 (Top-up)' 
				 WHEN  PRIORITY_2_DESC IN ('Nhom 3 (Credit line extension)') THEN 'Special secured - Nhom 3 (Credit line extension)'
				 end PRODUCT,
			SCORE_COLOR, 
			DATA_SOURCE,
		   PRIORITY_1_DESC,
		   PRIORITY_2_DESC,
		   CONTRACT_NO,
		   APPROVED_AMT
  FROM RETAILRISK.dbo.RMD_MASTER_DATA_LAST with (nolock)
 WHERE creation_date >= '2023-03-01'
 AND COALESCE(CREATED_BY, '0') not in ('thuynt57', 'tunglt19','hanhnt8','lytt1','hungvm4','hangvk','chanlnv')
 AND UPPER(COALESCE(SALE_CODE, '0')) not like 'RR%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%RISK%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%TEST%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%TES%'
 AND COALESCE(CUST_NAME,'NULL') not like '%TEST%' 
 AND DATA_SOURCE = 'DFSECPREAPPROVED' 
 and PRODUCT_NAME is null   

 --alter table RMD_LOS_RP_SECURED_DUC add [PRIORITY_1_DESC] nvarchar(max) 
 --alter table RMD_LOS_RP_SECURED_DUC add [PRIORITY_2_DESC] nvarchar(max) 
--alter table RMD_LOS_RP_SECURED_DUC add [APPROVED_AMT] float

------------Reasons Manual------------------- 
--ALTER TABLE DBO.RMD_LOS_RP_SECURED_DUC ADD G1_NEW NVARCHAR(255)
 
--ALTER TABLE DBO.RMD_LOS_RP_SECURED_DUC ADD G2_NEW NVARCHAR(255) 
--ALTER TABLE DBO.RMD_LOS_RP_SECURED_DUC ADD APPROVED_AMT NVARCHAR(255)



UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Credit history VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - BD - KH có n? x?u/ l?ch s? tr? n? t?i VP bank vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.%' 

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Credit history VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - BD - KH có n? x?u/ l?ch s? tr? n? t?i VP bank vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'02. Credit history FIs'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - BD - KH có n? x?u/ l?ch s? tr? n? t?i các t? ch?c tín d?ng khác vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'02. Credit history FIs'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - BD - KH có n? x?u/ l?ch s? tr? n? t?i các t? ch?c tín d?ng khác vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'02. Credit history FIs'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%HH - Credit history - CIC - N? nhóm 2 trong vòng 12 tháng (Khách hàng)%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'02. Credit history FIs'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%HH - Credit history - CIC - N? nhóm 3+ trong vòng 5 n?m (Khách hàng)%'

----------------------------------------------------------------
UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Blacklist VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - BL- K?t qu? ki?m tra Danh sách ?en trùng kh?p%' 

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Blacklist VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - BL- K?t qu? ki?m tra Danh sách ?en trùng kh?p%'



UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'48. Collateral policy not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - COL - V? trí c?a TSB? không ?áp ?ng ???c v? trí c?a TSB? ???c quy ??nh trong ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'48. Collateral policy not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - COL - Tu?i c?a ch? TSB? vi ph?m nh?ng ?i?u ki?n quy ??nh trong ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'48. Collateral policy not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - COL - Giá tr? ??nh giá TSB? nh? h?n m?c giá tr? TSB? t?i thi?u có th? nh?n theo quy ??nh trong ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'14. Location restrict'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - RES ADD - N?i th??ng trú, t?m trú c?a KH không có tr? s? c?a Vpbank%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'14. Location restrict'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - ADD - N?i th??ng trú, t?m trú c?a KH không có tr? s? c?a Vpbank%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'09. Working experiences/ Contract time/ Ownership/ Employment Type is not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - PHV - WD - KH xác nh?n th?i gian làm vi?c t?i công ty hi?n t?i/ th?i gian làm vi?c còn l?i c?a h?p ??ng lao ??ng/ hay kinh nghi?m làm vi?c khác v?i thông tin trong h? s? vay v?n.%' 

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'09. Working experiences/ Contract time/ Ownership/ Employment Type is not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - WD - KH có th?i gian làm vi?c t?i công ty hi?n t?i/ th?i gian còn l?i c?a h?p ??ng lao ??ng/ ho?c kinh nghi?m làm vi?c không ?áp ?ng ?i?u ki?n trong ch??ng trình s?n ph?m%' 

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'09. Working experiences/ Contract time/ Ownership/ Employment Type is not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - WD - KH có th?i gian làm vi?c t?i công ty hi?n t?i/ th?i gian còn l?i c?a h?p ??ng lao ??ng/ ho?c kinh nghi?m làm vi?c không ?áp ?ng ?i?u ki?n trong ch??ng trình s?n ph?m%'



UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'48. Collateral policy not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - DUR - COL- H? s? c? b? t? ch?i c?a Khách Hàng có cùng m?t tài s?n b?o ??m v?i h? s? m?i n?p%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'48. Collateral policy not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - COL - Lo?i tài s?n không ???c s? d?ng làm TSB? theo quy ??nh trong ch??ng trình s?n ph?m (vd: PTVT dùng trong l?nh v?c an ninh qu?c phòng)%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'11. Customer income violates product procedures'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - INCOME - Lo?i hình thu nh?p không ???c quy ??nh trong ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'11. Customer income violates product procedures'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - INCOME - Lo?i hình thu nh?p không ???c quy ??nh trong ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'11. Customer income violates product procedures'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - INCOME - Thu nh?p sau thu? t?i thi?u vi ph?m quy ??nh trong ?i?u ki?n s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'11. Customer income violates product procedures'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - INCOME - Thu nh?p sau thu? t?i thi?u vi ph?m quy ??nh trong ?i?u ki?n s?n ph?m%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - DTI - KH có DTI vi ph?m ?i?u ki?n DTI trong ch??ng trình s?n ph?m%' 

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC -UNS- DTI - KH có DTI vi ph?m ?i?u ki?n DTI trong ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - LA - KH xác nh?n h?n m?c vay t?i thi?u, t?i ?a khác v?i thông tin trong h? s? vay v?n%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - LA - S? ti?n vay/ h?n m?c tín d?ng t?i thi?u/t?i ?a không ???c quy ??nh ho?c vi ph?m quy ??nh ch??ng trình s?n ph?m%'

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'02. Fraud'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] IN
(  
N'CPC - UNS -Fraud -  K?t qu? th?c ??a cho th?y công ty c?a KH khác v?i thông tin trong h? s? vay v?n/ ho?c công ty c?a KH ?ã ng?ng ho?t ??ng',

N'CPC - UNS - FRAUD - KH/ N?i b? Vpbank cung c?p ch?ng t? gi? m?o ?? s? d?ng d?ch v? c?a VPbank',
N'CPC - FRAUD - DOCs - KH/ N?i b? Vpbank cung c?p ch?ng t? gi? m?o ?? s? d?ng d?ch v? c?a VPbank', 

N'CPC - FRAUD - INFO - KH/ N?i b? Vpbank cung c?p  thông tin không xác th?c, khai báo không xác th?c ?? s? d?ng d?ch v? c?a Vpbank',

N'CPC - FI - FRAUD - DOCs - K?t qu? th?c ??a cho th?y KH/ N?i b? Vpbank cung c?p ch?ng t? gi? m?o ?? s? d?ng d?ch v? c?a VPbank', 
N'CPC - FI - FRAUD - INFO - K?t qu? th?c ??a cho th?y KH/ N?i b? Vpbank cung c?p  thông tin không xác th?c, khai báo không xác th?c ?? s? d?ng d?ch v? c?a Vpbank',

N'CPC - FRAUD - DOCs - K?t qu? g?i ?i?n tho?i cho th?y KH/ N?i b? Vpbank cung c?p ch?ng t? gi? m?o ?? s? d?ng d?ch v? c?a VPbank', 
N'CPC - PHV - FRAUD - DOCs - K?t qu? g?i ?i?n tho?i cho th?y KH/ N?i b? Vpbank cung c?p ch?ng t? gi? m?o ?? s? d?ng d?ch v? c?a VPbank',
N'CPC - PHV - FRAUD - INFO - K?t qu? g?i ?i?n tho?i cho th?y KH/ N?i b? Vpbank cung c?p  thông tin không xác th?c, khai báo không xác th?c ?? s? d?ng d?ch v? c?a Vpbank',

N'CPC -UNS - FRAUD - H? s? c? c?a Khách Hàng ?ã t?ng b? t? ch?i vì gi? m?o.', 
N'CPC - DUR - FRAUD - H? s? c? c?a Khách Hàng ?ã t?ng b? t? ch?i vì gi? m?o.',

N'HH - Fraud - Ch?ng minh thu nh?p ho?c gi?y t? thay th?', 
N'HH - Fraud - K?t qu? tiêu c?c - CPV tr??c khi phê duy?t'
)

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'03. Fraud'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%fraud%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Negative List'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%2. CPC – UNS – PDC - KH thu?c danh sách vi ph?m KSSV%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'22. Income Documents not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND (C.[DEVIATION_DESC] IN (N'CPC - UNS - Ch?ng t? ngu?n thu không th?a',
						   N'CPC – UNS – Ch?ng t? pháp lý không th?a') 
or C.[DEVIATION_DESC] like N'%CPC - UNS - Ch?ng t? ngu?n thu không th?a%' 
or C.[DEVIATION_DESC] like N'%CPC – UNS – Ch?ng t? pháp lý không th?a%')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'07. Violated age condition of product policy'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - UNS - AGE - Tu?i c?a KH vi ph?m nh?ng quy ??nh trong ch??ng trình s?n ph?m%' 

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'07. Violated age condition of product policy'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%CPC - AGE - Tu?i c?a KH vi ph?m nh?ng quy ??nh trong ch??ng trình s?n ph?m%'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'03. Rejected by combination of Phone & Field Verification'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] IN
(
N'CPC - PHV - LP - KH khai báo m?c ?ích vay v?n khác v?i thông tin trong h? s? vay v?n',
N'CPC - UNS - LP - KH khai báo m?c ?ích vay v?n khác v?i thông tin trong h? s? vay v?n', 
N'CPC - LP - KH khai báo m?c ?ích vay v?n khác v?i thông tin trong h? s? vay v?n',

N'CPC - PRD - LP - M?c ?ích s? d?ng v?n vay c?a KH không ???c quy ??nh trong Ch??ng trình s?n ph?m', 
N'CPC - UNS - LP - M?c ?ích s? d?ng v?n vay c?a KH không ???c quy ??nh trong Ch??ng trình s?n ph?m', 

N'CPC - PHV - OTH - KH xác nh?n/ khai báo các thông tin khác không kh?p v?i thông tin trong h? s? vay v?n', 
N'CPC- OTH - KH xác nh?n/ khai báo các thông tin khác không kh?p v?i thông tin trong h? s? vay v?n',

N'CPC - PHV - WD - KH xác nh?n th?i gian làm vi?c t?i công ty hi?n t?i/ th?i gian làm vi?c còn l?i c?a h?p ??ng lao ??ng/ hay kinh nghi?m làm vi?c khác v?i thông tin trong h? s? vay v?n.',

N'CPC - UNS - DENIAL - KH ho?c công ty c?a KH t? ch?i xác minh thông tin', 
N'CPC - PHV - DENIAL - KH ho?c công ty c?a KH t? ch?i xác minh thông tin',

N'CPC - EMPLOYER - KH ?ang làm vi?c t?i nh?ng công ty mà không ???c quy ??nh trong ch??ng trình s?n ph?m',

N'CPC - UNS - DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? thu nh?p KH cung c?p', 
N'CPC - UNS - DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? pháp lý KH cung c?p', 
N'1. CPC - UNS - DIS -  Sai l?ch thông tin gi?a n?i dung trên PTTTT/DNVV/DNPHT KH cung c?p và n?i dung trên T24', 
N'CPC - UNS -DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung trên DNVV/ DNPHT KH cung c?p',
N'CPC - DIS - Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? KH cung c?p',
N'CPC - FI - DIS - K?t qu? th?c ??a cho th?y có sai l?ch thông tin gi?a khai báo c?a KH và n?i dung KH cung c?p trong h? s? vay v?n',

N'CPC - UNS - NOT MEET - Không th? ??t cu?c h?n v?i KH ho?c không th? g?p KH/ bên th? 3 ?? ?i th?c ??a',
N'CPC - FI - NOT MEET - Không th? ??t cu?c h?n v?i KH ho?c không th? g?p KH/ bên th? 3 ?? ?i th?c ??a', 
N'CPC - PHV - NOT CONTACT - Không th? liên l?c ???c v?i KH ho?c công ty c?a KH ?? xác minh thông tin',

N'CPC - UNS - PHV - Th?m ??nh ?i?n tho?i ng??i tham kh?o không th?a Q?',
N'CPC - PHV - Th?m ??nh ?i?n tho?i ng??i tham kh?o không th?a Q?',

N'CPC - UNS -DM- KH không có nhu c?u vay v?n', 
N'CPC - KH không có nhu c?u vay v?n',

N'HH - Policy - S? n?m kinh nghi?m không th?a',

N'HH - CPV - KH không h?p tác',

N'HH - Lý do khác (nêu c? th?)'
)



UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'12. Others'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] IN (N'DVKD RÚT H? S? KHÔNG TRÌNH L?I H? S?',  
						   N'DVKD TRÌNH KHÔNG ?ÚNG PHÂN LU?NG',
						   N'HH - Policy - Ngành ngh? h?n ch? ho?c b? c?m')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'12. Others'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'Application are overdue 6 days, Cancel by system'


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'12. Others'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] IN
(
N'CPC - OTH - Các tiêu chu?n KH khác không ???c quy ??nh/ vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m',

N'CPC_PERSONAL_JUDGMENT',
N'CPC-UNS - PERSONAL_JUDGMENT',

N'Default Reason',
N'New Reason'
)


/*
UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = 'REJECTED BY SYSTEM'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock),RETAILRISK.dbo.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.[APP_ID]
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'DVKD RÚT H? S? KHÔNG TRÌNH L?I H? S?'
*/
--Application are overdue 6 days, Cancel by system
--------------REASONS - AUTO------------------------
UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'01. Credit history VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR003',
						'AL003','AL004','AL005','AL011','AL012',
						'SC011','SC010','SC013','SC015',
						'DA012','DA013','DA014','DA011', 
						'HL008','HL009','RR008','RR009','RR005','RR006','SE004')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'01. Credit history VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR003',
						'AL003','AL004','AL005','AL011','AL012',
						'SC011','SC010','SC013','SC015',
						'DA012','DA013','DA014','DA011', 
						'HL008','HL009','RR008','RR009','RR005','RR006','SE004')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'02. Credit history FIs'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND (C.DEVIATION_CODE IN ('RR002','RR004','RR014','DA009','DA00901','DA010','DA015','DA01501','DA021','DA022', 
						 'SC012','SC014','SC018','SC019','SC024','SC025', 
						 'AL010', 
						 'HL007','HL010','HL011',
						 'HLC003','SE007','RR013','SE003','SE008') 
	or C.DEVIATION_DESC IN ('RR002','RR004','SC012','RR014','DA009','DA00901','DA010','DA015','DA01501','DA021','DA022', 
						 'SC012','SC014','SC018','SC019','SC024','SC025',
						 'AL010',
						 'HL007','HL010','HL011',
						 'HLC003','SE007','RR013','SE003','SE008') )
------------------------------------------------------

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'01. Blacklist VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR007','DA006')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'01. Blacklist VPBank'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR007','DA006')


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'02. Blacklist FEC'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR00701','DA004')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'02. Blacklist FEC'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR00701','DA004')

------------------------------------------------------
UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'01. Negative List'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('DA007','DA008','HL005','HL006')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'01. Negative List'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('DA007','DA008','HL005','HL006') 


------------------------------------------------------

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'03. Sale Code/DAO is inactive or blocked'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('FT007','DA018','SC01701','DA003','DA025','SE00601','SE00602')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'03. Sale Code/DAO is inactive or blocked'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('FT007','DA018','SC01701','DA003','DA025','SE00601','SE00602') 
  

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'14. Location restrict'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('DA019','AL014','DA020','HL003','SC021')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'14. Location restrict'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('DA019','AL014','DA020','HL003','SC021') 


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'08. Customer not in pre-approved list/has no pre-approved limit'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('SE009')  

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'08. Customer not in pre-approved list/has no pre-approved limit'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('SE009') 



UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'07. Violated age condition of product policy'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('SC001','DA001','SE001')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'07. Violated age condition of product policy'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('SC001','DA001','SE001')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'11. Customer income violates product procedures'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('AL013','SC016','DA016','SE005')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'11. Customer income violates product procedures'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('AL013','SC016','DA016','SE005')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'10. Company/Employer/ Teacher Type is not qualified'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR011','DA005','DA024','RR017')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'10. Company/Employer/ Teacher Type is not qualified'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR011','DA005','DA024','RR017')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'15. Tenor at disbursement date is not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('DA002','SE002')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'15. Tenor at disbursement date is not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('DA002','SE002')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'04. Fail 3rd-party credit scoring'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('KLP003','KLP002','KLP0021')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW= N'04. Fail 3rd-party credit scoring'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID= C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('KLP003','KLP002','KLP0021') 

update RMD_LOS_RP_SECURED_DUC  
set G2_NEW = '62. Kalapa Blacklist' 
FROM RMD_LOS_RP_SECURED_DUC b, RETAILRISK.dbo.DDS_DEVIATION_FACT c 
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND (C.DEVIATION_CODE IN ('KLP004','KLP005') OR C.DEVIATION_DESC IN ('KLP004','KLP005'))
AND C.SEVERITY = 'CRITICAL'  


UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = '39. COVID Lockdown Policy'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('LC001','LC002','LC003','LC004','COVID01901','COVID01902')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = '39. COVID Lockdown Policy'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('LC001','LC002','LC003','LC004','COVID01901','COVID01902')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = '16. Number of rejected app of applicant before application login date >1'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('SC030')

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = '16. Number of rejected app of applicant before application login date >1'
FROM RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('SC030') 

UPDATE DBO.RMD_LOS_RP_SECURED_DUC
SET G2_NEW='03. Fraud'
FROM DBO.RMD_LOS_RP_SECURED_DUC B with (nolock), RETAILRISK.dbo.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND (C.DEVIATION_CODE IN ('FT008','FT032','FT034') OR C.DEVIATION_DESC IN ('FT008','FT032','FT034'))


--SELECT * FROM RMD_LOS_RP_SECURED_DUC WITH (NOLOCK) WHERE G2_NEW IS NULL AND BI_APPSSTATUS='REJECTED' AND APP_ID='7f12660c0b1c47dd9c0686d58c3f4437'


----------------------------------REJECTION WF------------------------------------
--SELECT * FROM RMD_LOS_RP_SECURED_DUC WHERE BI_APPSSTATUS='REJECTED' AND G2_NEW IS NULL
--SELECT * FROM
UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Credit history VPBank'
FROM RETAILRISK.DBO.[STG_RLOS_APP] F with (nolock),RMD_LOS_RP_SECURED_DUC B with (nolock)
WHERE B.APP_ID = F.[ApplicationID]
AND F.[IMAXDPD] >= '90'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL

UPDATE A
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_RP_SECURED_DUC A WITH (NOLOCK), RETAILRISK.DBO.DDS_APP_DTI_DIM B WITH (NOLOCK)
WHERE A.APP_ID=B.APP_ID
AND B.[DTI000_APPROVED_LA_AMT] <'50000000'
AND A.BI_APPSSTATUS='REJECTED'
AND G2_NEW IS NULL 

UPDATE B
SET G2_NEW = N'01. Negative List'
FROM RMD_LOS_RP_SECURED_DUC B WITH (NOLOCK), RETAILRISK.dbo.DDS_WORKFLOW_FACT I with (nolock)
WHERE --A.APP_ID = B.APP_ID 
B.APP_ID=I.APP_ID
AND I.STEP = 'BlacklistFound' AND I.TYPE_DESC ='Decision' 
AND I.RESULT='Path selected is Yes'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 
--and I.START_DATE >= getdate()-14

UPDATE B
SET G2_NEW = N'68. Request amount not satisfied'
FROM RMD_LOS_RP_SECURED_DUC B WITH (NOLOCK), RETAILRISK.dbo.DDS_WORKFLOW_FACT I with (nolock), 
		RETAILRISK.dbo.RMD_MASTER_DATA_LAST c WITH (NOLOCK)
WHERE b.APP_ID = C.APP_ID 
AND B.APP_ID=I.APP_ID
AND I.STEP = 'Eligible 01' AND I.TYPE_DESC ='Decision' 
AND I.RESULT='Path selected is Reject'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL  
and b.data_source = 'DFSECUSEDCAR'  
AND C.REQUEST_AMT > 1000000000 
AND C.REQUEST_AMT <= 2000000001


--AND 1=1
/*
UPDATE A
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_RP_SECURED_DUC A WITH (NOLOCK), RETAILRISK.dbo.DDS_WORKFLOW_FACT B WITH (NOLOCK)
WHERE A.APP_ID=B.APP_ID
AND B.STEP= 'Pre Eligibility'
AND B.RESULT LIKE '%Reject%'
AND A.BI_APPSSTATUS='REJECTED' 
AND G2_NEW IS NULL
AND 1=1*/

/*UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Blacklist VPBank'
WHERE BI_APPSSTATUS='REJECTED' AND G2_NEW IS NULL*/


/*ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD CUSTOMER_TYPE NVARCHAR(100) 
ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD REGION NVARCHAR(255) 
ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD SALE_NAME NVARCHAR(255) 
ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD SOURCE_SYSTEM NVARCHAR(255) 
ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD CUSTOMER_SEGMENT NVARCHAR(255)
*/ 
UPDATE B
SET B.CUSTOMER_TYPE = A.CUST_TYPE
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK), RETAILRISK.dbo.RMD_MASTER_DATA_LAST A WITH(NOLOCK)
WHERE A.APP_ID=B.APP_ID
AND (B.CUSTOMER_TYPE IS NULL OR B.CUSTOMER_TYPE = 'NO SELECTED')

UPDATE B
SET B.CUSTOMER_TYPE = 'NO SELECTED'
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK)
WHERE B.CUSTOMER_TYPE IS NULL

UPDATE B
SET B.REGION = A.REGION
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK), RETAILRISK.dbo.RMD_MASTER_DATA_LAST A WITH(NOLOCK)
WHERE A.APP_ID=B.APP_ID

UPDATE B
SET B.SALE_NAME = A.SALE_NAME
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK), RETAILRISK.dbo.RMD_MASTER_DATA_LAST A WITH(NOLOCK)
WHERE A.APP_ID=B.APP_ID 

UPDATE B
SET B.SOURCE_SYSTEM = A.SOURCE_SYSTEM
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK), RETAILRISK.dbo.RMD_MASTER_DATA_LAST A WITH(NOLOCK)
WHERE A.APP_ID=B.APP_ID 

UPDATE B
SET B.CUSTOMER_SEGMENT = A.CUSTOMER_SEGMENT
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK), RETAILRISK.dbo.RMD_MASTER_DATA_LAST A WITH(NOLOCK)
WHERE A.APP_ID=B.APP_ID  

--ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD G1_NEW NVARCHAR(100)



----------------------SCORE - AUTO--------------
--ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD G1_NEW NVARCHAR(1000), G2_NEW NVARCHAR(1000);

UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW=N'02. Black Scoring'
FROM RETAILRISK.dbo.RMD_MASTER_DATA_LAST A with (nolock),RMD_LOS_RP_SECURED_DUC B with (nolock)  
WHERE A.SCORE_COLOR in ('Black','Pink') AND B.BI_APPSSTATUS='REJECTED' AND A.APP_ID = B.APP_ID AND G2_NEW IS NULL
AND B.PRODUCT_NAME IN
(
'Home Loan With Ownership Certificate',
'Home Loan Without Ownership Certificate',
'Refinancing Home Loan With Ownership Certificate',
'Refinancing Home Loan Without Ownership Certificate',
'Home Loan for Home Renovation',
'Loan for New Car', 
'Loan for Used Car', 
'Refinancing Loan for New Car', 
'Refinancing Loan for Used Car',
'Consumption loan for Car purpose',
'Consumption loan for Home Purpose',
'Consumption loan for Other Purpose',
'Consumption loan for Home Renovation',
'Fixed Asset Acquisition',
'Working capital in installment',
'Working Capital in Credit Limit '
) 



--SELECT * FROM RMD_LOS_RP_SECURED_DUC WHERE G2_NEW ='01. Blacklist VPBank'

----------------------------------SCORE - AUTO END--------------------------------
------------------------BEAUTY DATA-----------------------
/*
UPDATE RMD_LOS_RP_SECURED_DUC
SET G2_NEW = N'01. Rejected by combination of Phone & Field Verification'
WHERE G2_NEW =N'02. Rejected by combination of Phone & Field Verification'
*/
--------------------------------------------------------------------
UPDATE RMD_LOS_RP_SECURED_DUC
SET G1_NEW = '01. Sale responsibilities'
WHERE G2_NEW IN 
(
'01. Trusting Social/Mobifone - Mobile Phone not in the list OR customer is expired during processing',
'02. At submission, customer had existing credit card at VPBank',
'03. Sale Code/DAO is inactive or blocked',
'04. Customer have no demand',
'05. At submission, customer had existing UPL at VPBank',
'07. Violated age condition of product policy',
'08. Customer not in pre-approved list', 
'08. Customer not in pre-approved list/has no pre-approved limit',
'09. Working experiences/ Contract time/ Ownership/ Employment Type is not satisfied',
'10. Company/Employer/ Teacher Type is not qualified', 
'10. Company/Employer is not qualified',
'11. Customer income violates product procedures',
'12. Others',
'13. MobiFone Applied Card type is not Mobifone Classic/ Mobifone Titanium/ Mobifone Platinum',
'14. Location restrict',
'15. Violated Tenor of product policy',
'15. Tenor at disbursement date is not satisfied',
'16. Number of rejected app of applicant within 07 days before application login date >1', 
'16. Number of rejected app of applicant before application login date >1',
'17. Number of existing unsecured credit card > 4',
'18. Insurance Policy is not satisfied',
'19. Legal Documents not satisfied',
'20. Information Discrepancy (income docs,...)',
'21. Travel Policy is not satisfied',
'22. Income Documents not satisfied',
'23. Customer violates household business policies',
'24. Card for Car Policy is not satisfied',
'25. VPBank Staff not in the list',
'27. Card for card policy is not satisfied',
'28. Customer CIF not AF',
'29. Supplementary card policy not satisfied',
'30. Customer gender is not applied for this card type',
'38. Channel is not appicable for this products', 
'39. COVID Lockdown Policy',
'40. Policies of card for customer has secured loan is not satisfied',
'42. Policies of Self-Improvement product is not satisfied',
'41. Services product policy violation',
'43. Policy 05 violation',
'44. No KYC Result',
'45. KYC and OCR not satisfied',
'46. Mobifone strategy not satisfied',
'47. Corporate strategy not satisfied',
'48. Collateral policy not satisfied', 
'68. Request amount not satisfied'
)



UPDATE RMD_LOS_RP_SECURED_DUC
SET G1_NEW = '02. Risk criterias'
WHERE G2_NEW IN 
(
'01. Credit history VPBank',
'02. Credit history FIs', 
'02. Credit history Fis',
'03. Fraud',
'02. Fraud',
'01. Blacklist VPBank',
'02. Blacklist FEC',
'01. Negative List',
'04. Fail 3rd-party credit scoring',
'62. Kalapa Blacklist'
)

UPDATE RMD_LOS_RP_SECURED_DUC
SET G1_NEW = '03. Black Scoring'
WHERE G2_NEW IN 
(
'02. Black Scoring'
)

UPDATE RMD_LOS_RP_SECURED_DUC
SET G1_NEW = '04. Verification'
WHERE G2_NEW IN 
(
N'02. Failed at Phone Verification',
N'01. Rejected by combination of Phone & Field Verification',
N'03. Rejected by combination of Phone & Field Verification'
)

UPDATE RMD_LOS_RP_SECURED_DUC
SET G1_NEW = '05. Capacity'
WHERE G2_NEW IN 
(
'01. Failed DTI',
'02. Failed 575 - Product Multiplier',
'03. Failed Minimum Limit'
)

/*
alter table RMD_LOS_RP_SECURED_DUC add DETAILED_PERIOD NVARCHAR(100)
alter table RMD_LOS_RP_SECURED_DUC add FINAL_REGION NVARCHAR(100)
alter table RMD_LOS_RP_SECURED_DUC add FINAL_CUSTOMER_TYPE NVARCHAR(100)
alter table RMD_LOS_RP_SECURED_DUC add FINAL_CUST_SEGMENT NVARCHAR(100)
alter table RMD_LOS_RP_SECURED_DUC add FINAL_SEGMENT_GROUP NVARCHAR(100)
alter table RMD_LOS_RP_SECURED_DUC add FINAL_BI_REGION NVARCHAR(100) 
alter table RMD_LOS_RP_SECURED_DUC add DATA_SOURCE NVARCHAR(100)*/

--ALTER TABLE RMD_LOS_RP_SECURED_DUC DROP COLUMN DETAILED_PERIOD
--ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD CREATION_PERIOD NVARCHAR(100) 
--ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD WEEK NVARCHAR(100)

update RMD_LOS_RP_SECURED_DUC 
  set CREATION_PERIOD = CASE		WHEN YEAR(CREATION_date) < YEAR(GETDATE()) THEN
			CASE	    WHEN MONTH(CREATION_date)  IN (1,2,3) THEN CONCAT(YEAR(CREATION_date),'-Q1')
						WHEN MONTH(CREATION_date)  IN (4,5,6) THEN CONCAT(YEAR(CREATION_date),'-Q2')
						WHEN MONTH(CREATION_date)  IN (7,8,9) THEN CONCAT(YEAR(CREATION_date),'-Q3')
						ELSE CONCAT(YEAR(CREATION_date) ,'-Q4') END
			WHEN EOMONTH(CREATION_date)  <= EOMONTH(GETDATE(),-1) THEN CREATION_MONTH
			WHEN DAY(CREATION_date)  >= 01 AND DAY(CREATION_date)  <=07 THEN CONCAT(CREATION_MONTH,'-W1' )
			WHEN DAY(CREATION_date)  >= 08 AND DAY(CREATION_date)  <=15 THEN CONCAT(CREATION_MONTH,'-W2')
			WHEN DAY(CREATION_date)  >= 16 AND DAY(CREATION_date)  <=23 THEN CONCAT(CREATION_MONTH,'-W3')
				ELSE CONCAT(CREATION_MONTH,'-W4') END 

--ALTER TABLE DBO.RMD_LOS_COMM_REPORT ADD WEEK NVARCHAR(100)  
update RMD_LOS_RP_SECURED_DUC 
  set WEEK = CASE WHEN DAY(CREATION_date)  >= 01 AND DAY(CREATION_date)  <=07 THEN CONCAT(CREATION_MONTH,'-W1' )
			WHEN DAY(CREATION_date)  >= 08 AND DAY(CREATION_date)  <=15 THEN CONCAT(CREATION_MONTH,'-W2')
			WHEN DAY(CREATION_date)  >= 16 AND DAY(CREATION_date)  <=23 THEN CONCAT(CREATION_MONTH,'-W3')
				ELSE CONCAT(CREATION_MONTH,'-W4') END 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET FINAL_REGION = CASE WHEN REGION in ('NAM','HCM','SOUTH') THEN 'NAM'
						 WHEN REGION in ('BAC','NORTH') THEN 'BAC'
						 WHEN REGION in ('TRUNG','CENTRAL') THEN 'TRUNG'
						 WHEN REGION IS NULL THEN 'NO SELECTED' ELSE REGION END 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET FINAL_CUSTOMER_TYPE = CASE WHEN CUSTOMER_TYPE IS NULL THEN 'NO SELECTED' ELSE CUSTOMER_TYPE END

UPDATE RMD_LOS_RP_SECURED_DUC 
SET FINAL_CUST_SEGMENT = CASE WHEN CUSTOMER_SEGMENT IS NULL THEN 'NO SELECTED' ELSE CUSTOMER_SEGMENT END 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET FINAL_SEGMENT_GROUP = CASE WHEN SEGMENT_GROUP IS NULL THEN 'NO SELECTED' ELSE SEGMENT_GROUP END

UPDATE RMD_LOS_RP_SECURED_DUC 
SET FINAL_BI_REGION = CASE WHEN BI_REGION IN ('VUNG 1','VUNG1') THEN 'VUNG 1'  
						   WHEN BI_REGION IN ('VUNG 2','VUNG2') THEN 'VUNG 2' 
						   WHEN BI_REGION IN ('VUNG 3','VUNG3') THEN 'VUNG 3' 
						   WHEN BI_REGION IN ('VUNG 4','VUNG4') THEN 'VUNG 4'
						   WHEN BI_REGION IN ('VUNG 5','VUNG5') THEN 'VUNG 5' 
						   WHEN BI_REGION IN ('VUNG 6','VUNG6') THEN 'VUNG 6' 
						   WHEN BI_REGION IN ('VUNG 7','VUNG7') THEN 'VUNG 7' 
						   WHEN BI_REGION IN ('VUNG 8','VUNG8') THEN 'VUNG 8' 
						   WHEN BI_REGION IN ('VUNG 9','VUNG9') THEN 'VUNG 9' 
						   WHEN BI_REGION IN ('VUNG 10','VUNG10') THEN 'VUNG 10' 
						   WHEN BI_REGION IN ('VUNG 11','VUNG11') THEN 'VUNG 11' 
						   WHEN BI_REGION IN ('VUNG KHAC') THEN 'VUNG KHAC' 
						   WHEN BI_REGION IS NULL THEN 'NO SELECTED' 
						   ELSE BI_REGION
						   END 
UPDATE RMD_LOS_RP_SECURED_DUC 
SET DATA_SOURCE = CASE WHEN DATA_SOURCE IS NULL THEN 'NO SELECTED' 
						   ELSE DATA_SOURCE
						   END

UPDATE RMD_LOS_RP_SECURED_DUC 
SET CHANNEL_ID = CASE WHEN CHANNEL_ID IS NULL THEN 'NO SELECTED' 
						   ELSE CHANNEL_ID
						   END 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET CPC_REGION = CASE WHEN CPC_REGION IS NULL THEN 'NO SELECTED' 
						   ELSE CPC_REGION
						   END 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET BRANCH_NAME = CASE WHEN BRANCH_NAME IS NULL THEN 'NO SELECTED' 
						   ELSE BRANCH_NAME
						   END

/*ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD DC_YN NVARCHAR(100)*/ 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET DC_YN = 'YES' 
FROM RMD_LOS_RP_SECURED_DUC A, RETAILRISK.dbo.DDS_WORKFLOW_FACT B 
WHERE a.APP_ID =b.APP_ID  
AND B.STEP = 'Data Check' 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET DC_YN = 'NO' 
FROM RMD_LOS_RP_SECURED_DUC A, RETAILRISK.dbo.DDS_WORKFLOW_FACT B 
WHERE DC_YN IS NULL 

/*ALTER TABLE RMD_LOS_RP_SECURED_DUC DROP COLUMN UW_YN
ALTER TABLE RMD_LOS_RP_SECURED_DUC ADD UW_YN NVARCHAR(100)*/ 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET UW_YN = 'YES' 
FROM RMD_LOS_RP_SECURED_DUC A, RETAILRISK.dbo.DDS_WORKFLOW_FACT B 
WHERE a.APP_ID =b.APP_ID  
AND B.STEP in ('Manual Underwriting (1 Form)','Manual Underwriting (DDE Checking)','Manual Underwriting (1 Form)') 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET UW_YN = 'NO' 
FROM RMD_LOS_RP_SECURED_DUC A, RETAILRISK.dbo.DDS_WORKFLOW_FACT B 
WHERE UW_YN IS NULL 

--ALTER TABLE DBO.RMD_LOS_RP_SECURED_DUC ADD FIN_PRODUCT NVARCHAR(100)  
 update RMD_LOS_RP_SECURED_DUC 
  set FIN_PRODUCT = case when BI_PRODUCTNAME = '14. HH_UNSEC' THEN 'UPL_HH' 
						 when PRODUCT_NAME = 'Retail Universal Comm Credit' THEN 'UPL_HH' 
						 WHEN BI_PRODUCTNAME IS NULL AND PRODUCT_GROUP = 'Comm Unsecured Personal Loan' THEN 'UPL_HH' 
						/* WHEN PORTFOLIO = 'Retail Secured' and BI_PRODUCTNAME is null and PRODUCT_GROUP = 'Retail Universal Product' and PRODUCT_NAME is null 
								AND ReportType in ('ZALO_GET_SCORE','TS_CREDIT01') then 'UPL_HH' */
						when BI_PRODUCTNAME = '01. Auto Loan' then 'Auto' 
						--when PRODUCT_NAME = 'Retail Universal Secured Loan' then 'Auto'
						when BI_PRODUCTNAME = '02. Consumption Loan' then 'Cons'
						when BI_PRODUCTNAME = '03. Home Loan' then 'Home' 
						when BI_PRODUCTNAME = '05. Household Business' THEN 'Business'  
						WHEN BI_PRODUCTNAME = '10. UPL' THEN 'UPL_RB' 
						WHEN BI_PRODUCTNAME = '12. Credit Card' THEN 'Card'  
						--when PRODUCT_NAME = 'Retail Universal Credit Card' THEN 'Card'
						WHEN BI_PRODUCTNAME = '06. Overdraft' THEN 'Overdraft' 
						ELSE BI_PRODUCTNAME
						end

--alter table RMD_LOS_RP_SECURED_DUC add SOURCE_CHANNEL NVARCHAR(MAX)
UPDATE RMD_LOS_RP_SECURED_DUC 
SET  SOURCE_CHANNEL = case when  DATA_SOURCE IN ('DFPROJECTHOME','DFSECBUSINESS','DFSECCONSUMPTION','DFSECHOUSING')  THEN 'RACE for VPBank Sales' 
						   when  DATA_SOURCE IN ('DFSECUSEDCAR','DFSHOWROOM') then 'RACE for Partner Dealers'  
						   when DATA_SOURCE in ('DFSECAPP') THEN 'Online replacing CSR input' 
							else 'Offline - LOS input app'	
						END  

	

--ALTER TABLE  RMD_LOS_RP_SECURED_DUC DROP COLUMN DISBURSED_YN
--ALTER TABLE  RMD_LOS_RP_SECURED_DUC ADD DISBURSED_YN NUMERIC

UPDATE RMD_LOS_RP_SECURED_DUC 
SET DISBURSED_YN =  case when B.CONTRACT_NO IS NOT NULL THEN 1	ELSE 0 END  
		FROM RMD_LOS_RP_SECURED_DUC A, 
				RETAILRISK.dbo.RMD_MASTER_DATA_LAST B WITH (NOLOCK) 
				WHERE A.APP_NO = B.APP_NO 

/*
UPDATE RMD_LOS_RP_SECURED_DUC 
SET PRIORITY_1_DESC =  B.PRIORITY_1_DESC 
		FROM RMD_LOS_RP_SECURED_DUC A, 
				RETAILRISK.dbo.RMD_MASTER_DATA_LAST B WITH (NOLOCK) 
				WHERE A.APP_NO = B.APP_NO 

UPDATE RMD_LOS_RP_SECURED_DUC 
SET PRIORITY_2_DESC =  B.PRIORITY_2_DESC 
		FROM RMD_LOS_RP_SECURED_DUC A, 
				RETAILRISK.dbo.RMD_MASTER_DATA_LAST B WITH (NOLOCK) 
				WHERE A.APP_NO = B.APP_NO 
*/


/*UPDATE RMD_LOS_RP_SECURED_DUC 
SET DATA_SOURCE = B.DATA_SOURCE  
FROM RMD_LOS_RP_SECURED_DUC A LEFT JOIN [dbo].[RETAILRISK.dbo.RMD_MASTER_DATA_LAST] B 
ON A.APP_ID =B.APP_ID*/


--------------------------------------------------------------------------------

/*UPDATE B
SET B.SCORE = A.SCORE_COLOR
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK), RETAILRISK.dbo.RMD_MASTER_DATA_LAST A WITH(NOLOCK)
WHERE A.APP_ID=B.APP_ID
AND B.SCORE IS NULL

UPDATE B
SET B.SCORE = NULL
FROM RMD_LOS_RP_SECURED_DUC B WITH(NOLOCK)
WHERE B.SCORE IS NULL


--SELECT * FROM RMD_LOS_RP_SECURED_DUC WHERE BI_APPSSTATUS='REJECTED' AND G2_NEW IS NULL
*/


	----------- Log End
	UPDATE  [RETAILRISK_LOS].[dbo].[LOG_ETL_PROCESS] 
		SET STATUS=1,
			END_PROCESS_DTTM=GETDATE()
		WHERE Log_ID = @v_Log_ID
    ;
END TRY
BEGIN CATCH 
	UPDATE  [RETAILRISK_LOS].[dbo].[LOG_ETL_PROCESS] 
		SET STATUS=2,
			OBJECT_NOTE=('ERROR : Line ' +cast(ERROR_LINE() as varchar)+ ' - ' + ERROR_MESSAGE()) 
		WHERE Log_ID = @v_Log_ID
	
END CATCH
END;


GO


