# 🔍 AUDITORÍA PYTHON — Escuela Musk 2026

> **Última actualización:** 29 abril 2026  
> **Auditado por:** Perplexity AI MCP  
> **Objetivo:** Inventario real del curso + estado de tests + estructura repo

---

## 📊 Estado general del curso

| Módulo | Nombre | Lecciones plataforma | Tests pytest | Estado |
|--------|--------|---------------------|-------------|--------|
| M1 | Introducción a Python | 38/38 ✅ | — | ✅ Completado |
| M2 | Fundamentos | 67/67 ✅ | — | ✅ Completado |
| M3 | POO Básica | 23/23 ✅ | — | ✅ Completado |
| M4 | POO Avanzada | 49/49 ✅ | — | ✅ Completado |
| **M5** | **Manipulación de datos** | **48/49 ✅** | **26/26 ✅** | **✅ Completado 29/04** |
| CE | Clases Extra | 0/6 | 0 | 🔥 ACTIVO — SQL siguiente |
| M6 | Git & GitHub | 0 | 0 | ⏳ Pendiente |
| M7 | Proyecto Final | 0 | 0 | ⏳ Pendiente |

**Progreso general estimado: ~75% del curso**

```
M1 ████████████████████ 100%
M2 ████████████████████ 100%
M3 ████████████████████ 100%
M4 ████████████████████ 100%
M5 ████████████████████ 100% — 26/26 tests ✅
CE ░░░░░░░░░░░░░░░░░░░░   0% — SQL es siguiente
M6 ░░░░░░░░░░░░░░░░░░░░   0% — pendiente
M7 ░░░░░░░░░░░░░░░░░░░░   0% — proyecto final
```

---

## 📁 M5 — Manipulación de datos — CERRADO 29/04/2026

### Tests escritos con pytest

#### T1 — Archivos / Texto (10/10 tests)

| Test | Técnica |
|------|---------|
| `test_read_poem` | `capsys` — captura stdout |
| `test_count_lines` | assert valor numérico |
| `test_count_words` | assert valor numérico |
| `test_find_word` | assert return value |
| `test_display_words` | `isinstance()` + asserts lista |
| `test_hash_display` | `capsys` + assert string |
| `test_generate_alphabet_files` | `Path` + loop 26 letras |
| `test_append_and_read` | `Path.exists()` + `capsys` |
| `test_word_frequency` | `isinstance(result, Counter)` |
| `test_check_file_exists` | doble assert True + False |

#### T2 — Pandas (10/10 tests)

| Test | Técnica destacada |
|------|------------------|
| `test_basic_visualization` | `pytest.skip` condicional |
| `test_clean_data` | `isna().sum().sum()` |
| `test_find_most_expensive_car` | valor exacto `45400` |
| `test_filter_toyota` | `all(result['company'] == 'toyota')` |
| `test_count_cars_by_company` | `result["toyota"] == 7` |
| `test_most_expensive_by_company` | columnas `pd.DataFrame` |
| `test_average_mileage_by_company` | `result.index.name == "company"` |
| `test_sort_cars_by_price` | `is_monotonic_increasing` |
| `test_concatenate_cars` | datos hardcodeados, sin skip |
| `test_merge_cars` | `pd.merge` 3 columnas |

#### T3 — NumPy (6/6 tests)

| Test | Técnica destacada |
|------|------------------|
| `test_array_attributes` | `.dtype` + `.itemsize` + `.shape` |
| `test_create_range_array` | `.shape` + indexación directa |
| `test_slice_third_column` | `np.array_equal()` |
| `test_slice_odd_rows_even_columns` | `np.array_equal` 2D |
| `test_mathematical_operations` | tuple unpacking en test |
| `test_divide_matrix` | `isinstance(list)` + `all(sub.shape...)` |

---

## 📁 Clases Extra — ACTIVO

| # | Clase | Archivos en repo | Estado |
|---|-------|-----------------|--------|
| 1 | SQL | `06_clases-extra/01_sql/` | 🔥 Siguiente |
| 2 | Lambda / List Comprehension | `06_clases-extra/02_lambda-list-comprehension/` | ⏳ |
| 3 | Simulación PCA Parte 1 | `06_clases-extra/03_simulacion-pca-parte1/` | ⏳ |
| 4 | Simulación PCA Parte 2 | `06_clases-extra/04_simulacion-pca-parte2/` | ⏳ |
| 5 | Intro Testing | `06_clases-extra/05_intro-testing/` | ⏳ |
| 6 | Testing Parte 2 | `06_clases-extra/06_testing-parte2/` | ⏳ |

> El temario de clases extra **no está provisto por el curso** — se construirá progresivamente trabajando los videos y documentando aquí.

---

## 🚨 Pendientes técnicos (hacer localmente)

```bash
# 1. Renombrar carpeta git (M6, no M7)
git mv 02_formacion/01_escuela-musk/02_python/07_modulo-7-git-github \
       02_formacion/01_escuela-musk/02_python/07_modulo-6-git-github

# 2. Fix numeración duplicada en raíz de personal/
git mv 03_analisis 04_analisis
git mv 03_curiosidad 05_curiosidad
git mv 04_entrenamiento 06_entrenamiento

git commit -m "chore: fix numeración carpetas"
git push
```

---

## 📁 M1–M4 — Completados (sin cambios)

| Módulo | Archivos clave | Fecha |
|--------|---------------|-------|
| M1 | `APUNTES-MODULO-1.md` + 3 PDFs | Ene 2026 |
| M2 | `APUNTES-MODULO-2-TEMAS-1-2-3.md` (16.6KB) | Ene 2026 |
| M3 | `README.md` (4.5KB) + `Modulo3_Ejercicios.pdf` | Feb 2026 |
| M4 | `ejercicios_m4.py` (15.8KB) + `README.md` | 15 mar 2026 |

---

_Auditoría actualizada: 29 abril 2026, 20:30 CEST — Perplexity AI MCP_
