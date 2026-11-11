-- The professor of each section, as catalog's SectionCreated carries it (professorId): the roster
-- of a section (EN-10) is read only by its own professor, ADMIN or SERVICE (qone-docs#48). NULL
-- until the projection receives it: such a section has no professor who may read its roster.
ALTER TABLE enrollment.catalog_section_view
    ADD COLUMN professor_id uuid NULL;
