-- The five students of the demo with the ids of the identity seed (06-data, ADR-009). Upsert.
INSERT INTO enrollment.academic_record (student_id, student_name, program, semester, created_at, updated_at)
VALUES
    ('11111111-1111-4111-8111-111111111111', 'Laura Gómez', 'Ingeniería de Software', 6, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111112', 'Santiago Rojas', 'Ingeniería de Software', 5, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111113', 'María José Cabrera', 'Ingeniería de Software', 6, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111114', 'Andrés Pineda', 'Ingeniería de Software', 7, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z'),
    ('11111111-1111-4111-8111-111111111115', 'Valentina Suárez', 'Ingeniería de Software', 7, '2026-08-15T09:00:00Z', '2026-08-15T09:00:00Z')
ON CONFLICT (student_id) DO UPDATE SET student_name = EXCLUDED.student_name, program = EXCLUDED.program, semester = EXCLUDED.semester;
