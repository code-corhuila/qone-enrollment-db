-- An Idempotency-Key belongs to whoever sent it (qone-docs#55): the same key from another caller is
-- another key, so a replay never returns someone else's resource. owner_id is the user id of the
-- token, or the subject of a SERVICE token (the saga: qone-workflow). request_hash is the SHA-256
-- of the canonical request body: the same owner and key with another body is refused (422).
ALTER TABLE enrollment.idempotency_key
    ADD COLUMN owner_id     text NULL,
    ADD COLUMN request_hash text NULL;

-- The keys recorded before this version: the owner comes from the resource they point at (a
-- certificate is its student's; an enrollment was recorded by the saga). Their body was never
-- fingerprinted, so request_hash stays NULL and the service matches them by owner only.
UPDATE enrollment.idempotency_key k SET owner_id = c.student_id::text
FROM enrollment.certificate c
WHERE k.resource_type = 'certificate' AND c.id = k.resource_id AND k.owner_id IS NULL;
UPDATE enrollment.idempotency_key SET owner_id = 'qone-workflow'
WHERE resource_type = 'enrollment' AND owner_id IS NULL;
DELETE FROM enrollment.idempotency_key WHERE owner_id IS NULL;  -- a key whose resource no longer exists

ALTER TABLE enrollment.idempotency_key
    ALTER COLUMN owner_id SET NOT NULL,
    DROP CONSTRAINT pk_idempotency_key,
    ADD CONSTRAINT pk_idempotency_key PRIMARY KEY (owner_id, key),
    ADD CONSTRAINT chk_idempotency_key_owner CHECK (length(owner_id) BETWEEN 1 AND 128),
    ADD CONSTRAINT chk_idempotency_key_request_hash CHECK (request_hash IS NULL OR request_hash ~ '^[0-9a-f]{64}$');
