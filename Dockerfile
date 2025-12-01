# ✅ MITIGAÇÃO 1: Imagem base atualizada e slim
FROM node:20-slim 

# Definição do diretório de trabalho: alinhado com a estrutura do projeto.
WORKDIR /app

# ✅ MITIGAÇÃO 7: Instala SOMENTE ferramentas de build necessárias
# Adiciona as ferramentas essenciais para compilação de dependências nativas (se houver).
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    make \
    g++ && \
    rm -rf /var/lib/apt/lists/*

# Copiar os arquivos package.json e package-lock.json (da pasta local 'app/' para o WORKDIR)
COPY app/package*.json ./

# ✅ MITIGAÇÃO 2 & 5: Rodar 'npm install' como usuário não-root ('node')
USER node 

# Instalar dependências do Node.js
RUN npm install

# Copiar o restante da aplicação (da pasta local 'app/' para o WORKDIR)
COPY app/. .

# ✅ MITIGAÇÃO 8: Rodar aplicação como usuário não-root ('node')
# ❌ VULNERABILIDADE 6: Porta privilegiada 80 está em uso, mas corrigiremos isso depois.
CMD [ "npm", "start" ]