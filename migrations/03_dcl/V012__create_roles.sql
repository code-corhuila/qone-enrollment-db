-- Roles carry permissions and have no password (Annex A rule 10): NOLOGIN.
DO $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'enrollment_reader') THEN
        CREATE ROLE enrollment_reader NOLOGIN;
    END IF;
    IF NOT EXISTS (SELECT 1 FROM pg_roles WHERE rolname = 'enrollment_writer') THEN
        CREATE ROLE enrollment_writer NOLOGIN;
    END IF;
END
$$;
