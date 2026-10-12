-- passed_subject: append-only by grant (INV-REC-001): the writer gets INSERT and SELECT only.
CREATE TABLE enrollment.passed_subject (
    student_id   uuid        NOT NULL,
    subject_code text        NOT NULL,
    passed_at    timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_passed_subject      PRIMARY KEY (student_id, subject_code),
    CONSTRAINT chk_passed_subject_code CHECK (subject_code ~ '^[A-Z0-9-]{3,10}$')
);
