# Comparação entre os Métodos da Bissecção e Falsa Posição

Este projeto compara a eficiência dos métodos numéricos da **bissecção** e **falsa posição** para encontrar raízes de equações não lineares.

## 📋 Estrutura do Código

### 1. Método da Bissecção (`bisection`)
```python
def bisection(f, a, b, tol=1e-6, max_iter=1000):
    # Verifica se há mudança de sinal no intervalo
    if f(a) * f(b) >= 0:
        raise ValueError("A função deve ter sinais opostos nos extremos do intervalo.")

    iter_count = 0
    errors = []
    roots = []
    c_prev = None  # Armazena a raiz da iteração anterior

    while iter_count < max_iter:
        c = (a + b) / 2  # Ponto médio do intervalo
        roots.append(c)

        # Cálculo do erro relativo (exceto na primeira iteração)
        if c_prev is not None:
            error = abs((c - c_prev) / c)
            errors.append(error)
            if error < tol:  # Critério de parada
                break
        else:
            errors.append(None)

        # Atualiza o intervalo
        fc = f(c)
        if fc == 0:
            break
        if f(a) * fc < 0:
            b = c
        else:
            a = c

        c_prev = c
        iter_count += 1

    return roots, iter_count + 1, errors
```
### 2.Método da Falsa Posicição (false_position)
```python
def false_position(f, a, b, tol=1e-6, max_iter=1000):
    # Similar à bissecção, mas o ponto 'c' é calculado por interpolação linear
    c = (a * fb - b * fa) / (fb - fa)  # Fórmula da falsa posição
    # ... (restante igual à bissecção)
```
### 3. Definição das equações
```python
equations = [
    {
        'name': '-0.5x² + 2.5x + 4.5',
        'f': lambda x: -0.5*x**2 + 2.5*x + 4.5,
        'interval': (5, 10)
    },
    # ... (outras equações)
]
```
Cada equação possui:

name: Descrição da equação.

f: Função lambda que define a equação.

interval: Intervalo inicial para busca da raiz.

### 4. Processamento e Comparação
```python
for eq in equations:
    # Aplica ambos os métodos
    roots_bis, iter_bis, errors_bis = bisection(f, a, b, tolerance, max_iterations)
    roots_fp, iter_fp, errors_fp = false_position(f, a, b, tolerance, max_iterations)

    # Geração do gráfico de convergência
    plt.plot(..., label='Bissecção')
    plt.plot(..., label='Falsa Posição')
    plt.yscale('log')  # Escala logarítmica para melhor visualização do erro
```
