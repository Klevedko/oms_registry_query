-- select * from pd_query where query_id = 'F003(фд)/Уведомления медицинских организаций на включение в программу ОМС на заданный год'
-- oracle

           SELECT count(*) 
             FROM  OMS.DT_MEDSIG    
                left join  OMS.DT_MEDCOM on OMS.DT_MEDCOM .RECORD_IN             (+)  =  OMS.DT_MEDSIG .RECORD_IN_MEDCOM  
              AND  OMS.DT_MEDCOM .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_MEDCOM .DATE_END              (+) >=  SYSDATE
/* +Variable (AND  TO_CHAR       
                  (OMS.DT_MEDSIG .SIG_YEAR,'YYYY')           =  TO_CHAR (&CURRENTYEAR&,'YYYY')                                            ) */
/* +Filter   (AND  OMS.DT_MEDSIG .RECORD_IN_MEDCOM        JOIN  OMS.DT_MEDCOM .RECORD_IN                                                  
                                                       BROWSER  F003(фм)/Медицинские организации                                           
                                                         QUERY  F003(фм)/Медицинские организации                                          ) */
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
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDREX .RECORD_IN_MEDCOM                                 
                                                       BROWSER  R006/Классификатор причин исключения из реестра МО                        
                                                         QUERY  R006/Классификатор причин исключения из реестра МО                        
                                                       THROUGH  OMS.VT_MEDREX .RECORD_IN_MEDREX                                 
                                                         LABEL  Исключения                                                                ) */

														 
														 
-- postgresql

           SELECT count(*) 
             FROM  OMS.DT_MEDSIG    
                left join  OMS.DT_MEDCOM on OMS.DT_MEDCOM .temp_id             =  OMS.DT_MEDSIG .dt_medcom_id
              AND  OMS.DT_MEDCOM .bdate             <=  now()
              AND  OMS.DT_MEDCOM .edate               >=  now()
/* +Variable (AND  TO_CHAR       
                  (OMS.DT_MEDSIG .SIG_YEAR,'YYYY')           =  TO_CHAR (&CURRENTYEAR&,'YYYY')                                            ) */
/* +Filter   (AND  OMS.DT_MEDSIG .RECORD_IN_MEDCOM        JOIN  OMS.DT_MEDCOM .RECORD_IN                                                  
                                                       BROWSER  F003(фм)/Медицинские организации                                           
                                                         QUERY  F003(фм)/Медицинские организации                                          ) */
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
/* +Filter   (AND  OMS.DT_MEDCOM .RECORD_IN          MULTYJOIN  OMS.VT_MEDREX .RECORD_IN_MEDCOM                                 
                                                       BROWSER  R006/Классификатор причин исключения из реестра МО                        
                                                         QUERY  R006/Классификатор причин исключения из реестра МО                        
                                                       THROUGH  OMS.VT_MEDREX .RECORD_IN_MEDREX                                 
                                                         LABEL  Исключения                                                                ) */
