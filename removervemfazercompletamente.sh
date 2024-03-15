#!/bin/bash

echo "Iniciando o processo de desinstalação..."

# Parar e deletar aplicações gerenciadas pelo PM2
sudo pm2 stop all
sudo pm2 delete all
sudo npm uninstall pm2 -g

# Remover Node.js, npm e dependências do Puppeteer
sudo apt remove --purge -y nodejs npm

# Remover Docker e contêineres
sudo apt remove --purge -y docker docker-engine docker.io containerd runc
sudo docker container prune -f
sudo docker volume prune -f
sudo docker network prune -f

# Remover PostgreSQL
sudo apt remove --purge -y postgresql postgresql-contrib
sudo rm -rf /var/lib/postgresql/

# Remover Redis (caso instalado sem Docker)
# Para Redis em Docker, os contêineres já foram removidos

# Remover Nginx e Certbot
sudo apt remove --purge -y nginx certbot

# Remover usuário 'deploy'
sudo deluser deploy
sudo rm -rf /home/deploy/

# Limpar pacotes não utilizados e limpar cache
sudo apt autoremove -y
sudo apt autoclean

echo "Desinstalação concluída. O sistema está limpo."
