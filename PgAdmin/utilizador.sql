-- Role: "User"
-- DROP ROLE IF EXISTS "User";

CREATE ROLE "User" WITH
  LOGIN
  SUPERUSER
  INHERIT
  CREATEDB
  CREATEROLE
  NOREPLICATION
  ENCRYPTED PASSWORD 'SCRAM-SHA-256$4096:qYcXYLcL07zPfyf652Fv7w==$e0ogF3k/JJAdVHTAVmx6b/hCiTgDgwd5XN46Z2pLow0=:vhNB1J2/x+KSu9dPM9pJNekbc9/7Z1tgOBjTACcNd44=';

GRANT postgres TO "User" WITH ADMIN OPTION;