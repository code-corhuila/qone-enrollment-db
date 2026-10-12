-- passed_subject is append-only by grant (INV-REC-001): INSERT and SELECT, nothing else.
GRANT USAGE ON SCHEMA enrollment TO enrollment_reader, enrollment_writer;
GRANT SELECT ON ALL TABLES IN SCHEMA enrollment TO enrollment_reader;
GRANT SELECT, INSERT         ON enrollment.passed_subject, enrollment.enrollment_slot, enrollment.certificate, enrollment.inbox TO enrollment_writer;
GRANT SELECT, INSERT, UPDATE ON enrollment.academic_record, enrollment.enrollment, enrollment.outbox,
                                enrollment.catalog_subject_view, enrollment.catalog_section_view, enrollment.billing_tuition_view TO enrollment_writer;
GRANT SELECT, INSERT, DELETE ON enrollment.idempotency_key TO enrollment_writer;
