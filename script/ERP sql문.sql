        INSERT
    	  INTO
    	       STAFF_SKILL
		       (
		       STAFF_SKILL_NO
			   ,STAFF_NO
			   ,SKILL_CODE
		       )

                
                SELECT
				       STAFF_SKILL_SEQ.nextval,
				       A.* 
				  FROM 
				       (
                    
					        select 
					               24
					               ,(select skill_code from code_skill where skill_name = 'Java')
					          from 
					               dual

					    ) A
                        ;
                        
                        select max(staff_no) from staff;
                        
                        
                        
                        ;;
                        
                        
                        
                        
                        	select 
					               1
					               ,(select skill_code from code_skill where skill_name = 'Java')
					          from 
					               dual;
                                   
                                   
   	SELECT
    	       COUNT(*)
    	  FROM
    	       STAFF;              
                                   
                                   
select 
STAFF_NO,
STAFF_NAME,
DECODE(substr(jumin_no, 8, 1), '1', '남',  '2', '여', '3', '남', '4', '여') as "JUMIN_NO",
DEPARTMENT_NAME,
substr(GRADUATE_DAY, 0, 4) || '-' || substr(GRADUATE_DAY, 4, 2)
from staff S, code_department C
where (S.department_code = C.department_code)
;

                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   
                                   