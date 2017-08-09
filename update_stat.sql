create or replace PROCEDURE update_stat (complete_name_site IN VARCHAR2, type_change IN number ) IS
 
t_cnt INTEGER;
r_cnt INTEGER;
name_return VARCHAR2(100);
test_lol VARCHAR(50);
sql_stmt  VARCHAR(200);

BEGIN
		
			if type_change = 1 THEN name_return := 'line_added';
			elsif type_change =  2 THEN name_return := 'line_updated';
			elsif type_change =  3 THEN name_return := 'line_rejected';
      END if;
     
        execute immediate 'SELECT COUNT(*) FROM user_tables WHERE table_name = :site'
        INTO t_cnt USING complete_name_site;
        
         IF ( t_cnt > 0 ) THEN
          execute immediate 'SELECT COUNT(*) FROM :site WHERE date_update = TO_CHAR(sysdate))'
          INTO r_cnt USING complete_name_site;
          
			
        	IF( r_cnt > 0 ) THEN
          	EXECUTE immediate 'UPDATE :site SET    :name = :name + 1 WHERE date_update = (TO_CHAR(sysdate)))'
            USING complete_name_site,name_return;
        	else
          	EXECUTE immediate 'INSERT INTO :site (:name, date_update) VALUES (1, (TO_CHAR(sysdate)))'
            USING complete_name_site,name_return;
        	END if;
        else
           
          DBMS_OUTPUT.PUT_LINE('row:' || complete_name_site || ' updated');  
          
        end if;
   

END update_stat;