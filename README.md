# APP-CEP
[![NPM](https://img.shields.io/npm/l/react)](https://github.com/jricardo924/APP-CEP/blob/main/LICENSE) 

# Sobre o projeto

O App-Cep é uma aplicação desenvolvida em Delphi Tokyo que visa demonstrar métodos e experiências profissionais relevantes para seleção de emprego em uma grande empresa da área de software.

A aplicação opera com base em requisições por CEP ou endereço para um Web Service público (https://viacep.com.br). Após enviar a solicitação, o serviço retorna um JSON, que é convertido em uma string e enviado para uma fila no RabbitMQ. Este sistema gerencia a ordem de processamento e disponibiliza os dados em outra fila, também no RabbitMQ. Após a liberação, os dados são armazenados no banco de dados MongoDB e a consulta é atualizada para o aplicativo de consulta.

## Layout APP
![Mobile 1](https://github.com/jricardo924/image/blob/main/Form_Principal.png) 


# Tecnologias utilizadas
## Delphi
- Delphi Tokyo
- Criação de componente EdtFocus
- Classe StompClient (Gerencia filas RabbitMQ)
- Class Component TIdHTTP (Requests HTTP) 
- Class Component TJSONObject (Manipulação de Json)
  
## RabbitMQ
- RabbitMQ Server 3.12.10
- Erlang OTP 26.2.1 (14.2.1)
  
## MongoDB
- MongoDB 5.0.25 2008R2Plus SSL (64 bit)
- MongoDB Compass (Collection: local.cadastroceps)

# Arquitetura utilizada

 A arquitetura utilizada foi Model-View-Controller (MVC). Todas as classes com nomenclatura que terminam com "_C1" são classes de Model (Exemplo: Consulta_Cep_C1), "_F1" são classes de View (Exemplo: Consulta_Cep_F1) e "_L1" são classes de Controller (Exemplo: Consulta_Cep_L1).


# Metodologias e Técnicas Aplicadas

Aqui damos alguns exemplos dos metodos utilizado e aplicados no codigo.

## Clean Code

- O código está bem organizado e estruturado, com identação adequada e nomes de variáveis e métodos significativos.
Comentários claros foram incluídos para explicar o propósito de cada seção de código e o que cada método faz.
- Formatação Consistente: O código segue uma formatação consistente, com uso adequado de espaçamento, indentação e quebras de linha, tornando-o mais legível e fácil de seguir.

## SOLID

- Single Responsibility Principle: Cada método da classe TConsulta_Cep_C1 tem uma responsabilidade única e clara, como obter dados, manipular conexões com o MongoDB, e realizar consultas.
   
- Open/Closed Principle:  O código está aberto para extensão e fechado para modificação, pois novos tipos de consulta ou funcionalidades podem ser adicionados sem modificar o código existente. Por exemplo, é possível adicionar um novo tipo de consulta sem alterar o método fConsultaCepMongo.
  
- Interface Segregation Principle: As interfaces na classe TConsulta_Cep_C1 são coesas e específicas para os métodos que precisam ser expostos. Por exemplo, a interface pública fornece métodos para configurar a consulta de CEP, obter resultados e carregar dados, sem expor detalhes de implementação desnecessários.

- Liskov Substitution Principle: As subclasses podem ser substituídas por suas classes base sem afetar o comportamento do programa. Embora não haja subclasses diretas neste código, a classe TConsulta_Cep_C1 pode ser estendida por meio de herança para adicionar novos comportamentos relacionados à consulta de CEPs.

- Dependency Inversion Principle:A classe TConsulta_Cep_C1 depende de abstrações (interfaces) em vez de implementações concretas. Por exemplo, ela depende de TFDConnection e TFDMongoQuery, que são abstrações para conexão e consulta ao banco de dados, permitindo a troca fácil de implementações sem alterar o código cliente.

## POO

- Encapsulamento: O código faz uso extensivo de propriedades (getters e setters) para encapsular o acesso aos atributos privados da classe TConsulta_Cep_C1, como FCep, FLogradouro, etc. Isso ajuda a controlar o acesso aos dados e protegê-los de modificações não autorizadas.

- Abstração: A classe TConsulta_Cep_C1 abstrai o conceito de consulta de CEP e encapsula seu comportamento em métodos e propriedades. Isso permite que os usuários da classe interajam com ela de forma simplificada, sem precisar conhecer os detalhes de implementação subjacentes.

- Herança: Embora não seja explicitamente demonstrado no código fornecido, a classe TConsulta_Cep_C1 pode ser estendida por meio de herança para adicionar novos comportamentos ou personalizações relacionadas à consulta de CEPs. Por exemplo, poderia ser criada uma subclasse ConsultaCepEspecializada que herda de TConsulta_Cep_C1 e implementa funcionalidades adicionais.

- Polimorfismo: O método fConsultaCepMongo na classe TConsulta_Cep_C1 utiliza polimorfismo ao aceitar um parâmetro do tipo TTipoConsulta, que pode assumir diferentes valores. Dependendo do valor passado, o método se comporta de maneira diferente, permitindo consultas de diferentes tipos de CEP (por endereço ou por código).

- Reutilização de código: O código reutiliza componentes e classes fornecidos pelo ambiente de desenvolvimento, como TFDConnection e TFDMongoQuery, em vez de reinventar a roda. Isso promove a eficiência e reduz a duplicação de esforços.

## Serialização e desserialização de objetos JSON

A classe TConsulta_Cep_C1 possui métodos para gravar dados em um banco de dados MongoDB usando objetos JSON.
A função pGravaDadosMongoDb demonstra a desserialização de um objeto JSON para extrair os dados e armazená-los no banco de dados.

## Aplicação de Patterns

- Padrão Singleton: a classe TConsulta_Cep_C1 possui um gerenciamento centralizado para componentes importantes, como a conexão com o banco de dados MongoDB (FConMongo) e a consulta ao banco de dados (FMongoQry). Isso garante que apenas uma instância desses componentes seja criada e compartilhada por toda a aplicação, promovendo a eficiência e a consistência.

- Padrão Factory Method: A classe TConsulta_Cep_C1 atua como uma fábrica para criar consultas de CEP, encapsulando a lógica de criação e execução das consultas.

- Padrão Strategy:O método fConsultaCepMongo na classe TConsulta_Cep_C1 pode ser considerado uma aplicação do padrão Strategy. Ele aceita um parâmetro TipoConsulta do tipo TTipoConsulta, que determina o comportamento específico a ser executado durante a consulta ao MongoDB. Dependendo do valor desse parâmetro, o método adapta sua estratégia de consulta (por endereço ou por código).

- Padrão MVC (Model-View-Controller):O código segue uma estrutura MVC implícita, onde a classe TConsulta_Cep_L1 atua como o controlador (Controller) responsável por gerenciar a lógica de negócios relacionada à consulta de CEP. O TConsulta_Cep_F1 é a visão (View) que exibe os registros, e a classe: TConsulta_Cep_C1 e o modelo (Model) consiste nos dados de consulta e no acesso ao banco de dados MongoDB.

# Criação de Componentes

## Componente EdtFocus

O EdtFocus é um componente Delphi que fornece uma maneira simples de alterar a cor de um campo de edição (TEdit) quando ele ganha foco. Ele é útil para realçar visualmente campos de entrada em formulários.  

## Funcionalidades

Mudança de Cor: O componente permite especificar uma cor personalizada para o campo de edição quando ele ganha foco.
Restauração da Cor Original: Quando o campo perde o foco, a cor retorna ao valor padrão.

## Como Usar

Uso no Formulário: No Tool Pallete de formulários, localize o componente MyComponents >> TEdtFocus na paleta de componentes.
Defina a propriedade MudarColor para especificar a cor desejada quando o campo ganha foco.

# Como executar o projeto

## Aplicação
Pré-requisitos: Delphi Tokyo

```bash
# clonar repositório
git clone https://github.com/jricardo924/APP-CEP
Clone para diretorio C:\

# entrar na pasta do projeto
cd C:\APP-CEP-main.zip\APP-CEP-main

# executar o projeto
Abrir executavel na pasta C:\APP-CEP-main.zip\APP-CEP-main\Win32\Debug\App_Consulta_Cep_WS.exe

# Instalação de componente EdtFocus
Abrir o Project >> arquivo: C:\APP-CEP-main.zip\APP-CEP-main\Novo_Componente\EditFocus\CEditFocus.dproj
Compilar o componente
Instalar o componente

# MongoDB
Ao gravar a primeira vez um registro no banco de dados será na base de dados local >> Collection: cadastroceps
Caminha no mongo: local.cadastroceps
```



# Autor

José Ricardo Kinaip Soares

https://www.linkedin.com/in/wmazoni
