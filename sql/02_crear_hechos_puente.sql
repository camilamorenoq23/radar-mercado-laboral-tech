-- ============================================================
-- Radar de Mercado Laboral Tech
-- FASE 1 - Modelado dimensional (Esquema Estrella)
-- Script 02: Tabla de Hechos + Tabla Puente
-- Base de datos: radar_laboral
-- Requisito: ejecutar antes el script 01 (dimensiones).
-- ============================================================

DROP TABLE IF EXISTS bridge_oferta_tecnologia CASCADE;
DROP TABLE IF EXISTS fact_ofertas             CASCADE;

-- ------------------------------------------------------------
-- fact_ofertas : el corazón de la estrella.
-- Una fila = una oferta de empleo publicada (nuestro "grano").
-- Columnas:
--   * Clave subrogada propia (oferta_key)
--   * Claves foráneas (FK) que apuntan a cada dimensión
--   * Métricas (los números que analizaremos)
-- ------------------------------------------------------------
CREATE TABLE fact_ofertas (
    oferta_key        INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    -- Claves foráneas -> conectan con las dimensiones
    fecha_key         INT NOT NULL REFERENCES dim_fecha     (fecha_key),
    empresa_key       INT NOT NULL REFERENCES dim_empresa   (empresa_key),
    ubicacion_key     INT NOT NULL REFERENCES dim_ubicacion (ubicacion_key),
    puesto_key        INT NOT NULL REFERENCES dim_puesto    (puesto_key),
    modalidad_key     INT NOT NULL REFERENCES dim_modalidad (modalidad_key),

    -- Identificador de la oferta en la fuente original (web scraping).
    -- Sirve para no duplicar y para rastrear el origen.
    id_oferta_origen  VARCHAR(100),

    -- Métricas: los salarios pueden venir vacíos (no todas las
    -- ofertas lo publican), por eso permiten NULL.
    salario_min       NUMERIC(12,2),
    salario_max       NUMERIC(12,2),
    moneda            VARCHAR(10)
);

-- ------------------------------------------------------------
-- bridge_oferta_tecnologia : la tabla PUENTE.
-- Resuelve el "muchos a muchos": una oferta pide varias
-- tecnologias y una tecnologia aparece en muchas ofertas.
-- Cada fila = "esta oferta usa esta tecnologia".
-- La clave primaria es COMPUESTA (las dos columnas juntas),
-- asi evitamos repetir el mismo par oferta-tecnologia.
-- ------------------------------------------------------------
CREATE TABLE bridge_oferta_tecnologia (
    oferta_key     INT NOT NULL REFERENCES fact_ofertas   (oferta_key) ON DELETE CASCADE,
    tecnologia_key INT NOT NULL REFERENCES dim_tecnologia (tecnologia_key),
    PRIMARY KEY (oferta_key, tecnologia_key)
);
