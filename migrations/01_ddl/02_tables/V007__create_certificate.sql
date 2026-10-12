-- certificate: issued once, rendered once (D-12), verified publicly by its code (EN-11).
CREATE TABLE enrollment.certificate (
    id           uuid        NOT NULL DEFAULT gen_random_uuid(),
    student_id   uuid        NOT NULL,
    student_name text        NOT NULL,
    type         text        NOT NULL,
    code         text        NOT NULL,
    term         text        NOT NULL,
    document     bytea       NOT NULL,
    issued_at    timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT pk_certificate      PRIMARY KEY (id),
    CONSTRAINT chk_certificate_type CHECK (type IN ('estudios', 'matricula', 'pago', 'paz-y-salvo', 'avance')),
    CONSTRAINT chk_certificate_code CHECK (code ~ '^QMP-[A-Z0-9]{8}$'),
    CONSTRAINT chk_certificate_term CHECK (term ~ '^[0-9]{4}-[AB]$')
);
