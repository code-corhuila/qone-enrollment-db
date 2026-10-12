-- academic_record: one per student, created on first access from the token's sub and name (EN-02).
-- student_id is the id of identity.app_user and is NOT a foreign key (cross-domain id).
CREATE TABLE enrollment.academic_record (
    student_id   uuid        NOT NULL,
    student_name text        NOT NULL,
    program      text        NOT NULL,
    semester     integer     NOT NULL,
    created_at   timestamptz NOT NULL DEFAULT now(),
    updated_at   timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_academic_record          PRIMARY KEY (student_id),
    CONSTRAINT chk_academic_record_name    CHECK (length(student_name) BETWEEN 2 AND 120),
    CONSTRAINT chk_academic_record_program CHECK (length(program) BETWEEN 2 AND 80),
    CONSTRAINT chk_academic_record_semester CHECK (semester BETWEEN 1 AND 12)
);
