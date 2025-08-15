-- Basic administration

/*
-- Query the database file locations
-- select file_name from dba_data_files;
*/

/*
Creating a pluggable database

Note: Change the DATAFILE and FILE_NAME_CONVERT parameters accordingly if you have
deployed OracleDB on Windows. It requires replacement with the installation path.
*/
CREATE PLUGGABLE DATABASE DB_NAME
ADMIN USER DB_NAME_ADMIN IDENTIFIED BY PasswordThatIsNotSecureHere
ROLES = (DBA)
DEFAULT TABLESPACE users
DATAFILE '/opt/oracle/oradata/ORCLCDB/DB_NAME/users01.dbf' SIZE 500M AUTOEXTEND ON
FILE_NAME_CONVERT = ('/opt/oracle/oradata/ORCLCDB/', '/opt/oracle/oradata/ORCLCDB/DB_NAME/');

/* Opens database for writing */
ALTER PLUGGABLE DATABASE DB_NAME open;

/* Opens pluggable databases automatically 
(https://docs.oracle.com/en/database/oracle/oracle-database/21/xeinw/starting-and-stopping-oracle-database-xe.html) 
*/
ALTER PLUGGABLE DATABASE ALL OPEN;
ALTER PLUGGABLE DATABASE ALL SAVE STATE;

/* Create tablespace */
-- CREATE TABLESPACE users DATAFILE 'users01.dbf' SIZE 500M AUTOEXTEND ON;

/* Change session to pluggable database 
(this is done to perform operations such as creating a local user, etc.) 
*/
ALTER SESSION SET CONTAINER=DB_NAME;

/* Create local user for pluggable database */
CREATE USER username IDENTIFIED BY userpassword;
GRANT CONNECT, RESOURCE TO username;
ALTER USER username QUOTA 200M ON USERS;

/* Check if the database is open */
SELECT INSTANCE_NAME, STATUS, DATABASE_STATUS FROM V$INSTANCE;

/*
-- removing database

alter pluggable database db_name close instances=ALL;
drop pluggable database db_name including datafiles;

*/
