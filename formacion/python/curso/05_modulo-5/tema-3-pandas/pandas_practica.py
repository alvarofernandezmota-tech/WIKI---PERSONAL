import pandas as pd

# =============================================================================
# M5 - T3: INTRODUCCIÓN A PANDAS
# =============================================================================


# -----------------------------------------------------------------------------
# 3.2 CREACIÓN DE OBJETOS — DataFrame y Serie
# -----------------------------------------------------------------------------

# DataFrame desde diccionario con índice por defecto (0, 1, 2...)
df_numeros = pd.DataFrame({'Yes': [50, 21], 'No': [131, 2]})
print(df_numeros)

# DataFrame con strings como valores
df_opiniones = pd.DataFrame({
    'Bob': ['I liked it.', 'It was awful.'],
    'Sue': ['Pretty good.', 'Bland.']
})
print(df_opiniones)

# DataFrame con índice personalizado
df_productos = pd.DataFrame({
    'Bob': ['I liked it.', 'It was awful.'],
    'Sue': ['Pretty good.', 'Bland.']
}, index=['Product A', 'Product B'])
print(df_productos)

# Serie desde diccionario
diccionario = {'A': 10, 'B': 20, 'C': 30}
serie = pd.Series(diccionario)
print(serie)

# Serie desde lista
serie2 = pd.Series([1, 2, 3, 4, 5])
print(serie2)

# Serie con índice y nombre personalizados
serie3 = pd.Series([30, 35, 40],
                   index=['2015 Sales', '2016 Sales', '2017 Sales'],
                   name='Product A')
print(serie3)


# -----------------------------------------------------------------------------
# 3.3 LECTURA DE OBJETOS — CSV
# -----------------------------------------------------------------------------

# Leer CSV
# df = pd.read_csv('adult.csv', index_col=False)
# print(df.shape)       # (filas, columnas)
# df.head()             # primeras 5 filas
# df.columns            # nombres de columnas


# -----------------------------------------------------------------------------
# 3.4 ACCESO A COLUMNAS
# -----------------------------------------------------------------------------

# df['workclass']   → forma 1 (recomendada siempre)
# df.workclass      → forma 2 (solo si el nombre no tiene espacios/guiones)


# -----------------------------------------------------------------------------
# 3.5 INDEXACIÓN — iloc vs loc
# -----------------------------------------------------------------------------

df = pd.DataFrame({
    'nombre': ['Ana', 'Luis', 'Maria', 'Carlos'],
    'edad': [25, 32, 28, 45],
    'ciudad': ['Madrid', 'Barcelona', 'Sevilla', 'Valencia']
})

# iloc — por POSICIÓN numérica (como una matriz)
print(df.iloc[0, :])        # primera fila completa
print(df.iloc[0, 0])        # primera fila, primera columna → 'Ana'
print(df.iloc[:, 0])        # primera columna completa
print(df.iloc[[0, 1, 2], :]) # primeras 3 filas

# loc — por ETIQUETA (nombre de índice y columna)
print(df.loc[0, 'edad'])           # fila 0, columna 'edad'
print(df.loc[:, ['nombre', 'ciudad']])  # todas las filas, dos columnas

# Cambiar el índice
df = df.set_index('nombre')
print(df.head())
# Ahora loc usa el nombre como índice
print(df.loc['Ana', 'edad'])   # → 25


# -----------------------------------------------------------------------------
# 3.6 SELECCIÓN MEDIANTE CONDICIONES
# -----------------------------------------------------------------------------

df = pd.DataFrame({
    'nombre': ['Ana', 'Luis', 'Maria', 'Carlos'],
    'edad': [25, 32, 28, 45],
    'genero': ['Female', 'Male', 'Female', 'Male'],
    'educacion': ['HS-grad', 'Bachelors', 'HS-grad', 'Masters']
})

# Condición simple
mayores = df[df['edad'] > 28]
print(len(mayores))

# Condición múltiple con & (AND)
filtro = df[(df['genero'] == 'Male') & (df['educacion'] == 'HS-grad')]
print(len(filtro))

# isin — valor dentro de una lista
divorciados = df[df['educacion'].isin(['HS-grad', 'Bachelors'])]
print(len(divorciados))

# isna / isnull — valores NaN
# tmp = df[df['workclass'].isna()]


# -----------------------------------------------------------------------------
# 3.7 ASIGNACIÓN DE VALORES
# -----------------------------------------------------------------------------

# Valor constante en toda la columna
df['score'] = 100
print(df.head())

# Iterable de valores
df['score'] = range(len(df), 0, -1)
print(df.head())

# Asignar solo a filas que cumplen condición
df.loc[df['edad'] > 30, 'score'] = 0
print(df)


# -----------------------------------------------------------------------------
# 3.8 SUMMARY FUNCTIONS
# -----------------------------------------------------------------------------

# describe() — estadísticas de todas las columnas numéricas
print(df.describe())

# describe() de una columna específica
print(df['edad'].describe())

# unique() — valores únicos de una columna
print(df['educacion'].unique())

# nunique() — número de valores únicos
print(df['educacion'].nunique())

# value_counts() — frecuencia de cada valor
print(df['educacion'].value_counts())


# -----------------------------------------------------------------------------
# 3.9 MAP FUNCTIONS — map, apply, groupby
# -----------------------------------------------------------------------------

# map() — transforma valores a nivel de Serie (fila a fila)
def abreviar_genero(g):
    if g == 'Male':
        return 'M'
    else:
        return 'F'

df['genero'] = df['genero'].map(lambda x: abreviar_genero(x))
print(df['genero'])

# apply() — aplica función a todo el DataFrame fila por fila
df['edad_score'] = df.apply(lambda x: x['edad'] + x['score'], axis=1)
print(df['edad_score'])

# groupby() — agrupa filas por valor de columna
print(df.groupby('educacion').count())
print(df.groupby('educacion')['edad'].agg([len, min, max]))


# -----------------------------------------------------------------------------
# 3.10 MULTI-ÍNDICES
# -----------------------------------------------------------------------------

df_multi = pd.DataFrame({
    'pais': ['España', 'España', 'Francia', 'Francia'],
    'ciudad': ['Madrid', 'Barcelona', 'Paris', 'Lyon'],
    'poblacion': [3300000, 1600000, 2100000, 500000]
})

df_multi = df_multi.set_index(['pais', 'ciudad'])
print(df_multi.head())

# Restaurar índice original
df_multi = df_multi.reset_index()
print(df_multi.head())


# -----------------------------------------------------------------------------
# 3.11 ORDENACIÓN + DTYPES + MISSING VALUES
# -----------------------------------------------------------------------------

# sort_values
df_sorted = df.sort_values(by=['educacion'])
print(df_sorted)

df_sorted2 = df.sort_values(by=['educacion', 'edad'])
print(df_sorted2)

# dtypes — tipo de dato de cada columna
print(df.dtypes)

# astype — convertir tipo de dato
df['edad'] = df['edad'].astype('float')
print(df['edad'].dtype)   # float64

# Missing values — isna / isnull
print(df.isna().sum())         # NaN por columna
print(df.isna().sum().sum())   # total NaN en el df


# -----------------------------------------------------------------------------
# 3.12 RENOMBRAR Y COMBINAR OBJETOS
# -----------------------------------------------------------------------------

# rename — renombrar columnas
df = df.rename(columns={'nombre': 'name', 'edad': 'age'})
print(df.head())

# rename — renombrar índices
df = df.rename(index={0: 'first', 1: 'second'})
print(df.head())

# concat — unir DataFrames verticalmente (axis=0) u horizontalmente (axis=1)
df1 = pd.DataFrame({'A': [1, 2], 'B': [3, 4]})
df2 = pd.DataFrame({'A': [5, 6], 'B': [7, 8]})

df_vertical = pd.concat([df1, df2], axis=0)
print(df_vertical)

df_horizontal = pd.concat([df1, df2], axis=1)
print(df_horizontal)

# merge — combinar dos DataFrames por una columna común
df_personas = pd.DataFrame({
    'name': ['Ana', 'Luis', 'Maria'],
    'age': [25, 32, 28]
})
df_paises = pd.DataFrame({
    'name': ['Ana', 'Luis', 'Carlos'],
    'country': ['España', 'Francia', 'Italia']
})

# inner join — solo coincidencias
df_inner = df_personas.merge(df_paises, how='inner', on='name')
print(df_inner)

# outer join — todas las filas, NaN donde no hay coincidencia
df_outer = df_personas.merge(df_paises, how='outer', on='name')
print(df_outer)
