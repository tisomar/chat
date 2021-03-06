# SISTEMA DE CONTATO

Sistema de Contato

### **Frameworks:**
- Laravel 8
- Vue 2
- Vuetify

### **GIT:**
- [https://github.com/tisomar/chat.git](https://github.com/tisomar/chat.git)

### **Desenvolvedor:**
- Tiago de Souza Marques Rodrigues - [tisomar@gmail.com](mailto:tisomar@gmail.com)

---

### **Pré-requisitos**
```
Docker
docker-compose
```
### **BUILD DOCKER**

```
docker-compose up -d --build

Comandos para acompanhar a subida dos containers:

docker logs chat-cliente --follow
docker logs chat-servico --follow
docker logs chat-bd --follow

Obs: É necessário acompanhar o log até o fim a instalação das dependências do container cliente, servidor e bd(acompanhe no terminal até o container
cliente exibir -> App running at: - Local:   http://localhost:8080/)

```

### ** ROTA ** ###

cadastrar contato: [http://localhost:8080/api/contato](http://localhost:8080/api/contato)

### ** BANCO DE DADOS ** ###


| Acesso Banco de Dados |          |
|---------------|---------------          | 
| **Host**             | localhost        |
| **Porta**            | 5434             |
| **banco de dados**   | chat     |
| **Usuário**          | chat     |
| **Senha**            | chat     |

----

### **TABELAS DO SISTEMA** ### 

|                   |
|-------------------|
| contatos 		|

### **ENVIO DE E-MAIL** ### 

```
As configurações de email devem ser alteradas no .env:

MAIL_MAILER=smtp
MAIL_HOST=smtp.mailtrap.io
MAIL_PORT=2525
MAIL_USERNAME=3516f3f96b076e
MAIL_PASSWORD=cdd9cd2e6a4f8c
MAIL_ENCRYPTION=tls
MAIL_FROM_ADDRESS=chat@chat.com
MAIL_TO_ADDRESS=tiagorodrigues@chat.com
```

### **TESTE AUTOMATIZADO** ### 
```
Executar:
docker exec -it chat-servico ./vendor/bin/phpunit

```
