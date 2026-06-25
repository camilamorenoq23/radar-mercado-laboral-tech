-- ============================================================
-- Radar de Mercado Laboral Tech
-- FASE 1 - Modelado dimensional (Esquema Estrella)
-- Script 01: Tablas de Dimensión
-- Base de datos: radar_laboral
-- ============================================================

-- Idempotencia: si re-ejecutas el script, borra y recrea limpio.
-- CASCADE elimina también lo que dependa de estas tablas (la tabla
-- de hechos y la puente que crearemos en el script 02).
DROP TABLE IF EXISTS dim_fecha       CASCADE;
DROP TABLE IF EXISTS dim_empresa     CASCADE;
DROP TABLE IF EXISTS dim_ubicacion   CASCADE;
DROP TABLE IF EXISTS dim_puesto      CASCADE;
DROP TABLE IF EXISTS dim_modalidad   CASCADE;
DROP TABLE IF EXISTS dim_tecnologia  CASCADE;

-- ------------------------------------------------------------
-- dim_fecha : el "cuándo" de cada oferta
-- ------------------------------------------------------------
CREATE TABLE dim_fecha (
    fecha_key    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    fecha        DATE        NOT NULL,
    dia          SMALLINT    NOT NULL,
    mes          SMALLINT    NOT NULL,
    nombre_mes   VARCHAR(20) NOT NULL,
    trimestre    SMALLINT    NOT NULL,
    anio         SMALLINT    NOT NULL,
    dia_semana   VARCHAR(20) NOT NULL
);

-- ------------------------------------------------------------
-- dim_empresa : el "quién contrata"
-- ------------------------------------------------------------
CREATE TABLE dim_empresa (
    empresa_key     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_empresa  VARCHAR(200) NOT NULL,
    sector          VARCHAR(100),
    tamano          VARCHAR(50)   -- ej. Startup, PyME, Grande
);

-- ------------------------------------------------------------
-- dim_ubicacion : el "dónde"
-- ------------------------------------------------------------
CREATE TABLE dim_ubicacion (
    ubicacion_key  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    ciudad         VARCHAR(100),
    region         VARCHAR(100),
    pais           VARCHAR(100) NOT NULL
);

-- ------------------------------------------------------------
-- dim_puesto : el "qué rol"
-- ------------------------------------------------------------
CREATE TABLE dim_puesto (
    puesto_key     INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    titulo_puesto  VARCHAR(200) NOT NULL,
    seniority      VARCHAR(50),   -- Junior, Semi-Senior, Senior
    categoria      VARCHAR(100)   -- ej. Data, Backend, Frontend, DevOps
);

-- ------------------------------------------------------------
-- dim_modalidad : el "cómo se trabaja"
-- ------------------------------------------------------------
CREATE TABLE dim_modalidad (
    modalidad_key  INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    modalidad      VARCHAR(50) NOT NULL   -- Remoto, Híbrido, Presencial
);

-- ------------------------------------------------------------
-- dim_tecnologia : el catálogo de skills/tecnologías
-- Se conecta a la tabla de hechos mediante la tabla puente.
-- ------------------------------------------------------------
CREATE TABLE dim_tecnologia (
    tecnologia_key    INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nombre_tecnologia VARCHAR(100) NOT NULL,
    tipo              VARCHAR(50)   -- Lenguaje, Framework, BBDD, Cloud, Herramienta
);
