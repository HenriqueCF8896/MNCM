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
```matlab    
    y = y0; t = t0;
    times = [t0]; y_values = [y0];
```
Inicializa os vetores de tempo e solução.
 ```matlab   
    for i = 1:num_steps
        k1 = dt * ode_func(y, t, varargin{:});
        k2 = dt * ode_func(y + 0.5*k1, t + 0.5*dt, varargin{:});
        k3 = dt * ode_func(y + 0.5*k2, t + 0.5*dt, varargin{:});
        k4 = dt * ode_func(y + k3, t + dt, varargin{:});
```
Cálculo dos incrementos intermediários (k1 a k4) conforme o método RK4
 ```matlab  
        y = y + (k1 + 2*k2 + 2*k3 + k4)/6;
        t = t + dt;
        times = [times; t];
        y_values = [y_values; y];
    end
```
Atualiza a solução y e o tempo t, salvando os valores a cada passo.
### 3. Definição das EDO's
 ```matlab
function dvdt = ode_re_zero(v, ~)
    dvdt = 1.0 - v;
```
EDO para regime onde Re → 0 (linear, sem arrasto quadrático).
```matlab
function dvdt = ode_re_nonzero(v, ~, Res)
    dvdt = 1.0 - v - (3*Res/8.0)*v^2;
```
EDO com força de arrasto não linear (quadrática), dependendo de Res.
### 4. Tarefas a serem realizados de acordo com o que foi requerido
#### 4.1 Tarefa 1
 ```matlab  
function task1()
```
Compara a solução numérica via RK4 com a solução analítica para Re ≈ 0. Plota ambas.

#### 4.2 Tarefa 2
```matlab
function task2()
```
Avalia a sensibilidade do erro numérico ao passo de tempo dt, com gráfico log-log do erro RMS.
#### 4.3 Tarefa 3/4 
```matlab
function task34()
```
Para diferentes valores de Res, compara a velocidade final (regime permanente) entre a solução analítica e a obtida numericamente.
#### 4.4 Tarefa 5
```matlab
function task5()
```
Plota a evolução da velocidade para vários valores de Res, mostrando como a resistência altera a dinâmica.
### Execução do Script
```matlab
clear;
clc;
task1();
task2();
task34();
task5();
```
Limpa o ambiente e executa as tarefas na ordem.
