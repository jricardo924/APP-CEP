# APP-CEP
[![NPM](https://img.shields.io/npm/l/react)](https://github.com/jricardo924/APP-CEP/blob/main/LICENSE) 

# Sobre o projeto

App-Cep é uma aplicação desenvolvida em Delphi Tokyo para demonstrar metodos e tecnicas para seleção de emprego em uma grande empresa na area de Software.

A aplicação opera com base em requisições por CEP ou endereço para um Web Service público (https://viacep.com.br). Após enviar a solicitação, o serviço retorna um JSON, que é convertido em uma string e enviado para uma fila no RabbitMQ. Este sistema gerencia a ordem de processamento e disponibiliza os dados em outra fila, também no RabbitMQ. Após a liberação, os dados são armazenados no banco de dados MongoDB e a consulta é atualizada para o aplicativo de consulta.

## Layout APP
![Mobile 1](https://github.com/jricardo924/image/blob/main/Form_Principal.png) 

## Modelo conceitual
![Modelo Conceitual](https://github.com/acenelio/assets/raw/main/sds1/modelo-conceitual.png)

# Tecnologias utilizadas
## Delphi
- Delphi Tokyo
- Classe StompClient (Gerencia filas RabbitMQ)
- Class Component TIdHTTP (Requests HTTP) 
- Class Component TJSONObject (Manipulação de Json)
  
## RabbitMQ
- RabbitMQ Server 3.12.10
- Erlang OTP 26.2.1 (14.2.1)
  
## MongoDB
- MongoDB 5.0.25 2008R2Plus SSL (64 bit)
- MongoDB Compass

# Como executar o projeto

## Aplicação
Pré-requisitos: Delphi Tokyo

```bash
# clonar repositório
git clone https://github.com/jricardo924/APP-CEP

# entrar na pasta do projeto
cd C:\Teste_Softplan\Sistema CEP WS

# executar o projeto
Abrir executavel na pasta C:\Teste_Softplan\Sistema CEP WS\Win32\Debug
```

## Front end web
Pré-requisitos: npm / yarn

```bash
# clonar repositório
git clone https://github.com/devsuperior/sds1-wmazoni

# entrar na pasta do projeto front end web
cd front-web

# instalar dependências
yarn install

# executar o projeto
yarn start
```

# Autor

José Ricardo Kinaip Soares

https://www.linkedin.com/in/wmazoni
