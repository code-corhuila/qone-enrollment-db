-- enrollment_slot: the schedule snapshot of an enrollment; the conflict rule (INV-ENR-003) runs
-- against the CONFIRMED rows of the student.
CREATE TABLE enrollment.enrollment_slot (
    enrollment_id uuid NOT NULL,
    day           text NOT NULL,
    start_time    time NOT NULL,
    end_time      time NOT NULL,
    CONSTRAINT pk_enrollment_slot      PRIMARY KEY (enrollment_id, day, start_time, end_time),
    CONSTRAINT chk_enrollment_slot_day  CHECK (day IN ('MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT')),
    CONSTRAINT chk_enrollment_slot_time CHECK (start_time < end_time)
);
