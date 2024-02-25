# APP-CEP
[![NPM](https://img.shields.io/npm/l/react)](https://github.com/jricardo924/APP-CEP/blob/main/LICENSE) 

# Sobre o projeto

App-Cep é uma aplicação desenvolvida em Delphi Tokyo para demonstrar metodos e tecnicas para seleção de emprego em uma grande empresa na area de Software.

A aplicação opera com base em requisições por CEP ou endereço para um Web Service público (https://viacep.com.br). Após enviar a solicitação, o serviço retorna um JSON, que é convertido em uma string e enviado para uma fila no RabbitMQ. Este sistema gerencia a ordem de processamento e disponibiliza os dados em outra fila, também no RabbitMQ. Após a liberação, os dados são armazenados no banco de dados MongoDB e a consulta é atualizada para o aplicativo de consulta.

## Layout mobile
![Mobile 1](https://github.com/jricardo924/image/blob/main/Form_Principal.png) 

## Modelo conceitual
![Modelo Conceitual](https://github.com/acenelio/assets/raw/main/sds1/modelo-conceitual.png)

# Tecnologias utilizadas
## Back end
- Java
- Spring Boot
- JPA / Hibernate
- Maven
## Front end
- HTML / CSS / JS / TypeScript
- ReactJS
- React Native
- Apex Charts
- Expo
## Implantação em produção
- Back end: Heroku
- Front end web: Netlify
- Banco de dados: Postgresql

# Como executar o projeto

## Back end
Pré-requisitos: Java 11

```bash
# clonar repositório
git clone https://github.com/devsuperior/sds1-wmazoni

# entrar na pasta do projeto back end
cd backend

# executar o projeto
./mvnw spring-boot:run
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
