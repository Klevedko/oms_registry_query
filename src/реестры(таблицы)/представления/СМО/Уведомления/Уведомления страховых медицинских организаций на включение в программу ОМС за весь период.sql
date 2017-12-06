-- select * from pd_query where query_id ='F002(фд)/Уведомления страховых медицинских организаций на включение в программу ОМС за весь период'
-- oracle
					           SELECT count(*)
             FROM  OMS.DT_INSSIG
                left join  OMS.DT_INSCOM on OMS.DT_INSCOM .RECORD_IN             (+)  =  OMS.DT_INSSIG .RECORD_IN_INSCOM    
              AND  OMS.DT_INSCOM .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_INSCOM .DATE_END              (+) >=  SYSDATE
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
														 
														 
														 
														 
-- postgresql
														 -- select * from pd_query where query_id ='F002(фд)/Уведомления страховых медицинских организаций на включение в программу ОМС за весь период'
					           SELECT count(*)
             FROM  OMS.DT_INSSIG
                left join  OMS.DT_INSCOM on OMS.DT_INSCOM .temp_id              =  OMS.DT_INSSIG .dt_inscom_id    
              AND  OMS.DT_INSCOM .bdate            <=  NOW()
              AND  OMS.DT_INSCOM .edate              >=  NOW()
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