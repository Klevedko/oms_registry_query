            -- select * from pd_query where query_id ='F002(фд)/Страховые медицинские организации по месту регистрации с участием в ОМС на текущую дату'
			-- oracle

WITH AT_INSCOM AS  (/* ------------------------------------------------------------------------------------------------- */
                                /* Взяли все организации, которые подали уведомления на ЗАДАННЫЙ год и включены в реестр             */
                                /* ------------------------------------------------------------------------------------------------- */
                                SELECT  DISTINCT
                                        OMS.DT_INSCOM .RECORD_IN
                                  FROM  OMS.DT_INSCOM
                                     ,  OMS.DT_INSSIG
                                     ,  OMS.DT_INSINC
                                 WHERE  OMS.DT_INSSIG .RECORD_IN_INSCOM  =  OMS.DT_INSCOM .RECORD_IN
                                   AND  EXTRACT (YEAR FROM              
                                        OMS.DT_INSSIG .SIG_YEAR)         =  EXTRACT (YEAR FROM SYSDATE)
                                   AND  OMS.DT_INSINC .RECORD_IN_INSCOM  =  OMS.DT_INSCOM .RECORD_IN     
                                   AND  OMS.DT_INSINC .REX_DATE_END     IS  NULL                                          
                                   AND  OMS.DT_INSINC .INC_DATE_START   <=  SYSDATE
                               )
           SELECT  OMS.CB_OKATO  .OKATO_NAME     
                ,  OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSCOM .OMS_STATUS
                ,  OMS.DT_INSCOM .INS_NAME
                ,  OMS.DT_INSCOM .INS_FULL
                ,  OMS.DT_INSCOM .INS_INN
                ,  OMS.DT_INSCOM .INS_KPP
                , (OMS.DT_INSCOM .INS_INN || '-'  ||
                   OMS.DT_INSCOM .INS_KPP)       "ИНН-КПП объединенный "
                ,  OMS.DT_INSCOM .INS_OGRN
                ,  OMS.DT_TSFOMS .OMS_CODE
                ,  OMS.DT_TSFOMS .OMS_NAME
                ,  OMS.DT_INSCOM .INS_JPINDEX
                ,  OMS.DT_INSCOM .INS_JADDRESS
                ,  OMS.DT_INSCOM .INS_PPINDEX
                ,  OMS.DT_INSCOM .INS_PADDRESS
                ,  OMS.CB_OKOPF  .OKOPF_GROUP
                ,  OMS.CB_OKOPF  .OKOPF_CODE                                     
                ,  OMS.CD_INSSUB .INSSUB_CODE
                ,  OMS.DT_INSCOM .CEO_SURNAME
                ,  OMS.DT_INSCOM .CEO_FSTNAME
                ,  OMS.DT_INSCOM .CEO_PATNAME
                ,  OMS.DT_INSCOM .INS_PHONE
                ,  OMS.DT_INSCOM .INS_EMAIL
                ,  OMS.DT_INSCOM .INS_FAX
                ,  OMS.DT_INSCOM .INS_WWW
                , (SELECT  OMS.DT_INSSIG .SIG_DATE
                     FROM  OMS.DT_INSSIG
                    WHERE  OMS.DT_INSSIG .RECORD_IN_INSCOM   = OMS.DT_INSCOM .RECORD_IN
                      AND  EXTRACT (YEAR FROM
                           OMS.DT_INSSIG .SIG_YEAR)          = EXTRACT (YEAR FROM SYSDATE)) "Дата уведомления@dd.MM.yyyy"
                , (SELECT  MAX
                          (OMS.DT_INSINC .INC_DATE_START) 
                     FROM  OMS.DT_INSINC
                    WHERE  OMS.DT_INSINC .RECORD_IN_INSCOM   = OMS.DT_INSCOM .RECORD_IN
                      AND  EXTRACT (YEAR FROM
                           OMS.DT_INSINC .INC_DATE_START)   <= EXTRACT (YEAR FROM SYSDATE)) "Дата включения@dd.MM.yyyy"
                ,  OMS.OMS_MAIN  .getInsIncDateEnd      (OMS.DT_INSCOM.RECORD_IN, SYSDATE)  "Дата исключения@dd.MM.yyyy"
                ,  OMS.OMS_MAIN  .getInsIncAllRex       (OMS.DT_INSCOM.RECORD_IN, SYSDATE)  "Причины исключения"
                ,  TO_CHAR(SYSDATE,'YYYY')                                                  "Год@yyyy"
                ,  OMS.DT_INSCOM .UPDATE_DATE
                ,  OMS.DT_INSCOM .UPDATE_USER
             FROM  OMS.CB_OKATO
                ,  OMS.DT_TSFOMS             
                ,      AT_INSCOM 
                ,  OMS.DT_INSCOM 
                ,  OMS.CB_OKOPF  
                ,  OMS.CD_INSSUB
            WHERE  OMS.CB_OKATO  .DATE_START                <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END                  >=  SYSDATE
              AND  OMS.DT_INSCOM .DATE_START                <=  SYSDATE   
              AND  OMS.DT_INSCOM .DATE_END                  >=  SYSDATE
              AND  OMS.DT_INSCOM .RECORD_IN_OKATO            =  OMS.CB_OKATO  .RECORD_IN
              AND  OMS.DT_INSCOM .RECORD_IN                  =      AT_INSCOM .RECORD_IN
              AND  OMS.DT_TSFOMS .RECORD_IN                  =  OMS.DT_INSCOM .RECORD_IN_TSFOMS
              AND  OMS.CB_OKOPF  .RECORD_IN             (+)  =  OMS.DT_INSCOM .RECORD_IN_OKOPF
              AND  OMS.CD_INSSUB .RECORD_IN             (+)  =  OMS.DT_INSCOM .RECORD_IN_INSSUB        
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN               
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
              AND  OMS.DT_TSFOMS .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_TSFOMS .DATE_END              (+) >=  SYSDATE
              AND  OMS.CB_OKOPF  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKOPF  .DATE_END              (+) >=  SYSDATE
              AND  OMS.CD_INSSUB .DATE_START            (+) <=  SYSDATE
              AND  OMS.CD_INSSUB .DATE_END              (+) >=  SYSDATE
              AND  OMS.OMS_MAIN  .isRecordAllowByCode          (OMS.DT_INSCOM .INS_CODE, OMS.DT_INSCOM .OMS_STATUS)
                                                             =  1
         ORDER BY  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_INSCOM .INS_CODE

				
				
				
-- postgresql
				            -- select * from pd_query where query_id ='F002(фд)/Страховые медицинские организации по месту регистрации с участием в ОМС на текущую дату'
WITH AT_INSCOM AS  (/* ------------------------------------------------------------------------------------------------- */
                                /* Взяли все организации, которые подали уведомления на ЗАДАННЫЙ год и включены в реестр             */
                                /* ------------------------------------------------------------------------------------------------- */
                                SELECT  DISTINCT
                                        OMS.DT_INSCOM .temp_id
                                  FROM  OMS.DT_INSCOM
                                     join  OMS.DT_INSSIG on OMS.DT_INSSIG .dt_inscom_id  =  OMS.DT_INSCOM .temp_id
																		 AND  EXTRACT (YEAR FROM              
                                        OMS.DT_INSSIG .SIG_YEAR)         =  EXTRACT (YEAR FROM now())
																		join  OMS.DT_INSINC on OMS.DT_INSINC .dt_inscom_id  =  OMS.DT_INSCOM .temp_id
                                   AND  OMS.DT_INSINC .edate     IS  NULL                                          
                                   AND  OMS.DT_INSINC .bdate   <=  now()
                                 )
           SELECT  count(*)
             FROM  OMS.CB_OKATO
                join  OMS.DT_INSCOM on OMS.DT_INSCOM .cb_okato_id            =  OMS.CB_OKATO  .temp_id
										AND  OMS.DT_INSCOM .bdate                <=  now()   
										AND  OMS.DT_INSCOM .edate                  >=  now()
								join AT_INSCOM on OMS.DT_INSCOM .temp_id                  =      AT_INSCOM .temp_id
                join OMS.CB_OKOPF on OMS.CB_OKOPF  .temp_id               =  OMS.DT_INSCOM .cb_okopf_id
										AND  OMS.CB_OKOPF  .bdate             <=  now()
										AND  OMS.CB_OKOPF  .edate               >=  now()
                join OMS.CD_INSSUB on OMS.CD_INSSUB .temp_id               =  OMS.DT_INSCOM .cd_inssub_id    
										AND  OMS.CD_INSSUB .bdate             <=  now()
										AND  OMS.CD_INSSUB .edate               >=  now()	
							join  OMS.DT_TSFOMS  on  OMS.DT_TSFOMS .temp_id                  =  OMS.DT_INSCOM .dt_tsfoms_id
										AND  OMS.DT_TSFOMS .bdate             <=  now()
										AND  OMS.DT_TSFOMS .edate               >=  now()			
            WHERE  OMS.CB_OKATO  .bdate                <=  now()
              AND  OMS.CB_OKATO  .edate                  >=  now()
/* +Filter   (AND  OMS.DT_INSCOM .temp_id_TSFOMS        JOIN  OMS.DT_TSFOMS .temp_id                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_INSCOM .temp_id_OKATO         JOIN  OMS.CB_OKATO  .temp_id               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_INSCOM .temp_id_OKOPF         JOIN  OMS.CB_OKOPF  .temp_id               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_INSCOM .temp_id_INSSUB        JOIN  OMS.CD_INSSUB .temp_id               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
/* +Filter   (AND  OMS.DT_INSCOM .temp_id          MULTYJOIN  OMS.VT_INSREX .temp_id_INSCOM
                                                       BROWSER  R005/Классификатор причин исключения из реестра СМО
                                                         QUERY  R005/Классификатор причин исключения из реестра СМО
                                                       THROUGH  OMS.VT_INSREX .temp_id_INSREX
                                                         LABEL  Исключения                                                                ) */
              
              
             