-- select * from pd_query where query_id = 'F004(фд)/Просроченные сертификаты экспертов качества по Экспертам на текущую дату'
-- oracle

              WITH AT_EXPERT AS  (/* ------------------------------------------------------------------------------------------------- */
                                  /* Взяли всех экспертов, которые включены в реестр                                                   */
                                  /* ------------------------------------------------------------------------------------------------- */
                                  SELECT  DISTINCT
                                          OMS.DT_EXPERT .RECORD_IN
                                    FROM  OMS.DT_EXPERT
                                       ,  OMS.DT_EXPINC
                                   WHERE  OMS.DT_EXPINC .RECORD_IN_EXPERT   =  OMS.DT_EXPERT .RECORD_IN     
                                     AND  OMS.DT_EXPINC .INC_DATE_START    <=  SYSDATE
                                     AND (OMS.DT_EXPINC .REX_DATE_END      >=  SYSDATE
                                      OR  OMS.DT_EXPINC .REX_DATE_END      IS  NULL)                                          
                                 )
           SELECT  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_EXPERT .EXP_CODE
                ,  OMS.DT_EXPERT .EXP_SNILS
                ,  OMS.DT_EXPERT .EXP_SURNAME
                ,  OMS.DT_EXPERT .EXP_FSTNAME
                ,  OMS.DT_EXPERT .EXP_PATNAME
                ,  OMS.CD_JOBMED .JOBMED_CODE
                ,  OMS.CD_JOBMED .JOBMED_NAME             
                ,  OMS.DT_EXPLIC .LIC_TILL
                , (SELECT  LISTAGG (                                                                                                                                                                                  
                           OMS.CD_ACDDEG .ACDDEG_NAME, ', ')
                           WITHIN GROUP (ORDER BY
                           OMS.CD_ACDDEG .ACDDEG_CODE)
                     FROM  OMS.CD_ACDDEG
                        ,  OMS.DT_EXPLIC
                    WHERE  OMS.DT_EXPLIC .RECORD_IN_EXPERT  = OMS.DT_EXPERT .RECORD_IN
                      AND  OMS.DT_EXPLIC .RECORD_IN_ACDDEG  = OMS.CD_ACDDEG .RECORD_IN
                      AND  OMS.CD_ACDDEG .DATE_START       <= SYSDATE
                      AND  OMS.CD_ACDDEG .DATE_END         >= SYSDATE) "Научная степень            "
                ,  OMS.CD_QLFCAT .QLFCAT_NAME
                ,  OMS.DT_EXPLIC .LIC_SPEC_YEAR
                ,  OMS.DT_EXPLIC .LIC_SPEC_WORK
                ,  OMS.DT_EXPLIC .LIC_SPEC_POST
                , (SELECT  OMS.DT_LICEXM .EXM_QTY_EXAM
                     FROM  OMS.DT_LICEXM
                    WHERE  OMS.DT_LICEXM .RECORD_UQ_EXPLIC    = OMS.DT_EXPLIC .RECORD_UQ
                      AND  EXTRACT (YEAR FROM
                           OMS.DT_LICEXM .EXM_YEAR)           = EXTRACT (YEAR FROM SYSDATE) - 1) "Экспертиз@#,###,##0"
                , (SELECT  OMS.DT_LICEXM .EXM_QTY_REEX
                     FROM  OMS.DT_LICEXM
                    WHERE  OMS.DT_LICEXM .RECORD_UQ_EXPLIC    = OMS.DT_EXPLIC .RECORD_UQ
                      AND  EXTRACT (YEAR FROM
                           OMS.DT_LICEXM .EXM_YEAR)           = EXTRACT (YEAR FROM SYSDATE) - 1) "Реэкспертиз@#,###,##0"
                ,  TO_CHAR
                  (OMS.CD_EXPHSS .EXPHSS_CODE, '09')                                             "Код ГВС"
                , (SELECT  MAX
                          (OMS.DT_EXPINC .INC_DATE_START) 
                     FROM  OMS.DT_EXPINC
                    WHERE  OMS.DT_EXPINC .RECORD_IN_EXPERT   = OMS.DT_EXPERT .RECORD_IN
                      AND  EXTRACT (YEAR FROM
                           OMS.DT_EXPINC .INC_DATE_START)   <= EXTRACT (YEAR FROM  SYSDATE)) "Дата включения@dd.MM.yyyy"
                ,  OMS.OMS_MAIN  .getExpIncAllOff       (OMS.DT_EXPERT .RECORD_IN, SYSDATE)  "Предложения включения"
                ,  OMS.OMS_MAIN  .getExpIncDateEnd      (OMS.DT_EXPERT .RECORD_IN, SYSDATE)  "Дата исключения@dd.MM.yyyy"
                ,  OMS.OMS_MAIN  .getExpIncAllRex       (OMS.DT_EXPERT .RECORD_IN, SYSDATE)  "Причины исключения"
                ,  OMS.DT_EXPERT .EXP_PHONE1
                ,  OMS.DT_EXPERT .EXP_PHONE2
                ,  OMS.DT_EXPERT .EXP_EMAIL
             FROM      AT_EXPERT
                ,  OMS.DT_EXPERT
                ,  OMS.CB_OKATO
                ,  OMS.DT_EXPLIC 
                ,  OMS.CD_JOBMED
                ,  OMS.CD_QLFCAT
                ,  OMS.CD_EXPHSS 
            WHERE  OMS.DT_EXPERT .RECORD_IN                  =      AT_EXPERT .RECORD_IN
              AND  OMS.DT_EXPERT .RECORD_IN             NOT IN (SELECT  DISTINCT
                                                                        OMS.DT_EXPERT .RECORD_IN
                                                                  FROM  OMS.DT_EXPERT
                                                                     ,  OMS.DT_EXPLIC
                                                                 WHERE  OMS.DT_EXPLIC .RECORD_IN_EXPERT   =  OMS.DT_EXPERT .RECORD_IN     
                                                                   AND  OMS.DT_EXPLIC .LIC_TYPE           =  'Сертификат'
                                                                   AND (OMS.DT_EXPLIC .LIC_TILL          >=  SYSDATE
                                                                    OR  OMS.DT_EXPLIC .LIC_TILL          IS  NULL)
                                                               )
              AND  OMS.DT_EXPLIC .RECORD_IN_EXPERT           =  OMS.DT_EXPERT .RECORD_IN
              AND  OMS.DT_EXPLIC .LIC_TYPE                   =  'Сертификат'
              AND  OMS.CD_JOBMED .RECORD_IN             (+)  =  OMS.DT_EXPLIC .RECORD_IN_JOBMED
              AND  OMS.CD_QLFCAT .RECORD_IN             (+)  =  OMS.DT_EXPLIC .RECORD_IN_QLFCAT
              AND  OMS.CD_EXPHSS .RECORD_IN             (+)  =  OMS.DT_EXPLIC .RECORD_IN_EXPHSS
              AND  OMS.CB_OKATO  .RECORD_IN             (+)  =  OMS.DT_EXPERT .RECORD_IN_OKATO         
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN               
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС
                                                         QUERY  F001(фм)/Территориальные фонды ОМС           ) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_JOBMED        JOIN  OMS.CD_JOBMED .RECORD_IN               
                                                       BROWSER  V015/Классификатор медицинских специальностей
                                                         QUERY  V015/Классификатор медицинских специальностей) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_QLFCAT        JOIN  OMS.CD_QLFCAT .RECORD_IN               
                                                       BROWSER  R011/Классификатор квалификационных категорий
                                                         QUERY  R011/Категории-На заданную дату              ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN          MULTYJOIN  OMS.VT_EXPREX .RECORD_IN_EXPERT
                                                       BROWSER  R010/Классификатор причин исключения из реестра Экспертов
                                                         QUERY  R010/Классификатор причин исключения из реестра Экспертов
                                                       THROUGH  OMS.VT_EXPREX .RECORD_IN_EXPREX                                                                            
                                                         LABEL  Исключения                                   ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN          MULTYJOIN  OMS.VT_EXPOFF .RECORD_IN_EXPERT                                 
                                                       BROWSER  R009/Классификатор организаций, представляющих кандидатуру Эксперта       
                                                         QUERY  R009/Классификатор организаций, представляющих кандидатуру Эксперта       
                                                       THROUGH  OMS.VT_EXPOFF .RECORD_IN_EXPOFF                                 
                                                         LABEL  Предложения                                  ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN          MULTYJOIN  OMS.DT_EXPLIC .RECORD_IN_EXPERT        
                                                       BROWSER  R012/Классификатор учёных степеней
                                                         QUERY  R012/Степени-На заданную дату
                                                       THROUGH  OMS.DT_EXPLIC .RECORD_IN_ACDDEG
                                                         LABEL  Ученые степени                               ) */
              AND  OMS.DT_EXPERT .DATE_START                <=  SYSDATE
              AND  OMS.DT_EXPERT .DATE_END                  >=  SYSDATE
              AND  OMS.CD_JOBMED .DATE_START            (+) <=  SYSDATE
              AND  OMS.CD_JOBMED .DATE_END              (+) >=  SYSDATE
              AND  OMS.CD_QLFCAT .DATE_START            (+) <=  SYSDATE
              AND  OMS.CD_QLFCAT .DATE_END              (+) >=  SYSDATE
              AND  OMS.CD_EXPHSS .DATE_START            (+) <=  SYSDATE
              AND  OMS.CD_EXPHSS .DATE_END              (+) >=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_START            (+) <=  SYSDATE
              AND  OMS.CB_OKATO  .DATE_END              (+) >=  SYSDATE
         ORDER BY  OMS.CB_OKATO  .OKATO_NAME
                ,  OMS.DT_EXPERT .EXP_CODE
                ,  OMS.CD_JOBMED .JOBMED_NAME             



-- postgresql

              WITH AT_EXPERT AS  (/* ------------------------------------------------------------------------------------------------- */
                                  /* Взяли всех экспертов, которые включены в реестр                                                   */
                                  /* ------------------------------------------------------------------------------------------------- */
                                SELECT  DISTINCT
                                          OMS.DT_EXPERT .temp_id
                                    FROM  OMS.DT_EXPERT
                                       join  OMS.DT_EXPINC on OMS.DT_EXPINC .dt_expert_id   =  OMS.DT_EXPERT .temp_id     
                                     AND  OMS.DT_EXPINC .INC_date_start    <=  now()
                                     AND (OMS.DT_EXPINC .REX_date_end      >=  now()
                                      OR  OMS.DT_EXPINC .REX_date_end      IS  NULL)                                             
                                 )
           SELECT count(*)
             FROM      AT_EXPERT
               join  OMS.DT_EXPERT on OMS.DT_EXPERT .temp_id                  =      AT_EXPERT .temp_id
										AND  OMS.DT_EXPERT .bdate                <=  now()
										AND  OMS.DT_EXPERT .edate                  >=  now()
										and OMS.DT_EXPERT .temp_id             NOT IN (SELECT  DISTINCT
                                                                        OMS.DT_EXPERT .temp_id
                                                                  FROM  OMS.DT_EXPERT
                                                                     join  OMS.DT_EXPLIC on OMS.DT_EXPLIC .dt_expert_id   =  OMS.DT_EXPERT .temp_id
                                                                   AND  OMS.DT_EXPLIC .LIC_TYPE           =  'Сертификат'
                                                                   AND (OMS.DT_EXPLIC .LIC_TILL          >=  now()
                                                                    OR  OMS.DT_EXPLIC .LIC_TILL          IS  NULL)
                                                               )
                left join OMS.CB_OKATO on OMS.CB_OKATO  .temp_id              =  OMS.DT_EXPERT .cb_okato_id    
										AND  OMS.CB_OKATO  .bdate            <=  now()
										AND  OMS.CB_OKATO  .edate              >=  now()					
                join  OMS.DT_EXPLIC on OMS.DT_EXPLIC .dt_expert_id           =  OMS.DT_EXPERT .temp_id
								    AND  OMS.DT_EXPLIC .LIC_TYPE                   =  'Сертификат'
                left join  OMS.CD_JOBMED on OMS.CD_JOBMED .temp_id              =  OMS.DT_EXPLIC .cd_jobmed_id
										AND  OMS.CD_JOBMED .bdate            <=  now()
										AND  OMS.CD_JOBMED .edate              >=  now()
                left join  OMS.CD_QLFCAT on OMS.CD_QLFCAT .temp_id              =  OMS.DT_EXPLIC .cd_qlfcat_id
									AND  OMS.CD_QLFCAT .bdate            <=  now()
										AND  OMS.CD_QLFCAT .edate              >=  now()
                left join  OMS.CD_EXPHSS on OMS.CD_EXPHSS .temp_id              =  OMS.DT_EXPLIC .cd_exphss_id      
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_OKATO         JOIN  OMS.CB_OKATO  .RECORD_IN               
                                                       BROWSER  O002/Общероссийский классификатор административно-территориального деления
                                                         QUERY  O002/Общероссийский классификатор административно-территориального деления) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN_TSFOMS        JOIN  OMS.DT_TSFOMS .RECORD_IN               
                                                       BROWSER  F001(фм)/Территориальные фонды ОМС
                                                         QUERY  F001(фм)/Территориальные фонды ОМС           ) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_JOBMED        JOIN  OMS.CD_JOBMED .RECORD_IN               
                                                       BROWSER  V015/Классификатор медицинских специальностей
                                                         QUERY  V015/Классификатор медицинских специальностей) */
  /* +Filter (AND  OMS.DT_EXPLIC .RECORD_IN_QLFCAT        JOIN  OMS.CD_QLFCAT .RECORD_IN               
                                                       BROWSER  R011/Классификатор квалификационных категорий
                                                         QUERY  R011/Категории-На заданную дату              ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN          MULTYJOIN  OMS.VT_EXPREX .RECORD_IN_EXPERT
                                                       BROWSER  R010/Классификатор причин исключения из реестра Экспертов
                                                         QUERY  R010/Классификатор причин исключения из реестра Экспертов
                                                       THROUGH  OMS.VT_EXPREX .RECORD_IN_EXPREX                                                                            
                                                         LABEL  Исключения                                   ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN          MULTYJOIN  OMS.VT_EXPOFF .RECORD_IN_EXPERT                                 
                                                       BROWSER  R009/Классификатор организаций, представляющих кандидатуру Эксперта       
                                                         QUERY  R009/Классификатор организаций, представляющих кандидатуру Эксперта       
                                                       THROUGH  OMS.VT_EXPOFF .RECORD_IN_EXPOFF                                 
                                                         LABEL  Предложения                                  ) */
  /* +Filter (AND  OMS.DT_EXPERT .RECORD_IN          MULTYJOIN  OMS.DT_EXPLIC .RECORD_IN_EXPERT        
                                                       BROWSER  R012/Классификатор учёных степеней
                                                         QUERY  R012/Степени-На заданную дату
                                                       THROUGH  OMS.DT_EXPLIC .RECORD_IN_ACDDEG
                                                         LABEL  Ученые степени                               ) */