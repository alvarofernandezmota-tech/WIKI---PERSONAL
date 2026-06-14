# Tema 3. Introducción a Pandas

> M5 · Manipulación de Datos · Escuela Musk

**Estado:** 📖 PDF documentado | Vídeos + puzzle + quiz ⏳ pendiente

---

## 📌 RECURSOS DEL TEMA

| Recurso | URL | Estado |
|---------|-----|--------|
| Tema 3. Introducción a Pandas (intro) | https://campus.escuelamusk.com/mod/resource/view.php?id=60&forceview=1 | ✅ PDF leído |
| Tema 3.1 ¿Qué es pandas? Creación de objetos | https://campus.escuelamusk.com/mod/videotime/view.php?id=190&forceview=1 | ⏳ |
| Tema 3.2 Lectura de objetos y acceso a las columnas | https://campus.escuelamusk.com/mod/videotime/view.php?id=197&forceview=1 | ⏳ |
| Tema 3.3 Indexación y selección de datos mediante condiciones | https://campus.escuelamusk.com/mod/videotime/view.php?id=196&forceview=1 | ⏳ |
| Tema 3.4 Asignación de valores y summary functions | https://campus.escuelamusk.com/mod/videotime/view.php?id=195&forceview=1 | ⏳ |
| Tema 3.5 Map functions y análisis por grupos | https://campus.escuelamusk.com/mod/videotime/view.php?id=194&forceview=1 | ⏳ |
| Tema 3.6 Multi-índices y ordenación | https://campus.escuelamusk.com/mod/videotime/view.php?id=193&forceview=1 | ⏳ |
| Tema 3.7 Tipos de datos y missing values | https://campus.escuelamusk.com/mod/videotime/view.php?id=192&forceview=1 | ⏳ |
| Tema 3.8 Renombrar y combinar objetos | https://campus.escuelamusk.com/mod/videotime/view.php?id=191&forceview=1 | ⏳ |
| 🧰 Kit de Estudio Pandas | https://campus.escuelamusk.com/mod/page/view.php?id=3616&forceview=1 | ⏳ |
| Tema 3 Quizz | https://campus.escuelamusk.com/mod/quiz/view.php?id=576&forceview=1 | ⏳ |
| Tema 3. Block puzzle | https://campus.escuelamusk.com/mod/scorm/view.php?id=291&forceview=1 | ⏳ |
| Trivial Mix (tras T3) | https://campus.escuelamusk.com/mod/scorm/view.php?id=601&forceview=1 | ⏳ |

---

## 📋 CHECKLIST

- [ ] Tema 3.1 — ¿Qué es pandas? Creación de objetos
- [ ] Tema 3.2 — Lectura de objetos y acceso a las columnas
- [ ] Tema 3.3 — Indexación y selección de datos mediante condiciones
- [ ] Tema 3.4 — Asignación de valores y summary functions
- [ ] Tema 3.5 — Map functions y análisis por grupos
- [ ] Tema 3.6 — Multi-índices y ordenación
- [ ] Tema 3.7 — Tipos de datos y missing values
- [ ] Tema 3.8 — Renombrar y combinar objetos
- [ ] Kit de Estudio
- [ ] Quiz T3
- [ ] Block puzzle T3
- [ ] Trivial Mix

---

## 📝 APUNTES — Contenido completo PDF

### 3.1 Introducción a Pandas

Pandas es una librería de Python especializada en manejo y análisis de estructuras de datos.

**Características clave:**
- Estructuras de datos basadas en arrays de NumPy con nuevas funcionalidades
- Lee/escribe CSV, Excel y SQL fácilmente
- Acceso por índices o nombres para filas y columnas
- Métodos para reordenar, dividir y combinar datasets
- Trabaja con series temporales
- Muy eficiente con **large data** (no big data)

```python
import pandas as pd
# instalar si no tienes:
# pip install pandas
```

> 📖 Docs: https://pandas.pydata.org/docs/

**Dos objetos principales:** `DataFrame` y `Serie`

---

### 3.2 Creación de objetos

**DataFrame** = tabla. Cada entrada = fila + columna.

```python
# DataFrame con números
pd.DataFrame({'Yes': [50, 21], 'No': [131, 2]})

# DataFrame con strings
pd.DataFrame({'Bob': ['I liked it.', 'It was awful.'],
              'Sue': ['Pretty good.', 'Bland.']})

# DataFrame con índice personalizado
pd.DataFrame({'Bob': ['I liked it.', 'It was awful.'],
              'Sue': ['Pretty good.', 'Bland.']},
             index=['Product A', 'Product B'])
```

**Se puede crear desde:** diccionarios Python, listas Python, arrays NumPy 2D, CSV.

**Serie** = fila o columna de un DataFrame.

```python
# Desde diccionario
dictionary = {'A': 10, 'B': 20, 'C': 30}
series = pd.Series(dictionary)

# Desde lista
series = pd.Series([1, 2, 3, 4, 5])

# Con índice y nombre
pd.Series([30, 35, 40],
          index=['2015 Sales', '2016 Sales', '2017 Sales'],
          name='Product A')
```

> ℹ️ Una Serie no tiene nombre de columna, solo un `name` global.

---

### 3.3 Lectura de objetos

```python
df = pd.read_csv('adult.csv', index_col=False)
print(df.shape)   # (48842, 15)
df.head()         # primeras 5 filas
df.columns        # nombres de columnas
```

---

### 3.4 Acceso a las columnas

Dos formas equivalentes:

```python
df['workclass']   # forma 1 — RECOMENDADA (siempre funciona)
df.workclass      # forma 2 — solo si el nombre no tiene espacios
```

---

### 3.5 Indexación — loc vs iloc

| | `iloc` | `loc` |
|--|--------|-------|
| Basado en | **Posición numérica** | **Nombre/etiqueta** |
| Trata el df como | Matriz (lista de listas) | Índice significativo |
| Cuándo usar | Acceso rápido por posición | Cuando los índices tienen sentido |

```python
# iloc — por posición
df.iloc[0, :]        # primera fila completa
df.iloc[0, 0]        # fila 0, columna 0 → 25
df.iloc[:, 0]        # primera columna completa
df.iloc[[0,1,2], :]  # primeras 3 filas

# loc — por nombre
df.loc[0, 'age']                   # fila 0, columna 'age' → 25
df.loc[:, ['education', 'race']]   # todas filas, 2 columnas

# Cambiar índice
df = df.set_index('income')
```

---

### 3.6 Selección mediante condiciones

```python
# Condición simple
tmp = df[df['age'] > 20]                          # 45219 filas

# Condición múltiple con &
tmp = df[(df['gender'] == 'Male') & (df['education'] == 'HS-grad')]  # 10687

# isin — valor dentro de lista
tmp = df[df['marital-status'].isin(['Divorced', 'Never-married'])]   # 22750

# isna / isnull — filtrar NaN
tmp = df[df['workclass'].isna()]
```

---

### 3.7 Asignación de valores

```python
# Valor constante a toda una columna
df['capital-gain'] = 2000

# Iterable de valores
df['capital-gain'] = range(len(df), 0, -1)

# Asignar por condición (con loc)
df.loc[df['age'] > 60, 'hours-per-week'] = 10
```

---

### 3.8 Summary Functions

```python
df.describe()                    # count, mean, std, min, 25%, 50%, 75%, max
df['age'].describe()             # columna numérica
df['gender'].describe()          # columna string: count, unique, top, freq
df['occupation'].unique()        # valores únicos
df['occupation'].nunique()       # nº de valores únicos → 15
df['occupation'].value_counts()  # frecuencia de cada valor
```

---

### 3.9 Map Functions

```python
# map() — aplica a nivel de Serie (valor a valor)
df['native-country'] = df['native-country'].map(lambda x: rename_usa(x))

# apply() — aplica a todo el DataFrame (fila a fila)
df['new_col'] = df.apply(lambda x: x['capital-gain'] - x['capital-loss'], axis=1)

# groupby() — agrupar y agregar
df.groupby('native-country').count()
df.groupby('native-country')['capital-gain'].agg([len, min, max])
```

---

### 3.10 Multi-índices

```python
df = df.set_index(['native-country', 'workclass'])  # crear multi-índice
df = df.reset_index()                                # restaurar índice original
```

---

### 3.11 Ordenación + Tipos + Missing values

```python
# Ordenar
df.sort_values(by=['education'])
df.sort_values(by=['education', 'marital-status'])

# Tipos de datos
df.dtypes                                      # ver todos
df['capital-gain'] = df['capital-gain'].astype('float')  # convertir
# ⚠️ strings se guardan como tipo object

# Missing values (NaN)
df.isna().sum()        # NaN por columna
df.isna().sum().sum()  # total NaN → 6465
# ℹ️ NaN son siempre float64
```

---

### 3.12 Renombrar y combinar objetos

```python
# Renombrar
df = df.rename(columns={'native-country': 'country'})
df = df.rename(index={0: 'firstEntry', 1: 'secondEntry'})

# concat — concatenar dfs
df = pd.concat([df1, df2], axis=0)  # vertical
df = pd.concat([df1, df2], axis=1)  # horizontal

# merge — combinar por columna común (como SQL JOIN)
df = df1.merge(df3, how='inner', on='name')  # solo coincidencias
df = df1.merge(df3, how='outer', on='name')  # todas las filas
```

---

## 🧠 RESUMEN RÁPIDO

| Concepto | Uso |
|---------|-----|
| `iloc` | Acceso por **posición** numérica |
| `loc` | Acceso por **nombre/etiqueta** |
| `describe()` | Estadísticas rápidas |
| `value_counts()` | Frecuencia de cada valor |
| `groupby()` | Agrupar + agregar datos |
| `isna()` | Detectar missing values |
| `merge()` | Combinar dfs (como SQL JOIN) |
| `map()` | Transformar serie valor a valor |
| `apply()` | Transformar fila a fila en df |

---
_Documentado: 17 marzo 2026 | Fuente: PDF M5-T3 Escuela Musk_
