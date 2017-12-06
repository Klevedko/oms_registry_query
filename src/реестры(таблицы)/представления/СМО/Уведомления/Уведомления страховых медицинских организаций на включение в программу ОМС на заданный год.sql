-- select * from pd_query where query_id ='F002(фд)/Уведомления страховых медицинских организаций на включение в программу ОМС на заданный год';
-- oracle
					 SELECT  DISTINCT
                   OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSCOM .INS_FULL
                ,  OMS.DT_INSSIG .SIG_YEAR
                ,  OMS.DT_INSSIG .SIG_DATE
                ,  OMS.DT_INSSIG .QTY_INSURE
                , (SELECT  TO_CHAR (TO_NUMBER (COUNT (*),'B9'),'B9')
                     FROM  OMS.CA_SCANDOC 
                    WHERE  OMS.CA_SCANDOC .RECORD_UQ_INSSIG = OMS.DT_INSSIG .RECORD_UQ) "К/С"
                ,  OMS.DT_INSSIG .UPDATE_DATE
                ,  OMS.DT_INSSIG .UPDATE_USER
             FROM  OMS.DT_INSSIG 
                ,  OMS.DT_INSCOM 
            WHERE  OMS.DT_INSCOM .RECORD_IN             (+)  =  OMS.DT_INSSIG .RECORD_IN_INSCOM    
              AND  OMS.DT_INSCOM .DATE_START            (+) <=  SYSDATE
              AND  OMS.DT_INSCOM .DATE_END              (+) >=  SYSDATE
AND  TO_CHAR       
                  (OMS.DT_INSSIG .SIG_YEAR,'YYYY')           =  '2017'
                          
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
              AND  OMS.OMS_MAIN  .isRecordAllowByCode (OMS.DT_INSCOM .INS_CODE, OMS.DT_INSCOM .OMS_STATUS) 
                                                             =  1
         ORDER BY  OMS.DT_INSCOM .INS_CODE
                ,  OMS.DT_INSSIG .SIG_YEAR                
                ,  OMS.DT_INSSIG .SIG_DATE

				
				
-- postgresql
				-- select * from pd_query where query_id ='F002(фд)/Уведомления страховых медицинских организаций на включение в программу ОМС на заданный год';
					 SELECT  COUNT(*)
             FROM  OMS.DT_INSSIG 
                LEFT JOIN  OMS.DT_INSCOM ON OMS.DT_INSCOM .temp_id               =  OMS.DT_INSSIG .dt_inscom_id
              AND  OMS.DT_INSCOM .BDATE             <=  NOW()
              AND  OMS.DT_INSCOM .EDATE               >=  NOW()
where 
                  extract(year from OMS.DT_INSSIG .SIG_YEAR          ) =  '2017'
                          
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
              