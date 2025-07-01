#!/bin/bash

# Define o caminho para o arquivo de configuração do Kanshi
CONFIG_FILE="$HOME/.config/kanshi/config"

# 💡 A LÓGICA:
# Verificamos o estado atual procurando por uma das linhas chave.
# Se encontrarmos, trocamos as duas linhas necessárias individualmente.

# Verifica se o sistema está no "Estado A" (UW na direita)
if grep -q 'PEGASIPROUW29.*position 1600,0' "$CONFIG_FILE"; then
    echo "Estado A detectado. Trocando para o Estado B..."
    
    # Troca a linha do Ultrawide
    sed -i '/PEGASIPROUW29/ s/position 1600,0/position 0,0/' "$CONFIG_FILE"
    
    # Troca a linha do AOC
    sed -i '/AOC 2050W DTK41IA013846/ s/position 0,0/position -1600,0/' "$CONFIG_FILE"

# Se não, verifica se está no "Estado B" (UW na esquerda)
elif grep -q 'PEGASIPROUW29.*position 0,0' "$CONFIG_FILE"; then
    echo "Estado B detectado. Trocando para o Estado A..."

    # Troca a linha do Ultrawide
    sed -i '/PEGASIPROUW29/ s/position 0,0/position 1600,0/' "$CONFIG_FILE"

    # Troca a linha do AOC
    sed -i '/AOC 2050W DTK41IA013846/ s/position -1600,0/position 0,0/' "$CONFIG_FILE"

else
    echo "Nenhuma configuração conhecida foi encontrada. Verifique o arquivo."
    exit 1
fi

# Notifica o Kanshi (ou Sway) para aplicar as mudanças imediatamente
# Se você usa kanshi, pode ser necessário reiniciar o serviço ou usar um comando específico.
# swaymsg reload é mais para o Sway. Para o Kanshi, as mudanças geralmente são aplicadas
# na próxima vez que um monitor for conectado/desconectado.
# Por via das dúvidas, swaymsg reload não fará mal.
swaymsg reload

kanshi

echo "Script finalizado. Configuração trocada."
