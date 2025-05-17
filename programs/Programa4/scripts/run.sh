#!/bin/bash

# Executa o código Python para gerar dados e scripts do Gnuplot
echo "Gerando dados e scripts do Gnuplot..."
python3 src/bairstow.py

# Executa os scripts do Gnuplot para gerar gráficos
echo "Gerando gráficos..."
cd gnuplot_scripts/
gnuplot grafico1.gnuplot
gnuplot grafico2.gnuplot

# Move os gráficos para a pasta images/
mv *.png ../images/
