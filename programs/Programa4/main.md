# bairstow_fractal.py

Implementação comentada linha por linha do script **bairstow_fractal.py**, que calcula as raízes de polinômios pelo método de Bairstow e gera um fractal representando o número de iterações para convergência.

```python
#!/usr/bin/env python3
"""
bairstow_fractal.py

Implementação do método de Bairstow para encontrar raízes de polinômios
com geração do fractal de Bairstow.
...
"""
```
Define que o script é em Python3 e explica propósito, saídas, uso e dependências.
```python
import numpy as np  # biblioteca para cálculos numéricos
import cmath        # biblioteca para suportar números complexos
```
numpy: manipulação de arrays e operações vetoriais
cmath: operações com números complexos
```python
def bairstow(a, r=1.0, s=1.0, tol=1e-6, max_iter=1000):
a_work = np.array(a, dtype=float)
roots = []
it_count = 0
deg = a_work.size - 1
```
Define a função principal do método de Bairstow para encontrar raízes de polinômio de coeficientes a. Em seguida, converte a em float, cria lista vazia para armazenar raízes.

