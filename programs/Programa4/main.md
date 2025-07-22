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
while deg > 2:
rr, ss = r, s
it = 0
b = np.zeros(deg+1)
c = np.zeros(deg+1)
b[deg] = a_work[deg]
b[deg-1] = a_work[deg-1] + rr * b[deg]
for i in range(deg-2, -1, -1):
    b[i] = a_work[i] + rr * b[i+1] + ss * b[i+2]
c[deg] = b[deg]
c[deg-1] = b[deg-1] + rr * c[deg]
for i in range(deg-2, 0, -1):
    c[i] = b[i] + rr * c[i+1] + ss * c[i+2]
D = c[2]*c[2] - c[3]*c[1]
dr = (-b[1]*c[2] + b[0]*c[3]) / D
ds = (-b[0]*c[2] + b[1]*c[1]) / D
rr += dr
ss += ds
it += 1
if abs(dr) < tol and abs(ds) < tol:
    break
disc = rr*rr + 4*ss
root1 = (rr + cmath.sqrt(disc)) / 2
root2 = (rr - cmath.sqrt(disc)) / 2
roots.extend([root1, root2])
a_work = b[2:].copy()
deg = a_work.size - 1
```
Define a função principal do método de Bairstow para encontrar raízes de polinômio de coeficientes a. Em seguida, converte a em float, cria lista vazia para armazenar raízes e
define também o grau correspondente do polinômio lido.

Inicia o loop principal enquanto o polinômio tiver grau maior que 2, aplica-se iterativamente a função Bairstow: 

1) Inicializa palpites de r e s, e o contador de iterações
2) Cria arrays zerados auxiliares
3) Inicializa os dois últimos dois termos do vetor b
4) Calcula b recursivamente
5) Calcula c recursivamente para corrigir r e s
6) Calcula-se o determinante do sistema linear para dr e ds
7) Utiliza-se da Regra de Cramer para encontrar as correções
8) Atualiza-se os palpites e incrementa iteração
9) Verifica-se o critério de convergência
10) Calcula-se as raízes e adiciona à lista, mesmo podendo ser complexas
11) Deflaciona o polinômio retirando o fator quadrático


