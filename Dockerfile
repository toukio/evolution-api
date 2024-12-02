# Use uma imagem base Node.js compatível
FROM aristofanio/evolution-node-base:0.0.7 AS builder

# maintainer
LABEL version="2.2.0" description="Cloned Api to control whatsapp features through http requests." 
LABEL maintainer="Toukio Team" git="https://github.com/toukio"
LABEL contact="contato@ms.touk.io"

# Copiar todos os arquivos para o container
COPY . /app
WORKDIR /app

# copy initial .env
COPY .env.example /app/.env

# Executar script para gerar banco de dados
RUN chmod +x ./Docker/scripts/*
RUN dos2unix ./Docker/scripts/*  
RUN ./Docker/scripts/generate_database.sh

# Build da aplicação
RUN npm run build

# Expor a porta do servidor
EXPOSE ${SERVER_PORT}

# update
ENV DOCKER_ENV=true

# Comando padrão para iniciar a aplicação
CMD ["/bin/bash", "-c", ". ./Docker/scripts/deploy_database.sh && npm run start:prod"]