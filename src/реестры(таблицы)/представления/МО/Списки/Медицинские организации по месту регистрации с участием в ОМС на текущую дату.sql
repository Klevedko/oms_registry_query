-- select * from pd_query where query_id = 'F003(фд)/Медицинские организации по месту регистрации с участием в ОМС на текущую дату'
-- oracle

              WITH AT_MEDCOM AS  (/* ------------------------------------------------------------------------------------------------- */
                                  /* Взяли все организации, которые подали уведомления на ЗАДАННЫЙ год и включены в реестр             */
                                  /* ------------------------------------------------------------------------------------------------- */
                                  SELECT  DISTINCT
                                          OMS.DT_MEDCOM .RECORD_IN
                                    FROM  OMS.DT_MEDCOM
                                       ,  OMS.DT_MEDSIG
                                       ,  OMS.DT_MEDINC
                                   WHERE  OMS.DT_MEDSIG .RECORD_IN_MEDCOM           =  OMS.DT_MEDCOM .RECORD_IN
                                     AND  EXTRACT (YEAR FROM
                                          OMS.DT_MEDSIG .SIG_YEAR)                  =  EXTRACT (YEAR FROM SYSDATE)
                                     AND  OMS.DT_MEDINC .RECORD_IN_MEDCOM           =  OMS.DT_MEDCOM .RECORD_IN     
                                     AND  OMS.DT_MEDINC .REX_DATE_END              IS  NULL                                          
                                     AND  OMS.DT_MEDINC .INC_DATE_START            <=  SYSDATE
                                 )
           SELECT count(*)
             FROM  OMS.CB_OKATO
                ,  OMS.DT_TSFOMS             
                ,      AT_MEDCOM
                ,  OMS.DT_MEDCOM
                ,  OMS.CB_OKOPF
                ,  OMS.CD_DEPAFF
                ,  OMS.CD_MEDSUB
            WHERE  OMS.CB_OKATO  .DATE_START                <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END                  >=  SYSDATE
              AND  OMS.DT_MEDCOM .DATE_START                <=  SYSDATE   
              AND  OMS.DT_MEDCOM .DATE_END                  >=  SYSDATE
              AND  OMS.DT_MEDCOM .RECORD_IN_OKATO            =  OMS.CB_OKATO  .RECORD_IN
              AND  OMS.DT_MEDCOM .RECORD_IN                  =      AT_MEDCOM .RECORD_IN              
              AND  OMS.DT_TSFOMS .RECORD_IN                  =  OMS.DT_MEDCOM .RECORD_IN_TSFOMS              
              AND  OMS.CB_OKOPF  .RECORD_IN             (+)  =  OMS.DT_MEDCOM .RECORD_IN_OKOPF
              AND  OMS.CD_DEPAFF .RECORD_IN             (+)  =  OMS.DT_MEDCOM .RECORD_IN_DEPAFF
              AND  OMS.CD_MEDSUB .RECORD_IN             (+)  =  OMS.DT_MEDCOM .RECORD_IN_MEDSUB        
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                        
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_DEPAFF        JOIN  OMS.CD_DEPAFF .RECORD_IN               
                                                       BROWSER  F007/Классификатор ведомственной принадлежности медицинской организации
                                                         QUERY  F007/Классификатор ведомственной принадлежности медицинской организации   ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN_MEDSUB        JOIN  OMS.CD_MEDSUB .RECORD_IN               
                                                       BROWSER  R008/Классификатор признака подчиненности МО
                                                         QUERY  R008/Классификатор признака подчиненности МО                              ) */
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDCAT .RECORD_IN_MEDCOM
                                                       BROWSER  V008/Классификатор видов медицинской помощи
                                                         QUERY  V008/Классификатор видов медицинской помощи
                                                       THROUGH  OMS.VT_MEDCAT .RECORD_IN_CARTYP
                                                         LABEL  Вид помощи                                                                ) */
              AND  OMS.DT_TSFOMS .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_TSFOMS .DATE_END              (+) >=  SYSDATE
              AND  OMS.CB_OKOPF  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKOPF  .DATE_END              (+) >=  SYSDATE
              AND  OMS.CD_DEPAFF .DATE_START            (+) <=  SYSDATE
              AND  OMS.CD_DEPAFF .DATE_END              (+) >=  SYSDATE
              AND  OMS.CD_MEDSUB .DATE_START            (+) <=  SYSDATE
              AND  OMS.CD_MEDSUB .DATE_END              (+) >=  SYSDATE
         ORDER BY  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_MEDCOM .MED_CODE

				
				
				
-- posgtresql

              -- select * from DT_MEDSIG limit 1
							WITH AT_MEDCOM AS  (/* ------------------------------------------------------------------------------------------------- */
                                  /* Взяли все организации, которые подали уведомления на ЗАДАННЫЙ год и включены в реестр             */
                                  /* ------------------------------------------------------------------------------------------------- */
                                  SELECT  DISTINCT
                                          OMS.DT_MEDCOM .temp_id
                                    FROM  OMS.DT_MEDCOM
                                       join OMS.DT_MEDSIG on OMS.DT_MEDSIG .dt_medcom_id           =  OMS.DT_MEDCOM .temp_id
																			 AND  EXTRACT (YEAR FROM
                                          OMS.DT_MEDSIG .notification_year)                  =  EXTRACT (YEAR FROM now())
                                       join  OMS.DT_MEDINC on 
																		OMS.DT_MEDINC .dt_medcom_id           =  OMS.DT_MEDCOM .temp_id     
                                     AND  OMS.DT_MEDINC .edate              IS  NULL                                          
                                     AND  OMS.DT_MEDINC .bdate            <=  now()
                                 )
           SELECT  count(*)
             FROM  OMS.CB_OKATO
                 join  OMS.DT_MEDCOM on OMS.DT_MEDCOM .cb_okato_id            =  OMS.CB_OKATO  .temp_id
										AND  OMS.DT_MEDCOM .bdate                <=  now()   
										AND  OMS.DT_MEDCOM .edate                  >=  now()
								join OMS.DT_TSFOMS  on OMS.DT_TSFOMS .temp_id                  =  OMS.DT_MEDCOM .dt_tsfoms_id   
										AND  OMS.DT_TSFOMS .bdate             <=  now()
										AND  OMS.DT_TSFOMS .edate               >=  now()
								join      AT_MEDCOM on OMS.DT_MEDCOM .temp_id                  =      AT_MEDCOM .temp_id              
								left join OMS.CB_OKOPF on OMS.CB_OKOPF  .temp_id               =  OMS.DT_MEDCOM .cb_okopf_id
										AND  OMS.CB_OKOPF  .bdate             <=  now()
										AND  OMS.CB_OKOPF  .edate               >=  now()
                left join  OMS.CD_DEPAFF on OMS.CD_DEPAFF .temp_id               =  OMS.DT_MEDCOM .cd_depaff_id
										AND  OMS.CD_DEPAFF .bdate             <=  now()
										AND  OMS.CD_DEPAFF .edate               >=  now()
								left join OMS.CD_MEDSUB on OMS.CD_MEDSUB .temp_id               =  OMS.DT_MEDCOM .cd_medsub_id        
										AND  OMS.CD_MEDSUB .bdate             <=  now()
										AND  OMS.CD_MEDSUB .edate               >=  now()
            WHERE  OMS.CB_OKATO  .bdate                <=  now()
              AND  OMS.CB_OKATO  .edate                  >=  now() 

/* +Filter   (AND  OMS.DT_MEDCOM .temp_id_TSFOMS        JOIN  OMS.DT_TSFOMS .temp_id                                        
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
/* +Filter   (AND  OMS.DT_MEDCOM .temp_id_OKATO         JOIN  OMS.CB_OKATO  .temp_id               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_MEDCOM .temp_id_OKOPF         JOIN  OMS.CB_OKOPF  .temp_id               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
/* +Filter   (AND  OMS.DT_MEDCOM .temp_id_DEPAFF        JOIN  OMS.CD_DEPAFF .temp_id               
                                                       BROWSER  F007/Классификатор ведомственной принадлежности медицинской организации
                                                         QUERY  F007/Классификатор ведомственной принадлежности медицинской организации   ) */
/* +Filter   (AND  OMS.DT_MEDCOM .temp_id_MEDSUB        JOIN  OMS.CD_MEDSUB .temp_id               
                                                       BROWSER  R008/Классификатор признака подчиненности МО
                                                         QUERY  R008/Классификатор признака подчиненности МО                              ) */
/* +Filter   (AND  OMS.DT_MEDCOM .temp_id          MULTYJOIN  OMS.VT_MEDCAT .temp_id_MEDCOM
                                                       BROWSER  V008/Классификатор видов медицинской помощи
                                                         QUERY  V008/Классификатор видов медицинской помощи
                                                       THROUGH  OMS.VT_MEDCAT .temp_id_CARTYP
                                                         LABEL  Вид помощи                                                                ) */
              
              
              
              
