#!/bin/bash
echo "Back - Iniciando o Endpoint da Aplicação"

if ! [ -f ".env" ]; then
    echo "Arquivo '.env' não encontrado - Gerando arquivo"
    cp env.dev-local .env
fi

echo "Permissões de acesso ao .env"
chmod -R 777 .env

if [ -d "/var/www/html/vendor" ]
 then
    rm -rf vendor
fi

echo "Instalando as dependências com o composer..."
php -d memory_limit=-1 /usr/local/bin/composer install

echo "Permissões de acesso a pasta vendor"
chmod -R 777 vendor

echo "ligando o servidoer web socket"
php server.php

