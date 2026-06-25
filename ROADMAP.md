# 🛰️ Radar de Mercado Laboral Tech — Roadmap del Proyecto

**Autora:** Camila · **Rol técnico:** Data / BI Engineer
**Stack:** Python · PostgreSQL · Docker · Power BI · GitHub
**Objetivo:** Pipeline end-to-end que ingiere ofertas de empleo tech, extrae skills/stacks/salarios con NLP, los almacena en un modelo dimensional en PostgreSQL y los visualiza en Power BI.

---

## 🎯 Visión del producto

Un observatorio que responde preguntas como:
- ¿Qué tecnologías se piden más este mes y cómo evolucionan?
- ¿Qué skills se pagan mejor?
- ¿Qué combinaciones de stack aparecen juntas (ej. Python + AWS + Docker)?
- ¿Cómo se mueven los rangos salariales por seniority y ubicación?

**Pregunta de portafolio:** "Construí esto para entender el mercado al que estoy aplicando." Esa historia vende.

---

## 🗺️ Fases del proyecto

### Fase 0 — Arquitectura y Setup
Montar la base profesional antes de escribir una sola línea de lógica.
- Estructura de repositorio limpia (`src/`, `data/`, `sql/`, `notebooks/`, `docs/`).
- Entorno virtual + `requirements.txt`.
- `docker-compose.yml` con PostgreSQL + pgAdmin.
- Manejo de secretos con `.env` (y `.gitignore` correcto).
- Inicialización de Git y primer commit.

**Conceptos:** scaffolding de proyectos, contenedores con Docker, gestión de variables de entorno, flujo básico de Git.

### Fase 1 — Modelado de Datos (Esquema Estrella)
Diseñar *cómo* se guardará la información antes de ingerirla.
- Tabla de hechos: `fact_job_posting`.
- Dimensiones: `dim_company`, `dim_skill`, `dim_location`, `dim_date`, `dim_seniority`.
- Tabla puente `bridge_posting_skill` (relación muchos-a-muchos oferta↔skill).
- Scripts DDL versionados en `sql/`.

**Conceptos:** modelado dimensional, esquema estrella vs. normalización, granularidad, claves subrogadas, relaciones muchos-a-muchos.

### Fase 2 — Ingesta / Extracción (Python)
Traer los datos crudos de forma legal y reproducible.
- Elegir fuente: **API de Adzuna** o **Remotive** (gratuitas y legales) frente a scraping.
- Cliente de API con paginación, manejo de rate limits y reintentos.
- Zona de aterrizaje "raw" (JSON crudo / tabla staging) sin transformar.
- Logging y configuración externa.

**Conceptos:** consumo de APIs REST, `requests`, paginación, rate limiting, idempotencia, logging, separación raw vs. processed.

### Fase 3 — Transformación + NLP
Convertir texto desordenado en datos estructurados — el corazón innovador del proyecto.
- Limpieza y deduplicación con pandas.
- Parsing de salarios (regex + normalización de moneda/periodo).
- Extracción de skills con un diccionario taxonómico + spaCy.
- Detección de seniority desde el texto.

**Conceptos:** limpieza de datos con pandas, regex, NLP (extracción de entidades/keywords), construcción de una taxonomía de skills.

### Fase 4 — Carga a PostgreSQL (ETL)
Poblar el modelo estrella de forma robusta.
- Carga con SQLAlchemy.
- Upserts (insertar/actualizar sin duplicar).
- Manejo de transacciones y errores.
- Poblado de dimensiones antes que la tabla de hechos.

**Conceptos:** ETL/ELT, upsert, transacciones, integridad referencial, nociones de Slowly Changing Dimensions.

### Fase 5 — Orquestación y Automatización
Que el pipeline corra solo.
- Encadenar extracción → transformación → carga en un solo flujo.
- Programación (cron en Docker, o un orquestador ligero como Prefect).
- Cargas incrementales (solo lo nuevo).

**Conceptos:** orquestación, idempotencia, cargas incrementales, scheduling.

### Fase 6 — Power BI (Visualización Avanzada)
Convertir el modelo en un dashboard que impresione.
- Conexión a PostgreSQL (Import vs. DirectQuery).
- Modelado del esquema estrella dentro de Power BI.
- Medidas DAX (top skills, salario mediano, crecimiento mensual).
- Drill-down, tooltips, diseño limpio y consistente.

**Conceptos:** conexión a BD, modo Import vs. DirectQuery, DAX, modelado en Power BI, principios de diseño UX/visual.

### Fase 7 — Documentación y Portafolio
Empaquetarlo para que cuente como experiencia demostrable.
- `README.md` profesional con diagrama de arquitectura.
- Capturas del dashboard.
- Guion de storytelling para entrevistas.
- Repo público pulido en GitHub.

**Conceptos:** documentación técnica, diagramas de arquitectura, data storytelling.

---

## ✅ Reglas de trabajo (mentor)
1. Avanzamos **fase por fase**: no paso a la siguiente hasta que confirmes que la actual funciona.
2. En cada fase: explicación práctica + aplicación directa al código/BD/dashboard.
3. Exigencia de buenas prácticas: repo ordenado, commits descriptivos, Docker, diseño limpio.

**Estado actual:** Roadmap aprobado. Próximo paso → **Fase 0: Arquitectura y Setup**.
