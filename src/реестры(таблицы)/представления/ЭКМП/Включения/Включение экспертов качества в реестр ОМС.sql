-- select * from pd_query where query_id = 'F004(фд)/Включение экспертов качества в реестр ОМС'

-- oracle
           SELECT  count(*)
             FROM  OMS.DT_EXPINC 
                ,  OMS.DT_EXPERT 
            WHERE  OMS.DT_EXPERT .RECORD_IN             (+)  =  OMS.DT_EXPINC .RECORD_IN_EXPERT
              AND  OMS.DT_EXPERT .DATE_START            (+) <=  OMS.DT_EXPINC .INC_DATE_START
              AND  OMS.DT_EXPERT .DATE_END              (+) >=  OMS.DT_EXPINC .INC_DATE_START
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС ) */
  /* +Filter (AND  OMS.DT_EXPINC .RECORD_IN_EXPERT        JOIN  OMS.DT_EXPERT .RECORD_IN
                                                       BROWSER  F004(фм)/Эксперты качества
                                                         QUERY  F004(фм)/Эксперты качества         ) */
          

		  
		  
-- postgresql

           SELECT  count(*)
             FROM  OMS.DT_EXPINC 
                left join  OMS.DT_EXPERT on OMS.DT_EXPERT .temp_id               =  OMS.DT_EXPINC .dt_expert_id
              AND  OMS.DT_EXPERT .bdate             <=  OMS.DT_EXPINC .INC_DATE_START
              AND  OMS.DT_EXPERT .edate               >=  OMS.DT_EXPINC .INC_DATE_START
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС ) */
  /* +Filter (AND  OMS.DT_EXPINC .RECORD_IN_EXPERT        JOIN  OMS.DT_EXPERT .RECORD_IN
                                                       BROWSER  F004(фм)/Эксперты качества
                                                         QUERY  F004(фм)/Эксперты качества         ) */
             
