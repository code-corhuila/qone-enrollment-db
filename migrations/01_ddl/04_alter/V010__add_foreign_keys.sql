-- Foreign keys inside the domain, after every table exists (Annex A rule 2).
ALTER TABLE enrollment.passed_subject
    ADD CONSTRAINT fk_passed_subject_record FOREIGN KEY (student_id) REFERENCES enrollment.academic_record (student_id) ON DELETE RESTRICT;
ALTER TABLE enrollment.enrollment
    ADD CONSTRAINT fk_enrollment_record FOREIGN KEY (student_id) REFERENCES enrollment.academic_record (student_id) ON DELETE RESTRICT;
ALTER TABLE enrollment.enrollment_slot
    ADD CONSTRAINT fk_enrollment_slot_enrollment FOREIGN KEY (enrollment_id) REFERENCES enrollment.enrollment (id) ON DELETE CASCADE;
ALTER TABLE enrollment.certificate
    ADD CONSTRAINT fk_certificate_record FOREIGN KEY (student_id) REFERENCES enrollment.academic_record (student_id) ON DELETE RESTRICT;
