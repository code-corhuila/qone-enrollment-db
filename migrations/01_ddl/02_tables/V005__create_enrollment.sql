-- enrollment: the facts the saga records (EN-05). The in-flight state is the saga's; there is
-- no PENDING row. Snapshots freeze what the student saw at decision time.
CREATE TABLE enrollment.enrollment (
    id               uuid        NOT NULL DEFAULT gen_random_uuid(),
    student_id       uuid        NOT NULL,
    student_name     text        NOT NULL,
    term             text        NOT NULL,
    subject_code     text        NOT NULL,
    subject_name     text        NOT NULL,
    section_id       uuid        NOT NULL,
    group_number     integer     NOT NULL,
    status           text        NOT NULL,
    rejection_reason text        NULL,
    origin           text        NOT NULL,
    confirmation_id  uuid        NULL,
    reservation_id   uuid        NULL,
    saga_id          uuid        NOT NULL,
    created_at       timestamptz NOT NULL DEFAULT now(),
    updated_at       timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_enrollment                  PRIMARY KEY (id),
    CONSTRAINT chk_enrollment_term            CHECK (term ~ '^[0-9]{4}-[AB]$'),
    CONSTRAINT chk_enrollment_status          CHECK (status IN ('CONFIRMED', 'REJECTED', 'CANCELLED')),
    CONSTRAINT chk_enrollment_reason          CHECK (rejection_reason IS NULL OR rejection_reason IN ('TUITION_UNPAID', 'PREREQ_MISSING', 'NO_SEATS', 'SCHEDULE_CONFLICT')),
    CONSTRAINT chk_enrollment_rejected_reason CHECK ((status = 'REJECTED') = (rejection_reason IS NOT NULL)),
    CONSTRAINT chk_enrollment_origin          CHECK (origin IN ('UI', 'AGENT')),
    -- INV-ENR-005: an enrollment made by the agent carries the student's confirmation.
    CONSTRAINT chk_enrollment_agent_confirmation CHECK ((origin = 'AGENT') = (confirmation_id IS NOT NULL))
);

COMMENT ON COLUMN enrollment.enrollment.section_id IS 'Id in catalog.section; no foreign key across domains.';
