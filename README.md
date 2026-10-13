# qone-enrollment-db

> enrollment bounded context: database (schema, seeds, migrations)

Part of the **Qampus (Quorum One)** distributed system — team `quorum-one`, Grupo 1.
Governance and documentation live in [`qone-docs`](https://github.com/code-corhuila/qone-docs).

## Purpose

The database of the **enrollment** domain (course norm 5.2, Annex A): its own PostgreSQL 16
instance, the schema `enrollment` and the migrations that build it. `qone-enrollment-api`
consumes it and never versions it; no other service connects here (ADR-006). The tool is
**Flyway Community** (ADR-007): one SQL file, one version, a mirror `U` script per version.

Specification: `06-data/models.md` (schema `enrollment`), `06-data/modeling-conventions.md`,
`06-data/migration-strategy.md`. Stories: `code-corhuila/qone-docs#40`..`#42` (HU-ENR-001..003).

## Schema

| Table | What it keeps | Rules the database enforces |
|---|---|---|
| `academic_record` | one row per student, created on first access | name, program, semester shape |
| `passed_subject` | the subjects a student passed | **append-only by grant** (INV-REC-001): the writer has `INSERT, SELECT` only |
| `enrollment` | the facts the saga records: `CONFIRMED`, `REJECTED` (with its reason), `CANCELLED` | **one `CONFIRMED` per student, subject and term by partial unique index** (INV-ENR-001); `REJECTED` if and only if a reason; `AGENT` if and only if a `confirmation_id` (INV-ENR-005) |
| `enrollment_slot` | the schedule snapshot of an enrollment | day and times shape; the conflict rule (INV-ENR-003) is in the domain |
| `certificate` | issued certificates with their PDF, rendered once (D-12) | type list, public code `QMP-XXXXXXXX` unique |
| `catalog_subject_view`, `catalog_section_view`, `billing_tuition_view` | projections fed by catalog and billing events (D-11) | rebuilt from events, never edited by hand |
| `idempotency_key`, `outbox`, `inbox` | the shared shapes of 06-data | `EnrollmentConfirmed`, `EnrollmentRejected`, `EnrollmentCancelled`, `CertificateIssued` |

`student_id` and `section_id` are ids of other domains and are not foreign keys.

## How to run it

```bash
cp .env.example .env            # set ENROLLMENT_DB_PASSWORD; .env is ignored by git
docker network create platform  # once; qone-infra creates it in the full platform
docker compose --env-file .env -f deploy/compose.yml up -d enrollment-db
docker compose --env-file .env -f deploy/compose.yml --profile tooling run --rm enrollment-db-migrate
sh scripts/rebuild-check.sh     # the Annex A check db-ci runs on every pull request
```

## Branching

Three permanent branches. **None of them accepts a direct commit** — you enter through a child
branch and leave through a Pull Request.

```
develop  <--PR--  feat/... fix/... chore/...
qa       <--PR--  qa/...
main     <--PR--  release/...  hotfix/...
```

Promotion happens **by re-application** (`git cherry-pick -x`), never by merging one permanent
branch into another: `merge develop -> qa` and `merge qa -> main` do not exist in this model.

`main` requires **1 approval from `ariel5253`**. On `develop` and `qa` the team sets its own review
rule.

Full policy: `00-governance/branching-policy.md` in `qone-docs`.
