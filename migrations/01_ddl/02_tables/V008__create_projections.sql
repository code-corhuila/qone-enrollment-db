-- Read models fed by catalog and billing events (06-data/models.md, D-11). A projection is
-- rebuilt from the event stream, never edited by hand; a late event is applied by updated_at.
CREATE TABLE enrollment.catalog_subject_view (
    subject_id    uuid        NOT NULL,
    code          text        NOT NULL,
    name          text        NOT NULL,
    credits       integer     NOT NULL,
    semester      integer     NOT NULL,
    prerequisites text[]      NOT NULL DEFAULT '{}',
    updated_at    timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_catalog_subject_view PRIMARY KEY (subject_id)
);

CREATE TABLE enrollment.catalog_section_view (
    section_id      uuid        NOT NULL,
    subject_code    text        NOT NULL,
    subject_name    text        NOT NULL,
    term            text        NOT NULL,
    group_number    integer     NOT NULL,
    professor_name  text        NOT NULL,
    slots           jsonb       NOT NULL,
    seats_available integer     NOT NULL,
    updated_at      timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_catalog_section_view PRIMARY KEY (section_id)
);

CREATE TABLE enrollment.billing_tuition_view (
    student_id uuid        NOT NULL,
    term       text        NOT NULL,
    status     text        NOT NULL,
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_billing_tuition_view     PRIMARY KEY (student_id, term),
    CONSTRAINT chk_billing_tuition_status  CHECK (status IN ('ISSUED', 'PAID'))
);
