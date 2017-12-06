-- select * from pd_query where query_id = 'F002(фд)/Включения страховых медицинских организаций в реестр ОМС'
-- oracle

           SELECT  DISTINCT 
                   OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSCOM .INS_FULL
                ,  OMS.DT_INSINC .INC_DATE_START
                ,  OMS.DT_INSINC .REX_DATE_END
                ,  OMS.DT_INSINC .REX_POLICE
                , (SELECT  LISTAGG (OMS.CD_INSREX .INSREX_CODE, ',') WITHIN GROUP (ORDER BY OMS.CD_INSREX .INSREX_CODE)             
                     FROM  OMS.DT_INSREX
                        ,  OMS.CD_INSREX
                    WHERE  OMS.DT_INSREX .RECORD_UQ_INSINC  =  OMS.DT_INSINC .RECORD_UQ
                      AND  OMS.CD_INSREX .RECORD_IN         =  OMS.DT_INSREX .RECORD_IN_INSREX        
                      AND  OMS.CD_INSREX .DATE_START       <=  OMS.DT_INSINC .INC_DATE_START
                      AND  OMS.CD_INSREX .DATE_END         >=  OMS.DT_INSINC .INC_DATE_START
                  ) "Причины исключения"
                ,  OMS.DT_INSINC .UPDATE_DATE
                ,  OMS.DT_INSINC .UPDATE_USER
             FROM  OMS.DT_INSINC 
                ,  OMS.DT_INSCOM 
            WHERE  OMS.DT_INSCOM .RECORD_IN             (+)  =  OMS.DT_INSINC .RECORD_IN_INSCOM        
              AND  OMS.DT_INSCOM .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_INSCOM .DATE_END              (+) >=  SYSDATE
  /* +Filter (AND  OMS.DT_INSINC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                           ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                   ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм       ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                        ) */
              AND  OMS.OMS_MAIN  .isRecordAllowByCode (OMS.DT_INSCOM .INS_CODE, OMS.DT_INSCOM .OMS_STATUS) 
                                                             =  1
         ORDER BY  OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSINC .INC_DATE_START
				
				
				
				
				
--postgresql
				
				
          SELECT  count(*)
             FROM  OMS.DT_INSINC 
						 left join OMS.DT_INSCOM on OMS.DT_INSCOM .temp_id =  OMS.DT_INSINC .dt_inscom_id 
              AND  OMS.DT_INSCOM .bdate             <=  CURRENT_DATE
              AND  OMS.DT_INSCOM .edate               >= CURRENT_DATE
  /* +Filter (AND  OMS.DT_INSINC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                           ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                   ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм       ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                        ) */
         
                

