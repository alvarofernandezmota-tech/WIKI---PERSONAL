import pytest
import string
import pandas as pd
import numpy as np
from pathlib import Path
from typing import Counter
from ejercicios_modulo5.ejercicios_m5 import (generate_alphabet_files, read_poem, count_lines, count_words, find_word,
                                              display_words, hash_display, 
                                              generate_alphabet_files, append_and_read,
                                              word_frequency, check_file_exists,
                                              basic_visualization, clean_data, 
                                              find_most_expensive_car, filter_toyota, 
                                              count_cars_by_company, most_expensive_by_company,
                                              average_mileage_by_company,
                                              sort_cars_by_price, concatenate_cars,
                                              merge_cars,
                                              array_attributes, create_range_array,
                                              slice_third_column, slice_odd_rows_even_columns,
                                              mathematical_operations, divide_matrix,
                                              )

## python -m pytest ejercicios_modulo5/tests/test_m5.py -v

def test_read_poem(capsys):
    read_poem()
    captured = capsys.readouterr()
    assert "caminante" in captured.out
    assert "andar" in captured.out

def  test_count_lines():
    assert count_lines() == 3

def test_count_words(): 
    assert count_words() == 22

def test_find_word(capsys):
    result = find_word()
    captured = capsys.readouterr()
    assert result == 3

def test_display_words(capsys):
    result = display_words()
    captured = capsys.readouterr()
    assert isinstance(result, list)
    assert len(result) == 10
    assert all(len(word) < 4 for word in result)
    assert "una" in result
    assert "vez" in result

def test_hash_display(capsys):
    result = hash_display()
    captured = capsys.readouterr()
    assert isinstance(result, str)
    assert "#" in captured.out
    assert "H#E#L#L#O" in captured.out

def test_generate_alphabet_files():
    generate_alphabet_files()
    alphabet_dir = Path(__file__).parent.parent / "data" / "alphabet"
    assert alphabet_dir.exists()
    for letter in "ABCDEFGHIJKLMNOPQRSTUVWXYZ":
        file_path = alphabet_dir / f"{letter}.txt"
        assert file_path.exists(), f"Falta el archivo {letter}.txt"
        assert file_path.read_text(encoding="utf-8").strip() == f"Archivo de la letra {letter}"

def test_append_and_read(capsys):
    append_and_read()
    captured = capsys.readouterr()
    file_path = (Path(__file__).parent.parent / "data" / "python.txt")
    assert file_path.exists()
    assert "¡Hola, mundo!" in captured.out

def test_word_frequency():
    result = word_frequency()
    assert isinstance(result, Counter)
    assert result["hola"] == 4
    assert result["mundo"] == 3
    assert result["python"] == 2
    assert "programacion" in result

def test_check_file_exists(capsys):
    result_true = check_file_exists(str(Path(__file__).parent.parent / "data" / "poema.txt"))
    captured = capsys.readouterr()
    assert result_true is True
    assert "existe" in captured.out
    result_false = check_file_exists(str(Path(__file__).parent.parent / "data" / "no_existe.txt"))
    captured = capsys.readouterr()
    assert result_false is False
    assert "no existe" in captured.out

## test bloque 2

def test_basic_visualization(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = basic_visualization()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert "company" in result.columns
    assert "price" in result.columns
    assert len(result) > 0
    assert "Primeras 5 filas" in captured.out
    assert "Últimas 5 filas" in captured.out

def test_clean_data(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = clean_data()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert result.isna().sum().sum() > 0
    assert "?" not in result.values.flatten()
    assert "n.a." not in result.values.flatten()
    assert "NaN" not in result.values.flatten()

def test_find_most_expensive_car(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = find_most_expensive_car()
    captured = capsys.readouterr()
    assert isinstance(result, pd.Series)
    assert "company" in result.index
    assert "price" in result.index
    assert result["price"] == 45400
    assert "la empresa" in captured.out
    assert "con un precio de" in captured.out

def test_filter_toyota(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = filter_toyota()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert "company" in result.columns
    assert len(result) > 0
    assert all(result['company'] == 'toyota')
    assert "Coches" in captured.out
    assert "marca Toyota" in captured.out

def test_count_cars_by_company(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = count_cars_by_company()
    captured = capsys.readouterr()
    assert isinstance(result, pd.Series)
    assert result.index.name == "company"
    assert result["toyota"] == 7
    assert result["bmw"] == 6
    assert result["volvo"] == 2
    assert len(result) == 16
    assert "Número de coches por empresa" in captured.out
    assert "toyota" in captured.out
    assert "7 coches" in captured.out

def test_most_expensive_by_company(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = most_expensive_by_company()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert "company" in result.columns
    assert "price" in result.columns
    assert "Coche más caro por empresa" in captured.out

def test_average_mileage_by_company(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = average_mileage_by_company()
    captured = capsys.readouterr()
    assert isinstance(result, pd.Series)
    assert result.index.name == "company"
    assert "Kilometraje medio por empresa" in captured.out
    assert "km/l" in captured.out

def test_sort_cars_by_price(capsys):
    file_path = Path(__file__).parent.parent / "data" / "automovile.csv"
    file_path.exists() or pytest.skip("El archivo automovile.csv no existe en el directorio data")
    result = sort_cars_by_price()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert "price" in result.columns
    assert result['price'].dropna().is_monotonic_increasing
    assert "Coches ordenados por precio" in captured.out

def test_concatenate_cars(capsys):
    result = concatenate_cars()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert "Company" in result.columns
    assert "Price" in result.columns
    assert len(result) == 8
    assert "DataFrame combinado" in captured.out

def test_merge_cars(capsys):
    result = merge_cars()
    captured = capsys.readouterr()
    assert isinstance(result, pd.DataFrame)
    assert "Company" in result.columns
    assert "Price" in result.columns
    assert "horsepower" in result.columns
    assert len(result) == 4
    assert "DataFrame fusionado" in captured.out

## test bloque 3

def test_array_attributes(capsys):
    result = array_attributes()
    captured = capsys.readouterr()
    assert isinstance(result, np.ndarray)
    assert result.shape == (4, 2)
    assert result.dtype == np.uint16
    assert result.itemsize == 2
    assert "Forma (shape)" in captured.out
    assert "Dimensiones" in captured.out
    assert "Tamaño de cada elemento en bytes" in captured.out

def test_create_range_array(capsys):
    result = create_range_array()
    captured = capsys.readouterr()
    assert isinstance(result, np.ndarray)
    assert result.shape == (5, 2)
    assert result[0, 0] == 100
    assert result[4, 1] == 190
    assert "Matriz 5X2" in captured.out

def test_slice_third_column(capsys):
    result = slice_third_column()
    captured = capsys.readouterr()
    assert isinstance(result, np.ndarray)
    assert len(result) == 3
    assert np.array_equal(result, [33, 66, 99])
    assert "Tercera columna" in captured.out

def test_slice_odd_rows_even_columns(capsys):
    result = slice_odd_rows_even_columns()
    captured = capsys.readouterr()
    assert isinstance(result, np.ndarray)
    assert result.shape == (2, 2)
    assert np.array_equal(result, [[15, 21], [39, 45]])
    assert "Filas impares" in captured.out

def test_mathematical_operations(capsys):
    sum_arr, squared_arr = mathematical_operations()
    captured = capsys.readouterr()
    assert isinstance(sum_arr, np.ndarray)
    assert isinstance(squared_arr, np.ndarray)
    assert np.array_equal(sum_arr, [[20, 39, 33], [25, 25, 28]])
    assert np.array_equal(squared_arr, [[400, 1521, 1089], [625, 625, 784]])
    assert "Suma" in captured.out
    assert "Cuadrado" in captured.out

def test_divide_matrix(capsys):
    result = divide_matrix()
    captured = capsys.readouterr()
    assert isinstance(result, list)
    assert len(result) == 4
    assert all(isinstance(sub, np.ndarray) for sub in result)
    assert all(sub.shape == (2, 3) for sub in result)
    assert "Submatriz" in captured.out
