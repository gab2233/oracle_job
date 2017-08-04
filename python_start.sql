ALTER SESSION SET NLS_DATE_FORMAT = 'YYYYMMDD';
DROP TABLE Annonce;
DROP TABLE Compagnie;
DROP TABLE Stat_jobboom;

CREATE TABLE Annonce
(
    title VARCHAR(500) NOT NULL,
    site_provenance VARCHAR(500) NOT NULL,
    lien VARCHAR(1000) NOT NULL,
    texte LONG,
    nom_compagnie VARCHAR(500) NOT NULL,
    date_dernier_poste  VARCHAR(10)  NOT NULL,
    PRIMARY KEY (title, lien)

);

CREATE TABLE Compagnie
(
    nom_compagnie VARCHAR(100) NOT NULL,
    position_compagnie VARCHAR(400) NOT NULL,
    poste_liste VARCHAR(200) NOT NULL,
    date_dernier_poste  VARCHAR(10)  NOT NULL,
    date_premier_poste  VARCHAR(10)  NOT NULL,
    PRIMARY KEY (nom_compagnie,position_compagnie)  
);

CREATE TABLE Stat_jobboom
(
    line_added 	number default 0,
    line_updated 	number default 0,
    line_rejected   number default 0,
    date_update VARCHAR(10) NOT NULL,
    PRIMARY KEY (date_update)
);

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
    --Raise_Application_Error (-20343, 'The balance is too low.');
    update_stat(complete_name_site,1);
      
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
      DBMS_OUTPUT.PUT_LINE('row:'||:new.title||' updated'); 
      
      UPDATE Annonce
      SET date_dernier_poste = (TO_CHAR(sysdate))
      where  :new.title = title and :new.lien = lien;
      
      update_stat(complete_name_site,2);

    WHEN OTHERS THEN
	
      update_stat(complete_name_site,3);
      RAISE;
        
END;
/
ALTER TRIGGER update_annonce ENABLE;