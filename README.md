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
Abrir executavel na pasta C:\Teste_Softplan\Sistema CEP WS\Win32\Debug\App_Consulta_Cep_WS.exe
```

# Metodologias e Técnicas Aplicadas

Aqui damos alguns exemplos dos metodos solicitado e trechos do codigo aplicado.

## Clean Code

- O código está bem organizado e estruturado, com identação adequada e nomes de variáveis e métodos significativos.
Comentários claros foram incluídos para explicar o propósito de cada seção de código e o que cada método faz.
- Formatação Consistente: O código segue uma formatação consistente, com uso adequado de espaçamento, indentação e quebras de linha, tornando-o mais legível e fácil de seguir.

## SOLID

- Single Responsibility Principle: Cada método da classe TConsulta_Cep_C1 tem uma responsabilidade única e clara, como obter dados, manipular conexões com o MongoDB, e realizar consultas. 
- Open/Closed Principle:  O código pode ser estendido para adicionar novos tipos de consulta sem a necessidade de modificar as classes existentes.
- Interface Segregation Principle: As interfaces públicas da classe são bem definidas e fornecem apenas os métodos necessários para interagir com ela.

## POO

A classe TConsulta_Cep_C1 encapsula o comportamento e os dados relacionados à consulta de CEPs, seguindo os princípios de encapsulamento e abstração.


## Serialização e desserialização de objetos JSON

A classe TConsulta_Cep_C1 possui métodos para gravar dados em um banco de dados MongoDB usando objetos JSON.
A função pGravaDadosMongoDb demonstra a desserialização de um objeto JSON para extrair os dados e armazená-los no banco de dados.

## Aplicação de Patterns

Singleton: A classe TConsulta_Cep_C1 gerencia uma única conexão com o banco de dados MongoDB, garantindo que apenas uma instância dessa conexão seja criada.


# Autor

José Ricardo Kinaip Soares

https://www.linkedin.com/in/wmazoni
