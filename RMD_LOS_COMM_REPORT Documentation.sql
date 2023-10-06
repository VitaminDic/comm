USE [RETAILRISK_LOS]
GO
/****** Object:  StoredProcedure [dbo].[SP_RMD_LOS_COMM_REPORT]    Script Date: 06/10/2023 11:06:14 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		duclhm & hungvm4
-- Create date: 29 sep 2023
-- Description: Update rejection for Unsecured Comm Product
-- EXEC RETAILRISK_LOS.DBO.SP_RMD_LOS_COMM_REPORT ;
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

ALTER PROCEDURE [dbo].[SP_RMD_LOS_COMM_REPORT]

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

	--SELECT distinct G2_NEW FROM RMD_LOS_COMM_REPORT
	---PREPARE DATA 
--TRUNCATE TABLE [RETAILRISK].DBO.RMD_LOS_COMM_REPORT 
	--SELECT * FROM RMD_LOS_COMM_REPORT
	/*UPDATE DBO.RMD_LOS_COMM_REPORT
	SET CALCULATED = 1
	WHERE CREATION_DATE <= GETDATE() - 14
	AND  BI_APPSSTATUS IN ('APPROVED','REJECTED','CANCEL')*/

	--DELETE FROM RMD_LOS_COMM_REPORT WHERE CALCULATED IS NULL;
	--DELETE FROM RMD_LOS_COMM_REPORT WHERE BI_APPSSTATUS='PROCESSING'; 

	--ALTER TABLE RMD_LOS_COMM_REPORT ADD MARKED NVARCHAR(100) 
	
	--ALTER TABLE RMD_LOS_COMM_REPORT ADD CHANNEL_ID NVARCHAR(100) 
	
	delete from RMD_LOS_COMM_REPORT where CREATION_DATE >= getdate()-30


	--SELECT * FROM RMD_LOS_COMM_REPORT_FINAL
	--ALTER TABLE RMD_LOS_COMM_REPORT ADD CUST_TYPE NVARCHAR(50)*/
	/*
	CREATE TABLE RMD_LOS_COMM_REPORT
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
	DROP TABLE RMD_LOS_COMM_REPORT_FINAL
	CREATE TABLE RMD_LOS_COMM_REPORT_FINAL
	(
	   APP_NO NVARCHAR(100)
      ,CREATION_DATE NVARCHAR(100)
      ,CREATION_MONTH NVARCHAR(100)
      ,BI_APPSSTATUS NVARCHAR(100)
      ,BRANCH_NAME NVARCHAR(100)
	  ,DAO NVARCHAR(100)
	  ,DAO_NAME NVARCHAR(100)
	  ,PRODUCT_NAME NVARCHAR(100)
	  ,PRODUCT_GROUP NVARCHAR(100)
	  ,FULL_NAME NVARCHAR(100)
	  ,ID_NO NVARCHAR(100)
	  ,REGION NVARCHAR(100)
	  ,G1_NEW NVARCHAR(100)
	  ,G2_NEW NVARCHAR(100)
	  ,PROVINCE NVARCHAR(30)
	  ,BI_REGION NVARCHAR(30)
	  ,CUSTOMER_TYPE NVARCHAR(30)
	  ,CUST_DES NVARCHAR(30)
	)
	*/
	INSERT INTO RMD_LOS_COMM_REPORT (
	   APP_ID
      ,APP_NO
      ,CREATION_DATE
      ,CREATION_MONTH
      ,BI_APPSSTATUS
      ,BRANCH_NAME
	  ,DAO
	  ,DAO_NAME
	  ,PRODUCT_NAME
	  ,PRODUCT_GROUP
	  ,BI_PRODUCTNAME
	  ,FULL_NAME
	  ,ID_NO
	  ,REGION
	  ,CUST_GRADE
	  ,CUST_TYPE
	  ,CHANNEL_ID
	  ,CONTRACT_NO
	)
  SELECT APP_ID
      ,APP_NO
      ,CREATION_DATE
      ,CREATION_MONTH
      ,BI_APPSSTATUS
      ,BRANCH_NAME
	  ,DAO
	  ,DAO_NAME
	  ,PRODUCT_NAME
	  ,PRODUCT_GROUP
	  ,BI_PRODUCTNAME
	  ,FULL_NAME
	  ,ID_NO
	  ,REGION
	  ,CUST_GRADE
	  ,CUST_TYPE
	  ,CHANNEL_ID
	  ,CONTRACT_NO
  FROM RETAILRISK.DBO.RMD_MASTER_DATA_LAST with (nolock)
 WHERE --WORKFLOW = 'MANUAL' 
 SOURCE_SYSTEM = 'LOS'
 AND CREATION_DATE >= getdate()-30
 --AND CREATION_DATE >= '2020-01-01'
 AND COALESCE(CREATED_BY, '0') not in ('thuynt57', 'tunglt19','hanhnt8','lytt1','hungvm4','hangvk')
 AND UPPER(COALESCE(SALE_CODE, '0')) not like 'RR%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%RISK%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%TEST%'
 AND UPPER(COALESCE(SALE_CODE, '0')) not like '%TES%'
 AND COALESCE(CUST_NAME,'NULL') not like '%TEST%'
 /*AND APP_NO NOT IN 
		(SELECT APP_NO FROM RMD_LOS_COMM_REPORT 
			where CREATION_DATE >= getdate()-30
			and MARKED = 'X'  )*/
 AND [PRODUCT_GROUP] IN 
 (
 'Comm Unsecured Personal Loan',
 'Household Unsecured',
 'Comm Credit Card Auto Approval'
 ) 
 --OR BI_PRODUCTNAME IN ('14. HH_UNSEC') 
 AND PRODUCT_GROUP NOT LIKE '%Universal%'





 /*SELECT * FROM RETAILRISK.DBO.RMD_MASTER_DATA WHERE   CREATION_DATE >= '2020-05-01' AND [PRODUCT_GROUP] IN 
 (
 'Comm Unsecured Personal Loan',
 'Household Unsecured'
 )
 */
 --UPDATE A SET A.CUST_TYPE = B.CUST_TYPE FROM RMD_LOS_COMM_REPORT A, [RETAILRISK.DBO.RMD_MASTER_DATA] B WHERE A.APP_ID=B.APP_ID 
 update RMD_LOS_COMM_REPORT 
set DATA_SOURCE = B.DATA_SOURCE 
FROM RMD_LOS_COMM_REPORT A, RETAILRISK.DBO.RMD_MASTER_DATA_LAST B WITH (NOLOCK)
WHERE A.APP_NO = B.APP_NO 
 AND A.CREATION_DATE >= getdate()-31

 update RMD_LOS_COMM_REPORT 
set DATA_SOURCE = B.CRM_code 
FROM RMD_LOS_COMM_REPORT A, RETAILRISK.DBO.STG_RLOS_APP_FORM B
WHERE A.APP_NO = B.ApplicationNo AND A.DATA_SOURCE IS NULL 
 AND A.CREATION_DATE >= getdate()-31

 update RMD_LOS_COMM_REPORT 
set CHANNEL_ID = B.CHANNEL_ID
FROM RMD_LOS_COMM_REPORT A, RETAILRISK.DBO.RMD_MASTER_DATA_LAST B WITH (NOLOCK)
WHERE A.APP_NO = B.APP_NO 
	AND A.CHANNEL_ID IS NULL 
	 AND A.CREATION_DATE >= getdate()-31 


--alter table RMD_LOS_COMM_REPORT add APPROVED_AMT numeric
--alter table RMD_LOS_COMM_REPORT add REQUEST_AMT numeric 
--alter table RMD_LOS_COMM_REPORT add CIF nvarchar(100)
--alter table RMD_LOS_COMM_REPORT add G3_NEW NVARCHAR(MAX) 
--alter table RMD_LOS_COMM_REPORT add CONTRACT_NO NVARCHAR(100)

update RMD_LOS_COMM_REPORT 
set APPROVED_AMT = B.APPROVED_AMT 
FROM RMD_LOS_COMM_REPORT a, RETAILRISK.DBO.RMD_MASTER_DATA_LAST b with (nolock)  
WHERE A.APP_NO = B.APP_NO 
	 AND A.CREATION_DATE >= getdate()-31

update RMD_LOS_COMM_REPORT 
set REQUEST_AMT = B.REQUEST_AMT 
FROM RMD_LOS_COMM_REPORT a, RETAILRISK.DBO.RMD_MASTER_DATA_LAST b with (nolock)  
WHERE A.APP_NO = B.APP_NO
	 AND A.CREATION_DATE >= getdate()-31

update RMD_LOS_COMM_REPORT 
set CIF = b.CIF 
FROM RMD_LOS_COMM_REPORT a, RETAILRISK.DBO.RMD_MASTER_DATA_LAST b with (nolock)  
WHERE A.APP_NO = B.APP_NO 
	 AND A.CREATION_DATE >= getdate()-31

------------Reasons Manual-------------------

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '06. Fraud'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE N'%Fraud%'

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Failed at Phone Verification'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS - ADD - KH xác nh?n n?i th??ng trú, t?m trú c?a KH khác v?i thông tin trong h? s? vay v?n',
N'CPC - UNS - NOT CONTACT - Không th? liên l?c ???c v?i KH ho?c công ty c?a KH ?? xác minh thông tin',
N'CPC - UNS - PHV - Th?m ??nh ?i?n tho?i ng??i tham kh?o không th?a Q?',
N'CPC - PHV - DENIAL - KH ho?c công ty c?a KH t? ch?i xác minh thông tin',
N'CPC - UNS - DENIAL - KH ho?c công ty c?a KH t? ch?i xác minh thông tin',
N'CPC - UNS - DEN - Công ty/ KH t? ch?i xác nh?n thông tin qua ?i?n tho?i và th?c ??a',
N'CPC - Th?m ??nh ?i?n tho?i ng??i tham kh?o không th?a Q?',
N'CPC - RES ADD - KH xác nh?n n?i th??ng trú, t?m trú c?a KH khác v?i thông tin trong h? s? vay v?n',
N'CPC - UNS - NOT MEET - Không th? ??t cu?c h?n v?i KH ho?c không th? g?p KH/ bên th? 3 ?? ?i th?c ??a',
N'CPC - UNS - LP - M?c ?ích s? d?ng v?n vay c?a KH không ???c quy ??nh trong Ch??ng trình s?n ph?m',
N'CPC - UNS - LP - KH khai báo m?c ?ích vay v?n khác v?i thông tin trong h? s? vay v?n',
N'CPC - UNS - LA - KH xác nh?n h?n m?c vay t?i thi?u, t?i ?a khác v?i thông tin trong h? s? vay v?n',
N'HH - CPV - KH che gi?u thông tin',
N'HH - CPV - KH không h?p tác',
N'HH - CPV Office - K?t qu? tiêu c?c',
N'HH - Customer Meeting Sheet - K?t qu? tiêu c?c',
N'HH - KH ho?c Ng??i ??ng vay - Ti?u s? tiêu c?c (cho vay ti?n, ch?i h?i,…)',
N'HH - TRC - K?t qu? tiêu c?c',
N'HH - TVR - K?t qu? tiêu c?c',
N'CPC - PHV - DENIAL - KH ho?c công ty c?a KH t? ch?i xác minh thông tin',
N'HH - CPV Residence - K?t qu? tiêu c?c',
N'CPC - PHV - LP - KH khai báo m?c ?ích vay v?n khác v?i thông tin trong h? s? vay v?n'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Failed Minimum Limit'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] LIKE '%DTI%'


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] like '%black%'


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] =N'CPC - UNS - BL- K?t qu? ki?m tra Danh sách ?en trùng kh?p'


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '05. Negative List'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'2. CPC – UNS – PDC - KH thu?c danh sách vi ph?m KSSV'


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS - BD - KH có n? x?u/ l?ch s? tr? n? t?i VP bank vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.',
N'CPC - BD - KH có n? x?u/ l?ch s? tr? n? t?i VP bank vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.',
N'HH - Credit history - KT n?i b? - Tr? h?n 1 k? ho?c ?ang tr? h?n (Khách hàng)',
N'HH - Credit history - KT n?i b? - Tr? h?n t? 2 k? tr? lên (Khách hàng)',
N'HH - Credit history - KT n?i b? - Tr? h?n nhi?u l?n (ng??i thân/??ng vay)',
N'HH - Credit history - KT n?i b? - Tr? h?n 1 k? ho?c ?ang tr? h?n (ng??i thân/??ng vay)',
N'HH - Credit history - KT n?i b? - Tr? h?n nhi?u l?n (Khách hàng)',
N'HH - Credit history - KT n?i b? - Tr? h?n t? 2 k? tr? lên (ng??i thân/??ng vay)'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS - BD - KH có n? x?u/ l?ch s? tr? n? t?i các t? ch?c tín d?ng khác vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.',
N'CPC - BD - KH có n? x?u/ l?ch s? tr? n? t?i VP bank vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m.',
N'HH - Credit history - CIC - N? nhóm 3+ trong vòng 5 n?m (Khách hàng)',
N'HH - Credit history - CIC - N? nhóm 2 trong vòng 12 tháng (ng??i thân/??ng vay)',
N'HH - Credit history - CIC - N? nhóm 3+ trong vòng 5 n?m (ng??i thân/??ng vay)',
N'HH - Credit history - CIC - N? nhóm 2 trong vòng 12 tháng (Khách hàng)',
N'CPC - BD - KH có n? x?u/ l?ch s? tr? n? t?i các t? ch?c tín d?ng khác vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m. '
)


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Customer have no demand'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS -DM- KH không có nhu c?u vay v?n',
N'CPC - KH không có nhu c?u vay v?n'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '14. Location restrict'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in
(N'CPC - UNS - ADD - N?i th??ng trú, t?m trú c?a KH không có tr? s? c?a Vpbank',
 N'CPC - RES ADD - N?i th??ng trú, t?m trú c?a KH không có tr? s? c?a Vpbank',
 N'HH - Policy - Ngoài ph?m vi kinh doanh')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '21. Income Documents not satisfied'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'CPC - UNS - Ch?ng t? ngu?n thu không th?a'


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '07. Violated age condition of product policy'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND C.[REMARKS]='MANUAL'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[DEVIATION_DESC] LIKE N'%AGE%'

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '19. Legal Documents not satisfied'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] IN 
(
N'CPC – UNS – Ch?ng t? pháp lý không th?a',
N'CPC - UNS-O/S sai quy ??nh',
N'CPC - O/S sai quy ??nh'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '20. Information Discrepancy (income docs,...)'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS - DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? pháp lý KH cung c?p',
N'CPC - UNS - DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? thu nh?p KH cung c?p',
N'CPC - UNS -DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung trên DNVV/ DNPHT KH cung c?p',
N'1. CPC - UNS - DIS -  Sai l?ch thông tin gi?a n?i dung trên PTTTT/DNVV/DNPHT KH cung c?p và n?i dung trên T24',
N'CPC - LP - KH khai báo m?c ?ích vay v?n khác v?i thông tin trong h? s? vay v?n',
N'CPC - PHV - OTH - KH xác nh?n/ khai báo các thông tin khác không kh?p v?i thông tin trong h? s? vay v?n',
N'CPC - PRD - LP - M?c ?ích s? d?ng v?n vay c?a KH không ???c quy ??nh trong Ch??ng trình s?n ph?m',
N'THONG TIN KHACH HANG CAPTURE SAI',
N'CPC - UNS -DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung trên DNVV/ DNPHT KH cung c?p',
N'CPC - UNS - DIS -  Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? pháp lý KH cung c?p',
N'CPC - UNS -DIS - Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung trên DNVV/ DNPHT KH cung c?p',
N'CPC - UNS - DIS - Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? pháp lý KH cung c?p',
N'CPC - UNS - DIS - Sai l?ch thông tin gi?a khai báo c?a KH và n?i dung ch?ng t? thu nh?p KH cung c?p'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '06. Customer income violates product procedures'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - INCOME - Lo?i hình thu nh?p không ???c quy ??nh trong ch??ng trình s?n ph?m',
N'CPC - INCOME - Thu nh?p sau thu? t?i thi?u vi ph?m quy ??nh trong ?i?u ki?n s?n ph?m',
N'CPC - UNS - INCOME - Lo?i hình thu nh?p không ???c quy ??nh trong ch??ng trình s?n ph?m',
N'CPC - UNS - INCOME - Thu nh?p sau thu? t?i thi?u vi ph?m quy ??nh trong ?i?u ki?n s?n ph?m'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS - VL - KH ?ang có d? n? tín ch?p/ H?n m?c th? tín d?ng/ H?n m?c th?u chi t?i VPBank nên vi ph?m quy ??nh c?a s?n ph?m',
N' CPC - UNS - VL - KH ?ang có d? n? tín ch?p/ H?n m?c th? tín d?ng/ H?n m?c th?u chi t?i VPBank nên vi ph?m quy ??nh c?a s?n ph?m',
N'CPC - UNS - LA - S? ti?n vay/ h?n m?c tín d?ng t?i thi?u/t?i ?a không ???c quy ??nh ho?c vi ph?m quy ??nh ch??ng trình s?n ph?m',
N'HH - CFA - Dòng ti?n không th?a',
N'HH - CFA - V??t quá gánh n?ng n? (nhi?u kho?n vay)'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '33. Household Product Policy not satisfied'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'HH - Policy - Không thu?c chính sách s?n ph?m (nêu c? th?)',
N'HH - Policy - Ngành ngh? h?n ch? ho?c b? c?m',
N'HH - Policy - Th?i gian c? trú không th?a',
N'HH - Policy - Gi?y t? yêu c?u (không có Ch?ng minh kinh doanh)',
N'HH - Policy - Gi?y t? yêu c?u (không có Ch?ng minh th?i gian c? trú)',
N'HH - Policy - S? n?m kinh nghi?m không th?a'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '10. Company/Employer/ Teacher Type is not qualified'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC - UNS - EMPLOYER - KH ?ang làm vi?c t?i nh?ng công ty mà không ???c quy ??nh trong ch??ng trình s?n ph?m',
N'CPC - EMPLOYER - KH ?ang làm vi?c t?i nh?ng công ty mà không ???c quy ??nh trong ch??ng trình s?n ph?m',
N'CPC - UNS - WD - KH có th?i gian làm vi?c t?i công ty hi?n t?i/ th?i gian còn l?i c?a h?p ??ng lao ??ng/ ho?c kinh nghi?m làm vi?c không ?áp ?ng ?i?u ki?n trong ch??ng trình s?n ph?m'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '33. Household Product Policy not satisfied'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'CPC - Nhóm KH liên quan  không ?áp ?ng  nh?ng ?i?u ki?n dành cho nhóm KH liên quan ???c quy ??nh trong ch??ng trình s?n ph?m'

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Customer have no demand'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'KHÁCH HÀNG KHÔNG CÓ NHU C?U'

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '34. Customers belongs to TIMO'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] = N'CPC- UNS-COM- KH là KH c?a Kh?i Tín d?ng ti?u th??ng/Timo'


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '12. Others'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.[DDS_DEVIATION_FACT] C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND C.[DEVIATION_DESC] in 
(
N'CPC-UNS - PERSONAL_JUDGMENT',
N'TR? HS V? DO UPLOAD KHÔNG ?ÚNG Y/C',
N'CPC_PERSONAL_JUDGMENT',
N'HH - Lý do khác (nêu c? th?)',
N'Default Reason',
N'New Reason',
N'CPC - OTH - Các tiêu chu?n KH khác không ???c quy ??nh/ vi ph?m ?i?u ki?n trong ch??ng trình s?n ph?m'
)

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '04. Violated Tenor of product policy'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.[REMARKS]='MANUAL'
AND (C.[DEVIATION_CODE] in ('UW097') or C.DEVIATION_DESC IN (N'CPC - UNS - LT -Th?i gian vay t?i thi?u/ t?i ?a không ???c quy ??nh ho?c vi ph?m quy ??nh ch??ng trình s?n ph?m'))

--------------REASONS - AUTO------------------------ 
UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='16. Number of rejected app of applicant within 07 days before application login date >1'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR001')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='16. Number of rejected app of applicant within 07 days before application login date >1'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR001')


UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='02. Credit history FIs'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
--AND G2_NEW=N'01. Credit history'
AND C.DEVIATION_CODE IN ('RR002','RR004','RR012','STC008','CP028','HH003','UU00301','UU00303','UU00302',
'RR013','RR014','VNF001','TR003','BP003','DC001','UN004','SU002','MBC009','STC002','STC008','CTC002','TM002','SI005','AF002','RRS005','RRS006','RRS007','RRS008','RRS009',
'CO012','CT003','CT018','MB009','CP028','TC00301','TC00303','TR003','UM001','UM007','CM006','CM009','SPC001','PSL006','PSC006','STC00801','COMC001','UG007','UB008','CASL003','CASC003',
'SL007','UJ005','ODA010','ODS001','ODE008','ODP010','ADC004','COMM022','COMM026')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='02. Credit history FIs'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
--AND G2_NEW=N'01. Credit history'
AND C.DEVIATION_DESC IN ('RR002','RR004','RR012','STC008','CP028','HH003','UU00301','UU00303','UU00302',
'RR013','RR014','VNF001','TR003','BP003','DC001','UN004','SU002','MBC009','STC002','STC008','CTC002','TM002','SI005','AF002','RRS005','RRS006','RRS007','RRS008','RRS009',
'CO012','CT003','CT018','MB009','CP028','TC00301','TC00303','TR003','UM001','UM007','CM006','CM009','SPC001','PSL006','PSC006','STC00801','COMC001','UG007','UB008','CASL003','CASC003',
'SL007','UJ005','ODA010','ODS001','ODE008','ODP010','ADC004','COMM022','COMM026')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='01. Credit history VPBank'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR005','RR002','CP03502','UN014','UN011','MB008','TS00201','UN016','UU00301','CP03501','TU00201','TC00302','TC00201','TR003','MBC009',
'CO012','UU006','CT002','RR014','RR013','TU00301','TC00301','TR002','HH03','UU007','CO011','RR004','CP02801','UU00201','MB009','RR006',
'RR012','RR003','CT003','MBC020','CP02701','TS00301','HH002','SU002','SU003','CP02803','CP02703','UU00203','UU00303','TC00303','TC00203',
'HH003','HH002','SI005','TM001','TM002','STC002','AF001','AF002','CTC001','CTC002','STC008','ST007','RRS001','RRS002','RRS003','RRS004','RRS005','RRS006','RRS007','RRS008','RRS009',
'RR031','CP028','CP027','CP028','RR0311','RR0312','VNF001','HH025','HH026','COMC002','CASC004')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='01. Credit history VPBank'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR005','RR002','CP03502','UN014','UN011','MB008','TS00201','UN016','UU00301','CP03501','TU00201','TC00302','TC00201','TR003','MBC009',
'CO012','UU006','CT002','RR014','RR013','TU00301','TC00301','TR002','HH03','UU007','CO011','RR004','CP02801','UU00201','MB009','RR006',
'RR012','RR003','CT003','MBC020','CP02701','TS00301','HH002','SU002','SU003','CP02803','CP02703','UU00203','UU00303','TC00303','TC00203',
'HH003','HH002','SI005','TM001','TM002','STC002','AF001','AF002','CTC001','CTC002','STC008','ST007','RRS001','RRS002','RRS003','RRS004','RRS005','RRS006','RRS007','RRS008','RRS009',
'RR031','CP028','CP027','CP028','RR0311','RR0312','VNF001','HH025','HH026','COMC002','CASC004')

-------------------Unsecured Monthly-------------------
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Unsecured Monthly'
AND C.DEVIATION_CODE IN ('COMM011','COMM010','COMM014','COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Unsecured Monthly'
AND C.DEVIATION_DESC IN ('COMM011','COMM010','COMM014','COMM003')

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM020','COMM021') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM020','COMM021')  

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m','Tax Plus')
AND C.DEVIATION_DESC IN ('COMM022','COMM004') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m','Tax Plus')
AND C.DEVIATION_CODE IN ('COMM022','COMM004')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Unsecured Monthly'
AND C.DEVIATION_CODE IN ('COMM009')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Unsecured Monthly'
AND C.DEVIATION_DESC IN ('COMM009') 

-------------------Topup_STP-------------------

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Topup_STP'
AND C.DEVIATION_CODE IN ('COMM014','COMM010','COMM013','COMM011')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Topup_STP'
AND C.DEVIATION_DESC IN ('COMM014','COMM010','COMM013','COMM011')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Topup_STP'
AND C.DEVIATION_CODE IN ('COMM004')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME ='Topup_STP'
AND C.DEVIATION_DESC IN ('COMM004') 

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Topup_STP')
AND C.DEVIATION_CODE IN ('COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank' ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Topup_STP')
AND C.DEVIATION_DESC IN ('COMM003') 

-------------------Express/ Tax plus/ Kiosk-------------------

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_CODE IN ('COMM011','COMM010','COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_DESC IN ('COMM011','COMM010','COMM003') 


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_CODE IN ('COMM009')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_DESC IN ('COMM009') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Kiosk Owner')
AND C.DEVIATION_DESC IN ('COMM020','COMM021') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Kiosk Owner')
AND C.DEVIATION_CODE IN ('COMM020','COMM021')  

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Kiosk Owner','Tax Plus')
AND C.DEVIATION_DESC IN ('COMM022','COMM004') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Kiosk Owner','Tax Plus')
AND C.DEVIATION_CODE IN ('COMM022','COMM004')

-------------------UPL Pawning-------------------

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Pawning','UPL House Owner ')
AND C.DEVIATION_CODE IN ('COM003','COMM011','COMM010','COMM019','COMM014','COMM013','COMM020','RR00501','RR00601','RR006')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Pawning')
AND C.DEVIATION_DESC IN ('COM003','COMM011','COMM010','COMM019','COMM014','COMM013','COMM020','RR00501','RR00601','RR006')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Pawning')
AND C.DEVIATION_CODE IN ('COMM012','COMM004')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Pawning')
AND C.DEVIATION_DESC IN ('COMM012','COMM004')

-------------------UPL Ecommerce-------------------

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Ecommerce')
AND C.DEVIATION_CODE IN ('COM003','COMM013','COMM011','COMM010','COMM016','COMM014','COMM015')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Ecommerce')
AND C.DEVIATION_DESC IN ('COM003','COMM013','COMM011','COMM010','COMM016','COMM014','COMM015')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Ecommerce')
AND C.DEVIATION_CODE IN ('COMM012','COMM004')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Ecommerce')
AND C.DEVIATION_DESC IN ('COMM012','COMM004')


-------------------UPL Payoff 6m-------------------
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM010','COMM011','COMM003')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM010','COMM011','COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM009','COMM004')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM009','COMM004') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM020','COMM021') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM020','COMM021')  

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM022','COMM004') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM022','COMM004')


-------------------UPL House Owner------------------- 
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM009','COMM004')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM009','COMM004')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL House Owner')
AND C.DEVIATION_CODE IN ('COMM004','COMM012')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL House Owner')
AND C.DEVIATION_DESC IN ('COMM004','COMM012') 

---------------------------------------END---------------------------------------

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('COM002','COM003','COM004','COM005','COM006','COM00701','COM00801','RR005','RR006','RR00601',
'COMM014','COMM013','COMM003','RR009','RR008')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('COM002','COM003','COM004','COM005','COM006','COM00701','COM00801','RR005','RR006','RR00601',
'COMM014','COMM013','COMM003','RR009','RR008')  

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('COM01101','RR014','COM012','COM001','RR013','RR014','COMM004','RR004')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'02. Credit history FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('COM01101','RR014','COM012','COM001','RR013','RR014','COMM004','RR004')   

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='05. Negative List'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND C.SEVERITY='CRITICAL'
AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR011','RR016','RR008','RR009','RR022','RR023','TS001','UN017','UW105','UJ004')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='05. Negative List'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID 
AND B.BI_APPSSTATUS='REJECTED' AND C.SEVERITY='CRITICAL'
AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR011','RR016','RR008','RR009','RR022','RR023','TS001','UN017','UW105','UJ004')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '50. Kalapa Antifraud - Debt-Collection'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('KLP002') 

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '50. Kalapa Antifraud - Debt-Collection'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('KLP002')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '51. Kalapa Antifraud - Pre-Screening'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('KLP003')  

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '51. Kalapa Antifraud - Pre-Screening'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('KLP003') 


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '62. Kalapa Blacklist'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('KLP004','KLP005') 

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '62. Kalapa Blacklist'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('KLP004','KLP005')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '63. Number of enquiries from other FIs for this customer > 4 (90 days) & Gray'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('KLP006')  

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '63. Number of enquiries from other FIs for this customer > 4 (90 days) & Gray'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND C.SEVERITY='CRITICAL' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('KLP006') 



/*
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Credit history'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL AND  C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('COM002','COM003','COM004','COM005','COM006','COM00701','COM00801','COM01101','RR014','COM012','COM001')
;*/


UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='03. Sale Code/DAO is inactive or blocked'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' 
AND C.SEVERITY='CRITICAL'
AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('FT007') 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='03. Sale Code/DAO is inactive or blocked'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' 
AND C.SEVERITY='CRITICAL'
AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('FT007')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='03. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR007')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='03. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR007')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='04. Blacklist FEC'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR00701')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='04. Blacklist FEC'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR00701')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR007')  

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'01. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR007') 

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'05. Legal Documents not satisfied'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('COMM023') 
AND B.PRODUCT_NAME IN ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m') 

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW=N'05. Legal Documents not satisfied'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('COMM023') 
AND B.PRODUCT_NAME IN ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='07. Violated age condition of product policy'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('COM013','COM014','COMM001','COMM002','COMC007','COMC008','CASC002','CASC001')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='07. Violated age condition of product policy'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('COM013','COM014','COMM001','COMM002','COMC007','COMC008','CASC002','CASC001')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='08. Customer not in pre-approved list'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('COM015','COMM007')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='08. Customer not in pre-approved list'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('COM015','COMM007')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='04. Violated Tenor of product policy'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('COM017','COM20','COMM006','COMM008')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='04. Violated Tenor of product policy'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('COM017','COM20','COMM006','COMM008')


UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='35. Covid Policy location restrict'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('LC003','LC001')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='35. Covid Policy location restrict'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('LC003','LC001') 

update RMD_LOS_COMM_REPORT  
set G2_NEW = '10. Company/Employer is not qualified'
FROM RMD_LOS_COMM_REPORT b, RETAILRISK.DBO.DDS_DEVIATION_FACT c 
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR017','RR011')
AND C.SEVERITY = 'CRITICAL'  

update RMD_LOS_COMM_REPORT  
set G2_NEW = '10. Company/Employer is not qualified'
FROM RMD_LOS_COMM_REPORT b, RETAILRISK.DBO.DDS_DEVIATION_FACT c 
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR017','RR011')
AND C.SEVERITY = 'CRITICAL'  

update RMD_LOS_COMM_REPORT  
set G2_NEW = '19. Legal Documents not satisfied'
FROM RMD_LOS_COMM_REPORT b, RETAILRISK.DBO.DDS_DEVIATION_FACT c 
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('COMC005','CASC006')
AND C.SEVERITY = 'CRITICAL'  

update RMD_LOS_COMM_REPORT  
set G2_NEW = '19. Legal Documents not satisfied'
FROM RMD_LOS_COMM_REPORT b, RETAILRISK.DBO.DDS_DEVIATION_FACT c 
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('COMC005','CASC006')
AND C.SEVERITY = 'CRITICAL' 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='06. Fraud'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('FT008')
AND C.SEVERITY = 'CRITICAL'  

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='06. Fraud'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('FT008') 
AND C.SEVERITY = 'CRITICAL' 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '43. Policy 05 violation'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('CT005','CT05')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '43. Policy 05 violation'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('CT005','CT05')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '11. Customer income violates product procedures'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('TC011','CO01402','CO021','CP006','CP005','HH006','CP03401','CP03201','HH006','CP00501','CP00502','CO02101','CO02102',
'SL005','UB004','CASL007','CASC007','BDS003','ODA008','ODP008')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '11. Customer income violates product procedures'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('TC011','CO01402','CO021','CP006','CP005','HH006','CP03401','CP03201','HH006','CP00501','CP00502','CO02101','CO02102',
'SL005','UB004','CASL007','CASC007','BDS003','ODA008','ODP008') 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '30. Customer gender is not applied for this card type'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('SI008','UN003','RRS010','CT016','CO016','SU022','STC009','CTC012','AF007','CM007','PSC009','CASC008')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '30. Customer gender is not applied for this card type'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('SI008','UN003','RRS010','CT016','CO016','SU022','STC009','CTC012','AF007','CM007','PSC009','CASC008')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '66. Nationality not allowed by policy'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('RR015')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '66. Nationality not allowed by policy'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('RR015')




UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Rejected by combination of Phone & Field Verification'
FROM --RETAILRISK.DBO.RMD_MASTER_DATA A with (nolock),
RETAILRISK.DBO.DDS_PHONE_VRF_FACT F with (nolock),RETAILRISK.DBO.DDS_FIELD_VRF_FACT G with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)
WHERE b.APP_ID = F.APP_ID 
--AND A.APP_ID=B.APP_ID 
AND b.APP_ID=G.APP_ID
AND F.PHONE_VRF_RESULT IN ('4','6','8')
AND G.FIELD_VRF_RESULT IN ('5','6','8','N')
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 


UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Failed at Phone Verification'
FROM --RETAILRISK.DBO.RMD_MASTER_DATA A with (nolock),
RETAILRISK.DBO.DDS_PHONE_VRF_FACT F with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)
WHERE --A.APP_ID = F.APP_ID 
F.APP_ID=B.APP_ID
AND F.PHONE_VRF_RESULT = 'N'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 


UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '02. Failed at Field Verification'
FROM --RETAILRISK.DBO.RMD_MASTER_DATA A with (nolock),
RETAILRISK.DBO.DDS_FIELD_VRF_FACT F with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)
WHERE --A.APP_ID = F.APP_ID 
F.APP_ID=B.APP_ID
AND F.FIELD_VRF_RESULT = 'N'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Rejected by combination of Phone & Field Verification'
where app_no in ('LN2201155097069','LN2201155097122','LN2201135083108')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Rejected by combination of Phone & Field Verification'
FROM --RETAILRISK.DBO.RMD_MASTER_DATA A with (nolock),
RETAILRISK.DBO.DDS_PHONE_VRF_FACT F with (nolock),RETAILRISK.DBO.DDS_FIELD_VRF_FACT G with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)
WHERE --A.APP_ID = F.APP_ID 
F.APP_ID=B.APP_ID 
AND b.APP_ID=G.APP_ID
AND F.PHONE_VRF_RESULT IS NULL
AND G.FIELD_VRF_RESULT = '3'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Rejected by combination of Phone & Field Verification'
FROM --RETAILRISK.DBO.RMD_MASTER_DATA A with (nolock),
RETAILRISK.DBO.DDS_PHONE_VRF_FACT F,RETAILRISK.DBO.DDS_FIELD_VRF_FACT G with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)
WHERE --A.APP_ID = F.APP_ID 
b.APP_ID=F.APP_ID 
AND b.APP_ID=G.APP_ID
AND F.PHONE_VRF_RESULT IN ('N','5')
AND G.FIELD_VRF_RESULT IS NULL
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '06. Fraud'
FROM --RETAILRISK.DBO.RMD_MASTER_DATA A with (nolock),
RETAILRISK.DBO.DDS_PHONE_VRF_FACT F with (nolock),RETAILRISK.DBO.DDS_FIELD_VRF_FACT G with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)
WHERE --.APP_ID = F.APP_ID 
F.APP_ID=B.APP_ID 
AND B.APP_ID=G.APP_ID
--AND F.PHONE_VRF_RESULT IN ('N','5')
AND G.FIELD_VRF_RESULT ='7'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND B.PRODUCT_NAME <> 'UPL for Normal Household Business' 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='14. Location restrict'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_CODE IN ('TC012','MB010','MBC010','RR020','CP015','HH001','CO003','RR2001','HH004', 'TR005','RR018',
'RR0201','SU009','DR002','HH010','SI006','TM007','CTC011','VNF006','UM00402','UM00403','UM00404','CM00801','CM00802','CM00803',
'SPC00801','SPC00802','SL003','PSC003','UG013','CASL005','CASC005','CCP006','ODA005','ODP007','ODE007')

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='14. Location restrict'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE  B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND C.DEVIATION_DESC IN ('TC012','MB010','MBC010','RR020','CP015','HH001','CO003','RR2001','HH004', 'TR005','RR018',
'RR0201','SU009','DR002','HH010','SI006','TM007','CTC011','VNF006','UM00402','UM00403','UM00404','CM00801','CM00802','CM00803',
'SPC00801','SPC00802','SL003','PSC003','UG013','CASL005','CASC005','CCP006','ODA005','ODP007','ODE007')

---------------------UPL ELIGIBLE02-------------------------


--select distinct product_name from RMD_LOS_COMM_REPORT
--delete RMD_LOS_COMM_REPORT where creation_month >='2021-07'

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = N'03. Failed Minimum Limit'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.DDS_APP_DTI_DIM H with (nolock)
WHERE B.APP_ID = H.APP_ID
and B.PRODUCT_NAME = 'Topup_STP'
AND H.DTI000_APPROVED_LA_AMT <= '9999999'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Failed Minimum Limit'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.DDS_APP_DTI_DIM H with (nolock)
WHERE B.APP_ID = H.APP_ID 
AND CONVERT(BIGINT,H.DTI099_APPROVED_CC_LIMIT_AMT) <= '14999999'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND B.PRODUCT_NAME = 'Auto CC for TopUp HHB' 

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Failed Minimum Limit'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.DDS_APP_DTI_DIM H with (nolock)
WHERE B.APP_ID = H.APP_ID 
AND CONVERT(BIGINT,H.DTI000_APPROVED_LA_AMT) <= '20000000'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL 
and B.PRODUCT_NAME = 'UPL for CASA OTHER BANK'

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Failed Minimum Limit'
FROM DBO.RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.DDS_APP_DTI_DIM H with (nolock)
WHERE B.APP_ID = H.APP_ID 
AND CONVERT(BIGINT,H.DTI000_APPROVED_LA_AMT) <= '0'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
--AND B.PRODUCT_NAME in ('Tax Plus','UPL for CASA OTHER BANK')

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = N'01. Black Scoring'
FROM RMD_LOS_COMM_REPORT B with (nolock),RETAILRISK.DBO.DDS_DERIVED_ATTRIBUTE_DIM H with (nolock)
WHERE B.APP_ID = H.APP_ID 
AND B.PRODUCT_NAME IN 
(
'Kiosk Owner',
'Tax Plus ',
'Express',
'Unsecured Monthly',
'UPL House Owner',
'UPL for Normal Household Business',
'UPL for CASA OTHER BANK',
'UPL Pawning',
'UPL Payoff 6m'
)
AND H.RR_SCORE_COLOR ='Black'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL

UPDATE DBO.RMD_LOS_COMM_REPORT
SET G2_NEW='01. Black Scoring'
FROM RETAILRISK.DBO.STG_RLOS_DERIVED_ATTRIBUTE A with (nolock),DBO.RMD_LOS_COMM_REPORT B with (nolock)  
WHERE A.RR_SCORECOLOR ='Black' AND B.BI_APPSSTATUS='REJECTED' AND A.ApplicationID = B.APP_ID  
AND G2_NEW IS NULL
AND B.PRODUCT_NAME IN
(
'Auto CC for CASA OTHER BANK'
) 


/*
UPDATE B
SET B.G2_NEW = '01. Credit history VPBank'
FROM DBO.RMD_LOS_COMM_REPORT B WITH (NOLOCK), [RETAILRISK].[dbo].[STG_RLOS_APP] A WITH (NOLOCK)
WHERE A.[ApplicationID] = B.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND A.[IMAXDPD] >='90'

update RMD_LOS_COMM_REPORT
set g1_new =null
where CREATION_MONTH>='2021-07' and PRODUCT_NAME = 'Topup_STP' and g2_new ='01. Black Scoring'

*/


/*UPDATE B
SET B.G2_NEW = N'01. Black Scoring'
FROM RMD_LOS_COMM_REPORT B WITH (NOLOCK), DDS_WORKFLOW_FACT A WITH (NOLOCK)
--,RETAILRISK.DBO.DDS_DERIVED_ATTRIBUTE_DIM H with (nolock)
WHERE A.APP_ID = B.APP_ID 
--AND B.APP_ID=H.APP_ID 
--AND H.RR_SCORE_COLOR ='Gray' 
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND A.STEP IN ('Eligible 02','Eligible 03')
AND A.RESULT='Path selected is Reject' 
and b.PRODUCT_NAME in ('Kiosk Owner',
'Tax Plus ',
'Express',
'Unsecured Monthly',
'UPL House Owner',
'UPL for Normal Household Business',
'UPL for CASA OTHER BANK',
'UPL Pawning',
'UPL Payoff 6m')*/


/*UPDATE B
SET B.G2_NEW = N'01. Black Scoring'
FROM RMD_LOS_COMM_REPORT B WITH (NOLOCK),RETAILRISK.DBO.DDS_DERIVED_ATTRIBUTE_DIM H with (nolock)
WHERE  B.APP_ID=H.APP_ID 
AND H.RR_SCORE_COLOR ='Gray' 
AND PRODUCT_NAME IN 
('Express', 'Kiosk Owner', 'Tax Plus', 'Unsecured Monthly')
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL*/




/*
--SELECT DISTINCT G2_NEW FROM RMD_LOS_COMM_REPORT
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW='03. Blacklist VPBank'
WHERE G2_NEW='02. Credit history FIs'

select * from RMD_LOS_COMM_REPORT where g2_new is null and BI_APPSSTATUS='rejected'
update RMD_LOS_COMM_REPORT set g1_new =null where g2_new is null and BI_APPSSTATUS='rejected'
DDS_WORKFLOW_FACT
*/

-------------------REJECTION WF--------------------
/*
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Blacklist VPBank'
WHERE BI_APPSSTATUS='REJECTED' AND G2_NEW IS NULL
*/

/*UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '03. Failed Minimum Limit'
WHERE BI_APPSSTATUS='REJECTED' AND G2_NEW IS NULL*/

/*
UPDATE B
SET B.G2_NEW = '01. Blacklist VPBank'
FROM RMD_LOS_COMM_REPORT B WITH (NOLOCK), DDS_WORKFLOW_FACT A WITH (NOLOCK)
WHERE A.APP_ID = B.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL
AND A.STEP='Blacklist Found'
AND A.RESULT like '%Y%'
*/
/*
UPDATE RMD_LOS_COMM_REPORT SET G2_NEW=N'01. Blacklist VPBank',G1_NEW=N'03. Other risk criterias'  WHERE APP_ID='fe0da895446b4af3ae70021ee792e95f'
SELECT * FROM RMD_LOS_COMM_REPORT A,RETAILRISK.DBO.DDS_DEVIATION_FACT B
 WHERE BI_APPSSTATUS='REJECTED' AND G1_NEW IS NULL AND A.APP_ID=B.APP_ID
--LN2109224357526
SELECT * FROM RETAILRISK.DBO.DDS_DEVIATION_FACT WHERE APP_ID='f61f2778bb7945c0980016e3e01827e4'
--SELECT * FROM RMD_LOS_COMM_REPORT WHERE  BI_APPSSTATUS='REJECTED' AND G1_NEW IS NULL
*/
---------------------------LEFTOVER CHECK----------------------------------
/*
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = 'NEED TO BE CHECK'
FROM RETAILRISK.DBO.RMD_MASTER_DATA A,RMD_LOS_COMM_REPORT B,DDS_WORKFLOW_FACT I
WHERE A.APP_ID = B.APP_ID AND A.APP_ID=I.APP_ID
AND I.STEP = 'Eligible 01'
AND [RESULT]='Path selected is Reject'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL;

---------------------------Blacklist----------------------------------
UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Credit history'
FROM RETAILRISK.DBO.RMD_MASTER_DATA A,RMD_LOS_COMM_REPORT B,DDS_WORKFLOW_FACT I
WHERE A.APP_ID = B.APP_ID AND A.APP_ID=I.APP_ID
AND I.STEP = 'Blacklist Found'
AND [RESULT]='Path selected is Y'
AND B.BI_APPSSTATUS='REJECTED' AND B.G2_NEW IS NULL;
*/
-------------------------------------------------------------------- 

------------------------------------------------------------------------------G3_NEW RULE NAME------------------------------------------------------------------------------   
--------------------------Policy related to Sales responsibilities--------------------------
UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G3_NEW=N'Customer ID age > 15 years'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM023') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G3_NEW=N'Customer ID age > 15 years'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM023')



--------------------------Credit history FIs--------------------------
UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G3_NEW=N'Within last 36m, Customer or Co-borrower had debt > G2 at other FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM004') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G3_NEW=N'Within last 36m, Customer or Co-borrower had debt > G2 at other FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM004')
 
UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Customer got written off at other FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('RR014') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Customer got written off at other FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL 
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('RR014') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Customer got restructured at other FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('RR013') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner','UPL Payoff 6m')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Customer got restructured at other FIs'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL 
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('RR013') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner','UPL Payoff 6m') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW= N'Within recent 24m, Customer or Co-borrower had G3-G5 at Other Fis'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_CODE IN ('COMM009')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW = N'Within recent 24m, Customer or Co-borrower had G3-G5 at Other Fis'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' 
AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_DESC IN ('COMM009') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Customer had G2 at other FIs + PCB Score <= 410'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m','Tax Plus ')
AND C.DEVIATION_DESC IN ('COMM022') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Customer had G2 at other FIs + PCB Score <= 410'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m','Tax Plus ')
AND C.DEVIATION_CODE IN ('COMM022')



--------------------------Credit history VPBank-------------------------- 
UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G3_NEW=N'Within recent 36m, Customer or Co-borrower had G3_G5 at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM020','COMM021') 

UPDATE RMD_LOS_COMM_REPORT ---------------bo sung ngay 13/06/2022 sau go-live PP2021-2246
SET G3_NEW=N'Within recent 36m, Customer or Co-borrower had G3_G5 at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner','UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM020','COMM021') 


UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 24m, Customer or Co-borrower had G3-G5 at VPB'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_CODE IN ('COMM011','COMM010','COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 24m, Customer or Co-borrower had G3-G5 at VPB'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Express','Tax Plus','Kiosk Owner')
AND C.DEVIATION_DESC IN ('COMM011','COMM010','COMM003') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'From recent 24m to 36m, Customer or Co_borrower has G3-G5 for loan at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('COMM014','COMM013') 
and b.PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'From recent 24m to 36m, Customer or Co_borrower has G3-G5 for loan at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('COMM014','COMM013')  
and b.PRODUCT_NAME in ('Unsecured Monthly','Express','Kiosk Owner')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 36m, Spouse had G3-G5 at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('COMM015','COMM016') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 36m, Spouse had G3-G5 at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL 
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('COMM015','COMM016') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Spouse had G3-G5 at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('COMM017','COMM018') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Spouse had G3-G5 at VPBank'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL 
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('COMM017','COMM018') 
and b.PRODUCT_NAME in ('Express','Unsecured Monthly','Kiosk Owner') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Customer had debt overdue > 30 days + PCB Score <= 410'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_CODE IN ('COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Customer had debt overdue > 30 days + PCB Score <= 410'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('UPL Payoff 6m')
AND C.DEVIATION_DESC IN ('COMM003') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Customer had debt overdue > 30 days + BScore = Low'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Topup_STP')
AND C.DEVIATION_CODE IN ('COMM003')

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Within recent 12m, Customer had debt overdue > 30 days + BScore = Low'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND PRODUCT_NAME in ('Topup_STP')
AND C.DEVIATION_DESC IN ('COMM003') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Spouse currently having overdue loans'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_DESC IN ('RR00601') 

UPDATE RMD_LOS_COMM_REPORT
SET G3_NEW=N'Spouse currently having overdue loans'
FROM RMD_LOS_COMM_REPORT B with (nolock), RETAILRISK.DBO.DDS_DEVIATION_FACT C with (nolock)
WHERE B.APP_ID = C.APP_ID
AND B.BI_APPSSTATUS='REJECTED' AND B.G3_NEW IS NULL
AND C.SEVERITY='CRITICAL'
AND C.DEVIATION_CODE IN ('RR00601')
-------------------G3_NEW RULE NAME--------------------

UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '01. Sale responsibilities'
WHERE G2_NEW IN 
(
N'01. Customer have no demand',
N'02. Location restrict',
N'03. Sale Code/DAO is inactive or blocked',
N'04. Violated Tenor of product policy',
N'05. Legal Documents not satisfied',
N'06. Customer income violates product procedures',
N'07. Violated age condition of product policy',
N'08. Customer not in pre-approved list',
N'09. Working experiences/ Contract time/ Ownership/ Employment Type is not satisfied',
N'10. Company/Employer/ Teacher Type is not qualified',
N'11. Customer income violates product procedures',
N'12. Others',
N'13. Violated Tenor of product policy',
N'14. Location restrict',
--N'15. CIF not in TOP-UP list',
N'19. Legal Documents not satisfied',
N'20. Information Discrepancy (income docs,...)',
N'21. Income Documents not satisfied',
N'33. Household Product Policy not satisfied',
N'34. Customers belongs to TIMO',
N'35. Covid Policy location restrict',
N'19. Legal Documents not satisfied',
N'16. Number of rejected app of applicant within 07 days before application login date >1', 
N'66. Nationality not allowed by policy',
N'30. Customer gender is not applied for this card type'
)


UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '02. Risk criterias'
WHERE G2_NEW IN 
(
N'01. Blacklist VPBank',
N'01. Credit history VPBank',
N'02. Credit history FIs',
N'03. Blacklist VPBank',
N'04. Blacklist FEC',
N'05. Negative List',
N'03. Negative List',
N'06. Fraud',
N'04. Fraud',
N'03. Fraud',
N'50. Kalapa Antifraud - Debt-Collection',
N'51. Kalapa Antifraud - Pre-Screening', 
N'62. Kalapa Blacklist' ,
N'63. Number of enquiries from other FIs for this customer > 4 (90 days) & Gray'
)

UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '03. Black Scoring'
WHERE G2_NEW IN 
(
N'01. Black Scoring',
N'02. Black Scoring'
)

--SELECT * FROM RMD_LOS_COMM_REPORT WHERE CREATION_MONTH>='2021-07' AND G2_NEW IS NOT NULL AND G1_NEW IS NULL

UPDATE RMD_LOS_COMM_REPORT
SET G2_NEW = '01. Credit history'
WHERE G2_NEW = '02. Credit history'
/*
UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '02. Risk criterias'
WHERE G2_NEW IN 
(
N'01. Credit history VPBank',
N'02. Credit history FIs',
N'03. Fraud'
)
*/
/*
UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '03. Other risk criterias'
WHERE G2_NEW IN 
(
'01. Blacklist VPBank',
'02. Blacklist FEC',
'03. Negative List'
)
*/


UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '04. Verification'
WHERE G2_NEW IN 
(
'01. Failed at Phone Verification', 
'02. Failed at Field Verification',
'03. Rejected by combination of Phone & Field Verification'
)

UPDATE RMD_LOS_COMM_REPORT
SET G1_NEW = '05. Capacity'
WHERE G2_NEW IN 
(
'03. Failed Minimum Limit'
)


----------------DATA BEAUTY-----------------------------
--UPDATE RMD_LOS_COMM_REPORT SET BI_REGION= NULL

UPDATE B
SET B.BI_REGION = 'HH VUNG 1'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE B.BRANCH_NAME IN
(
N'HH - BAC GIANG 1',
N'HH - BAC NINH 1',
N'HH - CAU GIAY 1',
N'HH - DONG ANH 1',
N'HH - HA DONG 1',
N'HH - HA LONG 1',
N'HH - HAI DUONG 2',
N'HH - PHUC YEN 1',
N'HH - THAI NGUYEN 2',
N'HH - THANH TRI 1',
N'HH - VIET TRI 1'
)

UPDATE B
SET B.BI_REGION = 'HH VUNG 2'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE B.BI_REGION IS NULL
AND B.BRANCH_NAME IN
(
N'HH - DONG HOI 1',
N'HH - HA TINH 1',
N'HH - HOA BINH 1',
N'HH - HUNG YEN HS',
N'HH - NAM DINH 1',
N'HH - NINH BINH HS',
N'HH - PHU LY HS',
N'HH - THAI BINH 1',
N'HH - THANH HOA 1',
N'HH - THANH HOA 2',
N'HH - VINH 1'
)

UPDATE B
SET B.BI_REGION = 'HH VUNG 3'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE B.BI_REGION IS NULL
AND  B.BRANCH_NAME IN
(
N'HH - BINH DINH 1',
N'HH - BINH THUAN 1',
N'HH - DA LAT 1',
N'HH - DA NANG 1',
N'HH - DAK LAK 2',
N'HH - DONG HA 1',
N'HH - GIA LAI 1',
N'HH - HUE 1',
N'HH - NHA TRANG 1',
N'HH - PHU HOI 1',
N'HH - QUANG NAM 1'
)

UPDATE B
SET B.BI_REGION = 'HH VUNG 4'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE B.BI_REGION IS NULL
AND B.BRANCH_NAME IN
(
N'HH - BINH CHANH 1',
N'HH - BINH DUONG 3',
N'HH - BINH TAN 1',
N'HH - CU CHI 1',
N'HH - D7 1',
N'HH - DI AN',
N'HH - DONG NAI',
N'HH - GO VAP 2',
N'HH - HO NAI 2',
N'HH - TAN BINH 3',
N'HH - VUNG TAU 1'
)

UPDATE B
SET B.BI_REGION = 'HH VUNG 5'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE B.BI_REGION IS NULL
AND B.BRANCH_NAME IN
(
N'HH - BEN LUC',
N'HH - CA MAU HS',
N'HH - CAN THO 1',
N'HH - CHAU DOC 1',
N'HH - DONG THAP 1',
N'HH - KIEN GIANG 1',
N'HH - LONG AN',
N'HH - LONG XUYEN 2',
N'HH - MY THO 1',
N'HH - TAY NINH HS',
N'HH - VINH LONG 2'
)

UPDATE B
SET B.BI_REGION = 'OTHERS'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE B.BI_REGION IS NULL

UPDATE B
SET B.PROVINCE = 'An Giang'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - CHAU DOC 1',
N'HH - LONG XUYEN 2'
)

UPDATE B
SET B.PROVINCE = N'B?c Giang'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BAC GIANG 1'
)

UPDATE B
SET B.PROVINCE = N'B?c Ninh'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BAC NINH 1'
)

UPDATE B
SET B.PROVINCE = N'Bình ??nh'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BINH DINH 1'
)

UPDATE B
SET B.PROVINCE = N'Bình D??ng'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BINH DUONG 3',
N'HH - DI AN'
)

UPDATE B
SET B.PROVINCE = N'Bình Thu?n'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BINH THUAN 1'
)

UPDATE B
SET B.PROVINCE = N'Cà Mau'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - CA MAU HS'
)

UPDATE B
SET B.PROVINCE = N'C?n Th?'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - CAN THO 1'
)

UPDATE B
SET B.PROVINCE = N'?à L?t'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DA LAT 1'
)

UPDATE B
SET B.PROVINCE = N'?à N?ng'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DA NANG 1'
)

UPDATE B
SET B.PROVINCE = N'?à N?ng'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DA NANG 1'
)

UPDATE B
SET B.PROVINCE = N'Daklak'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DAK LAK 2'
)

UPDATE B
SET B.PROVINCE = N'??ng Nai'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DONG NAI',
N'HH - HO NAI 2'
)

UPDATE B
SET B.PROVINCE = N'??ng Tháp'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DONG THAP 1'
)

UPDATE B
SET B.PROVINCE = N'Gia Lai'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - Gia Lai 1'
)

UPDATE B
SET B.PROVINCE = N'Hà Nam'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - Phu Ly HS'
)

UPDATE B
SET B.PROVINCE = N'Hà N?i'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HA DONG 1',
N'HH - THANH TRI 1',
N'HH - CAU GIAY 1',
N'HH - DONG ANH 1'
)

UPDATE B
SET B.PROVINCE = N'Hà T?nh'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HA TINH 1'
)

UPDATE B
SET B.PROVINCE = N'H?i D??ng'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HAI DUONG 2'
)

UPDATE B
SET B.PROVINCE = N'HCM'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BINH CHANH 1',
N'HH - Binh Tan 1',
N'HH - D7 1',
N'HH - CU CHI 1',
N'HH - GO VAP 2',
N'HH - TAN BINH 3'
)

UPDATE B
SET B.PROVINCE = N'Hòa Bình'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HOA BINH 1'
)

UPDATE B
SET B.PROVINCE = N'Hu?'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HUE 1',
N'HH - PHU HOI 1'
)

UPDATE B
SET B.PROVINCE = N'H?ng Yên'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HUNG YEN HS'
)

UPDATE B
SET B.PROVINCE = N'Kiên Giang'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - KIEN GIANG 1'
)

UPDATE B
SET B.PROVINCE = N'Long An'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - BEN LUC',
N'HH - LONG AN'
)

UPDATE B
SET B.PROVINCE = N'Nam ??nh'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - NAM DINH 1'
)

UPDATE B
SET B.PROVINCE = N'Ngh? An'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - VINH 1'
)

UPDATE B
SET B.PROVINCE = N'Nha Trang'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - Nha Trang 1'
)

UPDATE B
SET B.PROVINCE = N'Ninh Bình'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - Ninh Binh HS'
)

UPDATE B
SET B.PROVINCE = N'Phú Th?'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - VIET TRI 1'
)

UPDATE B
SET B.PROVINCE = N'Qu?ng Bình'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DONG HOI 1'
)

UPDATE B
SET B.PROVINCE = N'Qu?ng Nam'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - QUANG NAM 1'
)

UPDATE B
SET B.PROVINCE = N'Qu?ng Ninh'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - HA LONG 1'
)

UPDATE B
SET B.PROVINCE = N'Qu?ng Tr?'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - DONG HA 1'
)

UPDATE B
SET B.PROVINCE = N'Tây Ninh'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - TAY NINH HS'
)

UPDATE B
SET B.PROVINCE = N'Thái Bình'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - THAI BINH 1'
)

UPDATE B
SET B.PROVINCE = N'Thái Nguyên'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - THAI NGUYEN 2'
)

UPDATE B
SET B.PROVINCE = N'Thanh Hóa'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - THANH HOA 1',
N'HH - THANH HOA 2'
)

UPDATE B
SET B.PROVINCE = N'Ti?n Giang'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - MY THO 1'
)

UPDATE B
SET B.PROVINCE = N'V?nh Long'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - VINH LONG 2'
)

UPDATE B
SET B.PROVINCE = N'V?nh Phúc'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - PHUC YEN 1'
)

UPDATE B
SET B.PROVINCE = N'V?ng Tàu'
FROM RMD_LOS_COMM_REPORT B with (nolock)
WHERE  B.BRANCH_NAME IN
(
N'HH - VUNG TAU 1'
)
/*
UPDATE A
SET A.CUSTOMER_TYPE='ETB'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('2','4','5','6','7','8')

UPDATE A
SET A.CUSTOMER_TYPE='NTB'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('1')

UPDATE A
SET A.CUSTOMER_TYPE='Relaxed Policy'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('9')

UPDATE A
SET A.CUSTOMER_TYPE='Others'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.DESCRIPTION ='No selected'

--ALTER TABLE RMD_LOS_COMM_REPORT ADD CUST_DES NVARCHAR(30)

UPDATE A
SET A.CUST_DES='New customer'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('1')

UPDATE A
SET A.CUST_DES='Existing customer'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('2')

UPDATE A
SET A.CUST_DES='No Selected'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.DESCRIPTION ='No selected'

UPDATE A
SET A.CUST_DES='Top up _ No change'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('4')

UPDATE A
SET A.CUST_DES='Top up _ Upgrade'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('5')

UPDATE A
SET A.CUST_DES='Top up _ Downgrade'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('6')

UPDATE A
SET A.CUST_DES='Top up _ Change Product'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('7')

UPDATE A
SET A.CUST_DES='Top up _ STP'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('8')

UPDATE A
SET A.CUST_DES='Customer with relaxed policy'
FROM RMD_LOS_COMM_REPORT A,  RMD_LOS_COM_EXTRA B
WHERE A.APP_NO = B.SZDISPLAYAPPLICATIONNO
AND B.SZCUSTOMERTYPEHH IN ('9')

SELECT * FROM RMD_LOS_COMM_REPORT
DELETE FROM  RMD_LOS_COMM_REPORT WHERE BI_APPSSTATUS='REJECTED' AND G1_NEW IS NULL
*/
--------------------------------------------------------------
--DELETE FROM RMD_LOS_COMM_REPORT WHERE BI_APPSSTATUS='REJECTED' AND G2_NEW IS NULL  

--ALTER TABLE DBO.RMD_LOS_COMM_REPORT ADD FIN_PRODUCT NVARCHAR(100)  
 update RMD_LOS_COMM_REPORT 
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

--ALTER TABLE DBO.RMD_LOS_COMM_REPORT ADD CREATION_PERIOD NVARCHAR(100)  

update RMD_LOS_COMM_REPORT 
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

update RMD_LOS_COMM_REPORT 
  set WEEK = CASE WHEN DAY(CREATION_date)  >= 01 AND DAY(CREATION_date)  <=07 THEN CONCAT(CREATION_MONTH,'-W1' )
			WHEN DAY(CREATION_date)  >= 08 AND DAY(CREATION_date)  <=15 THEN CONCAT(CREATION_MONTH,'-W2')
			WHEN DAY(CREATION_date)  >= 16 AND DAY(CREATION_date)  <=23 THEN CONCAT(CREATION_MONTH,'-W3')
				ELSE CONCAT(CREATION_MONTH,'-W4') END 

UPDATE RMD_LOS_COMM_REPORT
SET CUST_TYPE='NO SELECTED'
WHERE CUST_TYPE IS NULL 

--alter table RMD_LOS_COMM_REPORT add SOURCE_CHANNEL NVARCHAR(MAX)
UPDATE RMD_LOS_COMM_REPORT 
SET  SOURCE_CHANNEL = case when  DATA_SOURCE IN ('JARVISR3PA','JARVISR3NONPA','JARVISR2NONPA')  THEN 'JV Sales' 
						   when  DATA_SOURCE IN ('JARVIS_ROUND3CUS_VKYC','JARVISCUSR3VER',
													'JARVIS_ROUND3CUS_PHYSICALKYC','JARVIS_ROUND2CUS_VERIFIFED','JARVIS_ROUND2CUS_NONVERIFIFED') then 'JV Customer'  
						   when DATA_SOURCE in ('BEFINUPLPA') THEN 'BE Finance' 
						   when DATA_SOURCE in ('DFCCMAD','DFCCW','DFUPLW') THEN 'DF Web' 
						   when DATA_SOURCE like ('DF%') THEN 'DF Web' 
						   when DATA_SOURCE in ('OCBUPLCOMMTOPUP','OCBUPLPA') THEN 'OCB (VPBank NEO)' 
						   when DATA_SOURCE like ('OCB%') THEN 'OCB (VPBank NEO)' 
						   when data_source in ('EKYC_ROUND3CUS_PHYSICALKYC','EKYC_ROUND2CUS_NTB','EKYC_ROUND3CUS_VKYC') then 'eKYC Bundle'
							else 'Offline - LOS input app'	
						END 

--ALTER TABLE RMD_LOS_COMM_REPORT ADD DISBURSED_YN NUMERIC
UPDATE RMD_LOS_COMM_REPORT 
SET  DISBURSED_YN =  1  
FROM RMD_LOS_COMM_REPORT A, 
		RETAILRISK.DBO.RMD_MASTER_DATA_LAST C WITH (NOLOCK) 
		WHERE a.APP_NO = c.APP_NO and c.CONTRACT_NO is not null  

UPDATE RMD_LOS_COMM_REPORT 
SET  DISBURSED_YN =  0   
		WHERE DISBURSED_YN is null 

--DELETE FROM RMD_LOS_COMM_REPORT WHERE BI_APPSSTATUS IN ('CANCEL','PROCESSING')

delete from RMD_LOS_COMM_REPORT 
where app_no in 
(select distinct app_no from RMD_LOS_DAILY_APPLICATION_REPORT_INTERNAL_DUC_FINAL)

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

