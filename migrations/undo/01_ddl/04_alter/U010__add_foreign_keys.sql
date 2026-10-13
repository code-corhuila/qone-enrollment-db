ALTER TABLE enrollment.certificate DROP CONSTRAINT IF EXISTS fk_certificate_record;
ALTER TABLE enrollment.enrollment_slot DROP CONSTRAINT IF EXISTS fk_enrollment_slot_enrollment;
ALTER TABLE enrollment.enrollment DROP CONSTRAINT IF EXISTS fk_enrollment_record;
ALTER TABLE enrollment.passed_subject DROP CONSTRAINT IF EXISTS fk_passed_subject_record;
