-- The five synthetic students of the demo with the ids and names of the identity seed (06-data,
-- ADR-009). Upsert.
INSERT INTO enrollment.academic_record (student_id, student_name, program, semester, created_at, updated_at)
VALUES
    ('11111111-1111-4111-8111-111111111111', 'Estudiante Demo 01', 'Ingeniería de Software', 6, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111112', 'Estudiante Demo 02', 'Ingeniería de Software', 5, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111113', 'Estudiante Demo 03', 'Ingeniería de Software', 6, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111114', 'Estudiante Demo 04', 'Ingeniería de Software', 7, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111115', 'Estudiante Demo 05', 'Ingeniería de Software', 7, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z')
ON CONFLICT (student_id) DO UPDATE SET student_name = EXCLUDED.student_name, program = EXCLUDED.program, semester = EXCLUDED.semester;
