CREATE TABLESPACE tbs_perm_01
  DATAFILE 'tbs_perm_01.dat'
    SIZE 10M
    AUTOEXTEND ON;
    
CREATE TEMPORARY TABLESPACE tbs_temp_01
    TEMPFILE 'tbs_temp_01.dbf'
    SIZE 5M
    AUTOEXTEND ON;
    
CREATE USER PYTHONHOL
    IDENTIFIED BY welcome
    DEFAULT TABLESPACE tbs_perm_01
    TEMPORARY TABLESPACE tbs_temp_01
    ;
grant create session to PYTHONHOL;
grant alter session to PYTHONHOL;
grant create table to PYTHONHOL;
grant create trigger to PYTHONHOL;
GRANT UNLIMITED TABLESPACE TO PYTHONHOL;
grant connect ,resource,DBA to PYTHONHOL;


    