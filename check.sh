#!/bin/bash

# Detecta branch atual
branch=$(git symbolic-ref --short HEAD 2>/dev/null)
if [ -z "$branch" ]; then
    echo "Erro: você não está em um repositório Git."
    exit 1
fi
echo "Branch atual: $branch"

# Pega URL remota atual
remote_url=$(git remote get-url origin 2>/dev/null)
if [ -z "$remote_url" ]; then
    echo "Erro: remoto 'origin' não configurado."
    exit 1
fi
echo "Remote atual: $remote_url"

# Detecta a conta dono do repo
if [[ "$remote_url" == *"tcbvander"* ]]; then
    echo "Repo pertence a tcbvander → usando Host github-tcb"
    git remote set-url origin git@github-tcb:tcbvander/$(basename "$remote_url" .git).git
elif [[ "$remote_url" == *"vanderbrazglobo"* ]]; then
    echo "Repo pertence a vanderbrazglobo → usando Host github-vanderglobo"
    git remote set-url origin git@github-vanderglobo:vanderbrazglobo/$(basename "$remote_url" .git).git
else
    echo "Aviso: não consegui detectar a conta do repo. Verifique manualmente."
fi

# Push para o branch atual
echo "Fazendo push para o branch '$branch'..."
git push -u origin "$branch"

