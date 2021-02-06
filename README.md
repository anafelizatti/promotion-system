# Gestão de Promoções e cupons de desconto

Esta aplicação pode ser utilizada para gestão de promoções e suas categorias, e para emissão de cupons de desconto com código sequencial. 

## Funcionalidades
*As funcionalidades só são liberadas para usuários autenticados 
*Gestão de Promoções: 
    * Usuários autenticados podem cadastrar promoções, com nome, 
descrição, código, desconto, quantidade de cupons que podem ser emitidos, prazo de validade e possíveis categorias associadas.
    * As promoções podem ser editadas e deletadas a qualquer momento por usuários autenticados.
*Gestão de Categorias de Promoções:
    *  Usuários autenticados podem cadastrar categorias para uma promoção, com nome e código.
    *  As categorias cadastradas são disponibilizadas para o cadastro de promoções via check box.
    *  As categorias podem ser editadas ou deletadas a qualquer momento por usuários autenticados.
*Gestão de Cupons de desconto:
    *  A partir de Promoções, usuários podem emitir cupons sequenciais com códigos de desconto.
    *  Os cupons podem ser ativados ou desativados manualmente
    *  Os cupons podem ser consumidos (burn) via API


## Getting Started

Essas instruções fornecerão uma cópia do projeto instalado e funcionando em sua máquina local para fins de desenvolvimento e teste.

### Pré-requisitos

Máquina com sistema operacional Linux ( ou Windows Subsystem for Linux e similares) com chave SSH configurada,  com **Ruby 2.7.0** e **Rails 6.1.1** instalados.


### Instalação
Em seu terminal, digite:
`$ git clone git@qsd.campuscode.com.br:qsd-21/promotion-system.git`
Após clonar, execute `‘$ bundle install’`
Execute também `‘$ bin/setup’`

## Executando testes

Para executar os testes de funcionalidades, execute no terminal: 
`$ rspec`
Para testes de configuração e formatação, execute no terminal: 
`$ rubocop`
Para testes de REQUEST (API), execute no terminal: 
`$ rspec ./spec/requests/`

## Acesso a aplicação em navegador
* Para visualizar a aplicação via navegador, execute no terminal:
$ rails s
* Abra em seu navegador: localhost:3000
* Registre-se com email @locaweb.com.br
* Navegue! 

## Acesso a API em navegador
* Para visualizar a aplicação via navegador, execute no terminal:
$ rails s
* Para visualizar um cupom:
* GET 'api/v1/coupons/{coupons_code}

**Retornos possíveis:**
(...to be continued...)







