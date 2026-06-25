# 🛰️ Radar de Mercado Laboral Tech

Pipeline de datos *end-to-end* que ingiere ofertas de empleo del sector tecnológico, extrae habilidades, stacks y rangos salariales mediante NLP, los almacena en un modelo dimensional en PostgreSQL y los visualiza en un dashboard interactivo en Power BI.

> **Problema que resuelve:** quien busca empleo en datos/tecnología no sabe qué habilidades se piden *realmente* ni cómo se mueven los salarios. Este radar convierte cientos de ofertas dispersas en tendencias claras y accionables.

---

## 🧱 Arquitectura

```
   API de empleo  ──▶  Ingesta (Python)  ──▶  data/raw
                                                  │
                                                  ▼
                                   Transformación + NLP (Python)
                                                  │
                                                  ▼
                              PostgreSQL (esquema estrella · Docker)
                                                  │
                                                  ▼
                                      Power BI (dashboard)
```

## 🛠️ Stack tecnológico

| Capa | Herramienta |
|---|---|
| Lenguaje | Python |
| Base de datos | PostgreSQL |
| Contenedores | Docker / Docker Compose |
| Visualización | Power BI |
| Control de versiones | Git / GitHub |

## 📁 Estructura del proyecto

```
Data-Insights-Innovator/
├── data/
│   ├── raw/            # Datos crudos de la API (sin transformar)
│   └── processed/      # Datos limpios y estructurados
├── src/
│   ├── ingestion/      # Extracción de ofertas
│   ├── transformation/ # Limpieza + NLP
│   └── load/           # Carga a PostgreSQL
├── sql/                # Scripts DDL del modelo de datos
├── notebooks/          # Exploración y pruebas
├── docs/               # Documentación y diagramas
├── docker-compose.yml  # PostgreSQL + pgAdmin
├── requirements.txt    # Dependencias de Python
└── ROADMAP.md          # Plan del proyecto por fases
```

## 🚀 Puesta en marcha

```bash
# 1. Levantar la base de datos
docker compose up -d

# 2. Crear y activar el entorno virtual
python -m venv venv
.\venv\Scripts\Activate        # Windows

# 3. Instalar dependencias
pip install -r requirements.txt
```

> Las credenciales se gestionan en un archivo `.env` (no versionado). Ver `docker-compose.yml` para las variables requeridas.

## 📌 Estado del proyecto

🚧 En construcción — **Fase 0: Arquitectura y Setup** completada.

---

*Proyecto de portafolio desarrollado por Camila.*
