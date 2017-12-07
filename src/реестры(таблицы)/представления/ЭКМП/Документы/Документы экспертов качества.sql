-- select * from pd_query where query_id = 'F004(фд)/Документы экспертов качества'
-- oracle

           SELECT count(*)
             FROM  OMS.DT_EXPLIC 
                ,  OMS.DT_EXPERT 
                ,  OMS.CD_JOBMED 
                ,  OMS.CD_QLFCAT 
                ,  OMS.CD_ACDDEG 
                ,  OMS.CB_OKATO
                ,  OMS.CD_EXPHSS
            WHERE  OMS.DT_EXPERT .RECORD_IN                     =  OMS.DT_EXPLIC .RECORD_IN_EXPERT
              AND  OMS.CD_JOBMED .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_JOBMED
              AND  OMS.CD_QLFCAT .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_QLFCAT
              AND  OMS.CD_ACDDEG .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_ACDDEG
              AND  OMS.CD_EXPHSS .RECORD_IN                (+)  =  OMS.DT_EXPLIC .RECORD_IN_EXPHSS
              AND  OMS.CB_OKATO  .RECORD_IN                (+)  =  OMS.DT_EXPERT .RECORD_IN_OKATO
  /* +Filter (AND  OMS.DT_EXPLIC .LIC_TYPE                 DOMAIN  Тип документа эксперта качества              ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_OKATO            JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                          BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                            QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS           JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                          BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                            QUERY  F001(фм)/Территориальные фонды ОМС           ) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_EXPERT           JOIN  OMS.DT_EXPERT .RECORD_IN               
                                                          BROWSER  F004(фм)/Эксперты качества                                           
                                                            QUERY  F004(фм)/Эксперты качества                   ) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_JOBMED           JOIN  OMS.CD_JOBMED .RECORD_IN               
                                                          BROWSER  V015/Классификатор медицинских специальностей
                                                            QUERY  V015/Классификатор медицинских специальностей) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_QLFCAT           JOIN  OMS.CD_QLFCAT .RECORD_IN               
                                                          BROWSER  R011/Классификатор квалификационных категорий
                                                            QUERY  R011/Категории-На заданную дату              ) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_ACDDEG           JOIN  OMS.CD_ACDDEG .RECORD_IN               
                                                          BROWSER  R012/Классификатор учёных степеней
                                                            QUERY  R012/Степени-На заданную дату                ) */
              AND  OMS.DT_EXPERT .DATE_START               (+) <=  SYSDATE
              AND  OMS.DT_EXPERT .DATE_END                 (+) >=  SYSDATE
              AND  OMS.CD_JOBMED .DATE_START               (+) <=  SYSDATE
              AND  OMS.CD_JOBMED .DATE_END                 (+) >=  SYSDATE
              AND  OMS.CD_QLFCAT .DATE_START               (+) <=  SYSDATE
              AND  OMS.CD_QLFCAT .DATE_END                 (+) >=  SYSDATE
              AND  OMS.CD_ACDDEG .DATE_START               (+) <=  SYSDATE
              AND  OMS.CD_ACDDEG .DATE_END                 (+) >=  SYSDATE
              AND  OMS.CD_EXPHSS .DATE_START               (+) <=  SYSDATE
              AND  OMS.CD_EXPHSS .DATE_END                 (+) >=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_START               (+) <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END                 (+) >=  SYSDATE 
			  
			  
-- postgresql

           SELECT count(*)
             FROM  OMS.DT_EXPLIC 
                join  OMS.DT_EXPERT on OMS.DT_EXPERT .temp_id                     =  OMS.DT_EXPLIC .dt_expert_id
										AND  OMS.DT_EXPERT .bdate                <=  now()
										AND  OMS.DT_EXPERT .edate                  >=  now()
                left join  OMS.CD_JOBMED on OMS.CD_JOBMED .temp_id                  =  OMS.DT_EXPLIC .cd_jobmed_id
								    AND  OMS.CD_JOBMED .bdate                <=  now()
										AND  OMS.CD_JOBMED .edate                  >=  now()
                left join  OMS.CD_QLFCAT on OMS.CD_QLFCAT .temp_id                  =  OMS.DT_EXPLIC .cd_qlfcat_id
										AND  OMS.CD_QLFCAT .bdate                <=  now()
										AND  OMS.CD_QLFCAT .edate                  >=  now()
                left join  OMS.CD_ACDDEG on OMS.CD_ACDDEG .temp_id                  =  OMS.DT_EXPLIC .cd_acddeg_id
										AND  OMS.CD_ACDDEG .bdate                <=  now()
										AND  OMS.CD_ACDDEG .edate                  >=  now()
                left join  OMS.CB_OKATO  on OMS.CB_OKATO  .temp_id                  =  OMS.DT_EXPERT .cb_okato_id
										AND  OMS.CB_OKATO  .bdate                <=  now()
										AND  OMS.CB_OKATO  .edate                  >=  now() 
                left join  OMS.CD_EXPHSS on  OMS.CD_EXPHSS .temp_id                  =  OMS.DT_EXPLIC .cd_exphss_id
										AND  OMS.CD_EXPHSS .bdate                <=  now()
										AND  OMS.CD_EXPHSS .edate                  >=  now()
              
  /* +Filter (AND  OMS.DT_EXPLIC .LIC_TYPE                 DOMAIN  Тип документа эксперта качества              ) */
  /* +Filter (AND  OMS.DT_EXPERT .temp_id_OKATO            JOIN  OMS.CB_OKATO  .temp_id               
                                                          BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                            QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_EXPERT .temp_id_TSFOMS           JOIN  OMS.DT_TSFOMS .temp_id                                                  
                                                          BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                            QUERY  F001(фм)/Территориальные фонды ОМС           ) */
  /* +Filter (AND  OMS.DT_EXPLIC .temp_id_EXPERT           JOIN  OMS.DT_EXPERT .temp_id               
                                                          BROWSER  F004(фм)/Эксперты качества                                           
                                                            QUERY  F004(фм)/Эксперты качества                   ) */
  /* +Filter (AND  OMS.DT_EXPLIC .temp_id_JOBMED           JOIN  OMS.CD_JOBMED .temp_id               
                                                          BROWSER  V015/Классификатор медицинских специальностей
                                                            QUERY  V015/Классификатор медицинских специальностей) */
  /* +Filter (AND  OMS.DT_EXPLIC .temp_id_QLFCAT           JOIN  OMS.CD_QLFCAT .temp_id               
                                                          BROWSER  R011/Классификатор квалификационных категорий
                                                            QUERY  R011/Категории-На заданную дату              ) */
  /* +Filter (AND  OMS.DT_EXPLIC .temp_id_ACDDEG           JOIN  OMS.CD_ACDDEG .temp_id               
                                                          BROWSER  R012/Классификатор учёных степеней
                                                            QUERY  R012/Степени-На заданную дату                ) */

              
              
              
