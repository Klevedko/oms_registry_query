  -- select * from pd_query where query_id = 'F002(фд)/Лицензии страховых медицинских организаций действующие на текущую дату'
	-- oracle
	SELECT  DISTINCT  
                   OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSCOM .INS_FULL
                ,  OMS.DT_INSLIC .LIC_DATE_START
                ,  OMS.DT_INSLIC .LIC_DATE_END
                ,  OMS.DT_INSLIC .LIC_DATE_TERM
                ,  OMS.DT_INSLIC .LIC_NUMBER
                , (SELECT  TO_CHAR (TO_NUMBER (COUNT (*),'B9'),'B9')
                     FROM  OMS.CA_SCANDOC 
                    WHERE  OMS.CA_SCANDOC .RECORD_UQ_INSLIC = OMS.DT_INSLIC .RECORD_UQ) "К/С"
                ,  OMS.DT_INSLIC .UPDATE_DATE
                ,  OMS.DT_INSLIC .UPDATE_USER
             FROM  OMS.DT_INSLIC 
                ,  OMS.DT_INSCOM 
            WHERE  OMS.DT_INSCOM .RECORD_IN             (+)  =  OMS.DT_INSLIC .RECORD_IN_INSCOM
              AND  OMS.DT_INSCOM .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_INSCOM .DATE_END              (+) >=  SYSDATE
              AND  OMS.DT_INSLIC .LIC_DATE_START            <=  SYSDATE
              AND  NVL (         
                   OMS.DT_INSLIC .LIC_DATE_END  , SYSDATE)  >=  SYSDATE
              AND  NVL (         
                   OMS.DT_INSLIC .LIC_DATE_TERM , SYSDATE)  >=  SYSDATE
  /* +Filter (AND  OMS.DT_INSLIC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                                ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
              AND  OMS.OMS_MAIN  .isRecordAllowByCode (OMS.DT_INSCOM .INS_CODE, OMS.DT_INSCOM .OMS_STATUS)   
                                                             =  1
         ORDER BY  OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSLIC .LIC_DATE_START
                ,  OMS.DT_INSLIC .LIC_DATE_END
                ,  OMS.DT_INSLIC .LIC_NUMBER

				
	-- postgresql
	SELECT  count(*)
             FROM  OMS.DT_INSLIC 
                left join  OMS.DT_INSCOM on OMS.DT_INSCOM .temp_id               =  OMS.DT_INSLIC .dt_inscom_id
              AND  OMS.DT_INSCOM .bdate             <=  now()
              AND  OMS.DT_INSCOM .edate               >=  now()
							where OMS.DT_INSLIC .LIC_DATE_START            <=  now()
              AND  COALESCE (         
                   OMS.DT_INSLIC .LIC_DATE_END  , now())  >=  now()
              AND  COALESCE (         
                   OMS.DT_INSLIC .LIC_DATE_TERM , now())  >=  now()
  /* +Filter (AND  OMS.DT_INSLIC .RECORD_IN_INSCOM        JOIN  OMS.DT_INSCOM .RECORD_IN                                                  
                                                       BROWSER  F002(фм)/Страховые медицинские организации                                
                                                         QUERY  F002(фм)/Страховые медицинские организации                                ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN                                                  
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС                                      
                                                         QUERY  F001(фм)/Территориальные фонды ОМС                                        ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_OKOPF         JOIN  OMS.CB_OKOPF  .RECORD_IN               
                                                       BROWSER  O005/Общероссийский классификатор организационно-правовых форм
                                                         QUERY  O005/Общероссийский классификатор организационно-правовых форм            ) */
  /* +Filter (AND  OMS.DT_INSCOM .RECORD_IN_INSSUB        JOIN  OMS.CD_INSSUB .RECORD_IN               
                                                       BROWSER  R007/Классификатор признака подчиненности СМО
                                                         QUERY  R007/Классификатор признака подчиненности СМО                             ) */
				