-- select * from pd_query where query_id = 'F003/Отпавшие из программы ОМС на заданный год к году сравнения'
-- учесть что входящих параметров должно быть два! два года ( not null )

-- oracle
           SELECT  DISTINCT
                  (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_MEDCOM .MED_CODE
             FROM  OMS.DT_MEDSIG
                ,  OMS.DT_MEDCOM
                ,  OMS.CB_OKATO 
            WHERE  OMS.DT_MEDCOM .RECORD_IN             (+)  =  OMS.DT_MEDSIG .RECORD_IN_MEDCOM    
              AND  OMS.DT_MEDCOM .DATE_START            (+) <=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE))
              AND  OMS.DT_MEDCOM .DATE_END              (+) >=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE))
              AND  OMS.CB_OKATO  .RECORD_IN             (+)  =  OMS.DT_MEDCOM .RECORD_IN_OKATO
              AND  OMS.CB_OKATO  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END              (+) >=  SYSDATE
AND  TO_CHAR                          
                  (OMS.DT_MEDSIG .SIG_YEAR,'YYYY')           =  '2016'
/* +Variable (AND  &CURRENTYEAR&                        IS NOT  NULL                                                                      ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN                                                  
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_MEDSUB        JOIN  OMS.CD_MEDSUB .RECORD_IN               
                                                       BROWSER  R008/Классификатор признака подчиненности МО
                                                         QUERY  R008/Классификатор признака подчиненности МО                              ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDCAT .RECORD_IN_MEDCOM
                                                       BROWSER  V008/Классификатор видов медицинской помощи
                                                         QUERY  V008/Классификатор видов медицинской помощи
                                                       THROUGH  OMS.VT_MEDCAT .RECORD_IN_CARTYP
                                                         LABEL  Вид помощи                                                                ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDREX .RECORD_IN_MEDCOM                                 
                                                       BROWSER  R006/Классификатор причин исключения из реестра МО                        
                                                         QUERY  R006/Классификатор причин исключения из реестра МО                        
                                                       THROUGH  OMS.VT_MEDREX .RECORD_IN_MEDREX                                 
                                                         LABEL  Исключения                                                                ) */
      
MINUS                           
           SELECT  DISTINCT     
                 (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_MEDCOM .MED_CODE
             FROM  OMS.DT_MEDSIG
                ,  OMS.DT_MEDCOM
                ,  OMS.CB_OKATO 
            WHERE  OMS.DT_MEDCOM .RECORD_IN             (+)  =  OMS.DT_MEDSIG .RECORD_IN_MEDCOM    
              AND  OMS.DT_MEDCOM .DATE_START            (+) <=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE))
              AND  OMS.DT_MEDCOM .DATE_END              (+) >=  DECODE (SIGN (TO_DATE ('01.01.2011','dd.MM.yyyy') - NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE)), 1,
                                                                              SYSDATE ,                             NVL (OMS.DT_MEDSIG .SIG_DATE, SYSDATE))
              AND  OMS.CB_OKATO  .RECORD_IN             (+)  =  OMS.DT_MEDCOM .RECORD_IN_OKATO
              AND  OMS.CB_OKATO  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END              (+) >=  SYSDATE
AND  TO_CHAR                          
                  (OMS.DT_MEDSIG .SIG_YEAR,'YYYY')           =  '2018'
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN                                                  
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_MEDSUB        JOIN  OMS.CD_MEDSUB .RECORD_IN               
                                                       BROWSER  R008/Классификатор признака подчиненности МО
                                                         QUERY  R008/Классификатор признака подчиненности МО                              ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDCAT .RECORD_IN_MEDCOM
                                                       BROWSER  V008/Классификатор видов медицинской помощи
                                                         QUERY  V008/Классификатор видов медицинской помощи
                                                       THROUGH  OMS.VT_MEDCAT .RECORD_IN_CARTYP
                                                         LABEL  Вид помощи                                                                ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDREX .RECORD_IN_MEDCOM                                 
                                                       BROWSER  R006/Классификатор причин исключения из реестра МО                        
                                                         QUERY  R006/Классификатор причин исключения из реестра МО                        
                                                       THROUGH  OMS.VT_MEDREX .RECORD_IN_MEDREX                                 
                                                         LABEL  Исключения                                                                ) */
          
      
	  
-- postgresql

           -- table DT_MEDSIG
					 SELECT  DISTINCT
                  (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_MEDCOM .MED_CODE
             FROM  OMS.DT_MEDSIG
                left join  OMS.DT_MEDCOM on OMS.DT_MEDCOM .temp_id  =  OMS.DT_MEDSIG .dt_medcom_id 
								AND OMS.DT_MEDCOM .bdate  <=
								(select case when ( date '2011.01.01' - COALESCE (OMS.DT_MEDSIG .notification_date, now())::date) < 1 
												then COALESCE (OMS.DT_MEDSIG .notification_date, now()) 
												else now() end)
								
								AND  OMS.DT_MEDCOM .edate >=
								(select case when (date '01.01.2011' - COALESCE(OMS.DT_MEDSIG .notification_date, now())::date) < 1
												then COALESCE (OMS.DT_MEDSIG .notification_date, now()) 
												else now() end)
												
                left join   OMS.CB_OKATO on OMS.CB_OKATO  .temp_id  =  OMS.DT_MEDCOM .cb_okato_id
              AND  OMS.CB_OKATO  .bdate             <=  now()
              AND  OMS.CB_OKATO  .edate              >=  now()
where  extract(year from OMS.DT_MEDSIG .notification_year)           = '2016'
/* +Variable (AND  &CURRENTYEAR&                        IS NOT  NULL                                                                      ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN                                                  
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_MEDSUB        JOIN  OMS.CD_MEDSUB .RECORD_IN               
                                                       BROWSER  R008/Классификатор признака подчиненности МО
                                                         QUERY  R008/Классификатор признака подчиненности МО                              ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDCAT .RECORD_IN_MEDCOM
                                                       BROWSER  V008/Классификатор видов медицинской помощи
                                                         QUERY  V008/Классификатор видов медицинской помощи
                                                       THROUGH  OMS.VT_MEDCAT .RECORD_IN_CARTYP
                                                         LABEL  Вид помощи                                                                ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDREX .RECORD_IN_MEDCOM                                 
                                                       BROWSER  R006/Классификатор причин исключения из реестра МО                        
                                                         QUERY  R006/Классификатор причин исключения из реестра МО                        
                                                       THROUGH  OMS.VT_MEDREX .RECORD_IN_MEDREX                                 
                                                         LABEL  Исключения                                                                ) */
         
except                           
           SELECT  DISTINCT    
                 (OMS.CB_OKATO  .OKATO_CODE_01  ||
                   OMS.CB_OKATO  .OKATO_CODE_02) "ОКАТО"
                ,  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_MEDCOM .MED_CODE
              FROM  OMS.DT_MEDSIG
                left join  OMS.DT_MEDCOM on OMS.DT_MEDCOM .temp_id  =  OMS.DT_MEDSIG .dt_medcom_id 
								AND OMS.DT_MEDCOM .bdate  <=
								(select case when ( date '2011.01.01' - COALESCE (OMS.DT_MEDSIG .notification_date, now())::date) < 1 
												then COALESCE (OMS.DT_MEDSIG .notification_date, now()) 
												else now() end)
								
								AND  OMS.DT_MEDCOM .edate >=
								(select case when (date '01.01.2011' - COALESCE(OMS.DT_MEDSIG .notification_date, now())::date) < 1
												then COALESCE (OMS.DT_MEDSIG .notification_date, now()) 
												else now() end)
												
                left join   OMS.CB_OKATO on OMS.CB_OKATO  .temp_id  =  OMS.DT_MEDCOM .cb_okato_id
              AND  OMS.CB_OKATO  .bdate             <=  now()
              AND  OMS.CB_OKATO  .edate              >=  now()
where  extract(year from OMS.DT_MEDSIG .notification_year)           = '2018'
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN                                                  
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм            
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_MEDSUB        JOIN  OMS.CD_MEDSUB .RECORD_IN               
                                                       BROWSER  R008/Классификатор признака подчиненности МО
                                                         QUERY  R008/Классификатор признака подчиненности МО                              ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDCAT .RECORD_IN_MEDCOM
                                                       BROWSER  V008/Классификатор видов медицинской помощи
                                                         QUERY  V008/Классификатор видов медицинской помощи
                                                       THROUGH  OMS.VT_MEDCAT .RECORD_IN_CARTYP
                                                         LABEL  Вид помощи                                                                ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDREX .RECORD_IN_MEDCOM                                 
                                                       BROWSER  R006/Классификатор причин исключения из реестра МО                        
                                                         QUERY  R006/Классификатор причин исключения из реестра МО                        
                                                       THROUGH  OMS.VT_MEDREX .RECORD_IN_MEDREX                                 
                                                         LABEL  Исключения                                                                ) */
             