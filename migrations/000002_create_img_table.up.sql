CREATE TABLE IF NOT EXISTS img (
    id           BIGSERIAL PRIMARY KEY,
    source_url   TEXT        NOT NULL,         -- звідки взяли картинку
    storage_path TEXT,                          -- шлях у файловій системі або s3
    mime_type    TEXT,                          -- image/jpeg, image/png і т.д.
    width        INT,
    height       INT,
    size_bytes   BIGINT,
    meta         JSONB       DEFAULT '{}'::jsonb, -- довільні метадані
    created_at   TIMESTAMPTZ NOT NULL DEFAULT now(),
    updated_at   TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- індекси
CREATE UNIQUE INDEX IF NOT EXISTS ux_img_source_url ON img(source_url);
CREATE INDEX IF NOT EXISTS ix_img_created_at ON img(created_at DESC);