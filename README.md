# Cadê Buffet
#### TreinaDev 12 - Campus Code
Cadê Buffet é uma aplicação para gerenciamento de buffets e eventos, onde donos de buffets podem cadastrar seus estabelecimentos e eventos, e clientes podem buscar, visualizar detalhes e fazer pedidos de eventos. A aplicação também possui uma API para integração com outras aplicações.<br/>
Todas as funcionalidades foram feitas utilizando TDD (Test Driven Development), portanto toda a aplicação está devidamente coberta por testes.


## Funcionalidades
### Autenticação

- Criar conta como dono de buffet
- Criar conta como cliente

### Gerenciamento de Buffet

- Dono de buffet pode cadastrar seu buffet
- Dono de buffet pode editar seu buffet

### Gerenciamento de Tipos de Evento

- Dono de buffet pode adicionar tipos de eventos ao buffet
- Dono de buffet pode definir preços por evento

### Pedidos de Clientes

- Cliente pode agendar um evento
- Dono de buffet avalia e aprova pedido
- Cliente confirma pedido

### Listagem e Busca

- Listagem de buffets
- Listagem de eventos
- Busca de buffets

### Fotos para Tipos de Eventos

- Dono de buffet pode adicionar fotos aos eventos

## Instalação
### Dependências
- Ruby 3.3.0
- Rails 7.1.3

### Gems
- devise
- turbo-rails
- stimulus-rails
- capybara
- rspec

### Setup

**1. Clone o repositório:**
   ```
   git clone https://github.com/lucasobx/cade_buffet.git
   ```
   ```
   cd cade_buffet
   ```

**2. Execute:**
   ```
   bundle install
   yarn install
   ```
   ```
   rails db:setup
   ```
**3. Inicie o Servidor:**
   ```
   rails server
   ```
**4. Acesse a aplicação:**
   ```
   http://localhost:3000
   ```

## Executando os Testes
```
bundle exec rspec
```

## Login
**Login como dono de buffet**
- Email: lucas@email.com
- Senha: 12345678

**Login como cliente**
- Email: julia@email.com
- Senha: 12345678

## Cadê Buffet API

### Endpoints
  - `/api/v1/buffets/:id` - Detalhes de um buffet

**Exemplo de Requisição**
```
http://localhost:3000/api/v1/buffets/1/
```

**Exemplo de Resposta**
```json
{
  "id": 1,
  "brand_name": "Casamentos Buffet",
  "phone_number": "(11)00001111",
  "email": "casabuffet@email.com",
  "address": "Av Machado, 650",
  "neighborhood": "Butantã",
  "city": "São Paulo",
  "state": "SP",
  "postal_code": "14980-970",
  "description": "Buffet especializado em casamentos",
  "payment_methods": [
    {"name": "Dinheiro"},
    {"name": "Pix"}
  ]
}
```

  - `/api/v1/buffets` - Listagem de buffets

**Exemplo de Requisição**
```
http://localhost:3000/api/v1/buffets/
```

**Exemplo de Resposta**
```json
[
  {
    "id": 1,
    "brand_name": "Casamentos Buffet",
    "corporate_name": "Casamentos Buffet LTDA",
    "registration_code": "73456164000100",
    "phone_number": "(11)00001111",
    "email": "casabuffet@email.com",
    "address": "Av Machado, 650",
    "neighborhood": "Butantã",
    "city": "São Paulo",
    "state": "SP",
    "postal_code": "14980-970",
    "description": "Buffet especializado em casamentos",
    "payment_methods": [
      {"name": "Dinheiro"},
      {"name": "Pix"}
    ]
  },
  {
    "id": 2,
    "brand_name": "Edecy Buffet",
    "corporate_name": "Edecy Buffet LTDA",
    "registration_code": "55996244000122",
    "phone_number": "(11)22229988",
    "email": "edecy@email.com",
    "address": "Rua Castilho, 560",
    "neighborhood": "Piratininga",
    "city": "Belo Horizonte",
    "state": "MG",
    "postal_code": "55280-001",
    "description": "Buffet para festa infantil",
    "payment_methods": [
      {"name": "Dinheiro"},
      {"name": "Pix"}
    ]
  }
]
```

  - `/api/v1/buffets` + `params: {search: name}` - Busca de buffets

**Exemplo de Requisição**
```
http://localhost:3000/api/v1/buffets?search=Edecy
```

**Exemplo de Resposta**
```json
[
  {
    "id": 2,
    "brand_name": "Edecy Buffet",
    "corporate_name": "Edecy Buffet LTDA",
    "registration_code": "55996244000122",
    "phone_number": "(11)22229988",
    "email": "edecy@email.com",
    "address": "Rua Castilho, 560",
    "neighborhood": "Piratininga",
    "city": "Belo Horizonte",
    "state": "MG",
    "postal_code": "55280-001",
    "description": "Buffet para festa infantil",
    "payment_methods": [
      {"name": "Dinheiro"},
      {"name": "Pix"}
    ]
  }
]
```

**Descrição dos Atributos**
- `id`: Identificador único
- `brand_name`: Nome fantasia
- `phone_number`: Telefone para contato
- `email`: E-mail para contato
- `address`: Endereço
- `neighborhood`: Bairro
- `city`: Cidade onde o buffet está localizado
- `state`: Estado onde o buffet está localizado
- `postal_code`: CEP
- `description`: Descrição
- `payment_methods`: Lista de métodos de pagamento aceitos

### Eventos
  - `/api/v1/buffets/:buffet_id/event_types` - Listagem de tipos de evento de um buffet

**Exemplo de Requisição**
```
http://localhost:3000/api/v1/buffets/1/event_types/
```

**Exemplo de Resposta**
```json
[
  {
    "id": 1,
    "name": "Festa de Casamento",
    "description": "Espaço luxuoso e confortável",
    "min_guests": 15,
    "max_guests": 150,
    "duration": 240,
    "menu_details": "Doces, Salgados, Bebidas",
    "alcohol_option": true,
    "decoration_option": true,
    "parking_service_option": true,
    "location_option": false,
    "base_price": "10000.0",
    "extra_guest": "250.0",
    "extra_hour": "1000.0",
    "we_base_price": "15000.0",
    "we_extra_guest": "400.0",
    "we_extra_hour": "1500.0"
  }
]
```

  - `/api/v1/event_types/:id` + `params: {event_date: date, guest_number: guest_number}` - Consulta de disponibilidade de um evento

**Exemplo de Requisição**
```
http://localhost:3000/api/v1/event_types/1?event_date=2025-05-10&guest_number=30
```

**Exemplo de Resposta**
```json
{
  "id": 1,
  "name": "Festa de Casamento",
  "estimated_price": "21000.0"
}
```

**Descrição dos Atributos**
- `id`: Identificador único
- `name`: Nome do tipo de evento
- `description`: Descrição detalhada do evento
- `min_guests`: Quantidade mínima de convidados permitida para o evento
- `max_guests`: Quantidade máxima de convidados permitida para o evento
- `duration`: Duração padrão do evento em minutos
- `menu_details`: Texto que indica o cardápio para o evento
- `alcohol_option`: Indica se o evento possui opção de bebidas alcoólicas (`true` ou `false`)
- `decoration_option`: Indica se o evento possui opção de decoração (`true` ou `false`)
- `parking_service_option`: Indica se o evento possui serviço de estacionamento ou valet (`true` ou `false`)
- `location_option`: Indica se o evento pode ser realizado em um endereço indicado pelo contratante (`true` ou `false`)
- `base_price`: Preço base do evento
- `extra_guest`: Custo adicional por convidado extra
- `extra_hour`: Custo adicional por hora extra
- `we_base_price`: Preço base do evento nos fins de semana
- `we_extra_guest`: Custo adicional por convidado extra nos fins de semana
- `we_extra_hour`: Custo adicional por hora extra nos fins de semana