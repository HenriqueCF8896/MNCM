# Simulação Numérica de EDOs com Método de Runge-Kutta 4ª Ordem

Este projeto utiliza o método de Runge-Kutta de 4ª ordem para resolver equações diferenciais ordinárias (EDOs) aplicadas à dinâmica de partículas, com foco em diferentes regimes do número de Reynolds (Re). As tarefas compreendem validações analíticas, análises de erro e variações paramétricas.

---

## 🔧 Estrutura do Código

O código está dividido nas seguintes seções:

### 1. Condição Inicial
```matlab
global y0;
y0 = 0;
```
Define a condição inicial global y(0) = 0 que é usada por todas as tarefas numéricas.
### 2. Função RK4
```matlab
function [times, y_values] = rk4(ode_func, y0, t0, dt, num_steps, varargin)
```
Função genérica que resolve uma EDO usando o método RK4. Recebe:
ode_func: função da EDO
y0: valor inicial
t0: tempo inicial
dt: passo de tempo
num_steps: número de passos
varargin: argumentos opcionais (usado para passar o Res)
