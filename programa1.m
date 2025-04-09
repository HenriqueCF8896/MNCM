%Condição inicial para todas as tarefas y(0) = 0
global y0;
y0 = 0;
%% Método de Runge-Kutta de 4ª ordem
function [times, y_values] = rk4(ode_func, y0, t0, dt, num_steps, varargin)
    y = y0;
    t = t0;
    times = [t0];
    y_values = [y0];

    for i = 1:num_steps
        k1 = dt * ode_func(y, t, varargin{:});
        k2 = dt * ode_func(y + 0.5*k1, t + 0.5*dt, varargin{:});
        k3 = dt * ode_func(y + 0.5*k2, t + 0.5*dt, varargin{:});
        k4 = dt * ode_func(y + k3, t + dt, varargin{:});

        y = y + (k1 + 2*k2 + 2*k3 + k4)/6;
        t = t + dt;

        times = [times; t];
        y_values = [y_values; y];
    end
end

%% Funções das EDOs - Aqui apresenta-se as EDOs requeridas nas atividade
%% Vale mencionar que a primeira função se refere a EDO do caso para Re->0 e o segundo caso
%% está definido para a adição de uma força de arrasto quadrática carinhosamente chamada de ode_re_nonzero.
function dvdt = ode_re_zero(v, ~)
    dvdt = 1.0 - v;
end

function dvdt = ode_re_nonzero(v, ~, Res)
    dvdt = 1.0 - v - (3*Res/8.0)*v^2;
end

%% Tarefa 1: Comparação com solução analítica para Re → 0
function task1()
    dt = 0.1;
    t_final = 5.0;
    num_steps = round(t_final/dt);

    [times, v_numeric] = rk4(@ode_re_zero, 0.0, 0.0, dt, num_steps);
    v_analytic = 1.0 - exp(-times);

    figure('position', [0, 0, 1000, 600]);
    plot(times, v_numeric, 'b-', 'LineWidth', 2, 'DisplayName', 'Solução Numérica');
    hold on;
    plot(times, v_analytic, 'r--', 'LineWidth', 2, 'DisplayName', 'Solução Analítica');
    title('Tarefa 1: Comparação Re → 0 (St = 0.1)');
    xlabel('Tempo Adimensional (t)');
    ylabel('Velocidade Adimensional (v)');
    legend('show');
    grid on;
    hold off;
end

%% Tarefa 2: Análise de convergência temporal
function task2()
    dts = [0.5, 0.1, 0.05, 0.01];
    errors = [];
    t_final = 5.0;

    for dt = dts
        num_steps = round(t_final/dt);
        [times, v_numeric] = rk4(@ode_re_zero, 0.0, 0.0, dt, num_steps);
        v_analytic = 1.0 - exp(-times);
        errors = [errors; sqrt(mean((v_numeric - v_analytic).^2))];
    end

    figure('position', [0, 0, 1000, 600]);
    loglog(dts, errors, 'bo-', 'LineWidth', 2);
    title('Tarefa 2: Convergência Temporal');
    xlabel('Passo Temporal (Δt)');
    ylabel('Erro RMS');
    grid on;
end


%Condição inicial para todas as tarefas y(0) = 0
global y0;
y0 = 0;
%% Método de Runge-Kutta de 4ª ordem
function [times, y_values] = rk4(ode_func, y0, t0, dt, num_steps, varargin)
    y = y0;
    t = t0;
    times = [t0];
    y_values = [y0];

    for i = 1:num_steps
        k1 = dt * ode_func(y, t, varargin{:});
        k2 = dt * ode_func(y + 0.5*k1, t + 0.5*dt, varargin{:});
        k3 = dt * ode_func(y + 0.5*k2, t + 0.5*dt, varargin{:});
        k4 = dt * ode_func(y + k3, t + dt, varargin{:});

        y = y + (k1 + 2*k2 + 2*k3 + k4)/6;
        t = t + dt;

        times = [times; t];
        y_values = [y_values; y];
    end
end

%% Funções das EDOs - Aqui apresenta-se as EDOs requeridas nas atividade
%% Vale mencionar que a primeira função se refere a EDO do caso para Re->0 e o segundo caso
%% está definido para a adição de uma força de arrasto quadrática carinhosamente chamada de ode_re_nonzero.
function dvdt = ode_re_zero(v, ~)
    dvdt = 1.0 - v;
end

function dvdt = ode_re_nonzero(v, ~, Res)
    dvdt = 1.0 - v - (3*Res/8.0)*v^2;
end

%% Tarefa 1: Comparação com solução analítica para Re → 0
function task1()
    dt = 0.1;
    t_final = 5.0;
    num_steps = round(t_final/dt);

    [times, v_numeric] = rk4(@ode_re_zero, 0.0, 0.0, dt, num_steps);
    v_analytic = 1.0 - exp(-times);

    figure('position', [0, 0, 1000, 600]);
    plot(times, v_numeric, 'b-', 'LineWidth', 2, 'DisplayName', 'Solução Numérica');
    hold on;
    plot(times, v_analytic, 'r--', 'LineWidth', 2, 'DisplayName', 'Solução Analítica');
    title('Tarefa 1: Comparação Re → 0 (St = 0.1)');
    xlabel('Tempo Adimensional (t)');
    ylabel('Velocidade Adimensional (v)');
    legend('show');
    grid on;
    hold off;
end

%% Tarefa 2: Análise de convergência temporal
function task2()
    dts = [0.5, 0.1, 0.05, 0.01];
    errors = [];
    t_final = 5.0;

    for dt = dts
        num_steps = round(t_final/dt);
        [times, v_numeric] = rk4(@ode_re_zero, 0.0, 0.0, dt, num_steps);
        v_analytic = 1.0 - exp(-times);
        errors = [errors; sqrt(mean((v_numeric - v_analytic).^2))];
    end

    figure('position', [0, 0, 1000, 600]);
    loglog(dts, errors, 'bo-', 'LineWidth', 2);
    title('Tarefa 2: Convergência Temporal');
    xlabel('Passo Temporal (Δt)');
    ylabel('Erro RMS');
    grid on;
end


%% Tarefa 3/4: Validação com solução analítica e variação de Res
function task34()
    % Parâmetros
    Res_values = [0.0, 0.5, 1.0, 2.0]; % Valores de Res
    t_final = 10.0;  % Tempo suficiente para regime permanente
    dt = 0.1;        % Passo temporal

    % Preparar dados
    v_analitico = zeros(size(Res_values));
    v_numerico = zeros(size(Res_values));

    % Calcular para cada Res
    for i = 1:length(Res_values)
        Res = Res_values(i);

        % Solução analítica
        if Res == 0
            v_analitico(i) = 1.0; % Caso Re → 0
        else
            v_analitico(i) = (-8 + sqrt(64 + 96*Res))/(6*Res);
        end

        % Solução numérica
        if Res == 0
            [~, v] = rk4(@ode_re_zero, 0.0, 0.0, dt, round(t_final/dt));
        else
            [~, v] = rk4(@ode_re_nonzero, 0.0, 0.0, dt, round(t_final/dt), Res);
        end
        v_numerico(i) = v(end); % Velocidade no regime permanente
    end

    % Plot 1: Comparação numérica vs analítica para diferentes Res
    figure('position', [0, 0, 1000, 600]);
    plot(Res_values, v_analitico, 'ro-', 'LineWidth', 2, 'MarkerSize', 8, 'DisplayName', 'Solução Analítica');
    hold on;
    plot(Res_values, v_numerico, 'bs--', 'LineWidth', 1, 'MarkerSize', 8, 'DisplayName', 'Solução Numérica');
    xlabel('Res');
    ylabel('Velocidade Adimensional (v)');
    title('Comparação entre Soluções Analítica e Numérica');
    legend('show');
    grid on;
    hold off;

    end
%% Tarefa 5: Comparação para diferentes Res
function task5()
    Res_values = [0.0, 0.5, 1.0, 2.0];
    dt = 0.1;
    t_final = 5.0;

    figure('position', [0, 0, 1000, 600]);
    for Res = Res_values
        if Res == 0.0
            [times, v] = rk4(@ode_re_zero, 0.0, 0.0, dt, round(t_final/dt));
        else
            [times, v] = rk4(@ode_re_nonzero, 0.0, 0.0, dt, round(t_final/dt), Res);
        end
        plot(times, v, 'LineWidth', 2, 'DisplayName', sprintf('Res = %.1f', Res));
        hold on;
    end
    title('Tarefa 5: Velocidade para Diferentes Res');
    xlabel('Tempo Adimensional (t)');
    ylabel('Velocidade Adimensional (v)');
    legend('show');
    grid on;
    hold off;
end

%% Execução principal
clear;
clc;
task1();
task2();
task34();
task5();
