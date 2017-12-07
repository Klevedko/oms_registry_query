-- select * from pd_query where query_id = 'F004(фд)/Документы экспертов качества на заданую дату'
-- oracle
           SELECT count(*)
             FROM  OMS.DT_EXPLIC 
                ,  OMS.DT_EXPERT 
                ,  OMS.CD_JOBMED 
                ,  OMS.CD_QLFCAT 
                ,  OMS.CD_ACDDEG
                ,  OMS.CD_EXPHSS 
                ,  OMS.CB_OKATO
            WHERE  OMS.DT_EXPERT .RECORD_IN                     =  OMS.DT_EXPLIC .RECORD_IN_EXPERT
              AND  OMS.CD_JOBMED .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_JOBMED
              AND  OMS.CD_QLFCAT .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_QLFCAT
              AND  OMS.CD_ACDDEG .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_ACDDEG
              AND  OMS.CD_EXPHSS .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_EXPHSS
              AND  OMS.CB_OKATO  .RECORD_IN                (+)  =  OMS.DT_EXPERT .RECORD_IN_OKATO 
AND (OMS.DT_EXPLIC .LIC_TILL                     >=  to_date('2017-05-05', 'YYYY-MM-DD')
               OR  OMS.DT_EXPLIC .LIC_TILL                     IS  NULL)                                        
/* +Filter   (AND  OMS.DT_EXPLIC .LIC_TYPE                 DOMAIN  Тип документа эксперта качества              ) */
/* +Filter   (AND  OMS.DT_EXPERT .RECORD_IN_OKATO            JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                          BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                            QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS           JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                          BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                            QUERY  F001(фм)/Территориальные фонды ОМС           ) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_EXPERT           JOIN  OMS.DT_EXPERT .RECORD_IN               
                                                          BROWSER  F004(фм)/Эксперты качества                                           
                                                            QUERY  F004(фм)/Эксперты качества                   ) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_JOBMED           JOIN  OMS.CD_JOBMED .RECORD_IN               
                                                          BROWSER  V015/Классификатор медицинских специальностей
                                                            QUERY  V015/Классификатор медицинских специальностей) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_QLFCAT           JOIN  OMS.CD_QLFCAT .RECORD_IN               
                                                          BROWSER  R011/Классификатор квалификационных категорий
                                                            QUERY  R011/Категории-На заданную дату              ) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_ACDDEG           JOIN  OMS.CD_ACDDEG .RECORD_IN               
                                                          BROWSER  R012/Классификатор учёных степеней
                                                            QUERY  R012/Степени-На заданную дату                ) */
AND  OMS.DT_EXPERT .DATE_START               (+) <=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.DT_EXPERT .DATE_END                 (+) >=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_JOBMED .DATE_START               (+) <=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_JOBMED .DATE_END                 (+) >=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_QLFCAT .DATE_START               (+) <=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_QLFCAT .DATE_END                 (+) >=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_ACDDEG .DATE_START               (+) <=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_ACDDEG .DATE_END                 (+) >=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_EXPHSS .DATE_START               (+) <=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CD_EXPHSS .DATE_END                 (+) >=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CB_OKATO  .DATE_START               (+) <=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
AND  OMS.CB_OKATO  .DATE_END                 (+) >=  TO_DATE('2017-05-05' , 'YYYY,MM,DD')
              AND  OMS.OMS_MAIN  .isRecordAllowByCode (OMS.DT_EXPERT .EXP_CODE, OMS.DT_EXPERT .OMS_STATUS)      
                                                                =  1
         ORDER BY  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_EXPERT .EXP_CODE 
                ,  OMS.DT_EXPLIC .LIC_TYPE

				
-- postgresql

           SELECT count(*)
             FROM  OMS.DT_EXPLIC 
                join  OMS.DT_EXPERT on OMS.DT_EXPERT .temp_id                     =  OMS.DT_EXPLIC .dt_expert_id
										AND  OMS.DT_EXPERT .bdate                <=  DATE('2017-05-05')
										AND  OMS.DT_EXPERT .edate                  >=  DATE('2017-05-05')
                left join  OMS.CD_JOBMED on OMS.CD_JOBMED .temp_id                  =  OMS.DT_EXPLIC .cd_jobmed_id
										AND  OMS.CD_JOBMED .bdate                <=  DATE('2017-05-05')
										AND  OMS.CD_JOBMED .edate                  >=  DATE('2017-05-05')
                left join  OMS.CD_QLFCAT on OMS.CD_QLFCAT .temp_id                  =  OMS.DT_EXPLIC .cd_qlfcat_id
										AND  OMS.CD_QLFCAT .bdate                <=  DATE('2017-05-05')
										AND  OMS.CD_QLFCAT .edate                  >=  DATE('2017-05-05')
                left join  OMS.CD_ACDDEG on OMS.CD_ACDDEG .temp_id                  =  OMS.DT_EXPLIC .cd_acddeg_id
										AND  OMS.CD_ACDDEG .bdate                <=  DATE('2017-05-05')
										AND  OMS.CD_ACDDEG .edate                  >=  DATE('2017-05-05')
                left join  OMS.CB_OKATO  on OMS.CB_OKATO  .temp_id                  =  OMS.DT_EXPERT .cb_okato_id
										AND  OMS.CB_OKATO  .bdate                <=  DATE('2017-05-05')
										AND  OMS.CB_OKATO  .edate                  >=  DATE('2017-05-05') 
                left join  OMS.CD_EXPHSS on OMS.CD_EXPHSS .temp_id                  =  OMS.DT_EXPLIC .cd_exphss_id
										AND  OMS.CD_EXPHSS .bdate                <=  DATE('2017-05-05')
										AND  OMS.CD_EXPHSS .edate                  >=  DATE('2017-05-05')
								WHERE
 (OMS.DT_EXPLIC .LIC_TILL                     >=  date('2017-05-05')
               OR  OMS.DT_EXPLIC .LIC_TILL                     IS  NULL)                                        
/* +Filter   (AND  OMS.DT_EXPLIC .LIC_TYPE                 DOMAIN  Тип документа эксперта качества              ) */
/* +Filter   (AND  OMS.DT_EXPERT .RECORD_IN_OKATO            JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                          BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                            QUERY  O002/Общероссийский классификатор административно-территориального деления) */
/* +Filter   (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS           JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                          BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                            QUERY  F001(фм)/Территориальные фонды ОМС           ) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_EXPERT           JOIN  OMS.DT_EXPERT .RECORD_IN               
                                                          BROWSER  F004(фм)/Эксперты качества                                           
                                                            QUERY  F004(фм)/Эксперты качества                   ) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_JOBMED           JOIN  OMS.CD_JOBMED .RECORD_IN               
                                                          BROWSER  V015/Классификатор медицинских специальностей
                                                            QUERY  V015/Классификатор медицинских специальностей) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_QLFCAT           JOIN  OMS.CD_QLFCAT .RECORD_IN               
                                                          BROWSER  R011/Классификатор квалификационных категорий
                                                            QUERY  R011/Категории-На заданную дату              ) */
/* +Filter   (AND  OMS.DT_EXPLIC .RECORD_IN_ACDDEG           JOIN  OMS.CD_ACDDEG .RECORD_IN               
                                                          BROWSER  R012/Классификатор учёных степеней
                                                            QUERY  R012/Степени-На заданную дату                ) */
