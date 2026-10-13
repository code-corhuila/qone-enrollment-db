DELETE FROM enrollment.billing_tuition_view WHERE student_id::text LIKE '11111111-1111-4111-8111-11111111111_';
DELETE FROM enrollment.catalog_section_view WHERE section_id::text LIKE '55555555-5555-4555-8555-5555555555%';
DELETE FROM enrollment.catalog_subject_view WHERE subject_id::text LIKE '44444444-4444-4444-8444-4444444444%';
