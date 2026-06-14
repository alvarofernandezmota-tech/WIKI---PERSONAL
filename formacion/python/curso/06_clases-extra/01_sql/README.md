# 🗄️ Clase Extra: Bases de Datos, SQL y Big Data

> **Última actualización:** 30 abril 2026  
> **Estado:** 🟡 En progreso — iniciado hoy  
> **Enfoque actual:** 100% Online (Oracle Live SQL + Microsoft Learn)

---

## 🎯 Visión General

Esta carpeta nace como extensión de Musk pero está pensada para crecer hacia un **repositorio independiente** de Data Engineering cuando el contenido lo justifique.

**Ruta de aprendizaje:**
```
SQL Bases → SQL Avanzado → PL/SQL (Oracle) / T-SQL (SQL Server) → Big Data
```

---

## 📚 Contenido — Estado actual

| Tema | Estado | Plataforma |
|------|--------|------------|
| **BD Relacionales — fundamentos** | 🟡 En progreso | Musk (hoy) |
| **SQL básico** (SELECT, WHERE, ORDER BY) | 🟡 En progreso | Musk + Oracle Live SQL |
| **SQL intermedio** (JOINs, GROUP BY, subqueries) | ⏳ Pendiente | Oracle Live SQL |
| **SQL avanzado** (índices, vistas, stored procedures) | ⏳ Pendiente | Oracle Live SQL |
| **BD No relacionales** (MongoDB, Redis) | ⏳ Pendiente | — |
| **PL/SQL** — lenguaje procedural Oracle | ⏳ Pendiente | Oracle Live SQL |
| **T-SQL** — lenguaje procedural SQL Server | ⏳ Pendiente | Microsoft Learn |
| **Big Data** (Hadoop, Spark, pipelines) | ⏳ Pendiente | — |

---

## 🌐 Plataformas Online (sin instalar nada)

| Plataforma | URL | Para qué |
|-----------|-----|----------|
| **Oracle Live SQL** | [livesql.oracle.com](https://livesql.oracle.com) | Practicar SQL y PL/SQL con BD Oracle real en el navegador |
| **Oracle FreeSQL** | [oracle.com/database/technologies/oracle-free-sql](https://www.oracle.com/database/technologies/oracle-free-sql/) | Editor SQL online + conexión VS Code |
| **Microsoft Learn SQL** | [learn.microsoft.com/sql](https://learn.microsoft.com/sql) | Ruta oficial SQL Server + T-SQL + certificaciones |
| **Oracle Dev Gym** | [devgym.oracle.com](https://devgym.oracle.com) | Cursos gratuitos SQL + ejercicios guiados |

---

## 🔵 SQL vs Lenguajes Procedurales — Conceptos clave

### SQL — Estándar (funciona en todos los motores)
Lenguaje **declarativo** → le dices *qué* quieres, no *cómo* obtenerlo.

```sql
SELECT nombre, edad
FROM usuarios
WHERE edad > 18
ORDER BY nombre;
```

### PL/SQL — Oracle (lenguaje procedural)
Extiende SQL añadiendo lógica de programación dentro de Oracle.

```sql
-- Bloque anónimo PL/SQL
DECLARE
  v_nombre VARCHAR2(50);
BEGIN
  SELECT nombre INTO v_nombre FROM usuarios WHERE id = 1;
  DBMS_OUTPUT.PUT_LINE('Nombre: ' || v_nombre);
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('No encontrado');
END;
```

Añade sobre SQL: variables, `IF/THEN/ELSE`, `LOOP/WHILE/FOR`, excepciones, stored procedures, funciones, triggers.

### T-SQL — Microsoft SQL Server
Equivalente de PL/SQL pero para SQL Server (Microsoft).

---

## 🗺️ Rutas de Certificación

### Oracle
| Cert | Nivel | Coste aprox. |
|------|-------|-------------|
| Oracle Database SQL (1Z0-071) | Fundamentos | ~245€ |
| Oracle PL/SQL Developer (1Z0-149) | Intermedio | ~245€ |

### Microsoft SQL Server
| Cert | Nivel | Coste aprox. |
|------|-------|-------------|
| **DP-900** — Data Fundamentals | Principiante | ~165€ |
| **DP-300** — Azure SQL DBA | Avanzado | ~165€ |

### Gratuitas para portfolio
| Badge | Plataforma | Coste |
|-------|-----------|-------|
| SQL (Basic / Intermediate / Advanced) | HackerRank | Gratis |
| Google Data Analytics | Coursera | ~40€/mes |

---

## 📂 Estructura de archivos (planificada)

```
01_sql/
├── README.md                         ← este archivo
├── 01_fundamentos-bd.md              ← tipos de BD, modelo relacional, ERD
├── 02_sql-basico.md                  ← SELECT, WHERE, ORDER BY, INSERT, UPDATE, DELETE
├── 03_sql-joins.md                   ← INNER/LEFT/RIGHT/FULL JOIN
├── 04_sql-avanzado.md                ← GROUP BY, subqueries, vistas, índices
├── 05_plsql-oracle.md                ← bloques PL/SQL, variables, cursores
├── 06_tsql-sqlserver.md              ← T-SQL, stored procedures SQL Server
├── 07_bd-no-relacionales.md          ← MongoDB, Redis, diferencias
├── 08_big-data-intro.md              ← Hadoop, Spark, pipelines
└── ejercicios/
    ├── oracle-livesql/               ← scripts practicados en Oracle Live SQL
    └── sqlserver/                    ← scripts practicados en Microsoft Learn
```

---

## 🔭 Evolución futura del repo

Cuando el contenido sea suficiente, esta carpeta se migrará a un repo independiente:

```
📦 data-engineering/  (repo independiente futuro)
├── 01_bases-de-datos/
│   ├── relacionales/
│   └── no-relacionales/
├── 02_sql/
├── 03_plsql-oracle/
├── 04_tsql-sqlserver/
└── 05_big-data/
```

---

## 📅 Timeline

| Fecha | Logro |
|-------|-------|
| 30 Abr 2026 | Inicio — BD relacionales + SQL básico (Musk clase extra) |

---

_Última actualización: 30 abril 2026 — Perplexity AI MCP_
