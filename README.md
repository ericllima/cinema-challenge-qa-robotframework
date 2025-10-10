# Cinema Challenge - QA Automation

[![Robot Framework](https://img.shields.io/badge/Robot%20Framework-7.1-blue.svg)](https://robotframework.org/)
[![Python](https://img.shields.io/badge/Python-3.13-green.svg)](https://python.org/)
[![Tests](https://img.shields.io/badge/Tests-60-brightgreen.svg)](#)
[![Coverage](https://img.shields.io/badge/Coverage-85%25-brightgreen.svg)](#)
[![GitHub](https://img.shields.io/badge/GitHub-Repository-black.svg)](https://github.com/ericllima/cinema-challenge-qa-robotframework)

Suíte completa de automação de testes para o sistema Cinema Challenge, desenvolvida com Robot Framework para validar funcionalidades web e APIs REST.

## 🎯 Objetivo

Validar a qualidade e funcionalidade do sistema Cinema Challenge através de testes automatizados abrangentes, garantindo que as funcionalidades críticas funcionem conforme especificado e proporcionem uma experiência de usuário satisfatória.

## 🚀 Tecnologias

- **Robot Framework 7.1** - Framework principal de automação
- **Browser Library** - Testes web modernos com Playwright
- **RequestsLibrary** - Testes de API REST
- **Python 3.13** - Linguagem de suporte
- **MongoDB** - Banco de dados para testes
- **JSONLibrary** - Manipulação de dados JSON

## 📊 Status dos Testes

### Última Execução
- **Total:** 60 testes
- **Aprovados:** 51 (85%)
- **Falharam:** 9 (15%)
- **Tempo:** 45 segundos

### Cobertura por Módulo
| Módulo | Testes | Sucesso | Taxa |
|--------|--------|---------|------|
| **Web** | 21 | 21 | 100% ✅ |
| **API** | 37 | 28 | 75.7% ⚠️ |
| **Health** | 2 | 2 | 100% ✅ |

## 📋 Funcionalidades Testadas

### 🌐 **Testes Web (Frontend)**
- ✅ **Autenticação** - Login, logout, registro, proteção de rotas
- ✅ **Catálogo** - Listagem de filmes, detalhes, navegação
- ✅ **Sessões** - Visualização de horários e salas
- ✅ **Reservas** - Seleção de assentos, checkout, histórico
- ✅ **Navegação** - Menu responsivo, breadcrumbs

### 🔧 **Testes API (Backend)**
- ⚠️ **Autenticação** - JWT, login, logout, perfil (63.6%)
- ✅ **Filmes** - CRUD, busca, filtros (85.7%)
- ✅ **Sessões** - Listagem, disponibilidade (100%)
- ✅ **Reservas** - Criação, consulta, cancelamento (100%)
- ✅ **Health Check** - Status da aplicação (100%)

## 🏗️ Estrutura do Projeto

```
cinema-challenge-qa-robotframework/
├── tests/                      # Casos de teste
│   ├── api/                   # Testes de API
│   │   ├── auth/             # Autenticação
│   │   │   ├── login.robot
│   │   │   ├── logout.robot
│   │   │   ├── profile.robot
│   │   │   └── register.robot
│   │   ├── movies/           # Filmes
│   │   │   ├── movies.robot
│   │   │   └── sessions.robot
│   │   └── reservations/     # Reservas
│   │       └── reservations.robot
│   ├── web/                  # Testes Web
│   │   ├── home.robot        # Página inicial
│   │   ├── login.robot       # Login
│   │   ├── logout.robot      # Logout
│   │   ├── movies.robot      # Catálogo
│   │   ├── register.robot    # Registro
│   │   └── reservation.robot # Reservas
│   └── health/               # Health checks
│       └── online.robot
├── resources/                 # Keywords e configurações
│   ├── base.resource         # Keywords base
│   ├── services.resource     # APIs
│   ├── pages/               # Page Objects
│   │   ├── components/      # Componentes
│   │   │   ├── Alert.resource
│   │   │   └── Header.resource
│   │   └── LoginPage.resource
│   ├── services/            # APIs
│   │   ├── auth.resource
│   │   ├── movies.resource
│   │   ├── reservations.resource
│   │   ├── sessions.resource
│   │   └── theaters.resource
│   ├── fixtures/            # Dados de teste
│   │   ├── movies.json
│   │   ├── reservations.json
│   │   ├── seats.json
│   │   ├── sessions.json
│   │   ├── theaters.json
│   │   └── users.json
│   ├── variables/           # Configurações
│   │   └── config.resource
│   └── libs/               # Bibliotecas customizadas
│       └── database.py
├── docs/                     # Documentação
│   └── test-plan.md         # Plano de testes
├── reports/                  # Relatórios (gerados)
├── .env                     # Variáveis de ambiente
├── requirements.txt          # Dependências
└── README.md                # Este arquivo
```

## 🛠️ Configuração do Ambiente

### Pré-requisitos
- Python 3.13
- Node.js 18 (para a aplicação)
- MongoDB 6.0
- Git

### Instalação

```bash
# 1. Clonar o repositório
git clone https://github.com/ericllima/cinema-challenge-qa-robotframework.git
cd cinema-challenge-qa-robotframework

# 2. Criar ambiente virtual
python -m venv .venv

# 3. Ativar ambiente virtual
# Windows
.venv\Scripts\activate
# Linux/Mac
source .venv/bin/activate

# 4. Instalar dependências
pip install -r requirements.txt

# 5. Inicializa a Library Browser
rfbrowser init

# 6. Configurar variáveis de ambiente
cp .env.example .env
# Editar .env com suas configurações
```

### Configuração da Aplicação Testada

O projeto testa as seguintes aplicações:

```bash
# Iniciar MongoDB
mongod

# Iniciar API (Backend)
cd ../cinema-challenge-api
npm install
npm start  # http://localhost:3000

# Iniciar Frontend
cd ../cinema-challenge-front
npm install
npm start  # http://localhost:3002
```

## ⚡ Execução dos Testes

### Comandos Básicos

```bash
# Executar todos os testes
robot tests/

# Executar apenas testes web
robot tests/web/

# Executar apenas testes de API
robot tests/api/

# Executar teste específico
robot tests/web/reservation.robot

# Executar com tags específicas
robot --include login tests/
robot --include api tests/
```

### Execução por Prioridade

```bash
# Testes críticos (alta prioridade)
robot --include critical tests/

# Testes de regressão
robot --include regression tests/

# Testes de fumaça (smoke)
robot --include smoke tests/
```

## 📊 Relatórios e Evidências

Após a execução, os seguintes arquivos são gerados:

- **`report.html`** - Relatório executivo com métricas
- **`log.html`** - Log detalhado da execução
- **`output.xml`** - Dados estruturados para CI/CD
- **Screenshots** - Evidências nos logs

## 🔗 Links do Projeto

- **Repositório Principal:** [cinema-challenge-qa-robotframework](https://github.com/ericllima/cinema-challenge-qa-robotframework)
- **Branch de Desenvolvimento:** [develop](https://github.com/ericllima/cinema-challenge-qa-robotframework/tree/develop)


## 📖 Documentação

- [📋 Plano de Testes parcial em Markdown](docs/test-plan.md)
- [📄 Plano de Testes PDF Completo](docs/test-plan.pdf)
- [📊 Relatórios de Execução](logs/)
- [🐛 Issues Conhecidas](https://github.com/ericllima/cinema-challenge-qa-robotframework/issues)

### Assistência de IA Amazon Q
Este projeto teve **assistência de IA Amazon Q** para controle de buscas de erros e soluções
