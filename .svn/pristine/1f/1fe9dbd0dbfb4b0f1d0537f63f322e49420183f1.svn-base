SELECT TFINFO.L_FUND_ID AS VC_BOND_ID,
       TFINFO.VC_FUND_CODE AS VC_BOND_CODE,
       TFINFO.VC_FUND_NAME AS VC_BOND_NAME,
       TFINFO.VC_ASSET_NAME AS VC_MR_FFDY,
       FAINFO.D_CREATE AS D_PRODUCT_ESTABLISH,
       FAINFO.D_DQRQ AS D_PRODUCT_CLEAR,
       TFINFO.C_FUND_STATUS,
       DETAIL.VC_CHECK_SUPERVISOR_NAME AS VC_VALUATION_MANAGER, --估值经理
       DBMS_LOB.SUBSTR(SUB.PARTY_FULL_NAME) AS VC_TRUSTEESHIP, --托管行
       DBMS_LOB.SUBSTR(SUB1.PARTY_FULL_NAME) AS VC_INVESTMENT_ADVISER, --投顾
       DBMS_LOB.SUBSTR(SUB2.PARTY_FULL_NAME) AS VC_CUSTODIAN, --委托人
       DBMS_LOB.SUBSTR(SUB3.FUNDMGR_NAME) AS VC_CUSTOMER_MANAGER, --客户经理
       DBMS_LOB.SUBSTR(SUB4.FUNDMGR_NAME) AS VC_INVESTMENT_MANAGER --投资经理
  FROM (SELECT t.L_FUND_ID, t.VC_FUND_CODE, t.VC_FUND_NAME, t.C_FUND_STATUS,t.vc_asset_name
          FROM (
          SELECT INFO.*,SSET.VC_ASSET_NAME FROM STAGE.FM_TFUNDINFO INFO LEFT JOIN STAGE.FM_TASSET SSET ON
 INFO.L_DEFAULT_ASSET=SSET.L_ASSET_ID AND INFO.L_FUND_ID=SSET.L_FUND_ID
          ) T
         WHERE T.C_FUND_STATUS != '5') TFINFO
  LEFT JOIN (SELECT T.D_CREATE, T.D_DQRQ, T.VC_CODE
               FROM STAGE.FA_TFUNDINFO T
               LEFT JOIN STAGE.FA_TSYSINFO F
                 ON T.L_FUNDID = F.L_ID
              WHERE F.L_VOID = '0') FAINFO
    ON TFINFO.VC_FUND_CODE = FAINFO.VC_CODE
  LEFT JOIN STAGE.OMS_T_OMS_PRODUCT_DETAIL DETAIL
    ON TFINFO.VC_FUND_CODE = DETAIL.VC_PRODUCT_CODE
  LEFT JOIN (SELECT FUND_CODE,
                    LISTAGG(PARTY_FULL_NAME, ',') WITHIN GROUP(ORDER BY(T.PARTY_FULL_NAME)) AS PARTY_FULL_NAME
               FROM (SELECT OP.PARTY_FULL_NAME,
                            CASE
                              WHEN INSTR(OPC.FUND_CODE, ',', 1, 1) = 0 THEN
                               OPC.FUND_CODE
                              ELSE
                               SUBSTR(OPC.FUND_CODE,
                                      1,
                                      INSTR(OPC.FUND_CODE, ',', 1, 1) - 1)
                            END AS FUND_CODE
                       FROM STAGE.PLMS_PM_PROD_PARTICIPANT P
                       LEFT JOIN STAGE.PLMS_PM_OPEN_PARTY_INFO OP
                         ON P.PARTY_ID = OP.PARTY_ID
                       LEFT JOIN STAGE.PLMS_PM_PROD_BASIC_INFO M
                         ON P.BIZ_ID = M.SYSID
                       LEFT JOIN STAGE.PLMS_PM_PROD_COMM_INFO OPC
                         ON M.PROD_ID = OPC.SYSID
                      WHERE OP.PARTY_TYPE = '02'
                        AND M.BIZ_TYPE = 'product'
                        AND M.CURRENT_VERSION = 'y'
                        AND OPC.FUND_CODE IS NOT NULL
                      GROUP BY OPC.FUND_CODE, OP.PARTY_FULL_NAME) T
              GROUP BY FUND_CODE) SUB
    ON SUB.FUND_CODE = TFINFO.VC_FUND_CODE
  LEFT JOIN (SELECT FUND_CODE,
                    LISTAGG(PARTY_FULL_NAME, ',') WITHIN GROUP(ORDER BY(T.PARTY_FULL_NAME)) AS PARTY_FULL_NAME
               FROM (SELECT OP.PARTY_FULL_NAME,
                            CASE
                              WHEN INSTR(OPC.FUND_CODE, ',', 1, 1) = 0 THEN
                               OPC.FUND_CODE
                              ELSE
                               SUBSTR(OPC.FUND_CODE,
                                      1,
                                      INSTR(OPC.FUND_CODE, ',', 1, 1) - 1)
                            END AS FUND_CODE
                       FROM STAGE.PLMS_PM_PROD_PARTICIPANT P
                       LEFT JOIN STAGE.PLMS_PM_OPEN_PARTY_INFO OP
                         ON P.PARTY_ID = OP.PARTY_ID
                       LEFT JOIN STAGE.PLMS_PM_PROD_BASIC_INFO M
                         ON P.BIZ_ID = M.SYSID
                       LEFT JOIN STAGE.PLMS_PM_PROD_COMM_INFO OPC
                         ON M.PROD_ID = OPC.SYSID
                      WHERE OP.PARTY_TYPE = '06'
                        AND M.BIZ_TYPE = 'product'
                        AND M.CURRENT_VERSION = 'y'
                        AND OPC.FUND_CODE IS NOT NULL
                      GROUP BY OPC.FUND_CODE, OP.PARTY_FULL_NAME) T
              GROUP BY FUND_CODE) SUB1
    ON SUB1.FUND_CODE = TFINFO.VC_FUND_CODE
  LEFT JOIN (SELECT FUND_CODE,
                    LISTAGG(PARTY_FULL_NAME, ',') WITHIN GROUP(ORDER BY(T.PARTY_FULL_NAME)) AS PARTY_FULL_NAME
               FROM (SELECT OP.PARTY_FULL_NAME,
                            CASE
                              WHEN INSTR(OPC.FUND_CODE, ',', 1, 1) = 0 THEN
                               OPC.FUND_CODE
                              ELSE
                               SUBSTR(OPC.FUND_CODE,
                                      1,
                                      INSTR(OPC.FUND_CODE, ',', 1, 1) - 1)
                            END AS FUND_CODE
                       FROM STAGE.PLMS_PM_PROD_PARTICIPANT P
                       LEFT JOIN STAGE.PLMS_PM_OPEN_PARTY_INFO OP
                         ON P.PARTY_ID = OP.PARTY_ID
                       LEFT JOIN STAGE.PLMS_PM_PROD_BASIC_INFO M
                         ON P.BIZ_ID = M.SYSID
                       LEFT JOIN STAGE.PLMS_PM_PROD_COMM_INFO OPC
                         ON M.PROD_ID = OPC.SYSID
                      WHERE OP.PARTY_TYPE = '20'
                        AND M.BIZ_TYPE = 'product'
                        AND M.CURRENT_VERSION = 'y'
                        AND OPC.FUND_CODE IS NOT NULL
                      GROUP BY OPC.FUND_CODE, OP.PARTY_FULL_NAME) T
              GROUP BY FUND_CODE) SUB2
    ON SUB2.FUND_CODE = TFINFO.VC_FUND_CODE
  LEFT JOIN (SELECT FUND_CODE,
                    LISTAGG(T.FUNDMGR_NAME, ',') WITHIN GROUP(ORDER BY(T.FUNDMGR_NAME)) AS FUNDMGR_NAME
               FROM (SELECT DISTINCT M.FUNDMGR_NAME,
                                     CASE
                                       WHEN INSTR(B.FUND_CODE, ',', 1, 1) = 0 THEN
                                        B.FUND_CODE
                                       ELSE
                                        SUBSTR(B.FUND_CODE,
                                               1,
                                               INSTR(B.FUND_CODE, ',', 1, 1) - 1)
                                     END AS FUND_CODE
                       FROM STAGE.PLMS_PM_PROD_FUNDMGR M
                       LEFT JOIN STAGE.PLMS_PM_PROD_BASIC_INFO A
                         ON M.PROD_ID = A.PROD_ID
                       LEFT JOIN STAGE.PLMS_PM_PROD_COMM_INFO B
                         ON A.PROD_ID = B.SYSID
                      WHERE M.FUNDMGR_TYPE = '4'
                        AND A.BIZ_TYPE = 'product'
                        AND A.CURRENT_VERSION = 'y'
                        AND B.FUND_CODE IS NOT NULL) T
              GROUP BY FUND_CODE) SUB3
    ON SUB3.FUND_CODE = TFINFO.VC_FUND_CODE
  LEFT JOIN (SELECT FUND_CODE,
                    LISTAGG(T.FUNDMGR_NAME, ',') WITHIN GROUP(ORDER BY(T.FUNDMGR_NAME)) AS FUNDMGR_NAME
               FROM (SELECT DISTINCT M.FUNDMGR_NAME,
                                     CASE
                                       WHEN INSTR(B.FUND_CODE, ',', 1, 1) = 0 THEN
                                        B.FUND_CODE
                                       ELSE
                                        SUBSTR(B.FUND_CODE,
                                               1,
                                               INSTR(B.FUND_CODE, ',', 1, 1) - 1)
                                     END AS FUND_CODE
                       FROM STAGE.PLMS_PM_PROD_FUNDMGR M
                       LEFT JOIN STAGE.PLMS_PM_PROD_BASIC_INFO A
                         ON M.PROD_ID = A.PROD_ID
                       LEFT JOIN STAGE.PLMS_PM_PROD_COMM_INFO B
                         ON A.PROD_ID = B.SYSID
                      WHERE M.FUNDMGR_TYPE = '2'
                        AND A.BIZ_TYPE = 'product'
                        AND A.CURRENT_VERSION = 'y'
                        AND B.FUND_CODE IS NOT NULL) T
              GROUP BY FUND_CODE) SUB4
    ON SUB4.FUND_CODE = TFINFO.VC_FUND_CODE