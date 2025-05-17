# Comparação entre os Métodos da Secante e Müller para Encontrar Raízes

Este projeto compara os métodos da **Secante** e **Müller** para encontrar raízes de polinômios, usando como exemplo a função \( f(x) = (x-1)(x-3)(x-5)(x-7)(x-9) \), com raízes conhecidas em \([1, 3, 5, 7, 9]\).

## 📋 Estrutura do Código

### 1. Definição do Polinômio
```python
def f(x):
    return (x - 1) * (x - 3) * (x - 5) * (x - 7) * (x - 9)
```
### 2. Método da secante
```python
def secant_method(f, x0, x1, tol=1e-6, max_iter=100):
    iterations = [x0, x1]
    for _ in range(max_iter):
        fx0 = f(x0)
        fx1 = f(x1)
        x_next = x1 - fx1 * (x1 - x0) / (fx1 - fx0)  # Fórmula da secante
        iterations.append(x_next)
        if abs(x_next - x1) < tol:
            break
        x0, x1 = x1, x_next  # Atualiza os pontos
    return iterations
```
Entrada: Dois pontos iniciais.

Saída: Lista de aproximações da raiz.
### 3. Método de Muller
```python
def muller_method(f, x0, x1, x2, tol=1e-6, max_iter=100):
    iterations = [x0, x1, x2]
    for _ in range(max_iter):
        # ... (cálculo das diferenças divididas e coeficientes da parábola)
        z = (-2 * c) / denominator_plus  # Escolhe o denominador maior
        x3 = x2 + z  # Nova aproximação (ignora parte complexa)
        iterations.append(x3)
        x0, x1, x2 = x1, x2, x3  # Atualiza os pontos
    return iterations
```
Entrada: Três pontos iniciais.

Saída: Lista de aproximações (considera apenas a parte real de raízes complexas).
### 4. 
