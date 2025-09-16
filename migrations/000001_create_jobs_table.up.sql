CREATE TABLE IF NOT EXISTS jobs (
    id UUID PRIMARY KEY,                                      -- унікальний ідентифікатор джоби
    created_at TIMESTAMPTZ NOT NULL DEFAULT now(),            -- час створення
    finished_at TIMESTAMPTZ,                                  -- час завершення (опційно)
    status TEXT NOT NULL CHECK (
        status IN ('new','running','done','error')            -- стан джоби
    ),
    error TEXT,                                               -- повідомлення про помилку (якщо було)
    total_images INT NOT NULL DEFAULT 0,                      -- скільки картинок у job
    processed_images INT NOT NULL DEFAULT 0                   -- скільки картинок вже оброблено
);