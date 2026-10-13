REVOKE ALL ON ALL TABLES IN SCHEMA enrollment FROM enrollment_writer;
REVOKE ALL ON ALL TABLES IN SCHEMA enrollment FROM enrollment_reader;
REVOKE USAGE ON SCHEMA enrollment FROM enrollment_reader, enrollment_writer;
