create or replace TRIGGER update_annonce
AFTER INSERT ON ANNONCE
FOR EACH ROW
DECLARE
name_site VARCHAR2(100);
complete_name_site VARCHAR2(100);
t_cnt INTEGER;
r_cnt INTEGER;

BEGIN
    name_site :=  :new.site_provenance;
    complete_name_site := CONCAT('Stat_',name_site);
    Raise_Application_Error (-20343, 'The balance is too low.');
    update_stat(complete_name_site,1);
    commit;   
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('row:'||:new.title||' updated'); 
      
      UPDATE annonce
      SET date_dernier_poste = (TO_CHAR(sysdate))
      where  :new.title = title and :new.lien = lien;
      
      update_stat(complete_name_site,2);

    WHEN OTHERS THEN
	
      update_stat(complete_name_site,3);
      RAISE;
        
END;
/
ALTER TRIGGER update_annonce ENABLE;