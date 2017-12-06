-- select * from pd_query where query_id ='F002/Отпавшие из программы ОМС на заданный год к году сравнения'
-- oracle

  SELECT distinct																																							
                  (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_INSCOM .INS_CODE
             FROM  OMS.DT_INSSIG 
                ,  OMS.DT_INSCOM 
                ,  OMS.CB_OKATO  
            WHERE  OMS.DT_INSCOM .RECORD_IN             (+)  =  OMS.DT_INSSIG .RECORD_IN_INSCOM    
              AND  OMS.DT_INSCOM .DATE_START            (+) <=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE))
              AND  OMS.DT_INSCOM .DATE_END              (+) >=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE))
              AND  OMS.CB_OKATO  .RECORD_IN             (+)  =  OMS.DT_INSCOM .RECORD_IN_OKATO
              AND  OMS.CB_OKATO  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END              (+) >=  SYSDATE
AND  TO_CHAR       
                  (OMS.DT_INSSIG .SIG_YEAR,'YYYY')           =  '2013' 

/* +Filter   (AND  OMS.DT_INSLIC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                                ) */                            
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO .RECORD_IN                                                   
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF .RECORD_IN                                                   
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN          MULTYJOIN  OMS.VT_INSREX .RECORD_IN_INSCOM
                                                       BROWSER  R005/Классификатор причин исключения из реестра СМО
                                                         QUERY  R005/Классификатор причин исключения из реестра СМО
                                                       THROUGH  OMS.VT_INSREX .RECORD_IN_INSREX
                                                         LABEL  Исключения                                                                ) */
              AND  OMS.OMS_MAIN  .isRecordAllowByCode (OMS.DT_INSCOM .INS_CODE, OMS.DT_INSCOM .OMS_STATUS)
                                                             =  1
MINUS                            
           SELECT  DISTINCT   
                  (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_INSCOM .INS_CODE
             FROM  OMS.DT_INSSIG 
                ,  OMS.DT_INSCOM 
                ,  OMS.CB_OKATO  
            WHERE  OMS.DT_INSCOM .RECORD_IN             (+)  =  OMS.DT_INSSIG .RECORD_IN_INSCOM    
              AND  OMS.DT_INSCOM .DATE_START            (+) <=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE))
              AND  OMS.DT_INSCOM .DATE_END              (+) >=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_INSSIG .SIG_DATE, SYSDATE))
              AND  OMS.CB_OKATO  .RECORD_IN             (+)  =  OMS.DT_INSCOM .RECORD_IN_OKATO
              AND  OMS.CB_OKATO  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END              (+) >=  SYSDATE
AND  TO_CHAR       
                  (OMS.DT_INSSIG .SIG_YEAR,'YYYY')           =  '2014'
/* +Filter   (AND  OMS.DT_INSLIC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                                ) */                            
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO .RECORD_IN                                                   
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF .RECORD_IN                                                   
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN          MULTYJOIN  OMS.VT_INSREX .RECORD_IN_INSCOM
                                                       BROWSER  R005/Классификатор причин исключения из реестра СМО
                                                         QUERY  R005/Классификатор причин исключения из реестра СМО
                                                       THROUGH  OMS.VT_INSREX .RECORD_IN_INSREX
                                                         LABEL  Исключения                                                                ) */
              AND  OMS.OMS_MAIN  .isRecordAllowByCode (OMS.DT_INSCOM .INS_CODE, OMS.DT_INSCOM .OMS_STATUS)
                                                             =  1
															 
															 
															 
-- postgresql

-- select * from pd_query where query_id ='F002/Отпавшие из программы ОМС на заданный год к году сравнения'
-- тут 2013 и 2014 приходят как входящие параметры и проверяются на пустоту в оригинале!
  SELECT    DISTINCT
                  (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_INSCOM .INS_CODE
             FROM  OMS.DT_INSSIG 
                left join  OMS.DT_INSCOM on OMS.DT_INSCOM .temp_id             =  OMS.DT_INSSIG .dt_inscom_id    
										AND  OMS.DT_INSCOM .bdate             <=  
										(select case when ( date '2011.01.01' - COALESCE (OMS.DT_INSSIG .notification_date, now())::date) < 1 
												then COALESCE (OMS.DT_INSSIG .notification_date, now()) 
												else now() end)
										AND  OMS.DT_INSCOM .edate >=  
										(select case when (date '01.01.2011' - COALESCE(OMS.DT_INSSIG .notification_date, now())::date) < 1
												then COALESCE (OMS.DT_INSSIG .notification_date, now()) 
												else now() end)
							left join  OMS.CB_OKATO  on OMS.CB_OKATO  .temp_id  =  OMS.DT_INSCOM .cb_okato_id
									AND  OMS.CB_OKATO  .bdate             <=  now()
									AND  OMS.CB_OKATO  .edate              >= now()
							where extract(year from OMS.DT_INSSIG .SIG_YEAR)           =  '2013' 
AND  '2013' is not Null 

/* +Filter   (AND  OMS.DT_INSLIC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                                ) */                            
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO .RECORD_IN                                                   
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF .RECORD_IN                                                   
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN          MULTYJOIN  OMS.VT_INSREX .RECORD_IN_INSCOM
                                                       BROWSER  R005/Классификатор причин исключения из реестра СМО
                                                         QUERY  R005/Классификатор причин исключения из реестра СМО
                                                       THROUGH  OMS.VT_INSREX .RECORD_IN_INSREX
                                                         LABEL  Исключения                                                                ) */
except                            
           SELECT  DISTINCT
                  (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_INSCOM .INS_CODE
             FROM  OMS.DT_INSSIG 
                left join  OMS.DT_INSCOM on OMS.DT_INSCOM .temp_id             =  OMS.DT_INSSIG .dt_inscom_id    
										AND  OMS.DT_INSCOM .bdate             <=  
										(select case when ( date '2011.01.01' - COALESCE (OMS.DT_INSSIG .notification_date, now())::date) < 1 
												then COALESCE (OMS.DT_INSSIG .notification_date, now()) 
												else now() end)
										AND  OMS.DT_INSCOM .edate >=  
										(select case when (date '01.01.2011' - COALESCE(OMS.DT_INSSIG .notification_date, now())::date) < 1
												then COALESCE (OMS.DT_INSSIG .notification_date, now()) 
												else now() end)
							left join  OMS.CB_OKATO  on OMS.CB_OKATO  .temp_id  =  OMS.DT_INSCOM .cb_okato_id
									AND  OMS.CB_OKATO  .bdate             <=  now()
									AND  OMS.CB_OKATO  .edate              >= now()
							where extract(year from OMS.DT_INSSIG .SIG_YEAR)           =  '2014' 
AND  '2014' is not Null 
/* +Filter   (AND  OMS.DT_INSLIC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                                ) */                            
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO .RECORD_IN                                                   
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF .RECORD_IN                                                   
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN          MULTYJOIN  OMS.VT_INSREX .RECORD_IN_INSCOM
                                                       BROWSER  R005/Классификатор причин исключения из реестра СМО
                                                         QUERY  R005/Классификатор причин исключения из реестра СМО
                                                       THROUGH  OMS.VT_INSREX .RECORD_IN_INSREX
                                                         LABEL  Исключения                                                                ) */