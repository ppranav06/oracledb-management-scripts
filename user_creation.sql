/* 
Creating Users in OracleDB
*/

/* 
Creating users for the container database (ORCLCDB)
This section creates a user with database administrator (dba) role

thank you, https://forums.oracle.com/ords/apexds/post/can-t-create-a-trigger-4246 !!!
*/
create user c##pranav IDENTIFIED by passwd;

grant CREATE SESSION TO c##pranav;
grant UNLIMITED TABLESPACE to c##pranav;
grant UNLIMITED TABLESPACE to c##pranav;
grant connect, resource, dba to c##pranav;
grant select, insert, update, delete on schema to c##pranav;


/*
Create users - pluggable databases

trying to create users with a special flag, by setting _ORACLE_SCRIPT to true. 
This is not recommended. 
This was done to reduce development time being spent on unnecessary issues. 

Actual reason: To allow illegal names, such as a number (like register numbers, in college's practice database)
*/
ALTER SESSION SET "_ORACLE_SCRIPT"=true;

/* 
Create users, assign roles, grant privileges and allot tablespace quotas
*/
DROP USER "1234567890";
-- 1 Create the user (wrap illegal name within quotes) with password "passwd"
CREATE USER "1234567890" IDENTIFIED BY passwd  DEFAULT TABLESPACE USERS  TEMPORARY TABLESPACE TEMP  PROFILE DEFAULT  ACCOUNT UNLOCK;
-- 2 Tablespace Quotas for "1234567890" 
ALTER USER "1234567890" QUOTA UNLIMITED ON SYSAUX;
ALTER USER "1234567890" QUOTA UNLIMITED ON USERS;
-- 3 Roles for "1234567890" 
GRANT CONNECT TO "1234567890" CONTAINER=ALL;
GRANT RESOURCE TO "1234567890" CONTAINER=ALL;
ALTER USER "1234567890" DEFAULT ROLE NONE;
-- 4 System Privileges for "1234567890" 
GRANT CREATE SESSION TO "1234567890";
GRANT CREATE TABLE TO "1234567890";
GRANT CREATE VIEW TO "1234567890";
GRANT CREATE SEQUENCE TO "1234567890";
GRANT CREATE PROCEDURE TO "1234567890";
GRANT CREATE TRIGGER TO "1234567890";
