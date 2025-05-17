#!/usr/bin/env python3
"""
bairstow_fractal.py

Implementação do método de Bairstow para encontrar raízes de polinômios
com geração do fractal de Bairstow.

Saídas:
  - Imprime as raízes encontradas (reais e complexas).
  - Gera o arquivo `dados_bairstow_simulado.txt` com colunas (r0, s0, iterações).
  - Cria um script Gnuplot `fractal_bairstow.gnu` com configurações avançadas para plotagem.

Uso:
  python3 bairstow_fractal.py

Dependências:
  - numpy
  - cmath (para raízes complexas)
"""
import numpy as np  # biblioteca para cálculos numéricos
import cmath        # biblioteca para suportar números complexos

# Função principal do método de Bairstow para encontrar todas as raízes
# a: lista de coeficientes do polinômio
# r, s: palpites iniciais para o fator quadrático
# tol: tolerância para convergência
# max_iter: número máximo de iterações
# Retorna: lista de raízes e número de iterações da última etapa

def bairstow(a, r=1.0, s=1.0, tol=1e-6, max_iter=1000):
    a_work = np.array(a, dtype=float)  # converte lista para array float
    roots = []  # lista para armazenar as raízes encontradas
    it_count = 0  # contador de iterações da última etapa

    deg = a_work.size - 1  # grau do polinômio
    while deg > 2:
        rr, ss = r, s  # inicia rr e ss com palpites iniciais
        it = 0  # contador de iterações
        while it < max_iter:
            b = np.zeros(deg+1)  # vetor auxiliar para divisão sintética
            c = np.zeros(deg+1)  # vetor auxiliar para derivadas sintéticas
            b[deg] = a_work[deg]
            b[deg-1] = a_work[deg-1] + rr * b[deg]
            for i in range(deg-2, -1, -1):
                b[i] = a_work[i] + rr * b[i+1] + ss * b[i+2]
            c[deg] = b[deg]
            c[deg-1] = b[deg-1] + rr * c[deg]
            for i in range(deg-2, 0, -1):
                c[i] = b[i] + rr * c[i+1] + ss * c[i+2]

            D = c[2]*c[2] - c[3]*c[1]  # determinante do sistema linear
            if abs(D) < tol:
                break  # evita divisão por número muito pequeno
            # calcula correções para r e s
            dr = (-b[1]*c[2] + b[0]*c[3]) / D
            ds = (-b[0]*c[2] + b[1]*c[1]) / D
            rr += dr
            ss += ds
            it += 1
            if abs(dr) < tol and abs(ds) < tol:
                break  # converge

        # calcula raízes do fator quadrático (pode ser complexa)
        disc = rr*rr + 4*ss
        root1 = (rr + cmath.sqrt(disc)) / 2
        root2 = (rr - cmath.sqrt(disc)) / 2
        roots.extend([root1, root2])  # adiciona as raízes à lista
        it_count = it  # salva iteração usada

        a_work = b[2:].copy()  # deflaciona o polinômio
        deg = a_work.size - 1

    # caso o grau seja 2, resolve diretamente pela fórmula de Bhaskara
    if deg == 2:
        a0, a1, a2 = a_work
        disc = a1*a1 - 4*a2*a0
        root1 = (-a1 + cmath.sqrt(disc)) / (2*a2)
        root2 = (-a1 - cmath.sqrt(disc)) / (2*a2)
        roots.extend([root1, root2])
    elif deg == 1:
        roots.append(-a_work[0] / a_work[1])  # raiz linear

    return np.array(roots), it_count

# Gera os dados de iteração para o fractal, percorrendo uma malha de r0 e s0

def fractal_data(a, r_min, r_max, s_min, s_max, grid_size=500, tol=1e-8, max_iter=999):
    a = np.array(a, dtype=float)  # garante tipo correto
    data = []
    for r0 in np.linspace(r_min, r_max, grid_size):  # varre r0
        for s0 in np.linspace(s_min, s_max, grid_size):  # varre s0
            _, it = bairstow(a, r0, s0, tol, max_iter)  # aplica método
            data.append((r0, s0, it))  # armazena resultado
    return data

# Função principal que executa o programa

def main():
    try:
        # lê os coeficientes do polinômio a partir da entrada do usuário
        entrada = input(
            "Digite os coeficientes do polinômio (termo independente ao maior grau), separados por espaço:\n"
        ).strip()
        a = [float(x) for x in entrada.split()]
    except Exception as e:
        print(f"Erro ao ler os coeficientes: {e}")
        return

    r0, s0 = 0.5, 0.5  # palpites iniciais padrão
    roots, iterations = bairstow(a, r0, s0)  # aplica método de Bairstow
    print("\nRaízes encontradas:")
    for root in roots:
        print(f"{root:.8f}")  # imprime raiz com 8 casas decimais
    print(f"Iterações no último fator: {iterations}")

    # gera dados do fractal e salva em arquivo
    data = fractal_data(a, -3, 3, -3, 3, grid_size=400)
    with open("dados_bairstow_simulado.txt", "w") as f:
        for r, s, it in data:
            f.write(f"{r}\t{s}\t{it}\n")
    print("Dados do fractal salvos em dados_bairstow_simulado.txt")

    # monta o script do Gnuplot para plotar o fractal
    gnuplot_script = """
set terminal pngcairo size 1000,800 enhanced font 'Arial,10'
set output 'mapa_bairstow.png'

set title "Fractal de Bairstow - Número de Iterações até Convergência"
set xlabel "r_0 (chute inicial)"
set ylabel "s_0 (chute inicial)"
set cblabel "Número de Iterações"

set palette defined ( \
  0 "#440154", \
  1 "#482777", \
  2 "#3E4989", \
  3 "#31688E", \
  4 "#26828E", \
  5 "#1F9E89", \
  6 "#35B779", \
  7 "#6CCE59", \
  8 "#B4DE2C", \
  9 "#FDE725" \
)

set view map
set datafile missing "999"

splot 'dados_bairstow_simulado.txt' using 1:2:3 with image notitle
"""
    # salva o script Gnuplot em arquivo
    with open("fractal_bairstow.gnu", "w") as f:
        f.write(gnuplot_script)
    print("Script Gnuplot salvo em fractal_bairstow.gnu")

# executa a função principal
if __name__ == "__main__":
    main()

