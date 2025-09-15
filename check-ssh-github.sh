#!/bin/bash

CONFIG_FILE="$HOME/.ssh/config"

echo "🔹 Verificando arquivo ~/.ssh/config..."

if [ ! -f "$CONFIG_FILE" ]; then
    echo "❌ Arquivo ~/.ssh/config não encontrado!"
    exit 1
fi

# Verifica permissões
perm=$(stat -c "%a" "$CONFIG_FILE" 2>/dev/null || stat -f "%Lp" "$CONFIG_FILE")
if [ "$perm" != "600" ]; then
    echo "⚠️ Permissões do arquivo ~/.ssh/config são $perm. Ajustando para 600..."
    chmod 600 "$CONFIG_FILE"
fi

echo "✅ ~/.ssh/config encontrado e permissões corretas."

# Checa aliases
for host in github-tcb github-vanderglobo; do
    grep -q "Host $host" "$CONFIG_FILE"
    if [ $? -eq 0 ]; then
        echo "✅ Alias '$host' encontrado no config."
    else
        echo "❌ Alias '$host' NÃO encontrado no config!"
    fi
done

# Testa conexões SSH
echo "🔹 Testando conexões SSH..."
for host in github-tcb github-vanderglobo; do
    echo "Testando $host..."
    ssh -T $host
done

echo "🔹 Verificação concluída."

