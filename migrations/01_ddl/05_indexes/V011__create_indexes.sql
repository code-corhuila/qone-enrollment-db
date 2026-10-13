-- INV-ENR-001 enforced by the database: one CONFIRMED enrollment per student, subject and term.
CREATE UNIQUE INDEX ux_enrollment_active ON enrollment.enrollment (student_id, subject_code, term) WHERE status = 'CONFIRMED';
CREATE INDEX ix_enrollment_student_term ON enrollment.enrollment (student_id, term, created_at DESC);   -- EN-07, EN-09
CREATE INDEX ix_enrollment_section_status ON enrollment.enrollment (section_id, status);               -- EN-10 roster
CREATE UNIQUE INDEX ux_certificate_code ON enrollment.certificate (code);                               -- EN-11
CREATE INDEX ix_certificate_student_issued ON enrollment.certificate (student_id, issued_at DESC);       -- EN-12
CREATE UNIQUE INDEX ux_catalog_subject_view_code ON enrollment.catalog_subject_view (code);
CREATE INDEX ix_outbox_unpublished ON enrollment.outbox (occurred_at) WHERE published_at IS NULL;
CREATE INDEX ix_idempotency_key_created_at ON enrollment.idempotency_key (created_at);
